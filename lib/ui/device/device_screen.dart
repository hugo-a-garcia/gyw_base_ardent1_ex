import 'package:flutter/material.dart';
import 'package:gyw_base_ardent1/gyw_base_ardent1.dart';

final DeviceService deviceService = DeviceService();

class DeviceScreen extends StatefulWidget {
  final String deviceId;
  final int rssi;

  const DeviceScreen(this.deviceId, this.rssi, {super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreen2State();
}

class _DeviceScreen2State extends State<DeviceScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    deviceService.disconnectDevice();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Error if we try to reconnect to device
    // LateError (LateInitializationError: Field '_gywBtDevice@37420571' has already been initialized.)
    deviceService.connectDevice(widget.deviceId, widget.rssi);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            deviceService.sendDrawing(helloWorldDrawing());
          },
          child: Text('Send Example Datat to deviceId : ${widget.deviceId}'),
        ),
      ),
    );
  }

  List<GYWDrawing> helloWorldDrawing() {
    return <GYWDrawing>[
      BlankScreen(color: Colors.white),
      IconDrawing(GYWIcon.up, top: 50, left: 60),
      TextDrawing(
        text: "Hello world",
        top: 50,
        left: 220,
        font: GYWFont.medium,
      ),
    ];
  }
}
