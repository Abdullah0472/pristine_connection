import 'package:celient_project/res/components/widgets/appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        icon: false,
        actionIcon: false,
        action: Text(''),
        title: 'Chat',
      ),
      body: SafeArea(

        child: Column(children: [

        ],),
      ),
    );
  }
}
