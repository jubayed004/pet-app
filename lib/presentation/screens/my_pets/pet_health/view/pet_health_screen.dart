import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

import '../widgets/health_history_card.dart';
import '../widgets/treatment_card.dart';

class PetHealthScreen extends StatefulWidget {
  final String id;
  const PetHealthScreen({super.key, required this.id});

  @override
  State<PetHealthScreen> createState() => _PetHealthScreenState();
}

class _PetHealthScreenState extends State<PetHealthScreen> with TickerProviderStateMixin {late TabController _healthTabController;


  final petHealthController = GetControllers.instance.getPetHealthController();

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText(text: "Pet Health",fontSize: 16,
        fontWeight: FontWeight.w600,),
        centerTitle: true,
      ),
      body: Column(
        children: [

          /// TabBar
          TabBar(
            controller: _healthTabController,
            labelColor: const Color(0xffFF914C),
            indicatorColor: const Color(0xffFF914C),
            unselectedLabelColor: Colors.black,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
            ],
          ),

          /// TabBarView with Expanded
          Expanded(
            child: TabBarView(
              controller: _healthTabController,
              children: [
                /// Pending Tab
                TreatmentCard(
                  controller: petHealthController,
                  id: widget.id,
                  status: "PADDING",

                ),
                TreatmentCard(
                  controller: petHealthController,
                  id: widget.id,
                  status: "COMPLETED",
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}



