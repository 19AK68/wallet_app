import 'package:flutter/material.dart';

class WalletList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return WalletListState();
  }

}

class WalletListState  extends State<WalletList>{

  int count =0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Walet"),
      ),
      body: getWalletListView(),

      floatingActionButton: FloatingActionButton(
        onPressed:(){
         debugPrint('FAB clicked');
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
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text("Dummy Title",style: titleStyle,),
              subtitle: Text("Dummy Date"),
              trailing: Icon(Icons.delete,color: Colors.grey,),

              onTap:(){
                debugPrint("ListTile Tapped");
              },
            ) ,

          );

        },
    );
  }
}