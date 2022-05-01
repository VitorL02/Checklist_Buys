// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CheckListPage extends StatelessWidget {
  const CheckListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CheckList de Compras',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Divider(),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Titulo da Compra',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
