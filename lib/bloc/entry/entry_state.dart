import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';

class EntryState extends Equatable {
  final String result;
  final List<Section> sections;

  const EntryState({this.result = '', required this.sections});

  EntryState copyWith({
    String? result,
    List<Section>? sections,
  }) {
    return EntryState(
        result: result ?? this.result, sections: sections ?? this.sections);
  }

  bool isValid() {
    var inValids = sections
        .map((section) {
          if (!RegExp(r'^\d+$').hasMatch(section.ratio)) {
            section.ratio = '';
          }
          return section;
        })
        .where((section) => section.sectionName.isEmpty)
        .length;
    return sections.isNotEmpty && inValids == 0;
  }

  @override
  List<Object> get props => [result, sections];
}

extension SectionListExt on List<Section> {
  List<PieChartSectionData> toPieChartSection() {
    final List<Color> colors = [
      Colors.blue.withOpacity(0.85),
      Colors.red.withOpacity(0.85),
      Colors.green.withOpacity(0.85),
      Colors.orange.withOpacity(0.85),
      Colors.purple.withOpacity(0.85),
      Colors.pink.withOpacity(0.85),
      Colors.brown.withOpacity(0.85),
      Colors.grey.withOpacity(0.85),
      Colors.lime.withOpacity(0.85),
      Colors.black.withOpacity(0.85),
    ];

    return map((section) {
      return PieChartSectionData(
          value: double.parse(section.ratio),
          radius: 100,
          color: colors.removeAt(0),
          title: section.sectionName,
          titleStyle: AppTextStyle.headline4);
    }).toList();
  }
}
