import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class MemberModel {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final String? phone;

  MemberModel({this.id, this.username, this.password, this.email, this.phone});

  /*factory MemberModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MemberModel(
      id: data?['id'],
      username: data?['username'],
      password: data?['password'],
      email: data?['email'],
      phone: data?['phone'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (username != null) "username": username,
      if (password != null) "password": password,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
    };
  }*/
  factory MemberModel.fromJson(Map<dynamic, dynamic> json) => MemberModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'email': email,
        'phone': phone
      };
}
