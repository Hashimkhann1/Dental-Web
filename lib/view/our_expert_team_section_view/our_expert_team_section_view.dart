import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor_demo/res/components/expert_doctor_card/expert_doctor_card.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OurExpertTeamSectionView extends StatefulWidget {
  const OurExpertTeamSectionView({super.key});

  @override
  State<OurExpertTeamSectionView> createState() =>
      _OurExpertTeamSectionViewState();
}

class _OurExpertTeamSectionViewState extends State<OurExpertTeamSectionView>
    with TickerProviderStateMixin {

  int activeIndex = 0;

  late AnimationController _controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> headingTextRevelAnimation;
  late Animation<double> textOpacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    textRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.9, curve: Curves.easeIn)));

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

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: 1200,
      // height: height * 0.6,
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<DisplayOffset, ScrollOffset>(

        buildWhen: (previous, current) {

          if (Responsive.isTablet(context)) {
            if ((current.scrollOffsetValue >= 2950 &&
                current.scrollOffsetValue <= 3080) ||
                _controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          } else if (Responsive.isMobile(context)) {
            if ((current.scrollOffsetValue >= 3305 &&
                current.scrollOffsetValue <= 3410) ||
                _controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          } else {
            if ((current.scrollOffsetValue >= 2290 &&
                current.scrollOffsetValue <= 2390) ||
                _controller.isAnimating) {
              return true;
            } else {
              return false;
            }
          }
        },

        builder: (context, state) {

          if(Responsive.isTablet(context)){
            if (state.scrollOffsetValue > 3067) {
              _controller.forward();
            }
          }else if(Responsive.isMobile(context)) {
            if (state.scrollOffsetValue > 3325) {
              _controller.forward();
            }
          }
          else{
            if (state.scrollOffsetValue > 2311) {
              _controller.forward();
            }
          }

          return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Responsive.isMobile(context) ? 60 : 90,
                      padding:
                      EdgeInsets.only(top: headingTextRevelAnimation.value),
                      child: FadeTransition(
                        opacity: textOpacityAnimation,
                        child: MyText(
                          title: "Our Expert Doctors",
                          fontSize: Responsive.isMobile(context) ? 34 : 50,
                          fontWeight: FontWeight.bold,
                          color: MyColors.blackColor,
                          fontFamily: 'Oswald',
                        ),
                      ),
                    ),
                    // const SizedBox(height: 4),
                    FadeTransition(
                      opacity: textOpacityAnimation,
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),

                    Container(
                      width: Responsive.isMobile(context) ? width * 0.98 : Responsive.isTablet(context) ? width * 0.6 : width * 0.42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CarouselSlider.builder(
                          itemCount: teamMembers.length,
                          itemBuilder: (context, index, relIndex) {
                            // print(imagesUrl.length);
                            return ExpertDoctorCard(
                                name: teamMembers[index]['name']!,
                                title: teamMembers[index]['title']!,
                                imagePath: teamMembers[index]['imagePath']!);
                          },
                          options: CarouselOptions(
                              height: Responsive.isMobile(context) ? height * 0.42 : Responsive.isTablet(context) ? height * 0.32 : height * 0.5,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (changeIndex, reason) {
                                setState(() {
                                  activeIndex = changeIndex;
                                });
                              })),
                    ),

                  ],
                );
              }
          );
        },
      ),
    );
  }
}


final List<Map<String, String>> teamMembers = [
  {
    'name': 'Natali Jones',
    'title': 'Oral Surgeon',
    'imagePath':
    'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
  },
  {
    'name': 'David Green',
    'title': 'Oral Surgeon',
    'imagePath':
    'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
  },
  {
    'name': 'Amy Walker',
    'title': 'Oral Surgeon',
    'imagePath':
    'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip'
  },
];