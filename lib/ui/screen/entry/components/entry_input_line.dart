import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_roulette_app/resource/model/section.dart';
import 'package:the_roulette_app/shared/constants/assets.dart';

class EntryInutLine extends HookWidget {
  final Section section;
  final Function onRemoved;

  const EntryInutLine(
      {super.key, required this.section, required this.onRemoved});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final ratioController = useTextEditingController();

    // useTextEditingControllerの引数に値を設定することでcontrollerの初期値を設定できるようだが
    // widgetの再描画時に前回の値が引き継がれることがあるため以下のように初期化する
    nameController.text = section.sectionName;
    ratioController.text = section.ratio.toString();

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '項目名',
            ),
            onChanged: (sectionName) {
              section.sectionName = sectionName;
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: TextField(
            controller: ratioController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '割合',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (ratio) {
              section.ratio = ratio;
            }, // Only numbers can be entered
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            onRemoved(section.id);
          },
          child: SvgPicture.asset(Assets.delete, width: 32, height: 32),
        ),
      ],
    );
  }
}
