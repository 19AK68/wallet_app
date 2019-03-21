import 'package:flutter/material.dart';
import 'package:wallet_f/model/wallet.dart';
import 'package:wallet_f/screen/wallet_detail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_f/utils/database_helper.dart';

class WalletList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return WalletListState();
  }

}

class WalletListState  extends State<WalletList>{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Wallet> walletList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(walletList == null){
      walletList = List<Wallet>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: getWalletListView(),

      floatingActionButton: FloatingActionButton(
        onPressed:(){
         debugPrint('FAB clicked');
        navigateToDetail(Wallet('', '', 2, 0),"Add Wallet");
      },
        tooltip: 'Add Note',
        child: Icon(Icons.add),

      ),
      
    );
  }
  ListView  getWalletListView(){

    TextStyle titleStyle =  Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context,int position){
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(

              
              leading: CircleAvatar(
                backgroundColor: getPriorityColor(this.walletList[position].priority),
                child: getPriorityIcon(this.walletList[position].priority),
              ),
              title: Text(this.walletList[position].title, style: titleStyle,),
              subtitle: Text(this.walletList[position].date),

              trailing: GestureDetector(
                child:  Icon(Icons.delete,color: Colors.grey,),
                onTap: (){
                  _delete(context, walletList[position]);
                },
              ),

              onTap:(){
                debugPrint("ListTile Tapped");
               navigateToDetail(this.walletList[position],'Edit Wallet ');

              },
            ) ,

          );

        },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Wallet wallet) async {

    int result = await databaseHelper.deleteWallet(wallet.id);
    if (result != 0){
      _showSnackBar(context,'Wallet Deleted Successully');
      updateListView();
    }
  }

  void  _showSnackBar (BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Wallet wallet ,String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
      return WalletDetail(wallet,title);
    }));

    if(result == true){
      updateListView();
    }
  }

  void updateListView(){

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Wallet>> walletListFuture = databaseHelper.getWalletList();
      walletListFuture.then((walletList){
        setState(() {
          this.walletList = walletList;
          this.count = walletList.length;
        });
      });
    });

  }
}