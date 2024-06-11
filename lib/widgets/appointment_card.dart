import 'package:flutter/material.dart';
import 'package:flutter_appointment_scheduler/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({required Key key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(appointment.doctor),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${appointment.date.toLocal().toString().split(' ')[0]}'),
            Text('Hora: ${appointment.time}'),
            Text('Paciente: ${appointment.patient}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Implement delete functionality here
          },
        ),
      ),
    );
  }
}
