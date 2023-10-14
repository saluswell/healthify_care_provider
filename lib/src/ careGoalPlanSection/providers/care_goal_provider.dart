import 'package:flutter/material.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/services/care_goal_plan_services.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/helperFunctions/showsnackbar.dart';
import '../../../common/utils/appcolors.dart';
import '../models/care_goal_plan_model.dart';

class CareGoalProvider extends ChangeNotifier {
  String? selectedGoal;
  List<String> careGoalsList = [
    "NUTRITION GOALS",
    "Water Intake (Glasses)/Day",
    "CALORIES PER DAY",
    "WEIGHT GOALS",
    "EXERCISE GOALS",
  ];

  updateGoal(String val) {
    selectedGoal = val;
    notifyListeners();
  }

  ///    ------------select exercises

  String? selectedExercise;

  List<String> excercisesList = [
    "Stationary bicycle 20 minutes",
    "Stationary bicycle 30 minutes",
    "Walking 30 minutes",
    "Swimming 30 minutes",
    "Swimming 45 minutes",
    "Yoga",
    "Strength training",
  ];

  updateExercise(String val) {
    selectedExercise = val;
    notifyListeners();
  }

  DateTime? selectedDate;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    notifyListeners();
  }

  ///firebase functions

  bool isLoading = false;

  makeLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  makeLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  CareGoalPlanServices careGoalPlanServices = CareGoalPlanServices();

  createCareGoalPlanProvider(CareGoalPlanModel careGoalPlanModel) {
    if (selectedGoal == null) {
      showSnackBarMessage(
          context: navstate.currentState!.context,
          backgroundcolor: AppColors.redcolor,
          contentColor: AppColors.whitecolor,
          content: "Please Select Goal");
    } else {
      try {
        makeLoadingTrue();

        careGoalPlanServices
            .createCareGoalPlan(careGoalPlanModel)
            .then((value) {
          makeLoadingFalse();

          Navigator.maybePop(navstate.currentState!.context);

          showSnackBarMessage(
              backgroundcolor: AppColors.appcolor,
              contentColor: AppColors.whitecolor,
              context: navstate.currentState!.context,
              content: "Care Goal Plan Added Successfully");
        });
      } catch (e) {
        makeLoadingFalse();
        showSnackBarMessage(
            context: navstate.currentState!.context, content: e.toString());
        // TODO
      }
    }
  }
}
