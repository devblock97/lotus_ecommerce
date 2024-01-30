import 'package:ecommerce_app/features/notification/presentation/notify_screen.dart';
import 'package:ecommerce_app/features/cart/presentation/cart_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/theme/theme.dart';
import 'package:ecommerce_app/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool selected = false;
  late ThemeMode _themeMode;

  @override
  Widget build(BuildContext context) {
    var theme = context.watch<ThemeSelector>();
    final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );
    final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 45,
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/products/apple.png'),
                  ),
                  title: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Nguyen Nhut Thong'),
                      Icon(
                        Icons.edit,
                        color: primaryButton,
                      )
                    ],
                  ),
                  subtitle: const Text('nhutthongltv@gmail.com'),
                ),
              ),
              ExpansionTile(
                onExpansionChanged: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text('Đơn hàng'),
                textColor: primaryText,
                initiallyExpanded: true,
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.credit_card_outlined),
                title: Text('Đơn hàng đã mua'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.location_on_outlined),
                title: Text('Địa chỉ giao hàng'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.payments_outlined),
                title: Text('Phương thức thanh toán'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.credit_score),
                title: Text('Thẻ tín dụng'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              ExpansionTile(
                onExpansionChanged: (value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const NotificationScreen()));
                },
                leading: const Icon(Icons.notifications_outlined),
                title: const Text('Thông báo'),
                initiallyExpanded: true,
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.help_outline),
                title: Text('Trợ giúp'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              const ExpansionTile(
                leading: Icon(Icons.info_outline),
                title: Text('Giới thiệu'),
                initiallyExpanded: true,
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              SwitchListTile(
                title: const Text('Light theme'),
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
                child: EcommerceButton(
                  title: 'Đăng xuất',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

