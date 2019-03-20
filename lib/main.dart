import 'package:flutter/material.dart';
import 'package:wallet_f/screen/wallet_detail.dart';
import 'package:wallet_f/screen/wallet_list.dart';

void main(){
  runApp(WalletApp());
}

class WalletApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Wallet App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue
          ),
          home:  WalletList() ,//WalletList(),
        );
  }
}



