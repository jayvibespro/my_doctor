import 'package:cloud_firestore/cloud_firestore.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 27|01|2025
* */

class BookingModel {
  String? id;
  String? patientId;
  String? patientName;
  String? patientPhone;
  String? doctorId;
  String? doctorName;
  String? doctorPhone;
  String? date;
  String? time;
  String? createdAt;
  String? description;
  String? status;

  BookingModel({
    this.id,
    required this.patientId,
    required this.patientName,
    required this.patientPhone,
    required this.doctorId,
    required this.doctorName,
    required this.doctorPhone,
    required this.date,
    required this.time,
    required this.createdAt,
    required this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'patient_name': patientName,
      'patient_phone': patientName,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'doctor_phone': doctorPhone,
      'date': date,
      'time': time,
      'created_at': createdAt,
      'description': description,
      'status': status,
    };
  }

  factory BookingModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return BookingModel(
      id: doc.id,
      patientId: doc.data()?['patient_id'],
      patientName: doc.data()?['patient_name'],
      patientPhone: doc.data()?['patient_phone'],
      doctorId: doc.data()?['doctor_id'],
      doctorName: doc.data()?['doctor_name'],
      doctorPhone: doc.data()?['doctor_phone'],
      date: doc.data()?['date'],
      time: doc.data()?['time'],
      createdAt: doc.data()?['created_at'],
      description: doc.data()?['description'],
      status: doc.data()?['status'],
    );
  }
}
