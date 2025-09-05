import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pet_app/presentation/components/custom_button/custom_defualt_appbar.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class PetHealthScreen extends StatefulWidget {
  const PetHealthScreen({super.key});

  @override
  State<PetHealthScreen> createState() => _PetHealthScreenState();
}

class _PetHealthScreenState extends State<PetHealthScreen>
    with TickerProviderStateMixin {
  late TabController _healthTabController;

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
                SingleChildScrollView(
                  padding: EdgeInsets.all(12.w),
                  child: const TreatmentCard(),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.all(12.w),
                  child: const TreatmentCard(),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable Treatment Card Widget
class TreatmentCard extends StatelessWidget {
  const TreatmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Treatment Name: Rabies vaccination",
            style: TextStyle(
              color: Colors.green,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          Text(
            "Doctor Name: Jane Cooper",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
          Gap(4.h),
          Text(
            "Treatment Date: Fri 28 Sep25/ at 11:30 am -12:00pm",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
            ),
          ),
          Gap(4.h),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 18),
              Gap(4.w),
              Expanded(
                child: Text(
                  "Oldesloer Strasse 82",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            "Treatment Description",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          Gap(6.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.green.withOpacity(0.4)),
            ),
            child: Text(
              "My Pet offers safe and reliable treatment services to keep your pet healthy. "
                  "We provide health check-ups, vaccinations, and basic care for common issues. "
                  "Every treatment is designed with love and care for your furry friend.",
              style: TextStyle(
                fontSize: 12.5.sp,
                color: Colors.black87,
              ),
            ),
          ),
          Gap(10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.green.shade700,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                "Completed",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
