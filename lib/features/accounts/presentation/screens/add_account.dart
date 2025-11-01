import 'package:flutter/material.dart';
import 'package:money_tracker/core/theme/app_colors.dart';
import 'package:money_tracker/core/theme/app_text_style.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Add new account",
          style: AppTextStyles.appBarTitle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
            color: AppColors.primary,
            width: double.infinity,
            child: Positioned(
              bottom: 0,right: 0,
              child: Column(
                children: [
                  Text("Balance")
                ],
              ),
            ),
          )),
          Expanded(
            flex: 1,
            child: BottomSheet(onClosing: (){}, builder: (context){
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
