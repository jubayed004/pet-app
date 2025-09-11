import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pet_app/controller/get_controllers.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key, this.index = 0});

  final int index;

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _controller = GetControllers.instance.getNavigationControllerMain();

  @override
  void initState() {
    super.initState();
    _controller.selectedNavIndex.value = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return IndexedStack(index: _controller.selectedNavIndex.value, children: _controller.getPages());
            }),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 20, top: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20.r)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                List.generate(
                  _controller.icons.length,
                  (index) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _controller.selectedNavIndex.value = index;
                      },
                      child: Obx(() {
                        bool isSelected = _controller.selectedNavIndex.value == index;
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (isSelected)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                transform: Matrix4.translationValues(0, -20, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(0.2), blurRadius: 4.r, offset: Offset(0, 4))],
                                ),
                                padding: EdgeInsets.all(6),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primaryColor : Colors.transparent,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(0.2), blurRadius: 4.r, offset: Offset(0, 4))],
                                  ),
                                  child: SvgPicture.asset(
                                    _controller.icons[index],
                                    colorFilter: ColorFilter.mode(isSelected ? AppColors.purple500 : AppColors.purple500, BlendMode.srcIn),
                                  ),
                                ),
                              )
                            else
                              SvgPicture.asset(_controller.icons[index], colorFilter: ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
                            if (!isSelected)
                              Padding(
                                padding: EdgeInsets.only(top: 4.w),
                                child: CustomText(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.white,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: _controller.labels[index],
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ).toList(),
          ),
        ),
      ),
    );
  }
}
