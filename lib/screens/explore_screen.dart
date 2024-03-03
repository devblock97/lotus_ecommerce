import 'package:ecommerce_app/screens/category_detail_screen.dart';
import 'package:ecommerce_app/features/search/presentation/filter_screen.dart';
import 'package:ecommerce_app/theme/color.dart';
import 'package:ecommerce_app/widgets/my_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Find Products',
          style: TextStyle(
              color: primaryText, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
              leading: const Text('Filter Categories'),
              trailing: GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const FilterScreen())),
                  child: SvgPicture.asset('assets/icons/filter.svg'))),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
