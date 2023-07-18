import 'package:celient_project/view_model/controller/unloaded/unloaded_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class SignatureDialog extends StatelessWidget {
  final unloadVM = Get.put(UnloadDataViewModel());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Capture Signature'),
      content: Container(
        height: 200,
        child: Signature(
          controller: unloadVM.signatureController,
          backgroundColor: Colors.lightBlueAccent.shade200,
          height: 200,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(unloadVM.signatureController.toImage());
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
