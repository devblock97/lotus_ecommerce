import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/core/utils/utils.dart';
import 'package:ecommerce_app/features/account/presentation/bloc/customer_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/presentation.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../inject_container.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool selected = false;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = context.watch<ThemeSelector>();
    final WidgetStateProperty<Color?> overlayColor =
    WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        // Material color when switch is selected.
        if (states.contains(WidgetState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );
    final WidgetStateProperty<Color?> trackColor =
    WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        // Track color when the switch is selected.
        if (states.contains(WidgetState.selected)) {
          return primaryButton;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AuthBloc>()..add(CheckSignedIn())),
            BlocProvider(create: (_) => sl<CustomerBloc>()..add(const CustomerInfoRequest()))
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        return ListTile(
                          leading: CircleAvatar(
                            maxRadius: 45,
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/icons/user_profile.jpg'),
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(state.authResponseModel == null ? 'Chưa đăng nhập': state.authResponseModel!.success!.data.displayName!),
                              const Icon(
                                Icons.edit,
                                color: primaryButton,
                              )
                            ],
                          ),
                          subtitle: Text(state.authResponseModel == null ? '' : state.authResponseModel!.success!.data.email!),
                        );
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          maxRadius: 45,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/products/apple.png'),
                        ),
                        title: const Text('Ban chưa đăng nhập'),
                      );
                    },
                  ),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GroceryApp(selectedIndex: 2,)));
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text('Đơn hàng'),
                  textColor: primaryText,
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text('Đơn hàng đã mua'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.location_on_outlined),
                  title: const Text('Địa chỉ giao hàng'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.payments_outlined),
                  title: const Text('Phương thức thanh toán'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.credit_score),
                  title: const Text('Thẻ tín dụng'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => const NotificationScreen()));
                    showFeatureComingSoon(context);
                  },
                  leading: const Icon(Icons.notifications_outlined),
                  title: const Text('Thông báo'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Trợ giúp'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                ExpansionTile(
                  onExpansionChanged: (value) => showFeatureComingSoon(context),
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Giới thiệu'),
                  initiallyExpanded: true,
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
                SwitchListTile(
                  title: const Text('Dark theme'),
                  value: selected,
                  trackColor: trackColor,
                  overlayColor: overlayColor,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        theme.themeMode = ThemeMode.dark;
                      } else {
                        theme.themeMode = ThemeMode.light;
                      }
                      selected = value;
                    });
                  },
                ),
                const Gap(10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthenticationLoading) {
                        showDialog(context: context, builder: (_) {
                          return const Center(child: CircularProgressIndicator(),);
                        });
                      }
                      if (state is UnAuthenticated) {
                        Navigator.pop(context);
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(message: 'Sign out successful!')
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoggedIn = (state is Authenticated);
                      return EcommerceButton(
                        title: isLoggedIn ? 'Đăng xuất' : 'Đăng nhập',
                        onTap: () {
                         if (isLoggedIn) {
                           context.read<AuthBloc>().add(SignOutRequest());
                         } else {
                           Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                         }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

