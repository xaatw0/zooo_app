import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zooo_app/logic/entry_fee.dart';
import 'package:zooo_app/ui/pages/fee_calculator/fee_calculator_model.dart';
part 'fee_calculator_provider.g.dart';

@riverpod
class FeeCalculatorProvider extends _$FeeCalculatorProvider {
  @override
  FeeCalculatorModel build() => FeeCalculatorModel.zero();

  void increase(AgeGroup ageGroup) {
    switch (ageGroup) {
      case AgeGroup.adult:
        state = state.copyWith(adultCount: state.adultCount + 1);
      case AgeGroup.child:
        state = state.copyWith(childCount: state.childCount + 1);
      case AgeGroup.senior:
        state = state.copyWith(seniorCount: state.seniorCount + 1);
    }
  }

  void decrease(AgeGroup ageGroup) {
    switch (ageGroup) {
      case AgeGroup.adult:
        if (state.adultCount == 0) {
          return;
        }
        state = state.copyWith(adultCount: state.adultCount - 1);

      case AgeGroup.child:
        if (state.childCount == 0) {
          return;
        }
        state = state.copyWith(childCount: state.childCount - 1);

      case AgeGroup.senior:
        if (state.seniorCount == 0) {
          return;
        }
        state = state.copyWith(seniorCount: state.seniorCount - 1);
    }
  }

  void reset() => state = FeeCalculatorModel.zero();

  void selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: state.currentTime,
      firstDate: state.currentTime.subtract(const Duration(days: 30)),
      lastDate: state.currentTime.add(const Duration(days: 30)),
    );

    if (selectedDate == null || !context.mounted) return null;
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(state.currentTime),
    );

    if (selectedTime != null) {
      state = state.copyWith(
        currentTime: DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, selectedTime.hour, selectedTime.minute),
      );
    }
  }
}
