import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthify_care_provider/common/helperFunctions/getUserIDhelper.dart';
import 'package:healthify_care_provider/common/widgets/textfield_widget.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/models/commentsModel.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/services/care_goal_plan_services.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/care_goal_plan_model.dart';
import '../providers/care_goal_provider.dart';
import '../widgets/care_goal_textfield.dart';
import '../widgets/nutrition_goal_widget.dart';

class CareGoalPlanDetail extends StatefulWidget {
  final CareGoalPlanModel careGoalPlanModel;

  const CareGoalPlanDetail({Key? key, required this.careGoalPlanModel})
      : super(key: key);

  @override
  State<CareGoalPlanDetail> createState() => _CareGoalPlanDetailState();
}

class _CareGoalPlanDetailState extends State<CareGoalPlanDetail> {
  CareGoalPlanServices careGoalPlanServices = CareGoalPlanServices();

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CareGoalProvider>(builder: (context, careGoalProvider, __) {
      return Scaffold(
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: 60,
                width: MediaQuery.sizeOf(context).width,
                child: Card(
                  color: AppColors.appLightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          controller: commentController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10),
                              hintStyle: TextStyle(
                                  color: AppColors.blackcolor.withOpacity(0.7),
                                  fontSize: 12),
                              hintText:
                                  "Enter progress of your goal daily in comments"),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            if (commentController.text.isNotEmpty) {
                              careGoalPlanServices.addComment(CommentModel(
                                  userId: getUserID(),
                                  careGoalPlanId:
                                      widget.careGoalPlanModel.careGoalPlanId,
                                  commentText: commentController.text,
                                  dateCreated:
                                      Timestamp.fromDate(DateTime.now())));
                              commentController.clear();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Icon(Icons.send),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text(
            widget.careGoalPlanModel.goalType.toString(),
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            if (widget.careGoalPlanModel.goalType == "NUTRITION GOALS") ...[
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
                      height: 7,
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
                              hintText:
                                  widget.careGoalPlanModel.carboHydratesActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText:
                                  widget.careGoalPlanModel.carboHydratesTarget,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 7,
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
                              hintText: widget.careGoalPlanModel.proteinActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: widget.careGoalPlanModel.proteinTarget,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 7,
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
                              hintText: widget.careGoalPlanModel.fatActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              enabled: false,
                              hintText: widget.careGoalPlanModel.fatTarget,
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ] else if (widget.careGoalPlanModel.goalType ==
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
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightActual,
                              enabled: false,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightTarget,
                              enabled: false,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ] else if (widget.careGoalPlanModel.goalType ==
                "CALORIES PER DAY") ...[
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
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightTarget,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ] else if (widget.careGoalPlanModel.goalType == "WEIGHT GOALS") ...[
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
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                            flex: 1,
                            child: CareGoalTextField(
                              hintText: widget
                                  .careGoalPlanModel.waterCaloriesWeightTarget,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ] else if (widget.careGoalPlanModel.goalType ==
                "EXERCISE GOALS") ...[
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
                              text: widget.careGoalPlanModel.exerciseType
                                  .toString(),
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
                              hintText: widget.careGoalPlanModel.exerciseActual,
                            )),
                        SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          flex: 1,
                          child: CareGoalTextField(
                            hintText: widget.careGoalPlanModel.exerciseTarget,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(
              height: 20,
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFieldWidget(
                  textFieldHeight: 80,
                  maxlines: 5,
                  toppadding: 15,
                  hintText: "Enter OutCome",
                  textInputType: TextInputType.text),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    "Progress Comments",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 15,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            StreamProvider.value(
                value: careGoalPlanServices.streamAllComments(
                    widget.careGoalPlanModel.careGoalPlanId.toString()),
                initialData: [CommentModel()],
                builder: (context, child) {
                  List<CommentModel> careGoalPlansList =
                      context.watch<List<CommentModel>>();
                  return careGoalPlansList.isEmpty
                      ? const Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Text("No comments found!",
                              style: TextStyle(
                                  // fontFamily: 'Gilroy',
                                  color: AppColors.blackcolor,
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Axiforma',
                                  fontSize: 13)),
                        ))
                      : careGoalPlansList[0].careGoalPlanId == null
                          ? const SpinKitSpinningLines(
                              size: 45,
                              color: AppColors.appcolor,
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: careGoalPlansList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                      top: 10, left: 8, right: 8, bottom: 15),
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            // height: 40,
                                            width: 170,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(13),
                                                    topLeft: Radius.circular(4),
                                                    bottomRight:
                                                        Radius.circular(4),
                                                    bottomLeft:
                                                        Radius.circular(4)),
                                                color: AppColors
                                                    .lightdarktextcolor
                                                    .withOpacity(0.7)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: careGoalPlansList[index]
                                                      .commentText
                                                      .toString(),
                                                  style: fontW5S12(context)!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .blackcolor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })),
                            );
                }),
            SizedBox(
              height: 80,
            )
          ],
        ),
      );
    });
  }
}
