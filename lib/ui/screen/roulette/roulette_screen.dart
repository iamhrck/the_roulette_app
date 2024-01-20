import 'package:audioplayers/audioplayers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_roulette_app/bloc/entry/entry_state.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_bloc.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_event.dart';
import 'package:the_roulette_app/bloc/roulette/roulette_state.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/shared/constants/assets.dart';
import 'package:the_roulette_app/ui/components/app_bar.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';

class RouletteScreen extends StatelessWidget {
  //final List<PieChartSectionData> sections;
  final List<Section> sections;

  const RouletteScreen({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: Strings.appTitle),
        body: BlocProvider(
            lazy: false,
            create: (context) =>
                RouletteBloc()..add(GetPieDataEvent(sections: sections)),
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
      switch (state.animation) {
        case RouletteAnimation.stop:
          return state.result.isEmpty
              ? Column(
                  children: [
                    Text(Strings.rouletteLeadMessage,
                        style: AppTextStyle.headline3),
                    const Text(Strings.space, style: AppTextStyle.bodyText),
                  ],
                )
              : Column(
                  children: [
                    Text(
                      state.result,
                      style: AppTextStyle.headline3
                          .copyWith(color: state.getWinnerColor()),
                    ),
                    const Text(Strings.rouletteRestartMessage,
                        style: AppTextStyle.bodyText)
                  ],
                );
        case RouletteAnimation.inprogress:
          return Column(
            children: [
              Text(Strings.rouletteStopMessage, style: AppTextStyle.headline3),
              const Text(Strings.space, style: AppTextStyle.bodyText),
            ],
          );
        default:
          return Column(
            children: [
              Text(Strings.space, style: AppTextStyle.headline3),
              const Text(Strings.space, style: AppTextStyle.bodyText),
            ],
          );
      }
    });
  }
}

class _Roulette extends HookWidget {
  const _Roulette();

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      upperBound: 100,
      duration: const Duration(seconds: 30),
    );

    final audioPlayer = AudioPlayer();

    useEffect(() {
      return () {
        audioPlayer.dispose();
      };
    }, const []);

    void switchAnimation() {
      RouletteAnimation animation =
          BlocProvider.of<RouletteBloc>(context).state.animation;

      switch (animation) {
        case RouletteAnimation.stop:
          context.read<RouletteBloc>().add(SwitchAnimationEvent());
          controller.repeat();
          audioPlayer.play(AssetSource('drum_roll_start.m4a'));
          audioPlayer.setReleaseMode(ReleaseMode.loop);
          break;

        case RouletteAnimation.inprogress:
          context.read<RouletteBloc>().add(SwitchAnimationEvent());
          // 0.18を加算してタップされた地点からアニメーション終了までほんのり動かす
          // FIXME: ここの誰に当てるかを判定する処理は別ファイルに移したい
          double endpoint = controller.value + 0.18;

          controller
              .animateTo(
            endpoint,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOut,
          )
              .whenComplete(() {
            context
                .read<RouletteBloc>()
                .add(JudgeWinnerEvent(endpoint: endpoint));
            context.read<RouletteBloc>().add(SwitchAnimationEvent());

            audioPlayer
                .play(AssetSource('drum_roll_end.m4a'))
                .then((_) => audioPlayer.setReleaseMode(ReleaseMode.stop));
          });
          break;

        case RouletteAnimation.waitting:
          break;
      }
    }

    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<RouletteBloc, RouletteState>(
      buildWhen: (p, c) => p.sections.length != c.sections.length,
      builder: (context, state) {
        return GestureDetector(
          onTap: switchAnimation,
          child: LimitedBox(
            maxHeight: size.width,
            maxWidth: size.width,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Stack(alignment: Alignment.topCenter, children: [
                  Transform.rotate(
                    angle: -(controller.value * 2 * 3.14),
                    child: _buildRoulette(state.sections, size),
                  ),
                  SvgPicture.asset(Assets.rouletteArrow, width: 30, height: 54)
                ]);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildRoulette(List<Section> sections, Size size) {
    // 端末サイズのようなUIに限った話はstateで管理しない
    // stateから生成するPieChartSectionDataをmapしてradiusだけ加工してWidgetに適用する
    List<PieChartSectionData> chartData =
        sections.toPieChartSection().map((pie) {
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
      buildWhen: (p, c) => p.sections.length != c.sections.length,
      builder: (context, state) {
        return Wrap(
            direction: Axis.horizontal, children: _buildRouletteGuide(state));
      },
    );
  }

  List<Widget> _buildRouletteGuide(RouletteState state) {
    return state.sections.toPieChartSection().map((element) {
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

enum RouletteAnimation { stop, inprogress, waitting }
