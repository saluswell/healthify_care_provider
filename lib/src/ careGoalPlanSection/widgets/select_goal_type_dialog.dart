import 'package:flutter/material.dart';
import 'package:healthify_care_provider/common/widgets/button_widget.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/providers/care_goal_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';

class GoalTypeDialog extends StatefulWidget {
  final String mealTime;

  const GoalTypeDialog({Key? key, required this.mealTime}) : super(key: key);

  @override
  State<GoalTypeDialog> createState() => _GoalTypeDialogState();
}

class _GoalTypeDialogState extends State<GoalTypeDialog> {
  TextEditingController mealController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Consumer<CareGoalProvider>(
            builder: (context, careGoalProvider, __) {
          return Container(
            width: MediaQuery.of(context).size.width - 30,
            height: MediaQuery.of(context).size.height - 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Select Goal",
                        style: fontW5S12(context)!.copyWith(
                            fontSize: 18,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.maybePop(context);
                        },
                        child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: AppColors.redcolor,
                                borderRadius: BorderRadius.circular(45)),
                            child: Icon(
                              Icons.close,
                              color: AppColors.whitecolor,
                            )),
                      ),
                    ],
                  ),
                  Container(
                    height: 280,
                    child: ListView.builder(
                        itemCount: careGoalProvider.careGoalsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              careGoalProvider.updateGoal(careGoalProvider
                                  .careGoalsList[index]
                                  .toString());
                            },
                            child: Container(
                              height: 50,
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        careGoalProvider.careGoalsList[index]
                                            .toString(),
                                        style: fontW5S12(context)!.copyWith(
                                            fontSize: 12,
                                            color: AppColors.blackcolor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      careGoalProvider.careGoalsList[index] ==
                                              careGoalProvider.selectedGoal
                                          ? Icon(Icons.verified_rounded)
                                          : SizedBox()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CommonButtonWidget(
                      text: "Ok",
                      buttonHeight: 50,
                      onTap: () {
                        Navigator.maybePop(context);
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
