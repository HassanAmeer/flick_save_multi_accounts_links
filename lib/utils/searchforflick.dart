import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ndef/ndef.dart' as ndef1;
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:vibration/vibration.dart';
// import 'package:nfc_manager/nfc_ndef.dart';

import '../provider/directtoggleVm.dart';
import 'app_constant.dart';
import 'helper.dart';

class SearchForFlick extends StatefulWidget {
  const SearchForFlick({super.key});

  @override
  State<SearchForFlick> createState() => _SearchForFlickState();
}

class _SearchForFlickState extends State<SearchForFlick> {
  @override
  void initState() {
    super.initState();
    checkNfcCardF();
  }

  checkNfcCardF() async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      // oh-no
    }

    var tag = await FlutterNfcKit.poll(timeout: const Duration(seconds: 10));

    if (tag.type == NFCTagType.iso7816) {
      var result = await FlutterNfcKit.transceive("00B0950000",
          timeout: const Duration(seconds: 5));
      Helper.showSnack(context, "NFC Result: $result");
    }

    if (tag.ndefAvailable!) {
      final userid = await getUserID();
      await FlutterNfcKit.writeNDEFRecords([
        ndef1.UriRecord.fromUri(Uri.parse(AppConstant.profileView + userid))
      ]);
      Helper.showSnack(context, "NFC CardIs Writes");
    }
    Vibration.vibrate(duration: 500);
    await FlutterNfcKit.finish();
    Helper.showSnack(context, "Successfully Write");
    Navigator.pop(context);
  }

  // _initializeNfc() async {
  //   try {
  //     await NfcManager.instance.startSession(
  //       onDiscovered: (NfcTag tag) async {
  //         try {
  //           final userid = await getUserID();

  //           NdefMessage message = NdefMessage([
  //             NdefRecord.createUri(Uri.parse(AppConstant.profileView + userid)),
  //           ]);

  //           await NfcNdefWriteHandler.write(message, tag);
  //           Helper.showSnack(context, "NFC Card is written successfully");
  //         } catch (e) {
  //           print('Error writing URL to NFC tag: $e');
  //         } finally {
  //           await NfcManager.instance.stopSession();
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     print('Error starting NFC session: $e');
  //   }
  // }

  // _initializeNfc() async {
  //   NfcManager.instance.startSession(
  //     onDiscovered: (NfcTag tag) async {
  //       try {
  //         final userid = await getUserID();

  //         NdefMessage message = NdefMessage([
  //           NdefRecord.createUri(Uri.parse(AppConstant.profileView + userid)),
  //         ]);

  //         await NfcNdefWriteHandler.write(message, tag);
  //         Helper.showSnack(context, "NFC CardIs Writes");
  //       } catch (e) {
  //         // Handle write failure
  //         print('Error writing URL to NFC tag: $e');
  //       } finally {
  //         NfcManager.instance.stopSession();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Ready to Scan Flick device",
            style: TextStyle(fontSize: 20, fontFamily: 'CarosMedium'),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Lottie.asset(
              'lib/assets/animations/searchforflick.json',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Hold your phone near the Flick device",
            style: TextStyle(
              fontSize: 14,
              fontFamily: "CarosMedium",
            ),
          )
        ],
      ),
    );
  }
}
