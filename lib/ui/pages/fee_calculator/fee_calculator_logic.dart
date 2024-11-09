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
    EntryFee entryFee,
    DateTime currentTime,
    int adultCount,
    int childCount,
    int seniorCount,
  ) {
    final PriceDeterminingProcess process =
        GroupDiscount(adultCount + seniorCount, childCount);
    process
        .setNext(EveningDiscount(currentTime))
        .setNext(HolidaySurcharge(currentTime))
        .setNext(DayOfWeekDiscount(currentTime));

    return 0;
  }
}
