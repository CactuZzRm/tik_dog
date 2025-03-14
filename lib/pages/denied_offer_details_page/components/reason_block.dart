import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_dog/pages/denied_offer_details_page/cubit/denied_offer_details_cubit.dart';

import '../../../themes.dart';

class ReasonBlock extends StatelessWidget {
  final String text;
  final int index;
  final int? selectedReasonIndex;
  const ReasonBlock({super.key, required this.text, required this.index, required this.selectedReasonIndex});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DeniedOfferDetailsCubit>();
    final reasonHints = context.read<DeniedOfferDetailsCubit>().reasonHints;

    return InkWell(
      onTap: () => model.selectReasonByIndex(index),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: index == selectedReasonIndex
                        ? AdaptiveTheme.of(context).mode.isDark
                            ? const Color.fromRGBO(255, 29, 101, 1)
                            : const Color.fromRGBO(181, 61, 173, 1)
                        : const Color.fromRGBO(128, 128, 128, 1),
                  ),
                ),
                child: index == selectedReasonIndex
                    ? Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AdaptiveTheme.of(context).mode.isDark
                              ? const Color.fromRGBO(255, 29, 101, 1)
                              : const Color.fromRGBO(181, 61, 173, 1),
                        ),
                      )
                    : const SizedBox(height: 14, width: 14),
              ),
            ],
          ),
          if (selectedReasonIndex != null && selectedReasonIndex == index) ...[
            const SizedBox(height: 16),
            ReasonTextField(
              hintText: reasonHints[index],
            ),
          ],
        ],
      ),
    );
  }
}

class ReasonTextField extends StatelessWidget {
  final String hintText;
  const ReasonTextField({
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<DeniedOfferDetailsCubit>();

    return TextField(
      minLines: 2,
      maxLines: 2,
      style: const TextStyle(fontSize: 15, height: 1.22),
      onChanged: (value) => model.editTextReason(value),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 18,
          right: 16,
          bottom: 25,
          left: 16,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonTextFieldHintColor!,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromRGBO(137, 137, 137, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
