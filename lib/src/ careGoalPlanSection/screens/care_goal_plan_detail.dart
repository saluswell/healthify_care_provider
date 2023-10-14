import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:healthify_care_provider/common/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/care_goal_plan_model.dart';
import '../providers/care_goal_provider.dart';
import '../widgets/care_goal_textfield.dart';
import '../widgets/nutrition_goal_widget.dart';

class CareGoalPlanDetail extends StatelessWidget {
  final CareGoalPlanModel careGoalPlanModel;

  const CareGoalPlanDetail({Key? key, required this.careGoalPlanModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CareGoalProvider>(builder: (context, careGoalProvider, __) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            careGoalPlanModel.goalType.toString(),
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            if (careGoalPlanModel.goalType == "NUTRITION GOALS") ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nutrition's",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 15,
                                color: AppColors.blackcolor,
                                fontWeight: FontWeight.w700),
                          ),
                          Row(
                            children: [
                              Text(
                                "Actual",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Goal",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: NutritionGoalWidget(text: "Carbohydrates")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.carboHydratesActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.carboHydratesTarget,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: NutritionGoalWidget(text: "Protein")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.proteinActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.proteinTarget,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2, child: NutritionGoalWidget(text: "Fat")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.fatActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: careGoalPlanModel.fatTarget,
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ] else if (careGoalPlanModel.goalType ==
                "Water Intake (Glasses)/Day") ...[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Actual",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 15,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "Goal",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 15,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: NutritionGoalWidget(text: "Glasses")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightActual,
                              enabled: false,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightTarget,
                              enabled: false,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ] else if (careGoalPlanModel.goalType == "CALORIES PER DAY") ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Row(
                            children: [
                              Text(
                                "Actual",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 55,
                              ),
                              Text(
                                "Goal",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 15,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child:
                                NutritionGoalWidget(text: "Calories Per Day")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightTarget,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ] else if (careGoalPlanModel.goalType == "WEIGHT GOALS") ...[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              "Actual",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 15,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "Goal",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 15,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 2,
                            child: NutritionGoalWidget(text: "Weight")),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText:
                                  careGoalPlanModel.waterCaloriesWeightTarget,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ] else if (careGoalPlanModel.goalType == "EXERCISE GOALS") ...[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: NutritionGoalWidget(
                              text: careGoalPlanModel.exerciseType.toString(),
                              width: MediaQuery.sizeOf(context).width,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Actual",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Goal",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 15,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText: careGoalPlanModel.exerciseActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 1,
                          child: CareGoalTextField(
                            hintText: careGoalPlanModel.exerciseTarget,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date of Completion",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 15,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Text(
                        careGoalProvider.selectedDate == null
                            ? ""
                            : careGoalProvider.selectedDate!.format("d-M-Y"),
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 12,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            careGoalProvider.selectDate(context);
                          },
                          child: Icon(Icons.calendar_month_rounded)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFieldWidget(
                  textFieldHeight: 100,
                  maxlines: 5,
                  toppadding: 15,
                  hintText: "Enter OutCome",
                  textInputType: TextInputType.text),
            )
          ],
        ),
      );
    });
  }
}
