import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_app/presentation/screens/business_owners/business_chat/business_chat_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_home/business_home_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/business_profile/business_profile_screen.dart';
import 'package:pet_app/presentation/screens/business_owners/dashboard/dashboard_screen.dart';
import 'package:pet_app/presentation/screens/chat/view/chatting_page.dart';
import 'package:pet_app/presentation/screens/chat/view/message_page.dart';


class BusinessNavigationControllerMain extends GetxController {
  static BusinessNavigationControllerMain get to => Get.find();

  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [
      BusinessHomeScreen(),
      DashboardScreen(),
      MessageListPage(),
      BusinessProfileScreen(),

    ];
  }

  // List of icons for the navigation bar
  final List<String> icons = [
    "assets/icons/homeicon.svg",
    "assets/icons/exploreicon.svg",
    "assets/icons/chaticon.svg",
    "assets/icons/profileicon.svg",
  ];

  // List of labels for the navigation bar
  final List<String> labels = [
    "Home",
    "Dashboard",
    "Chat",
    "Profile",
  ];
}
