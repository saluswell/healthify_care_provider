// To parse this JSON data, do
//
//     final mealDayModel = mealDayModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

MealDayModel mealDayModelFromJson(String str) =>
    MealDayModel.fromJson(json.decode(str));

String mealDayModelToJson(MealDayModel data) => json.encode(data.toJson());

class MealDayModel {
  Timestamp? dateCreated;
  List<String>? breakfastMeals;
  bool? isApprovedByAdmin;
  List<String>? dinnerMeals;
  List<String>? lunchMeals;
  String? mealPlanTitle;
  String? mealPlanId;
  String? userId;
  String? mealPlanDay;

  MealDayModel({
    this.dateCreated,
    this.breakfastMeals,
    this.isApprovedByAdmin,
    this.dinnerMeals,
    this.lunchMeals,
    this.mealPlanTitle,
    this.mealPlanId,
    this.userId,
    this.mealPlanDay,
  });

  factory MealDayModel.fromJson(Map<String, dynamic> json) => MealDayModel(
        dateCreated: json["dateCreated"],
        breakfastMeals: json["breakfastMeals"] == null
            ? []
            : List<String>.from(json["breakfastMeals"]!.map((x) => x)),
        isApprovedByAdmin: json["isApprovedByAdmin"],
        dinnerMeals: json["dinnerMeals"] == null
            ? []
            : List<String>.from(json["dinnerMeals"]!.map((x) => x)),
        lunchMeals: json["lunchMeals"] == null
            ? []
            : List<String>.from(json["lunchMeals"]!.map((x) => x)),
        mealPlanTitle: json["mealPlanTitle"],
        mealPlanId: json["mealPlanId"],
        userId: json["userID"],
        mealPlanDay: json["mealPlanDay"],
      );

  factory MealDayModel.fromMap(Map<String, dynamic> map, String id) =>
      MealDayModel(
        dateCreated: map["dateCreated"],
        breakfastMeals: map["breakfastMeals"] == null
            ? []
            : List<String>.from(map["breakfastMeals"]!.map((x) => x)),
        isApprovedByAdmin: map["isApprovedByAdmin"],
        dinnerMeals: map["dinnerMeals"] == null
            ? []
            : List<String>.from(map["dinnerMeals"]!.map((x) => x)),
        lunchMeals: map["lunchMeals"] == null
            ? []
            : List<String>.from(map["lunchMeals"]!.map((x) => x)),
        mealPlanTitle: map["mealPlanTitle"],
        mealPlanId: map["mealPlanId"],
        userId: map["userID"],
        mealPlanDay: map["mealPlanDay"],
      );

  Map<String, dynamic> toJson() => {
        "dateCreated": dateCreated,
        "breakfastMeals": breakfastMeals == null
            ? []
            : List<dynamic>.from(breakfastMeals!.map((x) => x)),
        "isApprovedByAdmin": isApprovedByAdmin,
        "dinnerMeals": dinnerMeals == null
            ? []
            : List<dynamic>.from(dinnerMeals!.map((x) => x)),
        "lunchMeals": lunchMeals == null
            ? []
            : List<dynamic>.from(lunchMeals!.map((x) => x)),
        "mealPlanTitle": mealPlanTitle,
        "mealPlanId": mealPlanId,
        "userID": userId,
        "mealPlanDay": mealPlanDay,
      };
}
