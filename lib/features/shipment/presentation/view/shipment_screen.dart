
import 'package:ecommerce_app/core/data/models/shipping.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_last_auth.dart';
import 'package:ecommerce_app/features/cart/data/models/cart.dart';
import 'package:ecommerce_app/features/shipment/data/models/city.dart';
import 'package:ecommerce_app/features/shipment/data/models/province.dart';
import 'package:ecommerce_app/features/shipment/domain/usecase/get_cities.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/city_bloc.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/city_state.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/shipment_bloc.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/ward_cubit.dart';
import 'package:ecommerce_app/features/shipment/presentation/bloc/ward_state.dart';
import 'package:ecommerce_app/inject_container.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ShipmentScreen extends StatefulWidget {
  const ShipmentScreen({super.key, required this.isUpdate, required this.cart});

  final bool isUpdate;
  final Cart cart;

  @override
  State<ShipmentScreen> createState() => _ShipmentScreenState();
}

class _ShipmentScreenState extends State<ShipmentScreen> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _province = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _ward = TextEditingController();
  final TextEditingController _fullName = TextEditingController();

  bool isValidUpdate = false;
  bool isValidCreate = false;

  String? _chosenModel;


  @override
  void dispose() {
    _address.dispose();
    _province.dispose();
    _city.dispose();
    _ward.dispose();
    _fullName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width * 0.96;
    return Scaffold(
      appBar: AppBar(
        title: Text('Địa chỉ giao hàng', style: theme.textTheme.headlineSmall),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left, color: theme.iconTheme.color,)
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ShipmentBloc>()..add(const GetProvincesRequest())),
          BlocProvider(create: (_) => sl<CityCubit>()),
          BlocProvider(create: (_) => sl<WardCubit>()),
        ],
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            if (!widget.isUpdate)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Họ tên'),
                  SizedBox(
                    width: width,
                    child: TextFormField(
                      controller: _fullName,
                      decoration: InputDecoration(
                          hintText: 'Vui lòng nhập họ tên',
                          focusedBorder: const OutlineInputBorder(),
                          disabledBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                          hintStyle: theme.textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: theme.textTheme.labelMedium!.color!.withOpacity(0.5)
                          )
                      ),
                      onChanged: (value) {
                        setState(() {
                          isValidCreate = _fullName.text.isNotEmpty;
                        });
                      },
                    ),
                  ),
                ],
              ),
            const Gap(10),
            const Text('Tỉnh/Thành phố'),
            BlocConsumer<ShipmentBloc, ShipmentState>(
                builder: (context, state) {
                  if (state is ShipmentProvinceState) {
                    return DropdownMenuTheme(
                      data: DropdownMenuThemeData(
                        inputDecorationTheme: _inputDecorationTheme(theme)
                      ),
                      child: DropdownMenu(
                        width: width,
                        menuHeight: 250,
                        searchCallback: (List<DropdownMenuEntry<Province>> provinces, String query) {
                          if (query.isEmpty) {
                            return null;
                          }
                          final index = provinces.indexWhere((p) => p.value.name
                              .toLowerCase().contains(query.toLowerCase()));
                          return index == -1 ? null : index;
                        },
                        controller: _province,
                        hintText: 'Vui lòng chọn tỉnh/thành phố',
                        enableFilter: true,
                        enableSearch: true,
                        menuStyle: MenuStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(theme.scaffoldBackgroundColor)
                        ),
                        dropdownMenuEntries: state.provinces.map((e) =>
                          DropdownMenuEntry(
                            value: e, label: e.nameWithType,
                            labelWidget: Text(e.nameWithType, style: theme.textTheme.labelMedium),
                          )).toList(),
                        trailingIcon: const Icon(Icons.expand_more),
                        onSelected: (value) {
                          context.read<CityCubit>().getCity(value!.code);
                          context.read<WardCubit>().getWard(value.code);
                          setState(() {
                            isValidUpdate = _province.text.isNotEmpty
                                && _city.text.isNotEmpty
                                && _ward.text.isNotEmpty
                                && _address.text.isNotEmpty;
                          });
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
                listener: (context, state) {
                  if (state is ShipmentProvinceState) {
                    print('province state: ${state.provinces}');
                  }
                }
            ),
            const Gap(10),
            const Text('Quận/Huyện/Thành phố'),
            BlocConsumer<CityCubit, CityState>(
              listener: (context, state) {
                print('active city when trigger province');
                if (state.status == CityStatus.success) {
                  Navigator.pop(context);
                }
                if (state.status == CityStatus.loading) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  );
                }
              },
              builder: (context, state) {
                return DropdownMenuTheme(
                  data: DropdownMenuThemeData(
                    inputDecorationTheme: _inputDecorationTheme(theme),
                  ),
                  child: DropdownMenu(
                    menuHeight: 250,
                    controller: _city,
                    hintText: 'Vui lòng chọn quận/huyện/thành phố',
                    width: width,
                    enableFilter: true,
                    enableSearch: true,
                    menuStyle: MenuStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(theme.scaffoldBackgroundColor)
                    ),
                    dropdownMenuEntries: state.cities.map((e) =>
                      DropdownMenuEntry(
                        value: e, label: e.nameWithType,
                        labelWidget: Text(e.nameWithType, style: theme.textTheme.labelMedium),
                      )).toList(),
                    trailingIcon: const Icon(Icons.expand_more),
                    onSelected: (value) {
                      context.read<WardCubit>().getWard(value!.code);
                      setState(() {
                        isValidUpdate = _province.text.isNotEmpty
                            && _city.text.isNotEmpty
                            && _ward.text.isNotEmpty
                            && _address.text.isNotEmpty;
                      });
                    },
                  ),
                );
                // }
                // return const SizedBox();
              },
            ),
            const Gap(10),
            const Text('Xã/Phường'),
            BlocConsumer<WardCubit, WardState>(
              listener: (context, state) {
                if (state.status == WardStatus.loading) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                  );
                }
                if (state.status == WardStatus.success) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return DropdownMenuTheme(
                  data: DropdownMenuThemeData(
                    inputDecorationTheme: _inputDecorationTheme(theme)
                  ),
                  child: DropdownMenu(
                    menuHeight: 250,
                    controller: _ward,
                    hintText: 'Vui lòng chọn xã/phường',
                    width: width,
                    enableFilter: true,
                    enableSearch: true,
                    menuStyle: MenuStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(theme.scaffoldBackgroundColor)
                    ),
                    dropdownMenuEntries: state.wards.map((e) =>
                      DropdownMenuEntry(
                        value: e, label: e.nameWithType,
                        labelWidget: Text(e.nameWithType, style: theme.textTheme.labelMedium),
                      )).toList(),
                    trailingIcon: const Icon(Icons.expand_more),
                    onSelected: (value) {
                      setState(() {
                        isValidUpdate = _province.text.isNotEmpty
                            && _city.text.isNotEmpty
                            && _ward.text.isNotEmpty
                            && _address.text.isNotEmpty;
                      });
                    },
                  ),
                );
              },
            ),
            const Gap(10),
            const Text('Tên đường/số nhà/tòa nhà...'),
            SizedBox(
              width: width,
              child: TextFormField(
                controller: _address,
                decoration: InputDecoration(
                  hintText: 'Nhập tên đường/số nhà/tòa nhà...',
                  focusedBorder: const OutlineInputBorder(),
                  disabledBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                  hintStyle: theme.textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: theme.textTheme.labelMedium!.color!.withOpacity(0.5)
                  )
                ),
                onChanged: (value) {
                  setState(() {
                    isValidUpdate = _province.text.isNotEmpty
                        && _city.text.isNotEmpty
                        && _ward.text.isNotEmpty
                        && _address.text.isNotEmpty;
                  });
                },
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: EcommerceButton(
                    onTap: () {
                      Navigator.pop(context, _address.text);
                    },
                    backgroundColor: Colors.redAccent,
                    titleColor: Colors.white,
                    title: 'Hủy',
                  ),
                ),
                const Gap(10),
                BlocConsumer<ShipmentBloc, ShipmentState>(
                  listener: (BuildContext context, state) {
                    if (state is ShipmentUpdateSuccess) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(state.customer);
                    }
                    if (state is ShipmentUpdateLoading) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const Center(child: CircularProgressIndicator(),);
                          }
                      );
                    }
                  },
                  builder: (context, state) {
                    return Expanded(
                      child: EcommerceButton(
                        title: 'Cập nhật',
                        onTap: () => _handleUpdate(context)
                      ),
                    );
                  }
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme(ThemeData theme) {
    return InputDecorationTheme(
      hintStyle: theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: theme.textTheme.labelMedium!.color!.withOpacity(0.5)
      ),
      focusedBorder: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(),
      disabledBorder: const OutlineInputBorder(),
    );
  }

  void _handleUpdate(BuildContext context) async {
    final firstName = _fullName.text.split(" ").first;
    final lastName = _fullName.text.substring(firstName.length, _fullName.text.length);
    StringBuffer addressSb = StringBuffer()
      ..writeAll([
        _address.text,
        _ward.text,
        _city.text,
        _province.text,], ', ');
    Shipping shipping = Shipping(
        firstName: widget.isUpdate ? widget.cart.shippingAddress!.firstName : firstName,
        lastName: widget.isUpdate ? widget.cart.shippingAddress!.lastName : lastName,
        address1: addressSb.toString(),
        city: _city.text,
        state: _province.text);
    final authRepository = sl<AuthRepository>();
    final getUserInfo = GetLastUserInfo(authRepository);
    final user = await getUserInfo.authRepository.getUserInfo();
    user.fold(
      (error) => debugPrint('error'),
      (user) => context.read<ShipmentBloc>().add(UpdateAddressRequest(
          userId: user!.success!.data!.id, address: shipping))
    );
  }
}