import 'package:zooo_app/logic/entry_fee.dart';
import 'package:zooo_app/logic/price_determining_factors/day_of_week_discount.dart';
import 'package:zooo_app/logic/price_determining_factors/evening_discount.dart';
import 'package:zooo_app/logic/price_determining_factors/group_discount.dart';
import 'package:zooo_app/logic/price_determining_factors/holiday_surcharge.dart';
import 'package:zooo_app/logic/price_determining_factors/price_determining_process.dart';

class FeeCalculatorLogic {
  int calcTotalAmountBeforeAdjustmentMap(
      EntryFee fees, int adultCount, int childCount, int seniorCount) {
    return fees.adult * adultCount +
        fees.child * childCount +
        fees.senior * seniorCount;
  }

  int calcTotalAmount(
    EntryFee fees,
    DateTime currentTime,
    int adultCount,
    int childCount,
    int seniorCount,
  ) {
    final PriceDeterminingProcess processor =
        GroupDiscount(adultCount + seniorCount, childCount);
    processor
        .setNext(EveningDiscount(currentTime))
        .setNext(HolidaySurcharge(currentTime))
        .setNext(DayOfWeekDiscount(currentTime));

    return processor.proceedPrice(fees.adult) * adultCount +
        processor.proceedPrice(fees.child) * childCount +
        processor.proceedPrice(fees.senior) * seniorCount;
  }

  String getAdjustmentDetails(
      DateTime currentTime, int adultCount, int childCount, int seniorCount) {
    final PriceDeterminingProcess processor =
        GroupDiscount(adultCount + seniorCount, childCount);
    processor
        .setNext(EveningDiscount(currentTime))
        .setNext(HolidaySurcharge(currentTime))
        .setNext(DayOfWeekDiscount(currentTime));
    final result = processor.proceedDetail('');
    return result.isEmpty ? '適応なし' : result.substring(0, result.length - 1);
  }
}
