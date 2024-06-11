import 'package:flutter/material.dart';
import 'package:flutter_appointment_scheduler/models/appointment_model.dart';
import 'package:flutter_appointment_scheduler/services/firestore_service.dart';

class AppointmentProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  Future<void> fetchAppointments() async {
    _appointments = await _firestoreService.getAppointments();
    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    await _firestoreService.addAppointment(appointment);
    await fetchAppointments();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await _firestoreService.updateAppointment(appointment);
    await fetchAppointments();
  }

  Future<void> deleteAppointment(String id) async {
    await _firestoreService.deleteAppointment(id);
    await fetchAppointments();
  }
}
