// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    int? id;
    String? fullname;
    String? email;
    String? password;
    String? gender;
    String? hn;
    String? age;
    String? symptom;
    String? disease;

    Users({
        this.id,
        this.fullname,
        this.email,
        this.password,
        this.gender,
        this.hn,
        this.age,
        this.symptom,
        this.disease,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
        gender: json["gender"],
        hn: json["HN"],
        age: json["age"],
        symptom: json["symptom"],
        disease: json["disease"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "password": password,
        "gender": gender,
        "HN": hn,
        "age": age,
        "symptom": symptom,
        "disease": disease,
    };
}
