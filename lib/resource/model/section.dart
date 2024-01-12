import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Section extends Equatable {
  final int id;
  final bool isSkip;
  final bool isTarget;
  String sectionName;
  String ratio;
  int ratioSumFromThis;

  Section({
    required this.id,
    this.isSkip = false,
    this.isTarget = false,
    this.sectionName = '',
    this.ratio = '1',
    this.ratioSumFromThis = 0,
  });

  Section copyWith({
    int? id,
    bool? isSkip,
    bool? isTarget,
    String? sectionName,
    String? ratio,
  }) {
    return Section(
        id: id ?? this.id,
        isSkip: isSkip ?? this.isSkip,
        isTarget: isTarget ?? this.isTarget,
        sectionName: sectionName ?? this.sectionName,
        ratio: ratio ?? this.ratio);
  }

  @override
  List<Object?> get props {
    return [id, isSkip, isTarget, sectionName, ratio, ratioSumFromThis];
  }
}
