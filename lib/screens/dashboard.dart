import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../theme.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _tabPages = [
    Center(child: Text('Home', style: AppTextStyles.heading)),
    Center(child: Text('Reports', style: AppTextStyles.heading)),
    Center(child: Text('Sync', style: AppTextStyles.heading)),
    Center(child: Text('Profile', style: AppTextStyles.heading)),
  ];

  String getFormattedDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d, y').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.screen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_selectedIndex == 0) ...[
                _buildAppBar(),
                SizedBox(height: 12.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(1.h),
                  decoration: BoxDecoration(
                    color: Color(0xFF0B0F2F),
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getFormattedDate(),
                        style: AppTextStyles.subHeading.copyWith(
                          fontSize: 13.sp,
                          color: Color(0xFFFEFEFE), // Light text
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _buildTodaySummarySection(),
                    ],
                  ),
                ),


                SizedBox(height: 16.h),
                _buildActionButtonsRow(),
                SizedBox(height: 18.h),
                _buildDailyCollectionChart(),
                SizedBox(height: 20.h),
                _buildDailyCostBreakdownChart(),
              ] else
                _tabPages[_selectedIndex],
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.buttonDark,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.textPrimary,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.sync), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),

    );

  }

  Widget _buildAppBar(){
    return Container(
      padding: EdgeInsets.all(24.h),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [

              Container(
                width: 30.h,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15.h)
                ),
              ),

              SizedBox(width: 16.h,),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome to',
                      style: AppTextStyles.subHeading,
                  ),
                  Text(
                    'Cattle Hut Department',
                    style: AppTextStyles.heading,
                  )
                ],
              )
            ],
          ),

          Stack(
            children: [
                Image.asset(
                  'assets/images/notifi.png',
                  height: 24.h,
                  width: 24.h,
                ),
              Positioned(
                  top: -4.h,
                  right: -4.h,
                  child: Container(
                    width: 14.h,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: AppColors.accentOrange,
                      border: Border.all(color: AppColors.buttonDark, width: 2.h),
                      borderRadius: BorderRadius.circular(7.h)
                    ),
                  )
                  )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTodaySummarySection() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Color(0xFF0D0F1C), // background color
        borderRadius: BorderRadius.circular(20.h),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 30.h,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT COLUMN
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔘 View Summary Button
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Color(0xFF1C1F32),
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12.sp, color: Colors.white),
                    SizedBox(width: 6.w),
                    Text(
                      'View Summary',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // 🟠 Custom Circular Indicator
              Container(
                width: 130.w,
                height: 130.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.12),
                      Colors.transparent,
                    ],
                    radius: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 65.w,
                      lineWidth: 8.w,
                      percent: 0.75,
                      animation: true,
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Colors.transparent,
                      progressColor: Colors.white,
                      center: SizedBox.shrink(),
                    ),

                    // 🟣 Dotted outer ring
                    Positioned.fill(
                      child: CustomPaint(painter: DottedCirclePainter()),
                    ),

                    // Top percentage label
                    Positioned(
                      top: 24.h,
                      child: Text(
                        "75%",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Center icon + price
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Icon(Icons.local_drink, size: 26.sp, color: Colors.white),
                        Image.asset(
                          'assets/images/milk.jpg',
                          height: 26.sp,
                          width: 26.sp,
                          fit: BoxFit.contain,
                        ),

                        SizedBox(height: 6.h),
                        Text(
                          '₹160/L',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Color(0xFFFF835E), // orange text
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Spacer(),

          /// RIGHT COLUMN (static example values)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(
                title: 'Today\'s Collection',
                data: [
                  _buildDataRow('Local', '18.1 kg', Color(0xFFDADADA), Color(0xFF3A86FF)),
                  _buildDataRow('Kitchen', '10 kg', Color(0xFFDADADA), Color(0xFFC54435)),
                  _buildDataRow('Total', '28.1 kg', Color(0xFFFBFBFB), Color(0xFF188869), isBold: true),
                ],
              ),
              SizedBox(height: 10.h),
              _buildInfoCard(
                title: 'This Month\'s Total',
                data: [
                  _buildDataRow('Local', '542.3 kg', Color(0xFFDADADA), Color(0xFF3A86FF)),
                  _buildDataRow('Kitchen', '298.7 kg', Color(0xFFDADADA), Color(0xFFC54435)),
                  _buildDataRow('Total', '841 kg', Color(0xFFFBFBFB), Color(0xFF188869), isBold: true),
                ],
              ),
              SizedBox(height: 8.h),
              _buildNetIncomeCard(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> data}) {
    return Container(
      padding: EdgeInsets.all(6.h),
      width: 160.w,
      decoration: BoxDecoration(
        color: Color(0xFF334155),
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
              AppTextStyles.label.copyWith(fontSize: 8.sp, color: AppColors.btnDarkBlueText)),
          SizedBox(height: 6.h),
          ...data,
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value,

      Color labelColor,
      Color valueColor, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: AppTextStyles.label.copyWith(
                fontSize: 10.sp,
                color: labelColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: AppTextStyles.label.copyWith(
                fontSize: 10.sp,
                color: valueColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              )),
        ],
      ),
    );
  }

  Widget _buildNetIncomeCard() {
    return Container(
      padding: EdgeInsets.all(12.h),
      width: 160.w,
      decoration: BoxDecoration(
        color: AppColors.buttonDark,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 12.sp, color: Colors.greenAccent),
              SizedBox(width: 6.w),
              Text('Net Income (MTD)',
                  style: AppTextStyles.label.copyWith(
                      fontSize: 10.sp, color: Colors.white)),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'Rs.1,34,560',
            style: AppTextStyles.heading
                .copyWith(fontSize: 14.sp, color: Colors.white),
          ),
          SizedBox(height: 6.h),
          Text('↑ 2.5% vs last month',
              style: AppTextStyles.label
                  .copyWith(fontSize: 9.sp, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildActionButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ➕ Daily Entry
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Blue
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.h),
              ),
            ),
            onPressed: () {
              // TODO: Add navigation or function
            },
            child: Text(
              '+ Daily Entry',
              style: AppTextStyles.button.copyWith(color: Color(0xFFFBFBFB)),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // ➕ Cost Entry
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonDark, // Dark Blue
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.h),
              ),
            ),
            onPressed: () {
              // TODO: Add navigation or function
            },
            child: Text(
              '+ Cost Entry',
              style: AppTextStyles.button.copyWith(color: Color(0xFFFBFBFB)),
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // 📤 Export
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.btnBkack, // Gray
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.h),
              ),
            ),
            onPressed: () {
              // TODO: Export functionality
            },
            child: Text(
              'Export',
              style: AppTextStyles.button.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyCollectionChart() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Color(0xFF0B0F2F),
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily Collection Trend', style: AppTextStyles.heading),
          SizedBox(height: 16.h),
          SizedBox(
            height: 220.h,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 40,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.white.withOpacity(0.05),
                    strokeWidth: 1,
                  ),
                  getDrawingVerticalLine: (_) => FlLine(
                    color: Colors.white.withOpacity(0.05),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 8,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.h),
                          child: Text(
                            value.toInt().toString(),
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        );
                      },
                    ),
                    axisNameWidget: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text('KG', style: AppTextStyles.label),
                    ),
                    axisNameSize: 24,
                    drawBelowEverything: true,
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const labels = [
                          '1 Dec', '2 Dec', '3 Dec', '4 Dec', '5 Dec', '6 Dec', '7 Dec'
                        ];
                        if (value < 0 || value >= labels.length) return Container();
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            labels[value.toInt()],
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        );
                      },
                    ),
                    axisNameWidget: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text('Date', style: AppTextStyles.label),
                    ),
                    axisNameSize: 24,
                    drawBelowEverything: true,
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _buildLine(AppColors.green, [28, 30, 29, 31, 34, 32, 29]), // Total
                  _buildLine(AppColors.blue,  [16, 17, 16, 18, 20, 19, 17]), // Local
                  _buildLine(AppColors.red,   [12, 13, 12, 13, 14, 13, 11]), // Kitchen
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  LineChartBarData _buildLine(Color color, List<double> values) {
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 0.4,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      dotData: FlDotData(show: false),
      spots: List.generate(
        values.length,
            (index) => FlSpot(index.toDouble(), values[index]),
      ),
    );
  }


  Widget _buildDailyCostBreakdownChart() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily Cost Breakdown', style: AppTextStyles.heading),
          SizedBox(height: 16.h),
          SizedBox(
            height: 250.h,
            child: BarChart(
              BarChartData(
                maxY: 600,
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 100,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const labels = [
                          '1 Dec', '2 Dec', '3 Dec', '4 Dec', '5 Dec', '6 Dec', '7 Dec'
                        ];
                        if (value < 0 || value >= labels.length) return Container();
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Text(
                            labels[value.toInt()],
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 10.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                barGroups: _generateBarGroups(),
                groupsSpace: 16.w,
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    final data = [
      [480, 160, 300, 200], // 1 Dec
      [500, 170, 280, 210], // 2 Dec
      [470, 180, 310, 220], // 3 Dec
      [460, 175, 290, 215], // 4 Dec
      [520, 190, 330, 230], // 5 Dec
      [490, 165, 305, 225], // 6 Dec
      [510, 185, 295, 210], // 7 Dec
    ];

    return List.generate(data.length, (i) {
      final dayData = data[i];
      return BarChartGroupData(
        x: i,
        barRods: List.generate(
          dayData.length,
              (j) => BarChartRodData(
            toY: dayData[j].toDouble(),
            width: 6.w,
            color: _getBarColor(j),
            borderRadius: BorderRadius.zero,
          ),
        ),
      );
    });
  }

  Color _getBarColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF2C3E66); // Punnaku - Dark Blue
      case 1:
        return Colors.white; // Vitamins - White
      case 2:
        return const Color(0xFF57CAC4); // Feed - Teal
      case 3:
        return const Color(0xFF224D3A); // Other - Dark Green
      default:
        return Colors.grey;
    }
  }

}


class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    for (int i = 0; i < 30; i++) {
      double angle = (i / 30) * 2 * pi;
      final dx = center.dx + (radius + 4) * cos(angle);
      final dy = center.dy + (radius + 4) * sin(angle);
      canvas.drawCircle(Offset(dx, dy), 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
