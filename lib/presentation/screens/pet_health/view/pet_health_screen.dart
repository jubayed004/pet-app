import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class PetHealthScreen extends StatefulWidget {
  const PetHealthScreen({super.key});

  @override
  State<PetHealthScreen> createState() => _PetHealthScreenState();
}

class _PetHealthScreenState extends State<PetHealthScreen> with TickerProviderStateMixin {
  late TabController _healthTabController;
  late TabController _colorTabController;

  @override
  void initState() {
    super.initState();
    _healthTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _healthTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          /// AppBar
          CustomDefaultAppbar(title: "Pet Health"),
          /// First TabBar & View
          SliverToBoxAdapter(
            child: Column(
              children: [
                TabBar(
                  dividerColor: Colors.white,
                  controller: _healthTabController,
                  labelColor:Color(0xffFF914C),
                  indicatorColor: Color(0xffFF914C),
                  tabs: const [
                    Tab(text: "Wellness"),
                    Tab(text: "Medical Records"),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: TabBarView(
                    controller: _healthTabController,
                    children: [
                      Padding(
                        padding: padding16H,
                        child: Card(
                          color: Colors.white,
                          elevation: 3,
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(text: "Vaccinations",fontSize: 16,fontWeight: FontWeight.w600,),
                                Gap(24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(text: "Rabies vaccination",fontSize: 14,fontWeight: FontWeight.w600,),
                                        CustomText(text: "24th Jan 2022",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                        CustomText(text: "Dr. Nambuvan",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(text: "Calicivirus",fontSize: 14,fontWeight: FontWeight.w600,),
                                        CustomText(text: "12nd Feb 2022",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                        CustomText(text: "Dr. Ram",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: padding16H,
                        child: Card(
                          color: Colors.white,
                          elevation: 3,
                          child: Container(
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(text: "Vaccinations",fontSize: 16,fontWeight: FontWeight.w600,),
                                Gap(24),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(text: "Rabies vaccination",fontSize: 14,fontWeight: FontWeight.w600,),
                                        CustomText(text: "24th Jan 2022",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                        CustomText(text: "Dr. Nambuvan",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CustomText(text: "Calicivirus",fontSize: 14,fontWeight: FontWeight.w600,),
                                        CustomText(text: "12nd Feb 2022",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                        CustomText(text: "Dr. Ram",fontSize: 14,fontWeight: FontWeight.w400,maxLines: 4,),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              ],

            ),
          ),


        ],
      ),
    );
  }
}
