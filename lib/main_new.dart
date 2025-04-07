import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyw_base_ardent1/providers/bluetooth_providers.dart';

import 'ui/bluetooth/bluetooth_screen.dart';
import 'ui/bluetooth/scan_screen.dart';

void main() {
  // Todo : Move the next line to a provider
  FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
  runApp(ProviderScope(child: MaterialApp(home: const FlutterBlueApp())));
}

class FlutterBlueApp extends ConsumerWidget {
  const FlutterBlueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bluetoothAdapterAsync = ref.watch(isAdapterOnProvider);
    return switch (bluetoothAdapterAsync) {
      AsyncData(:final value) =>
        value ? const ScanScreen() : BluetoothOffScreen(),
      AsyncError(:final error) => Text(error.toString()),
      _ => CircularProgressIndicator(),
    };
  }
}
