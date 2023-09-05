// To parse this JSON data, do
//
//     final patients = patientsFromJson(jsonString);

import 'dart:convert';

List<Patients> patientsFromJson(String str) => List<Patients>.from(json.decode(str).map((x) => Patients.fromJson(x)));

String patientsToJson(List<Patients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patients {
    int? id;
    String? fullname;
    String? hn;
    String? gender;
    String? age;
    String? symptom;
    String? disease;

    Patients({
        this.id,
        this.fullname,
        this.hn,
        this.gender,
        this.age,
        this.symptom,
        this.disease,
    });

    factory Patients.fromJson(Map<String, dynamic> json) => Patients(
        id: json["id"],
        fullname: json["fullname"],
        hn: json["HN"],
        gender: json["gender"],
        age: json["age"],
        symptom: json["symptom"],
        disease: json["disease"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "HN": hn,
        "gender": gender,
        "age": age,
        "symptom": symptom,
        "disease": disease,
    };
}
