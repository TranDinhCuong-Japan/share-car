import 'package:flutter/material.dart';

class ArtDailog{

  Future<void> _showMyDialogSudung(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm'),
            content: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text('Ban chuan bi su dung xe dung khong?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
}