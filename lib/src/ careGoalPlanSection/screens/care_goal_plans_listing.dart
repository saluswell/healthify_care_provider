import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/screens/add_care_goal_plan_screen.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/services/care_goal_plan_services.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../models/care_goal_plan_model.dart';
import '../widgets/care_goal_plan_card_widget.dart';

class CareGoalPlansListScreen extends StatefulWidget {
  const CareGoalPlansListScreen({Key? key}) : super(key: key);

  @override
  State<CareGoalPlansListScreen> createState() =>
      _CareGoalPlansListScreenState();
}

class _CareGoalPlansListScreenState extends State<CareGoalPlansListScreen> {
  CareGoalPlanServices careGoalPlanServices = CareGoalPlanServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.appcolor,
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Care Goal Plans",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 23,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      toNext(context: context, widget: AddCareGoalPlanScreen());
                    },
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: AppColors.lightwhitecolor),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.appcolor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Add New",
                              style: fontW5S12(context)!.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appcolor,
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
          ),
          SizedBox(
            height: 10,
          ),
          StreamProvider.value(
              value: careGoalPlanServices.streamCareGoalPlans(),
              initialData: [CareGoalPlanModel()],
              builder: (context, child) {
                List<CareGoalPlanModel> careGoalPlansList =
                    context.watch<List<CareGoalPlanModel>>();
                return careGoalPlansList.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 220),
                        child: Text("No Care Goal Plans Found!",
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
                            flex: 4,
                            child: GridView.builder(
                                itemCount: careGoalPlansList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, // Number of columns
                                        crossAxisSpacing:
                                            3.0, // Space between columns
                                        mainAxisSpacing:
                                            8.0, // Space between rows
                                        mainAxisExtent: 90),
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                    top: 10, left: 8, right: 8, bottom: 15),
                                itemBuilder: ((context, index) {
                                  return CareGoalPlanCardWidget(
                                    careGoalPlanModel: careGoalPlansList[index],
                                    index: index + 1,
                                  );
                                })));
              })
        ],
      ),
    );
  }
}
