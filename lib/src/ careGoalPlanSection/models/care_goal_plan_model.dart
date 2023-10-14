// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CareGoalPlanModel articleModelFromJson(String str) =>
    CareGoalPlanModel.fromJson(json.decode(str));

String articleModelToJson(CareGoalPlanModel data) =>
    json.encode(data.toJson(data.careGoalPlanId.toString()));

class CareGoalPlanModel {
  CareGoalPlanModel({
    this.userId,
    this.careGoalPlanId,
    this.goalType,
    this.exerciseType,
    this.waterCaloriesWeightActual,
    this.waterCaloriesWeightTarget,
    this.exerciseActual,
    this.exerciseTarget,
    this.carboHydratesActual,
    this.proteinActual,
    this.fatActual,
    this.carboHydratesTarget,
    this.proteinTarget,
    this.fatTarget,
    this.isApprovedByAdmin,
    this.dateCreated,
    this.dateCompleted,
    this.goalOutCome,
  });

  String? userId;
  String? careGoalPlanId;
  String? goalType;
  String? exerciseType;
  String? waterCaloriesWeightActual;
  String? waterCaloriesWeightTarget;
  String? exerciseActual;
  String? exerciseTarget;
  String? carboHydratesActual;
  String? proteinActual;
  String? fatActual;

  String? carboHydratesTarget;
  String? proteinTarget;
  String? fatTarget;

  bool? isApprovedByAdmin;
  Timestamp? dateCreated;
  Timestamp? dateCompleted;
  String? goalOutCome;

  factory CareGoalPlanModel.fromJson(Map<String, dynamic> json) =>
      CareGoalPlanModel(
        userId: json["userID"],
        careGoalPlanId: json["careGoalPlanId"],
        goalType: json["goalType"],
        exerciseType: json["exerciseType"],
        waterCaloriesWeightActual: json["waterCaloriesWeightActual"],
        waterCaloriesWeightTarget: json["waterCaloriesWeightTarget"],
        exerciseActual: json["exerciseActual"],
        exerciseTarget: json["exerciseTarget"],
        carboHydratesActual: json["carboHydratesActual"],
        proteinActual: json["proteinActual"],
        fatActual: json["fatActual"],
        carboHydratesTarget: json["carboHydratesTarget"],
        proteinTarget: json["proteinTarget"],
        fatTarget: json["fatTarget"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        dateCreated: json["dateCreated"],
        goalOutCome: json["goalOutCome"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": userId,
        "careGoalPlanId": docID,
        "goalType": goalType,
        "exerciseType": exerciseType,
        "waterCaloriesWeightActual": waterCaloriesWeightActual,
        "waterCaloriesWeightTarget": waterCaloriesWeightTarget,
        "exerciseActual": exerciseActual,
        "exerciseTarget": exerciseTarget,
        "carboHydratesActual": carboHydratesActual,
        "proteinActual": proteinActual,
        "fatActual": fatActual,
        "carboHydratesTarget": carboHydratesTarget,
        "proteinTarget": proteinTarget,
        "fatTarget": fatTarget,
        "isApprovedByAdmin": isApprovedByAdmin,
        "dateCreated": dateCreated,
        "goalOutCome": goalOutCome,
      };
}
