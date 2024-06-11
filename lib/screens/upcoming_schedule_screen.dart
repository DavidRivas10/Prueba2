import 'package:flutter/material.dart';
import 'package:flutter_appointment_scheduler/providers/appointment_provider.dart';
import 'package:flutter_appointment_scheduler/widgets/appointment_card.dart';

class UpcomingScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Schedule'),
      ),
      body: FutureBuilder(
        future: provider.fetchAppointments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.appointments.length,
            itemBuilder: (context, index) {
              return AppointmentCard(appointment: provider.appointments[index], key: null,);
            },
          );
        },
      ),
    );
  }
}

