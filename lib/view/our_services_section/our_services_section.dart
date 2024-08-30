import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class OurServicesSection extends StatelessWidget {
   OurServicesSection({super.key});

  List<String> servicesData = [
    "Root Canal (painless)",
    "Dental Implants",
    "Paediatric Dentistry",
    "Orthodontic Treatment",
    "Restorative Dentistry",
    "Cosmetic Dentistry"
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      color: MyColors.primaryColor,
      width: width,
      child: Column(
        children: [
          SizedBox(
          width: 1240,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrink-wraps the column to its children
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                const MyText(
                  title: "Our Services",
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: MyColors.whiteColor,
                  fontFamily: 'Oswald',
                ),
                SizedBox(height: height * 0.04),
                // Using Flexible instead of Expanded
                Flexible(
                  fit: FlexFit.loose, // Allows the child to take up its necessary space
                  child: GridView.builder(
                    itemCount: servicesData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: Responsive.isMobile(context) ? 2 / 1.1 : 2/1.4

                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all( Responsive.isMobile(context) ? 16: 30),
                        margin: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 10 : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: MyColors.whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// image
                            CircleAvatar(radius:  Responsive.isMobile(context) ? 30 : 36,),
                            SizedBox(height:  Responsive.isMobile(context) ? 10 : height * 0.02,),

                            /// service name
                            MyText(title: servicesData[index].toString(),fontSize: 28,fontWeight: FontWeight.bold,),
                            SizedBox(height:  Responsive.isMobile(context) ? 10 : height * 0.02,),
                            MyText(title: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",fontSize: 18,color: Colors.black.withOpacity(0.7),),
                          ],
                        ),
                      );
                    },

                  ),
                ),

                SizedBox(height: height * 0.06,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
