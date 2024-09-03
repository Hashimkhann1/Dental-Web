

import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HeaderSectionView extends StatelessWidget {
  const HeaderSectionView({
    super.key,
    this.homeOnTap,
    required this.aboutOnTap,
    required this.servicesOnTap,
    required this.contactOnTap,
    required this.drawertOnTap,
  });

  final void Function()? homeOnTap;
  final void Function()? aboutOnTap;
  final void Function()? servicesOnTap;
  final void Function()? contactOnTap;
  final void Function()? drawertOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.primaryColor,
      height: Responsive.isMobile(context) ? 50 : 100,
      width: MediaQuery.of(context).size.width,
      child: Responsive.isMobile(context)
          ? Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: drawertOnTap,
            child: const Icon(
              Icons.menu,
              size: 34,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// logo
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 50,
                height: 50,
              ),
              const MyText(
                title: "Dentist",
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: MyColors.whiteColor,
              )
            ],
          ),

          /// buttons
          Row(
            children: [
              MyTextButton(
                title: "Home",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: MyColors.whiteColor,
                onTap: homeOnTap,
              ),
              const SizedBox(
                width: 28,
              ),
              MyTextButton(
                title: "About us",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: MyColors.whiteColor,
                onTap: aboutOnTap,
              ),
              const SizedBox(
                width: 28,
              ),
              MyTextButton(
                title: "Services",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: MyColors.whiteColor,
                onTap: servicesOnTap,
              ),
              const SizedBox(
                width: 28,
              ),
              MyTextButton(
                title: "Contact us",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                textColor: MyColors.whiteColor,
                onTap: contactOnTap,
              ),
            ],
          )
        ],
      ),
    );
  }
}

