import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appointment_scheduler/models/appointment_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Appointment>> getAppointments() async {
    var snapshots = await _db.collection('appointments').get();
    return snapshots.docs.map((doc) => Appointment.fromFirestore(doc)).toList();
  }

  Future<void> addAppointment(Appointment appointment) {
    return _db.collection('appointments').add(appointment.toMap());
  }

  Future<void> updateAppointment(Appointment appointment) {
    return _db.collection('appointments').doc(appointment.id).update(appointment.toMap());
  }

  Future<void> deleteAppointment(String id) {
    return _db.collection('appointments').doc(id).delete();
  }
}

