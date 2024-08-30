import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FotterSectionView extends StatelessWidget {
  const FotterSectionView({super.key});

  Widget _buildContactSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(

          mainAxisAlignment: Responsive.isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,

          children: [
            Image.asset('assets/images/logo.png', width: 50, height: 50),
            const SizedBox(height: 20),
            const MyText(
              title: "Clinic Name",
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 33,
              fontFamily: 'Oswald',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: Responsive.isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.facebook, size: 30),
              color: Colors.blueAccent,
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.instagram, size: 30),
              color: Colors.blueAccent,
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.twitter, size: 30),
              color: Colors.blueAccent,
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.linkedin, size: 30),
              color: Colors.blueAccent,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        MyText(
          title: "Quick Links",
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
        SizedBox(height: 20),
        MyText(title: "Home", fontSize: 20, color: MyColors.whiteColor),
        MyText(title: "About us", fontSize: 20, color: MyColors.whiteColor),
        MyText(title: "Services", fontSize: 20, color: MyColors.whiteColor),
        MyText(title: "Contact us", fontSize: 20, color: MyColors.whiteColor),
      ],
    );
  }

  Widget _buildClinicHoursSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        MyText(
          title: "Clinic Hours",
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(title: "Mon-Fri", fontSize: 20, color: MyColors.whiteColor),
            SizedBox(width: 40),
            MyText(title: "9:00 - 7:00 PM", fontSize: 20, color: MyColors.whiteColor),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            MyText(title: "Saturday", fontSize: 20, color: MyColors.whiteColor),
            SizedBox(width: 40),
            MyText(title: "Closed", fontSize: 20, color: MyColors.whiteColor),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyText(title: "Sunday", fontSize: 20, color: MyColors.whiteColor),
            SizedBox(width: 40),
            MyText(title: "Closed", fontSize: 20, color: MyColors.whiteColor),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      // height: MediaQuery.of(context).size.height * 0.3,
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 0),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: isMobile
          ? Column(
        mainAxisAlignment: Responsive.isMobile(context) ?  MainAxisAlignment.start : MainAxisAlignment.center,
        crossAxisAlignment: Responsive.isMobile(context) ?  CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          _buildContactSection(context),
          const SizedBox(height: 20),
          _buildQuickLinksSection(context),
          const SizedBox(height: 20),
          _buildClinicHoursSection(context),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildContactSection(context),
          _buildQuickLinksSection(context),
          _buildClinicHoursSection(context),
        ],
      ),
    );
  }
}
