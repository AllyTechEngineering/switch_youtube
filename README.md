# switch_youtube

Raspberry Pi GPIO Demo

## switch_service.dart

1. **Import necessary packages**:
    - Importing `dart:async` for asynchronous programming.
    - Importing `dart_periphery` for GPIO handling.
    - Importing `flutter/foundation.dart` for debugging.

2. **Define the SwitchService class**:
    - The class that encapsulates the logic for handling the switch connected to a GPIO pin.

3. **Define class properties**:
    - Properties required for GPIO pin, polling interval, debounce interval, and stream controller for switch state.
    - `_isPolling` to track the polling state.
    - `_gpio` to manage the GPIO pin.

4. **Constructor to initialize the SwitchService**:
    - Initializes the GPIO pin and sets default values for polling and debounce intervals.

5. **Stream to expose switch state changes**:
    - Provides a stream that can be listened to for switch state changes.

6. **Method to start polling the switch state**:
    - Starts a periodic timer to poll the switch state.
    - Debounces the read values to avoid false state changes.

7. **Method to stop polling the switch state**:
    - Stops the polling by setting `_isPolling` to false.

8. **Method to clean up resources**:
    - Disposes of the stream controller and GPIO resources when they are no longer needed.

## switch_screen.dart

1. **Import necessary packages**:
    - Importing `flutter/material.dart` for building the UI.
    - Importing `switch_service.dart` for interacting with the switch service.

2. **Define the SwitchScreen widget**:
    - The main widget that will display the switch status.

3. **Define the state for the SwitchScreen widget**:
    - The state class that holds the logic and state for the `SwitchScreen` widget.

4. **Initialize the state of the widget**:
    - Initializes the `SwitchService` and starts polling for switch state changes.

5. **Dispose resources when the widget is removed from the widget tree**:
    - Cleans up the `SwitchService` and any other resources.

6. **Build the UI of the widget**:
    - Builds the scaffold with an app bar and a body that contains a `StreamBuilder` to listen to switch state changes.
    - Handles different connection states: waiting, error, no data, and displaying the switch state.
