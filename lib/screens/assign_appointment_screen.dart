import 'package:flutter/material.dart';
import 'package:flutter_appointment_scheduler/providers/appointment_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<AppointmentProvider>(
        create: (context) => AppointmentProvider(),
        child: AssignAppointmentScreen(),
      ),
    );
  }
}

class AssignAppointmentScreen extends StatefulWidget {
  const AssignAppointmentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AssignAppointmentScreenState createState() => _AssignAppointmentScreenState();
}

class _AssignAppointmentScreenState extends State<AssignAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedDoctor;
  late DateTime _selectedDate;
  late String _selectedTime;
  late String _patientName;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar Cita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Seleccione un doctor'),
                items: const [
                  DropdownMenuItem(child: Text('Dr. Juan Pérez'), value: 'Dr. Juan Pérez'),
                  DropdownMenuItem(child: Text('Dra. María García'), value: 'Dra. María García'),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDoctor = value as String;
                  });
                },
                validator: (value) => value == null ? 'Seleccione un doctor' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seleccione una fecha'),
                readOnly: true,
                onTap: () async {
                  DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  setState(() {
                    _selectedDate = date!;
                  });
                },
                // ignore: unnecessary_null_comparison
                validator: (value) => _selectedDate == null ? 'Seleccione una fecha' : null,
                // ignore: unnecessary_null_comparison
                controller: TextEditingController(text: _selectedDate != null ? _selectedDate.toLocal().toString().split(' ')[0] : ''),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seleccione una hora'),
                onChanged: (value) {
                  setState(() {
                    _selectedTime = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Seleccione una hora' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre del paciente'),
                onChanged: (value) {
                  setState(() {
                    _patientName = value;
                  });
                },
                validator: (value) => value!.isEmpty ? 'Ingrese el nombre del paciente' : null,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final appointment = Appointment(
                      doctor: _selectedDoctor,
                      date: _selectedDate,
                      time: _selectedTime,
                      patient: _patientName, id: '',
                    );
                    provider.addAppointment(appointment);
                  }
                },
                child: const Text('BUSCAR DOCTOR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
