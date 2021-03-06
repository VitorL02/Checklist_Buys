// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace,

import 'package:checklist_buys/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/buy.dart';

class CheckListPage extends StatefulWidget {
  const CheckListPage({Key? key}) : super(key: key);

  @override
  State<CheckListPage> createState() => _CheckListPageState();
}

class _CheckListPageState extends State<CheckListPage> {
  bool isBuy = false;
  TextEditingController buyTitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Buy>>(
            stream: DatabaseServices().listBuys(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.pink),
                );
              }
              List<Buy>? buys = snapshot.data;
              return Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CheckList de Compras',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Divider(),
                    SizedBox(height: 20),
                    ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[800],
                      ),
                      shrinkWrap: true,
                      itemCount: buys!.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(buys[index].title),
                          background: Container(
                              padding: EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: Icon(Icons.delete),
                              color: Colors.red),
                          onDismissed: (direction) async {
                            await DatabaseServices()
                                .deleteBuy(buys[index].uuid);
                            Get.snackbar(
                              'Compra Deletada',
                              'Sua compra ${buys[index].title} foi deletada com sucesso',
                              backgroundColor: Colors.green,
                              icon: Icon(Icons.delete, color: Colors.white),
                              colorText: Colors.white,
                            );
                          },
                          child: ListTile(
                            onTap: () {
                              DatabaseServices().completeBuy(buys[index].uuid);
                            },
                            leading: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    shape: BoxShape.circle),
                                child: buys[index].isBuy
                                    ? Icon(Icons.check, color: Colors.white)
                                    : Container()),
                            title: Text(
                              buys[index].title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[200]),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          elevation: 10,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SimpleDialog(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Row(
                  children: [
                    Text(
                      "Nova Compra",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.cancel, color: Colors.red))
                  ],
                ),
                children: [
                  Divider(),
                  TextFormField(
                    controller: buyTitleController,
                    style: TextStyle(
                        fontSize: 18, color: Colors.white, height: 1.5),
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Exemplo: Computador Novo',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(height: 50),
                  // ignore: deprecated_member_use
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () async {
                        if (buyTitleController.text.isNotEmpty) {
                          await DatabaseServices()
                              .createNewBuy(buyTitleController.text.trim());
                          Navigator.pop(context);
                          buyTitleController.text = '';
                        }
                      },
                      child: Text('Adicionar'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor),
    );
  }
}
