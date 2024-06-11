import 'package:flutter/material.dart';
import 'package:flutter_appointment_scheduler/providers/appointment_provider.dart';
import 'package:flutter_appointment_scheduler/screens/assign_appointment_screen.dart';
import 'package:flutter_appointment_scheduler/screens/upcoming_schedule_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
      child: MyApp(),
    ) as Widget,
  );
}
class Firebase {
  static initializeApp() {}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Appointment Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AssignAppointmentScreen(),
      routes: {
        '/assign': (context) => AssignAppointmentScreen(),
        '/upcoming': (context) => UpcomingScheduleScreen(),
      },
    );
  }
}
