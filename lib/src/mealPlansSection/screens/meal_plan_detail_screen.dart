import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthify_care_provider/common/helperFunctions/showsnackbar.dart';
import 'package:healthify_care_provider/src/mealPlansSection/models/meal_day_model.dart';
import 'package:healthify_care_provider/src/mealPlansSection/providers/meal_plan_provider.dart';
import 'package:healthify_care_provider/src/mealPlansSection/services/meal_plan_services.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import '../../../common/utils/appcolors.dart';
import '../../../common/utils/themes.dart';
import '../../../common/widgets/cacheNetworkImageWidget.dart';
import '../models/meal_plan_model.dart';
import '../widgets/meal_card_widget.dart';
import '../widgets/meal_item_card_widget.dart';

class MealPlanDetailScreen extends StatefulWidget {
  final String docID;

  //final RecipesModel recipesModel;

  const MealPlanDetailScreen({
    Key? key,
    required this.docID,
  }) : super(key: key);

  @override
  State<MealPlanDetailScreen> createState() => _MealPlanDetailScreenState();
}

class _MealPlanDetailScreenState extends State<MealPlanDetailScreen> {
  MealPlanServices mealPlanServices = MealPlanServices();

  @override
  void initState() {
    mealPlanServices.fetchDays(widget.docID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealPlanProvider>(builder: (context, mealPlanProvider, __) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          mealPlanProvider.selectedIndex = 0;

          return true;
        },
        child: Scaffold(
          backgroundColor: AppColors.whitecolor,
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  mealPlanProvider.selectedIndex = 0;
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back)),
            centerTitle: true,
            title: Text(
              "Meal Plan Details",
              style: TextStyle(fontSize: 15),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "",
                    //   recipesModel.recipeTitle.toString(),
                    style: fontW5S12(context)!.copyWith(
                        fontSize: 20,
                        color: AppColors.blackcolor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "INGREDIENTS",
                //         style: fontW5S12(context)!.copyWith(
                //             fontSize: 14,
                //             color: AppColors.darkAppColor,
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('mealPlans')
                      .doc(widget.docID) // Replace with your actual document ID
                      .collection('days')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: SpinKitSpinningLines(color: AppColors.appcolor),
                      ));
                    }

                    // Convert the QuerySnapshot to a list of DayModel objects
                    final List<MealDayModel> days =
                        snapshot.data!.docs.map((QueryDocumentSnapshot doc) {
                      return MealDayModel.fromMap(
                          doc.data() as Map<String, dynamic>, doc.id);
                    }).toList();

                    // Now you can use the 'days' list in your UI
                    return Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 55,
                          child: ListView.builder(
                              padding: EdgeInsets.only(top: 1, left: 8),
                              scrollDirection: Axis.horizontal,
                              itemCount: days.length,
                              itemBuilder: (BuildContext context, int index) {
                                final day = days[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      mealPlanProvider.selectedIndex = index;
                                    });
                                  },
                                  child: Container(
                                    height: 65,
                                    width: 80,
                                    child: Card(
                                      color: mealPlanProvider.selectedIndex ==
                                              index
                                          ? AppColors.darkAppColor
                                          : AppColors.appcolor,
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Day " +
                                              (int.parse(day.mealPlanId
                                                          .toString()) +
                                                      1)
                                                  .toString(),

                                          //   recipesModel.recipeTitle.toString(),
                                          style: fontW5S12(context)!.copyWith(
                                              fontSize: 13,
                                              color: AppColors.whitecolor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        StreamProvider.value(
                            value: mealPlanServices.fetchSpecificDayMeals(
                                widget.docID,
                                mealPlanProvider.selectedIndex.toString()),
                            initialData: MealDayModel(),
                            builder: (context, child) {
                              MealDayModel model =
                                  context.watch<MealDayModel>();
                              dp(
                                  msg: "specific day model",
                                  arg: model.toJson());
                              return model.mealPlanId == null
                                  ? Center(
                                      child: SpinKitSpinningLines(
                                        color: AppColors.appcolor,
                                        size: 45,
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Breakfast",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        model.breakfastMeals!.isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Text(
                                                    "Add Breakfast Meals",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: model.breakfastMeals!
                                                        .length *
                                                    68,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    padding: EdgeInsets.only(),
                                                    itemCount: model
                                                        .breakfastMeals!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return MealItemCardWidget(
                                                        item: model
                                                                .breakfastMeals![
                                                            index],
                                                      );
                                                    }),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Lunch",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        model.lunchMeals!.isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Text(
                                                    "Add Lunch Meals",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    model.lunchMeals!.length *
                                                        68,
                                                child: ListView.builder(
                                                    padding: EdgeInsets.only(),
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: model
                                                        .lunchMeals!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return MealItemCardWidget(
                                                        item: model
                                                            .lunchMeals![index],
                                                      );
                                                    }),
                                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Dinner",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        model.dinnerMeals!.isEmpty
                                            ? Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: Text(
                                                    "Add Dinner Meals",
                                                    style: fontW5S12(context)!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            color: AppColors
                                                                .blackcolor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height:
                                                    model.dinnerMeals!.length *
                                                        68,
                                                child: ListView.builder(
                                                    padding: EdgeInsets.only(),
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount: model
                                                        .dinnerMeals!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return MealItemCardWidget(
                                                        item:
                                                            model.dinnerMeals![
                                                                index],
                                                      );
                                                    }),
                                              ),
                                      ],
                                    );
                            })

                        // NumberStepper(
                        //   enableNextPreviousButtons: false,
                        //   direction: Axis.horizontal,
                        //   activeStepColor: AppColors.darkAppColor,
                        //   stepColor: AppColors.appcolor,
                        //   numberStyle: TextStyle(color: AppColors.whitecolor),
                        //   activeStep: 0,
                        //   lineDotRadius: 0.9,
                        //   stepRadius: 19,
                        //   lineLength: 30,
                        //
                        //   lineColor: AppColors.appcolor,
                        //   enableStepTapping: false,
                        //   numbers: days.length == 7
                        //       ? [1, 2, 3, 4, 5, 6, 7]
                        //       : [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                        // )
                      ],
                    );

                    //   Expanded(
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.only(top: 1),
                    //     itemCount: days.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       final day = days[index];
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 12),
                    //         child: Container(
                    //           height: 300,
                    //           width: MediaQuery.sizeOf(context).width,
                    //           child: Card(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(8)),
                    //             elevation: 5,
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 SizedBox(
                    //                   height: 10,
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.center,
                    //                   children: [
                    //                     Text(
                    //                       "Day " + day.mealPlanId.toString(),
                    //                       style: TextStyle(
                    //                           fontSize: 15,
                    //                           fontWeight: FontWeight.w800),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 15,
                    //                 ),
                    //                 Padding(
                    //                   padding:
                    //                       const EdgeInsets.symmetric(horizontal: 20),
                    //                   child: Row(
                    //                     children: [
                    //                       Text(
                    //                         "BreakFast Meals",
                    //                         style: TextStyle(
                    //                             fontSize: 13,
                    //                             fontWeight: FontWeight.w600),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   child: ListView.builder(
                    //                       scrollDirection: Axis.horizontal,
                    //                       itemCount: day.breakfastMeals!.length,
                    //                       shrinkWrap: true,
                    //                       physics: NeverScrollableScrollPhysics(),
                    //                       padding: EdgeInsets.only(
                    //                           top: 10, left: 15, right: 8),
                    //                       itemBuilder: ((context, index) {
                    //                         return MealCardWidget(
                    //                           text: day.breakfastMeals![index],
                    //                         );
                    //                       })),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 15,
                    //                 ),
                    //                 Padding(
                    //                   padding:
                    //                       const EdgeInsets.symmetric(horizontal: 20),
                    //                   child: Row(
                    //                     children: [
                    //                       Text(
                    //                         "Lunch Meals",
                    //                         style: TextStyle(
                    //                             fontSize: 13,
                    //                             fontWeight: FontWeight.w600),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   child: ListView.builder(
                    //                       scrollDirection: Axis.horizontal,
                    //                       itemCount: day.lunchMeals!.length,
                    //                       shrinkWrap: true,
                    //                       physics: NeverScrollableScrollPhysics(),
                    //                       padding: EdgeInsets.only(
                    //                           top: 10, left: 15, right: 8),
                    //                       itemBuilder: ((context, index) {
                    //                         return MealCardWidget(
                    //                           text: day.lunchMeals![index],
                    //                         );
                    //                       })),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 15,
                    //                 ),
                    //                 Padding(
                    //                   padding:
                    //                       const EdgeInsets.symmetric(horizontal: 20),
                    //                   child: Row(
                    //                     children: [
                    //                       Text(
                    //                         "Dinner Meals",
                    //                         style: TextStyle(
                    //                             fontSize: 13,
                    //                             fontWeight: FontWeight.w600),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   child: ListView.builder(
                    //                       scrollDirection: Axis.horizontal,
                    //                       itemCount: day.dinnerMeals!.length,
                    //                       shrinkWrap: true,
                    //                       physics: NeverScrollableScrollPhysics(),
                    //                       padding: EdgeInsets.only(
                    //                           top: 10, left: 15, right: 8),
                    //                       itemBuilder: ((context, index) {
                    //                         return MealCardWidget(
                    //                           text: day.dinnerMeals![index],
                    //                         );
                    //                       })),
                    //                 )
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //       //   ListTile(
                    //       //   title: Text('Day ID: ${day.mealPlanId}'),
                    //       //   subtitle: Text('Data Field: ${day.mealPlanTitle}'),
                    //       // );
                    //     },
                    //   ),
                    // );
                  },
                )
                // StreamProvider.value(
                //     value: mealPlanServices.streamMealPlansDetail(widget.docID),
                //     initialData: [MealPlanModel()],
                //     builder: (context, child) {
                //       List<MealPlanModel> recipesList =
                //           context.watch<List<MealPlanModel>>();
                //       return recipesList.isEmpty
                //           ? const Center(
                //               child: Padding(
                //               padding: EdgeInsets.only(top: 220),
                //               child: Text("No Recipes Found!",
                //                   style: TextStyle(
                //                       // fontFamily: 'Gilroy',
                //                       color: AppColors.blackcolor,
                //                       // decoration: TextDecoration.underline,
                //                       fontWeight: FontWeight.w700,
                //                       fontFamily: 'Axiforma',
                //                       fontSize: 13)),
                //             ))
                //           : recipesList[0].mealPlanId == null
                //               ? const SpinKitSpinningLines(
                //                   size: 45,
                //                   color: AppColors.appcolor,
                //                 )
                //               : Expanded(
                //                   flex: 4,
                //                   child: Container(
                //                     height: 500,
                //                     child: GridView.builder(
                //                         itemCount: recipesList.length,
                //                         gridDelegate:
                //                             const SliverGridDelegateWithFixedCrossAxisCount(
                //                                 crossAxisCount:
                //                                     1, // Number of columns
                //                                 crossAxisSpacing:
                //                                     3.0, // Space between columns
                //                                 mainAxisSpacing:
                //                                     8.0, // Space between rows
                //                                 mainAxisExtent: 80),
                //                         shrinkWrap: true,
                //                         padding: const EdgeInsets.only(
                //                             top: 10, left: 8, right: 8, bottom: 15),
                //                         itemBuilder: ((context, index) {
                //                           return Text("dummy text");
                //                         })),
                //                   ));
                //     })

                // ListView.builder(
                //     itemCount: recipesModel.ingredients!.length,
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     padding: EdgeInsets.only(top: 10, left: 20, right: 8),
                //     itemBuilder: ((context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(bottom: 15),
                //         child: Row(
                //           children: [
                //             Container(
                //               height: 8,
                //               width: 8,
                //               decoration: BoxDecoration(
                //                   borderRadius: BorderRadius.circular(33),
                //                   color: AppColors.appcolor),
                //             ),
                //             SizedBox(
                //               width: 12,
                //             ),
                //             Text(
                //               recipesModel.ingredients![index].toString(),
                //               style: fontW5S12(context)!.copyWith(
                //                   fontSize: 12,
                //                   color: AppColors.darkAppColor,
                //                   fontWeight: FontWeight.w700),
                //             ),
                //           ],
                //         ),
                //       );
                //     })),
                // SizedBox(
                //   height: 15,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 12),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "NUTRITION",
                //         style: fontW5S12(context)!.copyWith(
                //             fontSize: 14,
                //             color: AppColors.darkAppColor,
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
