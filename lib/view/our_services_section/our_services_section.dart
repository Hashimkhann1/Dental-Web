import 'package:doctor_demo/res/components/my_sevices_card/my_sevices_card.dart';
import 'package:doctor_demo/res/components/my_sevices_card/my_sevices_card.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OurServicesSection extends StatefulWidget {
  const OurServicesSection({super.key});

  @override
  State<OurServicesSection> createState() => _OurServicesSectionState();
}

class _OurServicesSectionState extends State<OurServicesSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> headingTextRevelAnimation;
  late Animation<double> textOpacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    headingTextRevelAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.1, curve: Curves.easeOut)));


    super.initState();
  }

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

    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if (Responsive.isMobile(context)) {
          if ((current.scrollOffsetValue >= 1770 &&
                  current.scrollOffsetValue <= 1800) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        } else {
          if ((current.scrollOffsetValue >= 1510 &&
                  current.scrollOffsetValue <= 1600) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        }
      },
      builder: (context, state) {
        if (Responsive.isMobile(context)) {
          if (state.scrollOffsetValue > 1782) {
            _controller.forward();
          }
        } else {
          if (state.scrollOffsetValue > 1530) {
            _controller.forward();
          }
        }

        return Container(
          color: MyColors.primaryColor,
          width: width,
          child: Column(
            children: [
              SizedBox(
                width: 1240,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),

                    Container(
                      // color: Colors.white,
                      height: Responsive.isMobile(context)
                          ? height * 0.14
                          : height * 0.1,
                      padding:
                          EdgeInsets.only(top: headingTextRevelAnimation.value),
                      child: FadeTransition(
                        opacity: textOpacityAnimation,
                        child: const MyText(
                          title: "Our Services",
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: MyColors.whiteColor,
                          fontFamily: 'Oswald',
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    // Using Flexible instead of Expanded
                    Flexible(
                      fit: FlexFit
                          .loose, // Allows the child to take up its necessary space
                      child: GridView.builder(
                        itemCount: servicesData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Responsive.isMobile(context)
                                ? 1
                                : Responsive.isTablet(context)
                                    ? 2
                                    : 3,
                            crossAxisSpacing:
                                Responsive.isTablet(context) ? 0 : 10,
                            mainAxisSpacing:
                                Responsive.isTablet(context) ? 16 : 10,
                            childAspectRatio: Responsive.isMobile(context)
                                ? 2 / 1.1
                                : Responsive.isTablet(context)
                                    ? 2 / 1
                                    : 2 / 1.4),
                        itemBuilder: (context, index) {
                          return MyServicesCard(image: 'image', title: servicesData[index].toString(), description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",index: index,);
                        },
                      ),
                    ),

                    SizedBox(
                      height: height * 0.06,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
