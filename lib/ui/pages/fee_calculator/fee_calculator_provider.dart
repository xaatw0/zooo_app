import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:zooo_app/logic/entry_fee.dart';
import 'package:zooo_app/ui/pages/fee_calculator/fee_calculator_logic.dart';
import 'package:zooo_app/ui/pages/fee_calculator/fee_calculator_model.dart';
part 'fee_calculator_provider.g.dart';

@riverpod
class FeeCalculatorProvider extends _$FeeCalculatorProvider {
  final _logic = FeeCalculatorLogic();

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

  void changeFeeType(FeeType? feeType) {
    state = state.copyWith(feeType: feeType);
  }

  int calcTotalSalesAmount(Map<FeeType, EntryFee> map) {
    return _logic.calcTotalAmount(
      map[state.feeType]!,
      state.currentTime,
      state.adultCount,
      state.childCount,
      state.seniorCount,
    );
  }

  int calcTotalAmountBeforeAdjustmentMap(Map<FeeType, EntryFee> map) {
    return _logic.calcTotalAmountBeforeAdjustmentMap(
      map[state.feeType]!,
      state.adultCount,
      state.childCount,
      state.seniorCount,
    );
  }

  String getAdjustmentDetails() => _logic.getAdjustmentDetails(
        state.currentTime,
        state.adultCount,
        state.childCount,
        state.seniorCount,
      );
}
