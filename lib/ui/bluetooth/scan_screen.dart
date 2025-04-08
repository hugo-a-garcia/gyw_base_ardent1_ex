import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyw_base_ardent1/gyw_base_ardent1.dart';
import 'package:gyw_base_ardent1_ex/ui/device/device_screen.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(scanResultsRecordsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Connect')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tap on the device you wish to connect to or scan to update the list with new devices',
              ),
            ),
            ElevatedButton(
              onPressed: () => ref.refresh(startScanProvider),
              child: Text('Scan'),
            ),
            switch (asyncResults) {
              AsyncData(:final value) => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final record = value[index];
                    return ScanResutCard(record);
                  },
                ),
              ),
              AsyncError(:final error) => Text(error.toString()),
              _ => const CircularProgressIndicator(),
            },
          ],
        ),
      ),
    );
  }
}

class ScanResutCard extends StatelessWidget {
  const ScanResutCard(this.scanResultRecord, {super.key});

  final ScanResultRecord scanResultRecord;

  @override
  Widget build(BuildContext context) {
    final AdvertisementDataRecord advertisement =
        scanResultRecord.advertisement;
    final BlueetoothDeviceRecord deviceRecord =
        scanResultRecord.blueetoothDeviceRecord;
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      DeviceScreen(deviceRecord.deviceId, deviceRecord.rssi),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('advName : ${advertisement.advName}'),
              Text('connectable : ${advertisement.connectable}'),
              Text('txPowerLevel : ${advertisement.txPowerLevel}'),

              Text('advName : ${deviceRecord.advName}'),
              Text('deviceId :  ${deviceRecord.deviceId}'),
              Text(
                'isAutoConnectedEnabled : ${deviceRecord.isAutoConnectedEnabled}',
              ),
              Text('isConnected : ${deviceRecord.isConnected}'),
              Text('isDiconnedted : ${deviceRecord.isDiconnedted}'),
              Text('mtuNow : ${deviceRecord.mtuNow}'),
              Text('platformName : ${deviceRecord.platformName}'),
            ],
          ),
        ),
      ),
    );
  }
}
