import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthify_care_provider/common/helperFunctions/showsnackbar.dart';
import 'package:healthify_care_provider/src/%20careGoalPlanSection/models/commentsModel.dart';

import '../../../common/utils/firebaseUtils.dart';
import '../models/care_goal_plan_model.dart';

class CareGoalPlanServices {
  ///Create goal plan
  Future createCareGoalPlan(CareGoalPlanModel careGoalPlanModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection(FirebaseUtils.careGoalPlans)
        .doc();
    return await docRef.set(careGoalPlanModel.toJson(docRef.id));
  }

  /// stream care goal plans
  Stream<List<CareGoalPlanModel>> streamCareGoalPlans(String appointmentID) {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.careGoalPlans)
        .where("appointmentID", isEqualTo: appointmentID)
        .orderBy("dateCreated", descending: false)
        //.doc()
        //.where("recieverID", isEqualTo: getUserID())

        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => CareGoalPlanModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///add comment
  Future addComment(CommentModel commentModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(FirebaseUtils.comments).doc();
    return await docRef.set(commentModel.toJson(docRef.id));
  }

  /// stream care goal plans
  Stream<List<CommentModel>> streamAllComments(String careGoalID) {
    dp(msg: "care goal id ", arg: careGoalID);
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.comments)
        .where("careGoalPlanId", isEqualTo: careGoalID)
        //.orderBy("dateCreated")

        //.doc()

        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => CommentModel.fromJson(singleDoc.data()))
            .toList());
  }
}
