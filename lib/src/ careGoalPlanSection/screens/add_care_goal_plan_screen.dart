import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthify_care_provider/common/helperFunctions/getUserIDhelper.dart';
import 'package:healthify_care_provider/common/helperFunctions/showsnackbar.dart';
import 'package:healthify_care_provider/common/widgets/button_widget.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/providers/care_goal_provider.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/widgets/care_goal_textfield.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/widgets/exercises_dialog.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/widgets/nutrition_goal_widget.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/textfield_widget.dart';
import '../models/care_goal_plan_model.dart';
import '../widgets/select_goal_type_dialog.dart';

class AddCareGoalPlanScreen extends StatefulWidget {
  final String appointmentID;

  const AddCareGoalPlanScreen({Key? key, required this.appointmentID})
      : super(key: key);

  @override
  State<AddCareGoalPlanScreen> createState() => _AddCareGoalPlanScreenState();
}

class _AddCareGoalPlanScreenState extends State<AddCareGoalPlanScreen> {
  TextEditingController carbohydratesActualController = TextEditingController();
  TextEditingController proteinActualController = TextEditingController();
  TextEditingController fatActualController = TextEditingController();

  TextEditingController carbohydratesTargetController = TextEditingController();
  TextEditingController proteinTargetController = TextEditingController();
  TextEditingController fatTargetController = TextEditingController();

  TextEditingController waterActualController = TextEditingController();
  TextEditingController waterTargetController = TextEditingController();

  TextEditingController caloriesActualController = TextEditingController();
  TextEditingController caloriesTargetController = TextEditingController();

  TextEditingController weightActualController = TextEditingController();
  TextEditingController weightTargetController = TextEditingController();

  TextEditingController exerciseActualController = TextEditingController();
  TextEditingController exerciseTargetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CareGoalProvider>(builder: (context, careGoalProvider, __) {
      return LoadingOverlay(
        isLoading: careGoalProvider.isLoading,
        progressIndicator: const SpinKitSpinningLines(
          size: 45,
          color: AppColors.appcolor,
        ),
        child: Scaffold(
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonButtonWidget(
                text: "Create Goal",
                textfont: 14,
                onTap: () {
                  if (careGoalProvider.selectedGoal == null) {
                    showSnackBarMessage(
                        context: context,
                        content: "Please Select Goal",
                        backgroundcolor: AppColors.redcolor);
                  } else {
                    if (careGoalProvider.selectedGoal == "NUTRITION GOALS") {
                      if (carbohydratesActualController.text.isEmpty ||
                          carbohydratesTargetController.text.isEmpty ||
                          proteinActualController.text.isEmpty ||
                          proteinTargetController.text.isEmpty ||
                          fatActualController.text.isEmpty ||
                          fatTargetController.text.isEmpty) {
                        showSnackBarMessage(
                            context: context,
                            backgroundcolor: AppColors.redcolor,
                            content: "Please fill all the fields");
                      } else {
                        careGoalProvider.createCareGoalPlanProvider(
                            CareGoalPlanModel(
                                userId: getUserID(),
                                appointmentID: widget.appointmentID,
                                goalType:
                                    careGoalProvider.selectedGoal.toString(),
                                carboHydratesActual:
                                    carbohydratesActualController.text,
                                carboHydratesTarget:
                                    carbohydratesTargetController.text,
                                proteinActual: proteinActualController.text,
                                proteinTarget: proteinTargetController.text,
                                fatActual: fatActualController.text,
                                fatTarget: fatTargetController.text,
                                dateCreated:
                                    Timestamp.fromDate(DateTime.now())));
                      }
                    } else if (careGoalProvider.selectedGoal ==
                        "Water Intake (Glasses)/Day") {
                      if (waterActualController.text.isEmpty ||
                          waterTargetController.text.isEmpty) {
                        showSnackBarMessage(
                            context: context,
                            backgroundcolor: AppColors.redcolor,
                            content: "Please fill all the fields");
                      } else {
                        careGoalProvider.createCareGoalPlanProvider(
                            CareGoalPlanModel(
                                userId: getUserID(),
                                appointmentID: widget.appointmentID,
                                goalType:
                                    careGoalProvider.selectedGoal.toString(),
                                waterCaloriesWeightActual:
                                    waterActualController.text,
                                waterCaloriesWeightTarget:
                                    waterTargetController.text,
                                dateCreated:
                                    Timestamp.fromDate(DateTime.now())));
                      }
                    } else if (careGoalProvider.selectedGoal ==
                        "CALORIES PER DAY") {
                      if (caloriesActualController.text.isEmpty ||
                          caloriesTargetController.text.isEmpty) {
                        showSnackBarMessage(
                            context: context,
                            backgroundcolor: AppColors.redcolor,
                            content: "Please fill all the fields");
                      } else {
                        careGoalProvider.createCareGoalPlanProvider(
                            CareGoalPlanModel(
                                userId: getUserID(),
                                appointmentID: widget.appointmentID,
                                goalType:
                                    careGoalProvider.selectedGoal.toString(),
                                waterCaloriesWeightActual:
                                    caloriesActualController.text,
                                waterCaloriesWeightTarget:
                                    caloriesTargetController.text,
                                dateCreated:
                                    Timestamp.fromDate(DateTime.now())));
                      }
                    } else if (careGoalProvider.selectedGoal ==
                        "WEIGHT GOALS") {
                      if (weightActualController.text.isEmpty ||
                          weightTargetController.text.isEmpty) {
                        showSnackBarMessage(
                            context: context,
                            backgroundcolor: AppColors.redcolor,
                            content: "Please fill all the fields");
                      } else {
                        careGoalProvider.createCareGoalPlanProvider(
                            CareGoalPlanModel(
                                userId: getUserID(),
                                appointmentID: widget.appointmentID,
                                goalType:
                                    careGoalProvider.selectedGoal.toString(),
                                waterCaloriesWeightActual:
                                    weightActualController.text,
                                waterCaloriesWeightTarget:
                                    weightTargetController.text,
                                dateCreated:
                                    Timestamp.fromDate(DateTime.now())));
                      }
                    } else if (careGoalProvider.selectedGoal ==
                        "EXERCISE GOALS") {
                      if (careGoalProvider.selectedExercise == null) {
                        showSnackBarMessage(
                            context: context,
                            backgroundcolor: AppColors.redcolor,
                            content: "Please Select Exercise");
                      } else {
                        if (exerciseActualController.text.isEmpty ||
                            exerciseTargetController.text.isEmpty) {
                          showSnackBarMessage(
                              context: context,
                              backgroundcolor: AppColors.redcolor,
                              content: "Please fill all the fields");
                        } else {
                          careGoalProvider.createCareGoalPlanProvider(
                              CareGoalPlanModel(
                                  userId: getUserID(),
                                  appointmentID: widget.appointmentID,
                                  goalType:
                                      careGoalProvider.selectedGoal.toString(),
                                  exerciseType: careGoalProvider
                                      .selectedExercise
                                      .toString(),
                                  exerciseActual: exerciseActualController.text,
                                  exerciseTarget: exerciseTargetController.text,
                                  dateCreated:
                                      Timestamp.fromDate(DateTime.now())));
                        }
                      }
                    }
                  }
                },
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.appcolor,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Create Care Goal Plan",
                      style: fontW5S12(context)!.copyWith(
                          fontSize: 23,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: AppColors.redcolor.withOpacity(0.1)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.close,
                                size: 20,
                                color: AppColors.redcolor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Cancel",
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.redcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black45,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext,
                            Animation animation, Animation secondaryAnimation) {
                          return GoalTypeDialog(
                            mealTime: 'Dinner',
                          );
                        });
                  },
                  child: TextFieldWidget(
                      showSuffixIcon: true,
                      //controller: resourceProvider.articletitleController,
                      textFieldHeight: 50,
                      maxlines: 1,
                      enabled: false,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      maxLengt: 50,
                      toppadding: 22,
                      hintColor: AppColors.blackcolor,
                      hintText: careGoalProvider.selectedGoal == null
                          ? "Select Goal"
                          : careGoalProvider.selectedGoal.toString(),
                      textInputType: TextInputType.emailAddress),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (careGoalProvider.selectedGoal == "NUTRITION GOALS") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child:
                                  NutritionGoalWidget(text: "Carbohydrates")),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Actual',
                                controller: carbohydratesActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: carbohydratesTargetController,
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
                                hintText: 'Actual',
                                controller: proteinActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: proteinTargetController,
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
                                hintText: 'Actual',
                                controller: fatActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: fatTargetController,
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ] else if (careGoalProvider.selectedGoal ==
                  "Water Intake (Glasses)/Day") ...[
                Column(
                  children: [
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
                                hintText: 'Actual',
                                controller: waterActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: waterTargetController,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else if (careGoalProvider.selectedGoal ==
                  "CALORIES PER DAY") ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 2,
                              child: NutritionGoalWidget(
                                  text: "Calories Per Day")),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Actual',
                                controller: caloriesActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: caloriesTargetController,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ] else if (careGoalProvider.selectedGoal == "WEIGHT GOALS") ...[
                Column(
                  children: [
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
                                hintText: 'Actual',
                                controller: weightActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Goal',
                                controller: weightTargetController,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ] else if (careGoalProvider.selectedGoal == "EXERCISE GOALS") ...[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: InkWell(
                                onTap: () {
                                  showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:
                                          MaterialLocalizations.of(context)
                                              .modalBarrierDismissLabel,
                                      barrierColor: Colors.black45,
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                      pageBuilder: (BuildContext buildContext,
                                          Animation animation,
                                          Animation secondaryAnimation) {
                                        return ExercisesDialog();
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: NutritionGoalWidget(
                                    text: careGoalProvider.selectedExercise ==
                                            null
                                        ? "SELECT EXERCISE"
                                        : careGoalProvider.selectedExercise
                                            .toString(),
                                    width: MediaQuery.sizeOf(context).width,
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    barrierColor: Colors.black45,
                                    transitionDuration:
                                        const Duration(milliseconds: 200),
                                    pageBuilder: (BuildContext buildContext,
                                        Animation animation,
                                        Animation secondaryAnimation) {
                                      return ExercisesDialog();
                                    });
                              },
                              child: Container(
                                height: 55,
                                width: 45,
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.arrow_drop_down_outlined),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: CareGoalTextField(
                                hintText: 'Actual',
                                controller: exerciseActualController,
                              )),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText: 'Goal',
                              controller: exerciseTargetController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      );
    });
  }
}
