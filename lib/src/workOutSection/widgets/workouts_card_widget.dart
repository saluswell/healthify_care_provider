import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/workout_model.dart';
import '../providers/workout_provider.dart';
import '../screens/workout_detail_screen.dart';

class WorkOutsCardWidget extends StatefulWidget {
  final WorkoutModel workoutModel;

  const WorkOutsCardWidget({Key? key, required this.workoutModel})
      : super(key: key);

  @override
  State<WorkOutsCardWidget> createState() => _WorkOutsCardWidgetState();
}

class _WorkOutsCardWidgetState extends State<WorkOutsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(builder: (context, workoutProvider, __) {
      return InkWell(
        onTap: () {
          toNext(
              context: context,
              widget: WorkoutDetailScreen(
                workoutModel: widget.workoutModel,
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
                          Image.asset(
                            "assets/Images/weight.png",
                            height: 35,
                            width: 35,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: [
                              Text(
                                widget.workoutModel.workoutTitle.toString(),
                                style: fontW5S12(context)!.copyWith(
                                    fontSize: 14,
                                    color: AppColors.blackcolor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.workoutModel.workoutDuration
                                        .toString(),
                                    style: fontW5S12(context)!.copyWith(
                                        fontSize: 14,
                                        color: AppColors.appcolor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Uploaded On",
                            style: fontW5S12(context)!.copyWith(
                                fontSize: 14,
                                color: AppColors.appcolor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.workoutModel.dateCreated!
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
    });
  }
}
