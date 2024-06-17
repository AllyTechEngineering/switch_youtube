// switch_screen.dart

// Import necessary packages
import 'package:flutter/material.dart';
import 'package:switch_youtube/src/switch_service.dart';

// Define the SwitchScreen widget
class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SwitchScreenState createState() => _SwitchScreenState();
}

// Define the state for the SwitchScreen widget
class _SwitchScreenState extends State<SwitchScreen> {
  late SwitchService _switchService;
  late Stream<bool> _switchStateStream;

  // Initialize the state of the widget
  @override
  void initState() {
    super.initState();
    _switchService = SwitchService(gpioPin: 23); // specify your GPIO pin here
    _switchStateStream = _switchService.switchStateStream;
    _switchService.startPolling();
  }

  // Dispose resources when the widget is removed from the widget tree
  @override
  void dispose() {
    _switchService.dispose();
    super.dispose();
  }

  // Build the UI of the widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch Status'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<bool>(
          stream: _switchStateStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No data');
            } else {
              bool switchState = snapshot.data!;
              return Text(
                switchState ? 'Switch is ON' : 'Switch is OFF',
                style: const TextStyle(fontSize: 50.0),
              );
            }
          },
        ),
      ),
    );
  }
}
