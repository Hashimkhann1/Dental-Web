

import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HeaderSectionView extends StatelessWidget {
  const HeaderSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      height: Responsive.isMobile(context) ? 50 : 100,
      width:MediaQuery.of(context).size.width,
      child: Responsive.isMobile(context) ? Align(alignment: Alignment.centerLeft, child: Icon(Icons.menu,size: 30,color: MyColors.whiteColor,)) : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          /// logo
          Row(
            children: [
              Image.asset('assets/images/logo.png',width: 50,height: 50,),
              const MyText(title: "Dentist",fontWeight: FontWeight.bold,fontSize: 30,color: MyColors.whiteColor,)
            ],
          ),


          /// buttons
          const Row(
            children: [
              MyTextButton(title: "Home",fontSize: 20,fontWeight: FontWeight.w500,textColor: MyColors.whiteColor,),
              SizedBox(width: 28,),
              MyTextButton(title: "About us",fontSize: 20,fontWeight: FontWeight.w500,textColor: MyColors.whiteColor,),
              SizedBox(width: 28,),
              MyTextButton(title: "Services",fontSize: 20,fontWeight: FontWeight.w500,textColor: MyColors.whiteColor,),
              SizedBox(width: 28,),
              MyTextButton(title: "Contact us",fontSize: 20,fontWeight: FontWeight.w500,textColor: MyColors.whiteColor,),
            ],
          )


        ],
      ),
    );
  }
}
