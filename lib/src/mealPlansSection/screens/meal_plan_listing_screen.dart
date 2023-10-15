import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthify_care_provider/src/mealPlansSection/models/meal_plan_model.dart';
import 'package:healthify_care_provider/src/mealPlansSection/screens/create_meal_plan_screen.dart';
import 'package:healthify_care_provider/src/mealPlansSection/services/meal_plan_services.dart';
import 'package:provider/provider.dart';

import '../../../common/helperFunctions/navigatorHelper.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import 'meal_plan_detail_screen.dart';

class MealPlansListingScreen extends StatefulWidget {
  final String appointmentID;

  const MealPlansListingScreen({Key? key, required this.appointmentID})
      : super(key: key);

  @override
  State<MealPlansListingScreen> createState() => _MealPlansListingScreenState();
}

class _MealPlansListingScreenState extends State<MealPlansListingScreen> {
  MealPlanServices mealPlanServices = MealPlanServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Meal Plans",
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 23,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      toNext(
                          context: context,
                          widget: CreateMealPlanScreen(
                            appointmentID: widget.appointmentID,
                          ));
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
                            const Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.appcolor,
                            ),
                            const SizedBox(
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
          const SizedBox(
            height: 10,
          ),
          StreamProvider.value(
              value: mealPlanServices.streamMealPlans(widget.appointmentID),
              initialData: [MealPlanModel()],
              builder: (context, child) {
                List<MealPlanModel> recipesList =
                    context.watch<List<MealPlanModel>>();
                return recipesList.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.only(top: 220),
                        child: Text("No Meal Plans  Found!Add New",
                            style: TextStyle(
                                // fontFamily: 'Gilroy',
                                color: AppColors.blackcolor,
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Axiforma',
                                fontSize: 13)),
                      ))
                    : recipesList[0].mealPlanId == null
                        ? const SpinKitSpinningLines(
                            size: 45,
                            color: AppColors.appcolor,
                          )
                        : Expanded(
                            flex: 4,
                            child: GridView.builder(
                                itemCount: recipesList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, // Number of columns
                                        crossAxisSpacing:
                                            3.0, // Space between columns
                                        mainAxisSpacing:
                                            8.0, // Space between rows
                                        mainAxisExtent: 80),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    top: 10, left: 8, right: 8, bottom: 15),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      toNext(
                                          context: context,
                                          widget: MealPlanDetailScreen(
                                            docID: recipesList[index]
                                                .mealPlanId
                                                .toString(),
                                            // recipesModel: recipesList[index],
                                          ));
                                    },
                                    child: Container(
                                      height: 45,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        elevation: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // CacheNetworkImageWidget(
                                            //   imgUrl: recipesList[index]
                                            //       .recipeImage
                                            //       .toString(),
                                            //   width: MediaQuery.of(context)
                                            //       .size
                                            //       .width,
                                            //   radius: 7,
                                            //   height: 160,
                                            // ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      width: 170,
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text:
                                                              recipesList[index]
                                                                  .mealPlanTitle
                                                                  .toString(),
                                                          style: fontW5S12(
                                                                  context)!
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color: AppColors
                                                                      .blackcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ), //
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Uploaded On",
                                                          style: fontW5S12(
                                                                  context)!
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color: AppColors
                                                                      .appcolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          recipesList[index]
                                                              .dateCreated!
                                                              .toDate()
                                                              .format("d-M-Y"),
                                                          style: fontW5S12(
                                                                  context)!
                                                              .copyWith(
                                                                  fontSize: 11,
                                                                  color: AppColors
                                                                      .blackcolor
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })));
              })
        ],
      ),
    );
  }
}
