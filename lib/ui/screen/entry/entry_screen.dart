import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_roulette_app/bloc/entry/entry_bloc.dart';
import 'package:the_roulette_app/bloc/entry/entry_event.dart';
import 'package:the_roulette_app/bloc/entry/entry_state.dart';
import 'package:the_roulette_app/shared/constants/app_colors.dart';
import 'package:the_roulette_app/shared/constants/app_text_style.dart';
import 'package:the_roulette_app/shared/constants/strings.dart';
import 'package:the_roulette_app/shared/router/app_router.dart';
import 'package:the_roulette_app/ui/components/app_alert_dialog.dart';
import 'package:the_roulette_app/ui/components/app_bar.dart';
import 'package:the_roulette_app/ui/components/app_button.dart';
import 'package:the_roulette_app/ui/screen/entry/components/entry_input_line.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.appTitle),
      body: BlocProvider(
        create: (_) => EntryBloc(),
        child: const _EntryScreenContents(),
      ),
    );
  }
}

class _EntryScreenContents extends StatelessWidget {
  const _EntryScreenContents();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              Strings.rouletteEntryMessage,
              style: AppTextStyle.bodyText,
            ),
            const SizedBox(height: 24),
            const _EntryInputList(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  text: Strings.addEntry,
                  onPressed: () {
                    context.read<EntryBloc>().add(AddSectionEvent());
                  },
                ),
                const SizedBox(width: 24),
                AppButton(
                  text: Strings.rouletteStart,
                  buttonColor: AppColors.deepGreen,
                  onPressed: () {
                    final state = BlocProvider.of<EntryBloc>(context).state;
                    if (state.isValid()) {
                      state.sections.fold(0, (previous, section) {
                        section.ratioSumFromThis =
                            previous + int.parse(section.ratio);
                        return section.ratioSumFromThis;
                      });

                      Navigator.pushNamed(context, AppRouter.roulette,
                          arguments: state.sections);
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => const AppAlertDialog(),
                      );
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EntryInputList extends StatelessWidget {
  const _EntryInputList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
              itemCount: state.sections.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return EntryInutLine(
                    section: state.sections[index],
                    onRemoved: (int id) {
                      context.read<EntryBloc>().add(RemoveSectionEvent(id));
                    });
              }),
        );
      },
    );
  }
}
