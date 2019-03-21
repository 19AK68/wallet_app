import 'package:flutter/material.dart';
import 'package:wallet_f/model/wallet.dart';
import 'package:wallet_f/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class WalletDetail extends StatefulWidget{

  final String appBarTitle;
  final Wallet wallet;

  WalletDetail(this.wallet, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return WalletDetailState(this.wallet,this.appBarTitle);
  }

}

class WalletDetailState extends State<WalletDetail>{

  static var _priorities = ["Credit","Debit"];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Wallet wallet;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  WalletDetailState(this.wallet,this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = wallet.title ;
    descriptionController.text = wallet.description;

    return WillPopScope(
      onWillPop: (){
        //Write some code to control things, when user press Back navigation button in device
        moveToLastScreen();
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon: Icon(
            Icons.arrow_back),
            onPressed: (){
              moveToLastScreen();
            }),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15.0,left: 10.0,right: 10.0),
          child: ListView(
            children: <Widget>[
            //1 element
              ListTile(
                title: DropdownButton(
                items: _priorities.map((String dropDownStringItem){
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),

                  );
                }).toList(),
                  style: textStyle,
                  value: getPriorityAsString(wallet.priority),
                  onChanged:  (valueSelectedByUser){
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                      updatePriorityAsInt(valueSelectedByUser);
                    });
                  }
                 ),

              ),
              // second element
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged:(value){
                    debugPrint('Something changed in Title Text Fied');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )

                  ),
                ),
              ),

              //third element
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged:(value){
                    debugPrint('Something changed in Description Text Fied');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )

                  ),
                ),
              ),

              // 4 ELEMENT
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,

                        ),
                        onPressed: (){
                          setState(() {
                            debugPrint('Save button checked');
                            _save();
                          });
                        },

                      ),
                    ),

                    Container(width: 5.0,),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,

                        ),
                        onPressed: (){
                          setState(() {
                            debugPrint('Delete button checked');
                            _delete();
                          });
                        },

                      ),
                    ),
                  ],

                ),
              )

          ],
          ),
          ),

    ));
  }

  void moveToLastScreen() {
    Navigator.pop(context,true);
  }

  //Convert int priority to String priority and display it to user in DropDown
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'Credit':
        wallet.priority = 1;
        break;
      case 'Debit':
        wallet.priority = 2;
        break;
    }
  }

  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];  // 'Credit'
        break;
      case 2:
        priority = _priorities[1];  // 'Debit'
        break;
    }
    return priority;
  }

  // Update the title of Wallet object
  void updateTitle(){
    wallet.title = titleController.text;
  }

  // Update the description of Wallet object
  void updateDescription() {
    String descriptionText;
    descriptionText = descriptionController.text;
    wallet.description = descriptionText;

  }

// Save data to database
  void _save() async {

    moveToLastScreen();
    wallet.date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    if (wallet.id != null) { //case 1: update operation
     result = await helper.updateWallet(wallet) ;

    } else {               // case 2: insert operation
      result = await helper.insertWallet(wallet) ;
    }

    if(result !=0 ){ //Success
      _showAlertDialog('Status', 'Wallet Saved Successfully');
    } else {         // Failure

      _showAlertDialog('Status', 'Problem Saving Wallet');
    }
  }

  void _delete() async {

    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW Wallet i.e. he has come to
    // the detail page by pressing the FAB of WalletList page.

    if(wallet.id == null){
      _showAlertDialog('Status', 'No Walet was delete');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.

    int result = await helper.deleteWallet(wallet.id);

    if(result !=0 ){ //Success
      _showAlertDialog('Status', 'Wallet Deleted Successfully');
    } else {         // Failure

      _showAlertDialog('Status', 'Error Occured while Deleting Wallet');
    }


  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}

