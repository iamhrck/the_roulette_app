import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_bloc.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_event.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_state.dart';
import 'package:the_roulette_app/ui/components/app_bar.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';

class RouletteScreen extends StatelessWidget {
  const RouletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Strings.appTitle),
        body: BlocProvider(
            lazy: false,
            create: (context) => RouletteBloc()..add(GetPieDataEvent()),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: const SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  _RouletteScreenLeadText(),
                  SizedBox(height: 28),
                  _Roulette(),
                  _RouletteGuideArea(),
                ]),
              ),
            )));
  }
}

class _RouletteScreenLeadText extends StatelessWidget {
  const _RouletteScreenLeadText();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(builder: (context, state) {
      if (state.result.isEmpty) {
        return Text(Strings.rouletteLeadMessage, style: AppTextStyle.headline3);
      } else {
        return Text(state.result,
            style:
                AppTextStyle.headline3.copyWith(color: state.getWinnerColor()));
      }
    });
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
      // 0.18を加算してタップされた地点からアニメーション終了までほんのり動かす
      // FIXME: ここの誰に当てるかを判定する処理は別ファイルに移したい
      double endpoint = _controller.value + 0.18;

      _controller
          .animateTo(
        endpoint,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
      )
          .whenComplete(() {
        context.read<RouletteBloc>().add(JudgeWinnerEvent(endpoint: endpoint));
      });
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
      upperBound: 10,
      duration: const Duration(seconds: 4),
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

    return BlocBuilder<RouletteBloc, RouletteState>(
      builder: (context, state) {
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
                    angle: -(_controller.value * 2 * 3.14),
                    child: _buildRoulette(state.pieDataList, size),
                  ),
                  SvgPicture.asset('assets/roulette_arrow.svg',
                      width: 30, height: 54)
                ]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoulette(List<PieChartSectionData> data, Size size) {
    // 端末サイズのようなUIに限った話はstateで管理するPieChartSectionDataには含めたくない
    // stateから取得したPieChartSectionDataをmapしてradiusだけ加工してWidgetに適用する
    List<PieChartSectionData> chartData = data.map((pie) {
      return pie.copyWith(radius: size.width / 2.5);
    }).toList();

    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        sections: chartData,
        centerSpaceRadius: 0,
      ),
    );
  }
}

class _RouletteGuideArea extends StatelessWidget {
  const _RouletteGuideArea();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      builder: (context, state) {
        return Wrap(
            direction: Axis.horizontal, children: _buildRouletteGuide(state));
      },
    );
  }

  List<Widget> _buildRouletteGuide(RouletteState state) {
    return state.pieDataList.map((element) {
      return Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: element.color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(element.title, style: AppTextStyle.bodyText)
          ],
        ),
      );
    }).toList();
  }
}
