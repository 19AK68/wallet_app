import 'package:flutter/material.dart';

class WalletDetail extends StatefulWidget{
  String appBarTitle;
  WalletDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return WalletDetailState(this.appBarTitle);
  }

}

class WalletDetailState extends State<WalletDetail>{
  static var _priorities = ["Credit","Debit"];

  String appBarTitle;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  WalletDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

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
                  value: "Debit",
                  onChanged:  (valueSelectedByUser){
                    setState(() {
                      debugPrint('User selected $valueSelectedByUser');
                    });
                  }
                 ),
              ),
              // second element
              Padding(
                padding: EdgeInsets.only(top: 15.0,bottom: 15.0),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged:(value){
                    debugPrint('Something changed in Title Text Fied');
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
                    debugPrint('Something changed in Title Text Fied');
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
    Navigator.pop(context);
  }
}
