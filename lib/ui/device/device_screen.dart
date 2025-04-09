import 'package:flutter/material.dart';
import 'package:gyw_base_ardent1/gyw_base_ardent1.dart';

import '../../main.dart' show routeObserver;

final DeviceService deviceService = DeviceService();

class DeviceScreen extends StatefulWidget {
  final String deviceId;
  final int rssi;

  const DeviceScreen(this.deviceId, this.rssi, {super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreen2State();
}

class _DeviceScreen2State extends State<DeviceScreen> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    deviceService.disconnectDevice();
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now the topmost route.
    print('didPush');
  }

  @override
  void didPop() {
    print('didPop');
  }

  @override
  void initState() {
    super.initState();
    deviceService.connectDevice(widget.deviceId, widget.rssi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            deviceService.sendExampleData();
          },
          child: Text('Send Example Datat to deviceId : ${widget.deviceId}'),
        ),
      ),
    );
  }
}
