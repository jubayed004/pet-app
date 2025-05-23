/*
import 'package:betwise_app/presentation/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

*/
/*
class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color? textColor;
  final bool? isTextColorActive;
  final bool? isPadding;
  final double fontSize;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.selectedColor,
    required this.unselectedColor,
    this.textColor,
    this.isTextColorActive = false,
    this.isPadding = true,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Makes tabs scrollable if they overflow
      child: Container(
        margin: EdgeInsets.zero,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0,
              color: unselectedColor,
            ),
          ),
        ),
        padding: isPadding!
            ? const EdgeInsets.symmetric(horizontal: 0)
            : const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Prevent forced spacing
          children: List.generate(tabs.length, (index) {
            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Expanded( // Ensures each tab shares available space equally
                child: Container(
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width / tabs.length,
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selectedIndex == index
                            ? selectedColor
                            : const Color(0xffD0DEFD),
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Text(
                    tabs[index],
                    style: GoogleFonts.poppins(
                      color: selectedIndex == index
                          ? selectedColor
                          : isTextColorActive!
                          ? textColor
                          : unselectedColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,

                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
*//*




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final Color? textColor;
  final bool? isTextColorActive;
  final bool? isPadding;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.selectedColor,
    required this.unselectedColor,
    this.textColor,
    this.isTextColorActive = false,
    this.isPadding = true,
    this.fontSize = 14,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Makes tabs scrollable if they overflow
      child: Container(
        alignment: Alignment.center,
        padding: isPadding == true
            ? EdgeInsets.symmetric(horizontal: 0.w)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 2,
              color: unselectedColor,
            ),
          ),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            return GestureDetector(
              onTap: () => onTabSelected(index),
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.zero,
                  alignment: Alignment.center,
                  width: MediaQuery.sizeOf(context).width/ tabs.length,
                  decoration: BoxDecoration(
                    border: selectedIndex == index
                        ? Border(
                      bottom: BorderSide(
                        color: selectedColor,
                        width: 2,
                      ),
                    )
                        : null,
                  ),
                  child: Padding(
                    padding: padding ??EdgeInsets.symmetric(horizontal: 0.w),
                    child: CustomText(
                      text: tabs[index],
                      fontSize: selectedIndex == index
                          ? 14.sp
                          : fontSize.sp,
                      fontWeight: selectedIndex == index
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: selectedIndex == index
                          ? selectedColor
                          : isTextColorActive == true
                          ? textColor
                          : unselectedColor,
                      maxLines: 1,

                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}


*/
