import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthify_care_provider/common/helperFunctions/showsnackbar.dart';
import 'package:healthify_care_provider/src/mealPlansSection/models/meal_day_model.dart';

import '../../../common/helperFunctions/hive_local_storage.dart';
import '../../../common/utils/firebaseUtils.dart';
import '../../../common/utils/textutils.dart';
import '../models/meal_plan_model.dart';

class MealPlanServices {
  ///Create meal plan
  Future<String> createMealPlan(MealPlanModel mealPlanModel, String day) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(FirebaseUtils.mealPlans).doc();

// Get the ID of the newly created document
    final String documentId = docRef.id;
    await docRef.set(mealPlanModel.toJson(docRef.id));

    DocumentReference docRef2 = FirebaseFirestore.instance
        .collection(FirebaseUtils.mealPlans)
        .doc(documentId)
        .collection("days")
        .doc(day);
    await docRef2.set(mealPlanModel.toJson(day));

    return documentId;
  }

  ///Create meal plan
  Future updateMealPlan(MealPlanModel mealPlanModel, String day) async {
    String documentID = await HiveLocalStorage.readHiveValue<String>(
          boxName: TextUtils.documentIDBox,
          key: TextUtils.documentIDKey,
        ) ??
        '';
    DocumentReference docRef2 = FirebaseFirestore.instance
        .collection(FirebaseUtils.mealPlans)
        .doc(documentID)
        .collection("days")
        .doc(day);
    return await docRef2.set(mealPlanModel.toJson(day));

    // DocumentReference docRef2 = FirebaseFirestore.instance
    //     .collection(FirebaseUtils.mealPlans)
    //     .doc(documentId)
    //     .collection("days")
    //     .doc(day);
    // await docRef2.set(mealPlanModel.toJson(day));
    //
    // return documentId;
  }

  /// show list of pending and approved articles  from admin
  Stream<List<MealPlanModel>> streamMealPlans() {
    //  try {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.mealPlans)
        //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        //.where("isApprovedByAdmin", isEqualTo: isApprove)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => MealPlanModel.fromJson(singleDoc.data()))
            .toList());
  }

  // /// show list of pending and approved articles  from admin
  // Stream<List<MealPlanModel>> streamMealPlansDetail(String docID) {
  //   //  try {
  //   return FirebaseFirestore.instance
  //       .collection(FirebaseUtils.mealPlans)
  //       .doc(docID)
  //       .collection("days")
  //
  //       //  .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       //.where("isApprovedByAdmin", isEqualTo: isApprove)
  //       .snapshots()
  //       .map((list) => list.docs
  //           .map((singleDoc) => MealPlanModel.fromJson(singleDoc.data()))
  //           .toList());
  // }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<MealDayModel?> fetchDays(String mealplanId) async {
    // Reference to the meal plan document
    DocumentReference mealPlanDocRef =
        firestore.collection('mealPlans').doc(mealplanId);
    // Reference to the "days" subcollection
    CollectionReference daysCollectionRef = mealPlanDocRef.collection('days');

// Reference to the "days" subcollection
    QuerySnapshot daysQuerySnapshot = await daysCollectionRef.get();

    //  Map<String, dynamic> dayDataVar;

// Loop through the documents in the "days" subcollection
    for (QueryDocumentSnapshot dayDoc in daysQuerySnapshot.docs) {
      // Access data within each document
      Map<String, dynamic> dayData = dayDoc.data() as Map<String, dynamic>;
      //  dayDataVar = dayData;

      print('Day ID: ${dayDoc.id}');
      // print('Day Data: $dayData');
      dp(msg: "day data ", arg: MealDayModel.fromJson(dayData).toJson());
      return MealDayModel.fromJson(dayData);
    }
  }

  ///Fetch User Record
  Stream<MealDayModel> fetchSpecificDayMeals(String mealPlanID, String dayID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.mealPlans)
        .doc(mealPlanID)
        .collection("days")
        .doc(dayID)
        .snapshots()
        .map((userData) => MealDayModel.fromJson(userData.data()!));
  }
}
