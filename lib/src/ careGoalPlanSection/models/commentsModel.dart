// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CommentModel articleModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String articleModelToJson(CommentModel data) =>
    json.encode(data.toJson(data.careGoalPlanId.toString()));

class CommentModel {
  CommentModel({
    this.userId,
    this.commentID,
    this.careGoalPlanId,
    this.commentText,
    this.isApprovedByAdmin,
    this.dateCreated,
  });

  String? userId;
  String? commentID;
  String? careGoalPlanId;
  String? commentText;

  bool? isApprovedByAdmin;
  Timestamp? dateCreated;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        userId: json["userID"],
        commentID: json["commentID"],
        careGoalPlanId: json["careGoalPlanId"],
        commentText: json["commentText"],
        isApprovedByAdmin: json["isApprovedByAdmin"],
        dateCreated: json["dateCreated"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": userId,
        "commentID": docID,
        "careGoalPlanId": careGoalPlanId,
        "commentText": commentText,
        "isApprovedByAdmin": isApprovedByAdmin,
        "dateCreated": dateCreated,
      };
}
