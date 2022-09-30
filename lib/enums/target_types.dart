import 'package:flutter_app/enums/enums.dart';
import 'package:flutter_app/generated/assets.dart';
import 'package:flutter_app/locales/localizes.dart';
import 'package:flutter_app/models/user/target_model.dart';
import 'package:get/get.dart';

enum TargetType {
  menstrual_period,
  get_pregnant,
  follow_pregnant,
  follow_pregnant_menstrual
}

class TargetTypes {
  static final followPeriod = TargetModel(
    icon: Assets.imagesPeriodCalendar,
    title: Localizes.followMyMenstrual.tr,
    subTitle: Localizes.menstrualMode.tr,
    targetType: TargetType.menstrual_period.name,
  );

  static final getPregnant = TargetModel(
    icon: Assets.imagesPregnancyTest,
    title: Localizes.tryPregnant.tr,
    subTitle: Localizes.willPregnantMode.tr,
    targetType: TargetType.get_pregnant.name,
  );

  static final followPregnant = TargetModel(
    icon: Assets.imagesPregnantFollow,
    title: Localizes.followMyPregnancy.tr,
    subTitle: Localizes.pregnancyMode.tr,
    targetType: TargetType.follow_pregnant.name,
  );

}
