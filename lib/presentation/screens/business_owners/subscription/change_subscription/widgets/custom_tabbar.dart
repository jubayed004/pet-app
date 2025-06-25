import 'package:flutter/material.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class CustomTabbar extends StatefulWidget {
  const CustomTabbar({
    super.key,
    required this.tabController, required this.tabLabels,

  });

  final TabController tabController;
  final List<String> tabLabels;  //

  @override
  _CustomTabbarState createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  final controller = GetControllers.instance.getSubscriptionController();
  @override
  void initState() {
    super.initState();
    // Listen to tab controller index changes to update the indicator's gradient
    widget.tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Clean up the listener when the widget is disposed
    widget.tabController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TabBar(
       // indicatorAnimation: TabIndicatorAnimation.linear,
        padding: const EdgeInsets.symmetric(horizontal: 1),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorColor: AppColors.greenColor,
        controller: widget.tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          // Update the gradient for the active tab dynamically
          gradient: _getTabGradient(widget.tabController.index),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        tabs: widget.tabLabels.map((label) => Tab(text: label.toUpperCase())).toList(),
      ),
    );
  }

  // Function to get the gradient for each tab
  LinearGradient _getTabGradient(int index) {
    switch (index) {
      case 2:
        return LinearGradient(
          colors: [
            Color(0xFFF97619),
            Color(0xFFFDE3D1),
            Color(0xFFE1650B),
            Color(0xFFF3771F),
            Color(0xFFF47B25),
            Color(0xFFFBD2B4),
            Color(0xFFE2650C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 1:
        return LinearGradient(
          colors: [
            Color(0xFF9DA5A6),
            Color(0xFFD7D7D7),
            Color(0xFFBBBBBB),
            Color(0xFF898989),
            Color(0xFF8C8C8C),
            Color(0xFFD9D8D6),
            Color(0xFF777777),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 0:
        return LinearGradient(
          colors: [
            Color(0xFFF9BC2E),
            Color(0xFFE29A1E),
            Color(0xFFFFCD38),
            Color(0xFFF0AF30),
            Color(0xFFE29A1E),
            Color(0xFFFFCD38),
            Color(0xFFDD931A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return LinearGradient(
          colors: [
            Color(0xFFF97619),
            Color(0xFFFDE3D1),
            Color(0xFFE1650B),
            Color(0xFFF3771F),
            Color(0xFFF47B25),
            Color(0xFFFBD2B4),
            Color(0xFFE2650C),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }
}
