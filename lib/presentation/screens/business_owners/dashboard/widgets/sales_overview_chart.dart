/*
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_app/presentation/components/custom_text/custom_text.dart';
import 'package:pet_app/utils/app_colors/app_colors.dart';
import 'package:pet_app/utils/app_const/padding_constant.dart';

class SalesOverviewChart extends StatefulWidget {

  const SalesOverviewChart({super.key});

  @override
  State<SalesOverviewChart> createState() => _SalesOverviewChartState();
}

class _SalesOverviewChartState extends State<SalesOverviewChart> {
  final List<double> greenBarData = [600, 800, 700, 720, 550, 680, 790, 120, 600, 530, 850, 640];

  final List<double> orangeBarData = [850, 300, 520, 290, 830, 670, 320, 540, 700, 450, 630, 320];

  String selectedView = 'Monthly';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blueColor50,
      margin: padding12,
      padding: EdgeInsets.only(top: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText( text: "salesOverview ,($selectedView)",fontSize: 16,),
              Container(
                color: AppColors.purple500,
                child: SizedBox(
                  height: 20.w,
                  child: DropdownButton<String>(
                    padding: padding6H,
                    value: selectedView,
                    dropdownColor: AppColors.kPrimaryLightDarkColor,
                    underline: SizedBox(),
                    icon: Icon(Icons.keyboard_arrow_down_sharp,size: 15.sp,),
                    iconEnabledColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    items: ['Monthly', 'weekly'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedView = value!;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 1000,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false, reservedSize: 30,),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        return Text(months[value.toInt()], style: TextStyle(fontSize: 8));
                      },
                      reservedSize: 30,
                      interval: 1,
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(12, (i) {
                  return BarChartGroupData(x: i, barRods: [
                    BarChartRodData(
                      toY: greenBarData[i],
                      color: AppColors.greenNormal,
                      width: 4,
                    ),
                    BarChartRodData(
                      toY: orangeBarData[i],
                      color: AppColors.primarColor,
                      width: 4,
                    ),

                  ], showingTooltipIndicators: []);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
