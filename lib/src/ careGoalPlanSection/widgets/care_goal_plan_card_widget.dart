import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/models/care_goal_plan_model.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../screens/care_goal_plan_detail.dart';

class CareGoalPlanCardWidget extends StatefulWidget {
  final CareGoalPlanModel careGoalPlanModel;
  final int index;

  const CareGoalPlanCardWidget(
      {Key? key, required this.careGoalPlanModel, required this.index})
      : super(key: key);

  @override
  State<CareGoalPlanCardWidget> createState() => _CareGoalPlanCardWidgetState();
}

class _CareGoalPlanCardWidgetState extends State<CareGoalPlanCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toNext(
            context: context,
            widget: CareGoalPlanDetail(
              careGoalPlanModel: widget.careGoalPlanModel,
              // workoutModel: widget.workoutModel,
            ));
      },
      child: Container(
        height: 35,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Image.asset(
                        //   "assets/Images/weight.png",
                        //   height: 35,
                        //   width: 35,
                        // ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: [
                            Text(
                              "Goal No " + widget.index.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 12,
                                  color: AppColors.appcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              widget.careGoalPlanModel.goalType.toString(),
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.blackcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                            // SizedBox(
                            //   height: 2,
                            // ),
                            // Row(
                            //   children: [
                            //     Text(
                            //       widget.workoutModel.workoutDuration
                            //           .toString(),
                            //       style: fontW5S12(context)!.copyWith(
                            //           fontSize: 14,
                            //           color: AppColors.appcolor,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ],
                            // ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Start Date",
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 13,
                              color: AppColors.appcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.careGoalPlanModel.dateCreated!
                              .toDate()
                              .format("d-M-Y"),
                          style: fontW5S12(context)!.copyWith(
                              fontSize: 11,
                              color: AppColors.blackcolor.withOpacity(0.5),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
