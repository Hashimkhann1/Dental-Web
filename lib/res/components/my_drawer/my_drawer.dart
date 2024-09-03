

import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, this.servicesOnTap, this.aboutOnTap, this.contactsOnTap,this.homeOnTap});

  final void Function()? homeOnTap;
  final void Function()? aboutOnTap;
  final void Function()? servicesOnTap;
  final void Function()? contactsOnTap;

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                children: [
                  SizedBox(height: height * 0.14,),

                  const Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: MyText(title: "Clinic Name",fontSize: 42,color: MyColors.primaryColor,fontWeight: FontWeight.bold,fontFamily: 'Oswald',letterSpacing: 2,)
                    ),
                  ),

                  SizedBox(height: height * 0.1,),


                  MyTextButton(
                    width: width * 0.66,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
                    margin: EdgeInsets.only(left: width * 0.02),
                    borderRadius: 6,
                    title: "Home",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor: MyColors.primaryColor,
                    onTap: homeOnTap,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  MyTextButton(
                    width: width * 0.66,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
                    margin: EdgeInsets.only(left: width * 0.02),
                    borderRadius: 6,
                    title: "About",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor: MyColors.primaryColor,
                    onTap: aboutOnTap,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  SizedBox(

                    height: height * 0.01,
                  ),
                  MyTextButton(
                    width: width * 0.66,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
                    margin: EdgeInsets.only(left: width * 0.02),
                    borderRadius: 6,
                    title: "Services",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor:MyColors.primaryColor,
                    onTap: servicesOnTap,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  MyTextButton(
                    width: width * 0.66,
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
                    margin: EdgeInsets.only(left: width * 0.02),
                    borderRadius: 6,
                    title: "Contact Us",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    textColor: MyColors.primaryColor,
                    onTap: contactsOnTap,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  )
                ],
              ),


              /// contact
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(title: "+00 0000000000",fontSize: 20,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
                    const MyText(title: "clinicName@gmail.com",fontSize: 20,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
                    SizedBox(height: height * 0.04,)
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
