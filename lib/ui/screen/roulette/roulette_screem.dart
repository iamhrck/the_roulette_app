import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/ui/components/app_bar.dart';
import 'package:the_roulette_app/shared/constants/app_colors.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';

class RouletteScreen extends StatelessWidget {
  const RouletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Strings.appTitle),
        body: Container(
          margin: const EdgeInsets.all(24),
          alignment: Alignment.center,
          child: const SingleChildScrollView(
            child:
                Column(mainAxisSize: MainAxisSize.max, children: [_Roulette()]),
          ),
        ));
  }
}

class _Roulette extends StatefulWidget {
  const _Roulette();

  @override
  _RouletteState createState() => _RouletteState();
}

class _RouletteState extends State<_Roulette>
    with SingleTickerProviderStateMixin {
  bool _isAnimating = false;
  late AnimationController _controller;

  void _switchAnimation() {
    if (_isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
    _isAnimating = !_isAnimating;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 100), // 一旦5秒
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _switchAnimation,
      child: LimitedBox(
        maxHeight: size.width,
        maxWidth: size.width,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(alignment: Alignment.topCenter, children: [
              Transform.rotate(
                angle: _controller.value * 2000,
                child: _buildRoulette(size),
              ),
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(double.infinity),
                    bottomLeft: Radius.circular(double.infinity),
                  ),
                ),
              )
            ]);
          },
        ),
      ),
    );
  }

  Widget _buildRoulette(Size deviceSize) {
    final List<PieChartSectionData> chartData = [
      PieChartSectionData(
          value: 1,
          radius: deviceSize.width / 2.5,
          color: Colors.blue,
          title: "Blue",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: deviceSize.width / 2.5,
          color: Colors.red,
          title: "Red",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 1,
          radius: deviceSize.width / 2.5,
          color: Colors.green,
          title: "Green",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white)),
      PieChartSectionData(
          value: 5,
          radius: deviceSize.width / 2.5,
          color: Colors.orange,
          title: "Orange",
          titleStyle: AppTextStyle.headline4.copyWith(color: AppColors.white))
    ];

    return PieChart(
      PieChartData(
        sections: chartData,
        centerSpaceRadius: 0,
      ),
    );
  }
}
