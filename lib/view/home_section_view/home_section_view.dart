import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HomeSectionView extends StatelessWidget {
  const HomeSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: Responsive.isMobile(context) ? height * 0.88 : height * 0.75,
      color: MyColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// main row or column based on responsiveness
          Responsive.isMobile(context)
              ? Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildChildren(context, width, height),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildChildren(context, width, height),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context, double width, double height) {
    return [
      /// Clinic name
      Container(
        width: 410,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.start,
          crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [

            // SizedBox(height: Responsive.isMobile(context) ? height * 0.02 : 0,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.04 : 0),
              child: MyText(
                title: 'Best Care For Your Family',
                fontSize: Responsive.isMobile(context) ? 48 : 76,
                fontWeight: FontWeight.w800,
                fontFamily: 'Oswald',
                color: MyColors.whiteColor,
                textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
              ),
            ),

            SizedBox(height: Responsive.isMobile(context) ? 10 : 0,),

            /// text
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.1 : 0),
              child: MyText(
                title:
                Responsive.isMobile(context) ? "Lorem Ipsum is simply dummy text of the printing and typesetting industry." : "Lorem Ipsum is simply dummy text of the printing and\n typesetting industry.",

                color: MyColors.whiteColor,
                textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextButton(
              title: "Book Appointment",
              fontSize: 18,
              backgroundColor: MyColors.whiteColor,
              textColor: MyColors.primaryColor,
              width: 200,
              height: Responsive.isMobile(context) ?  height * 0.07 : height * 0.06,
              borderRadius: 30,
            ),
          ],
        ),
      ),

      SizedBox(height: Responsive.isMobile(context) ? 30 : 0),

      /// Picture
      Image.network('https://i.imgur.com/NIwGSeL_d.jpg?maxwidth=520&shape=thumb&fidelity=high',width: Responsive.isMobile(context) ? width * 0.86 : 560,height: Responsive.isMobile(context) ? height * 0.48 : 510,fit: BoxFit.fitWidth,)
    ];
  }
}
