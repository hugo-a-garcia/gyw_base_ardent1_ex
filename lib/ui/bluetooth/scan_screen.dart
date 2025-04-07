import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gyw_base_ardent1/providers/bluetooth_providers.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResults = ref.watch(scanResultsRecordsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Blue River')),
      body: Center(
        child: Column(
          children: [
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Awesome Snackbar!'),
              action: SnackBarAction(
                label: 'Action',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        },
        child: Column(
          children: [
            Text('advName : ${advertisement.advName}'),
            Text('connectable : ${advertisement.connectable}'),
            Text('txPowerLevel : ${advertisement.txPowerLevel}'),

            Text('advName : ${deviceRecord.advName}'),
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
    );
  }
}
