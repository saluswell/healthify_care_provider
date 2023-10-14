import 'package:cloud_firestore/cloud_firestore.dart';

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
  Stream<List<CareGoalPlanModel>> streamCareGoalPlans() {
    return FirebaseFirestore.instance
        .collection(FirebaseUtils.careGoalPlans)
        .orderBy("dateCreated")

        //.doc()
        //.where("recieverID", isEqualTo: getUserID())

        // .where("appointmentStatus", isEqualTo: appointmentStatus)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => CareGoalPlanModel.fromJson(singleDoc.data()))
            .toList());
  }
}
