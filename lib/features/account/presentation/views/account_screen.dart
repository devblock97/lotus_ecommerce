import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/core/utils/utils.dart';
import 'package:ecommerce_app/features/account/presentation/bloc/customer_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/presentation.dart';
import 'package:ecommerce_app/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  String version = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final WidgetStateProperty<Color?> overlayColor =
    WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        // Material color when switch is selected.
        if (states.contains(WidgetState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(WidgetState.disabled)) {
          return Colors.black;
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
            BlocProvider(create: (_) => sl<CustomerBloc>()..add(const CustomerInfoRequest())),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is Authenticated) {
                        debugPrint('check auth state: $state');
                        return ListTile(
                          leading: CircleAvatar(
                            maxRadius: 45,
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/icons/user_profile.jpg'),
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                state.authResponseModel?.success?.data?.displayName ?? 'Chưa đăng nhập',
                                style: theme.textTheme.titleMedium,
                              ),
                              const Icon(
                                Icons.edit,
                                color: primaryButton,
                              )
                            ],
                          ),
                          subtitle: Text(
                            state.authResponseModel?.success?.data?.email ?? '',
                            style: theme.textTheme.titleMedium,
                          ),
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
                _MenuItem(
                  title: 'Đơn hàng',
                  icon: Icons.shopping_bag_outlined,
                  onTap: (value) {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GroceryApp(selectedIndex: 2,)));
                  },
                ),
                _MenuItem(
                  title: 'Đơn hàng đã mua',
                  icon: Icons.credit_card_outlined,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                _MenuItem(
                  title: 'Địa chỉ giao hàng',
                  icon: Icons.location_on_outlined,
                  onTap: (value) => showFeatureComingSoon(context),),
                _MenuItem(
                  title: 'Phương thức thanh toán',
                  icon: Icons.payments_outlined,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                _MenuItem(
                  title: 'Thẻ tín dụng',
                  icon: Icons.credit_score,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                _MenuItem(
                  title: 'Thông báo',
                  icon: Icons.notifications_outlined,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                _MenuItem(
                  title: 'Trợ giúp',
                  icon: Icons.help_outline,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                _MenuItem(
                  title: 'Giới thiệu',
                  icon: Icons.info_outline,
                  onTap: (value) => showFeatureComingSoon(context),
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    debugPrint('check theme bloc account: $state');
                    return SwitchListTile(
                      title: Text(
                        'Dark theme',
                        style: theme.textTheme.titleSmall,
                      ),
                      value: (state is SetThemeSuccess) ? state.theme == ThemeMode.dark : false,
                      trackColor: trackColor,
                      overlayColor: overlayColor,
                      onChanged: (value) {
                        debugPrint('Switch toggled: $value');
                        context.read<ThemeBloc>().add(SetThemeRequest(
                          theme: value ? ThemeMode.dark : ThemeMode.light,
                        ));
                      },
                    );
                  },
                ),
                const Gap(10),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasData) {
                      return _MenuItem(title: 'Version: ${snapshot.data!.version}.${snapshot.data!.buildNumber}', icon: Icons.settings);
                    }
                    return const Text("Version info not available");
                  }
                ),
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

  void _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;
    //
    // debugPrint("App Name: $appName");
    // debugPrint("Package Name: $packageName");
    // debugPrint("Version: $version");
    // debugPrint("Build Number: $buildNumber");

    version = '${packageInfo.version}.${packageInfo.buildNumber}';
  }

}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  final Function(bool value)? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      onExpansionChanged: onTap,
      leading: Icon(
        icon,
        color: theme.iconTheme.color,
      ),
      title: Text(
        title,
        style: theme.textTheme.titleSmall,
      ),
      initiallyExpanded: true,
      trailing: Icon(Icons.keyboard_arrow_right, color: theme.iconTheme.color,),
    );
  }
}

