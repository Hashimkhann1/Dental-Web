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
  late AnimationController _carouselController;

  late Animation<double> _titleSlideAnimation;
  late Animation<double> _titleOpacityAnimation;
  late Animation<double> _subtitleSlideAnimation;
  late Animation<double> _subtitleOpacityAnimation;
  late Animation<double> _carouselScaleAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Main controller for section entrance
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // Carousel animation controller
    _carouselController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Title animations
    _titleSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    _titleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    // Subtitle animations
    _subtitleSlideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _subtitleOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

    // Carousel animations
    _carouselScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _carouselController,
        curve: Curves.elasticOut,
      ),
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1400),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<DisplayOffset, ScrollOffset>(
        buildWhen: (previous, current) => _shouldRebuild(context, current),
        builder: (context, state) {
          _triggerAnimationBasedOnScroll(context, state);

          return AnimatedBuilder(
            animation: Listenable.merge([_controller, _carouselController]),
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 16 : 32,
                  vertical: Responsive.isMobile(context) ? 40 : 60,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.blue.shade50.withOpacity(_backgroundAnimation.value * 0.3),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 50),
                    _buildCarousel(height, width),
                    const SizedBox(height: 30),
                    _buildIndicators(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Main title
        Transform.translate(
          offset: Offset(0, _titleSlideAnimation.value),
          child: FadeTransition(
            opacity: _titleOpacityAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyText(
                title: "Our Expert Doctors",
                fontSize: _getResponsiveTitleSize(),
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
                fontFamily: 'Oswald',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle with enhanced styling
        Transform.translate(
          offset: Offset(0, _subtitleSlideAnimation.value),
          child: FadeTransition(
            opacity: _subtitleOpacityAnimation,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Meet our team of experienced healthcare professionals dedicated to providing exceptional medical care with compassion and expertise.",
                style: TextStyle(
                  fontSize: _getResponsiveSubtitleSize(),
                  color: Colors.grey[600],
                  height: 1.6,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarousel(double height, double width) {
    return ScaleTransition(
      scale: _carouselScaleAnimation,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: CarouselSlider.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: ExpertDoctorCard(
                name: teamMembers[index]['name']!,
                title: teamMembers[index]['title']!,
                imagePath: teamMembers[index]['imagePath']!,
                isActive: index == activeIndex,
              ),
            );
          },
          options: CarouselOptions(
            height: _getCarouselHeight(height),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInOutCubic,
            viewportFraction: _getViewportFraction(),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            enlargeFactor: 0.25,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return FadeTransition(
      opacity: _subtitleOpacityAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          teamMembers.length,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: index == activeIndex ? 24 : 8,
            decoration: BoxDecoration(
              color: index == activeIndex
                  ? Colors.blue.shade600
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for responsive sizing
  double _getResponsiveTitleSize() {
    if (Responsive.isMobile(context)) return 32;
    if (Responsive.isTablet(context)) return 42;
    return 50;
  }

  double _getResponsiveSubtitleSize() {
    if (Responsive.isMobile(context)) return 14;
    if (Responsive.isTablet(context)) return 16;
    return 18;
  }

  double _getCarouselHeight(double height) {
    if (Responsive.isMobile(context)) return height * 0.45;
    if (Responsive.isTablet(context)) return height * 0.4;
    return height * 0.5;
  }

  double _getViewportFraction() {
    if (Responsive.isMobile(context)) return 0.85;
    if (Responsive.isTablet(context)) return 0.6;
    return 0.4;
  }

  // Animation trigger logic
  bool _shouldRebuild(BuildContext context, ScrollOffset current) {
    final thresholds = _getScrollThresholds(context);
    return (current.scrollOffsetValue >= thresholds['min']! &&
        current.scrollOffsetValue <= thresholds['max']!) ||
        _controller.isAnimating ||
        _carouselController.isAnimating;
  }

  void _triggerAnimationBasedOnScroll(BuildContext context, ScrollOffset state) {
    final thresholds = _getScrollThresholds(context);

    if (state.scrollOffsetValue > thresholds['trigger']!) {
      if (!_controller.isCompleted) {
        _controller.forward();
        // Delay carousel animation slightly
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) _carouselController.forward();
        });
      }
    }
  }

  Map<String, double> _getScrollThresholds(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return {'min': 2950, 'max': 3080, 'trigger': 3067};
    } else if (Responsive.isMobile(context)) {
      return {'min': 3305, 'max': 3410, 'trigger': 3325};
    } else {
      return {'min': 2290, 'max': 2390, 'trigger': 2311};
    }
  }
}

final List<Map<String, String>> teamMembers = [
  {
    'name': 'Dr. Natali Jones',
    'title': 'Oral Surgeon',
    'specialty': 'Advanced Dental Surgery',
    'experience': '12+ Years Experience',
    'imagePath': 'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
  },
  {
    'name': 'Dr. David Green',
    'title': 'Cardiologist',
    'specialty': 'Heart Disease Specialist',
    'experience': '15+ Years Experience',
    'imagePath': 'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
  },
  {
    'name': 'Dr. Amy Walker',
    'title': 'Pediatrician',
    'specialty': 'Child Healthcare Expert',
    'experience': '10+ Years Experience',
    'imagePath': 'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip'
  },
];

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:doctor_demo/res/components/expert_doctor_card/expert_doctor_card.dart';
// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class OurExpertTeamSectionView extends StatefulWidget {
//   const OurExpertTeamSectionView({super.key});
//
//   @override
//   State<OurExpertTeamSectionView> createState() =>
//       _OurExpertTeamSectionViewState();
// }
//
// class _OurExpertTeamSectionViewState extends State<OurExpertTeamSectionView>
//     with TickerProviderStateMixin {
//
//   int activeIndex = 0;
//
//   late AnimationController _controller;
//   late Animation<double> textRevealAnimation;
//   late Animation<double> headingTextRevelAnimation;
//   late Animation<double> textOpacityAnimation;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2300),
//     );
//
//     textRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//             parent: _controller,
//             curve: const Interval(0.0, 0.9, curve: Curves.easeIn)));
//
//     headingTextRevelAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
//         CurvedAnimation(
//             parent: _controller,
//             curve: const Interval(0.0, 0.2, curve: Curves.easeOut)));
//
//     textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//             parent: _controller,
//             curve: const Interval(0.0, 0.1, curve: Curves.easeOut)));
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//
//     return Container(
//       width: 1200,
//       // height: height * 0.6,
//       padding: const EdgeInsets.all(16.0),
//       child: BlocBuilder<DisplayOffset, ScrollOffset>(
//
//         buildWhen: (previous, current) {
//
//           if (Responsive.isTablet(context)) {
//             if ((current.scrollOffsetValue >= 2950 &&
//                 current.scrollOffsetValue <= 3080) ||
//                 _controller.isAnimating) {
//               return true;
//             } else {
//               return false;
//             }
//           } else if (Responsive.isMobile(context)) {
//             if ((current.scrollOffsetValue >= 3305 &&
//                 current.scrollOffsetValue <= 3410) ||
//                 _controller.isAnimating) {
//               return true;
//             } else {
//               return false;
//             }
//           } else {
//             if ((current.scrollOffsetValue >= 2290 &&
//                 current.scrollOffsetValue <= 2390) ||
//                 _controller.isAnimating) {
//               return true;
//             } else {
//               return false;
//             }
//           }
//         },
//
//         builder: (context, state) {
//
//           if(Responsive.isTablet(context)){
//             if (state.scrollOffsetValue > 3067) {
//               _controller.forward();
//             }
//           }else if(Responsive.isMobile(context)) {
//             if (state.scrollOffsetValue > 3325) {
//               _controller.forward();
//             }
//           }
//           else{
//             if (state.scrollOffsetValue > 2311) {
//               _controller.forward();
//             }
//           }
//
//           return AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: Responsive.isMobile(context) ? 60 : 90,
//                       padding:
//                       EdgeInsets.only(top: headingTextRevelAnimation.value),
//                       child: FadeTransition(
//                         opacity: textOpacityAnimation,
//                         child: MyText(
//                           title: "Our Expert Doctors",
//                           fontSize: Responsive.isMobile(context) ? 34 : 50,
//                           fontWeight: FontWeight.bold,
//                           color: MyColors.blackColor,
//                           fontFamily: 'Oswald',
//                         ),
//                       ),
//                     ),
//                     // const SizedBox(height: 4),
//                     FadeTransition(
//                       opacity: textOpacityAnimation,
//                       child: Text(
//                         "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//
//                     Container(
//                       width: Responsive.isMobile(context) ? width * 0.98 : Responsive.isTablet(context) ? width * 0.6 : width * 0.42,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: CarouselSlider.builder(
//                           itemCount: teamMembers.length,
//                           itemBuilder: (context, index, relIndex) {
//                             // print(imagesUrl.length);
//                             return ExpertDoctorCard(
//                                 name: teamMembers[index]['name']!,
//                                 title: teamMembers[index]['title']!,
//                                 imagePath: teamMembers[index]['imagePath']!);
//                           },
//                           options: CarouselOptions(
//                               height: Responsive.isMobile(context) ? height * 0.42 : Responsive.isTablet(context) ? height * 0.32 : height * 0.5,
//                               autoPlay: true,
//                               autoPlayInterval: const Duration(seconds: 4),
//                               viewportFraction: 0.8,
//                               enlargeCenterPage: true,
//                               enlargeStrategy: CenterPageEnlargeStrategy.height,
//                               onPageChanged: (changeIndex, reason) {
//                                 setState(() {
//                                   activeIndex = changeIndex;
//                                 });
//                               })),
//                     ),
//
//                   ],
//                 );
//               }
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// final List<Map<String, String>> teamMembers = [
//   {
//     'name': 'Natali Jones',
//     'title': 'Oral Surgeon',
//     'imagePath':
//     'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
//   },
//   {
//     'name': 'David Green',
//     'title': 'Oral Surgeon',
//     'imagePath':
//     'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
//   },
//   {
//     'name': 'Amy Walker',
//     'title': 'Oral Surgeon',
//     'imagePath':
//     'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip'
//   },
// ];