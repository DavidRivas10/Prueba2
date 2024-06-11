import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String id;
  final String doctor;
  final DateTime date;
  final String time;
  final String patient;

  Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.patient,
  });

  factory Appointment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Appointment(
      id: doc.id,
      doctor: data['doctor'] ?? '',
      date: (data['date'] as Timestamp).toDate(), // Corregido aquí
      time: data['time'] ?? '',
      patient: data['patient'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctor': doctor,
      'date': date,
      'time': time,
      'patient': patient,
    };
  }
}
