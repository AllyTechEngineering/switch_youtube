// switch_service.dart

// Import necessary packages
import 'dart:async';
import 'package:dart_periphery/dart_periphery.dart';
import 'package:flutter/foundation.dart';

// Define the SwitchService class
class SwitchService { 
  // Define class properties
  final int gpioPin; // specify the GPIO pin connected to the switch
  final Duration pollInterval;
  final Duration debounceInterval;
  final StreamController<bool> _switchStateController = StreamController<bool>.broadcast();
  bool _isPolling = false;
  GPIO? _gpio;

  // Constructor to initialize the SwitchService
  SwitchService({
    required this.gpioPin,
    this.pollInterval = const Duration(milliseconds: 200),
    this.debounceInterval = const Duration(milliseconds: 50),
  }) {
    _gpio = GPIO(gpioPin, GPIOdirection.gpioDirIn);
  }

  // Stream to expose switch state changes
  Stream<bool> get switchStateStream => _switchStateController.stream;

  // Method to start polling the switch state
  void startPolling() {
    if (_isPolling) return;

    _isPolling = true;
    Timer.periodic(pollInterval, (timer) async {
      if (!_isPolling) {
        timer.cancel();
        return;
      }
      bool firstRead = _gpio!.read();
      await Future.delayed(debounceInterval);
      bool secondRead = _gpio!.read();

      if (firstRead == secondRead) {
        debugPrint('firstRead = $firstRead');
        _switchStateController.add(firstRead);
      }
    });
  }

  // Method to stop polling the switch state
  void stopPolling() {
    _isPolling = false;
  }

  // Method to clean up resources
  void dispose() {
    _isPolling = false;
    _switchStateController.close();
    _gpio?.dispose();
  }
}
