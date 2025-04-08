import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyw_base_ardent1/gyw_base_ardent1.dart';

import 'snackbar.dart';

class BluetoothOffIcon extends StatelessWidget {
  const BluetoothOffIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.bluetooth_disabled,
      size: 200.0,
      color: Colors.white54,
    );
  }
}

class Title extends ConsumerWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothAdapterAsync = ref.watch(bluetoothAdapterStateProvider);
    return switch (bluetoothAdapterAsync) {
      AsyncData(:final value) => Text(
        'Bluetooth Adapter is ${value.name}not available',
        style: Theme.of(
          context,
        ).primaryTextTheme.titleSmall?.copyWith(color: Colors.white),
      ),
      AsyncError(:final error) => Text(error.toString()),
      _ => CircularProgressIndicator(),
    };
  }
}

class TurnOnButton extends StatelessWidget {
  const TurnOnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        child: const Text('TURN ON'),
        onPressed: () async {
          try {
            if (!kIsWeb && Platform.isAndroid) {
              await FlutterBluePlus.turnOn();
            }
          } catch (e, backtrace) {
            Snackbar.show(
              ABC.a,
              prettyException("Error Turning On:", e),
              success: false,
            );
            print("$e");
            print("backtrace: $backtrace");
          }
        },
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: Snackbar.snackBarKeyA,
      child: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[BluetoothOffIcon(), Title(), TurnOnButton()],
          ),
        ),
      ),
    );
  }
}
