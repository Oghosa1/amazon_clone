import 'package:amazon_clone/widgets/below_appbar.dart';
import 'package:amazon_clone/widgets/orders.dart';
import 'package:flutter/material.dart';

import '../common/assets.dart';
import '../common/global_variable.dart';
import '../widgets/top_button.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  Assets.Amazon,
                  width: 200,
                  height: 100,
                  // color: Colors.black ,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          BelowAppbar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders()
        ],
      ),
    );
  }
}
