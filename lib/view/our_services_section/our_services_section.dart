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
  late AnimationController _backgroundController;
  late AnimationController _cardController;

  late Animation<double> _headingTextRevealAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _containerScaleAnimation;

  List<AnimationController> _cardControllers = [];
  List<Animation<double>> _cardAnimations = [];
  List<Animation<Offset>> _cardSlideAnimations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Initialize individual card controllers
    for (int i = 0; i < servicesData.length; i++) {
      final cardController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500 + (i * 200)),
      );
      _cardControllers.add(cardController);

      _cardAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: cardController,
            curve: Curves.elasticOut,
          ),
        ),
      );

      _cardSlideAnimations.add(
        Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: cardController,
            curve: Curves.easeOutBack,
          ),
        ),
      );
    }

    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    ));

    _headingTextRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.7, curve: Curves.easeOut),
      ),
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOut,
      ),
    );

    _containerScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Start background animation
    _backgroundController.repeat(reverse: true);
  }

  List<Map<String, dynamic>> servicesData = [
    {
      "title": "Root Canal (painless)",
      "description": "Advanced painless root canal treatment using modern techniques and sedation options.",
      "icon": Icons.healing,
      "color": Colors.blue,
    },
    {
      "title": "Dental Implants",
      "description": "Permanent tooth replacement solutions with titanium implants for natural-looking results.",
      "icon": Icons.construction,
      "color": Colors.green,
    },
    {
      "title": "Paediatric Dentistry",
      "description": "Specialized dental care for children in a fun, comfortable, and child-friendly environment.",
      "icon": Icons.child_care,
      "color": Colors.orange,
    },
    {
      "title": "Orthodontic Treatment",
      "description": "Comprehensive orthodontic solutions including braces and clear aligners for perfect smiles.",
      "icon": Icons.straighten,
      "color": Colors.purple,
    },
    {
      "title": "Restorative Dentistry",
      "description": "Complete restoration services including fillings, crowns, and bridges using premium materials.",
      "icon": Icons.build_circle,
      "color": Colors.teal,
    },
    {
      "title": "Cosmetic Dentistry",
      "description": "Transform your smile with veneers, whitening, and cosmetic procedures for enhanced beauty.",
      "icon": Icons.auto_awesome,
      "color": Colors.pink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if (isMobile) {
          if ((current.scrollOffsetValue >= 1900 &&
              current.scrollOffsetValue <= 2000) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        } else if (Responsive.isTablet(context)) {
          if ((current.scrollOffsetValue >= 2006 &&
              current.scrollOffsetValue <= 2100) ||
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
        if (isMobile) {
          if (state.scrollOffsetValue > 1952) {
            _startAnimations();
          }
        } else {
          if (state.scrollOffsetValue > 1530) {
            _startAnimations();
          }
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_controller, _backgroundController]),
          builder: (context, child) {
            return Container(
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    MyColors.primaryColor,
                    MyColors.primaryColor.withOpacity(0.9 + 0.1 * _backgroundAnimation.value),
                    MyColors.primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main content
                    ScaleTransition(
                      scale: _containerScaleAnimation,
                      child: Container(
                        width: width,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 60,
                          vertical: isMobile ? 32 : 50,
                        ),
                        child: Column(
                          children: [
                            // Enhanced Header Section
                            SlideTransition(
                              position: _titleSlideAnimation,
                              child: FadeTransition(
                                opacity: _headingTextRevealAnimation,
                                child: Column(
                                  children: [
                                    // Service Badge
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 18 : 24,
                                        vertical: isMobile ? 8 : 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(25),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.medical_services,
                                            color: Colors.white,
                                            size: isMobile ? 16 : 18,
                                          ),
                                          const SizedBox(width: 8),
                                          MyText(
                                            title: "Our Professional Services",
                                            fontSize: isMobile ? 12 : 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: isMobile ? 20 : 24),

                                    // Main Title
                                    MyText(
                                      title: "Our Services",
                                      fontSize: isMobile ? 36 : 52,
                                      fontWeight: FontWeight.w800,
                                      color: MyColors.whiteColor,
                                      fontFamily: 'Oswald',
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: isMobile ? 10 : 12),

                                    // Subtitle
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: isMobile ? width - 32 : 600,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 16 : 0,
                                      ),
                                      child: MyText(
                                        title: "Comprehensive dental care with state-of-the-art technology and personalized treatment plans",
                                        fontSize: isMobile ? 16 : 18,
                                        color: Colors.white.withOpacity(0.9),
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: isMobile ? height * 0.04 : height * 0.06),

                            // Services Grid
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: isMobile ? width - 32 : 1200,
                              ),
                              child: GridView.builder(
                                itemCount: servicesData.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isMobile
                                      ? 1
                                      : Responsive.isTablet(context)
                                      ? 2
                                      : 3,
                                  crossAxisSpacing: isMobile ? 16 : 20,
                                  mainAxisSpacing: isMobile ? 16 : 20,
                                  childAspectRatio: isMobile
                                      ? 1.1
                                      : Responsive.isTablet(context)
                                      ? 1.1
                                      : 1.0,
                                ),
                                itemBuilder: (context, index) {
                                  return _buildEnhancedServiceCard(index);
                                },
                              ),
                            ),

                            SizedBox(height: isMobile ? height * 0.04 : height * 0.06),

                            // Call to Action Section
                            _buildCallToActionSection(),

                            SizedBox(height: isMobile ? 24 : 40),
                          ],
                        ),
                      ),
                    ),

                    // Floating background elements (positioned last to avoid layout issues)
                    _buildFloatingElements(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFloatingElements() {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: IgnorePointer(
            child: OverflowBox(
              child: Stack(
                children: [
                  // Top right floating circle
                  Positioned(
                    top: (isMobile ? 80 : 100) + ((isMobile ? 20 : 30) * _backgroundAnimation.value),
                    right: isMobile ? 30 : 50,
                    child: Opacity(
                      opacity: isMobile ? 0.08 : 0.1,
                      child: Container(
                        width: isMobile ? 80 : 120,
                        height: isMobile ? 80 : 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  // Bottom left floating element
                  Positioned(
                    bottom: (isMobile ? 100 : 150) + ((isMobile ? 15 : 20) * _backgroundAnimation.value),
                    left: isMobile ? 20 : 30,
                    child: Opacity(
                      opacity: 0.08,
                      child: Container(
                        width: isMobile ? 60 : 80,
                        height: isMobile ? 60 : 80,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  // Medical icons - only show on tablet and desktop
                  if (!isMobile) ...[
                    Positioned(
                      top: 200 + (15 * _backgroundAnimation.value),
                      left: 100,
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(
                          Icons.local_hospital,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100 + (25 * _backgroundAnimation.value),
                      right: 150,
                      child: Opacity(
                        opacity: 0.08,
                        child: Icon(
                          Icons.medical_services,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedServiceCard(int index) {
    final service = servicesData[index];

    return MyServicesCard(
      title: service["title"] as String,
      description: service["description"] as String,
      icon: service["icon"] as IconData,
      color: service["color"] as Color,
      index: index,
      cardAnimation: index < _cardAnimations.length
          ? _cardAnimations[index]
          : _headingTextRevealAnimation,
      slideAnimation: index < _cardSlideAnimations.length
          ? _cardSlideAnimations[index]
          : _titleSlideAnimation,
    );
  }

  Widget _buildCallToActionSection() {
    final isMobile = Responsive.isMobile(context);

    return FadeTransition(
      opacity: _textOpacityAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 24 : 40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            MyText(
              title: "Ready to Transform Your Smile?",
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: isMobile ? 10 : 12),

            Container(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 500,
              ),
              child: MyText(
                title: "Schedule your consultation today and take the first step towards optimal dental health",
                fontSize: isMobile ? 14 : 16,
                color: Colors.white.withOpacity(0.9),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: isMobile ? 20 : 24),

            isMobile ? Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle appointment booking
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: MyColors.primaryColor,
                      elevation: 8,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: MyColors.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        MyText(
                          title: "Book Appointment",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MyColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle contact
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        MyText(
                          title: "Contact Us",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle appointment booking
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: MyColors.primaryColor,
                    elevation: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18,
                        color: MyColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      MyText(
                        title: "Book Appointment",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: MyColors.primaryColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                OutlinedButton(
                  onPressed: () {
                    // Handle contact
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.phone,
                        size: 18,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      MyText(
                        title: "Contact Us",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startAnimations() {
    _controller.forward();

    // Start card animations with delays
    for (int i = 0; i < _cardControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 500 + (i * 150)), () {
        if (mounted) {
          _cardControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _backgroundController.dispose();
    _cardController.dispose();

    for (final controller in _cardControllers) {
      controller.dispose();
    }

    super.dispose();
  }
}


// import 'package:doctor_demo/res/components/my_sevices_card/my_sevices_card.dart';
// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class OurServicesSection extends StatefulWidget {
//   const OurServicesSection({super.key});
//
//   @override
//   State<OurServicesSection> createState() => _OurServicesSectionState();
// }
//
// class _OurServicesSectionState extends State<OurServicesSection>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;
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
//   List<String> servicesData = [
//     "Root Canal (painless)",
//     "Dental Implants",
//     "Paediatric Dentistry",
//     "Orthodontic Treatment",
//     "Restorative Dentistry",
//     "Cosmetic Dentistry"
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return BlocBuilder<DisplayOffset, ScrollOffset>(
//       buildWhen: (previous, current) {
//         if (Responsive.isMobile(context)) {
//           if ((current.scrollOffsetValue >= 1900 &&
//                   current.scrollOffsetValue <= 2000) ||
//               _controller.isAnimating) {
//             return true;
//           } else {
//             return false;
//           }
//         }else if(Responsive.isTablet(context)) {
//           if ((current.scrollOffsetValue >= 2006 &&
//               current.scrollOffsetValue <= 2100) ||
//               _controller.isAnimating) {
//             return true;
//           } else {
//             return false;
//           }
//         }
//         else {
//           if ((current.scrollOffsetValue >= 1510 &&
//                   current.scrollOffsetValue <= 1600) ||
//               _controller.isAnimating) {
//             return true;
//           } else {
//             return false;
//           }
//         }
//       },
//       builder: (context, state) {
//         if (Responsive.isMobile(context)) {
//           if (state.scrollOffsetValue > 1952) {
//             _controller.forward();
//           }
//         } else {
//           if (state.scrollOffsetValue > 1530) {
//             _controller.forward();
//           }
//         }
//
//         return Container(
//           color: MyColors.primaryColor,
//           width: width,
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 1240,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: height * 0.03,
//                     ),
//
//                     Container(
//                       // color: Colors.white,
//                       height: Responsive.isMobile(context)
//                           ? height * 0.14
//                           : height * 0.1,
//                       padding:
//                           EdgeInsets.only(top: headingTextRevelAnimation.value),
//                       child: FadeTransition(
//                         opacity: textOpacityAnimation,
//                         child: const MyText(
//                           title: "Our Services",
//                           fontSize: 50,
//                           fontWeight: FontWeight.bold,
//                           color: MyColors.whiteColor,
//                           fontFamily: 'Oswald',
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: Responsive.isMobile(context) ? height * 0.01 : height * 0.04),
//                     // Using Flexible instead of Expanded
//                     Flexible(
//                       fit: FlexFit
//                           .loose, // Allows the child to take up its necessary space
//                       child: GridView.builder(
//                         itemCount: servicesData.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: Responsive.isMobile(context)
//                                 ? 1
//                                 : Responsive.isTablet(context)
//                                     ? 2
//                                     : 3,
//                             crossAxisSpacing:
//                                 Responsive.isTablet(context) ? 0 : 10,
//                             mainAxisSpacing:
//                                 Responsive.isTablet(context) ? 16 : 10,
//                             childAspectRatio: Responsive.isMobile(context)
//                                 ? 2 / 1.1
//                                 : Responsive.isTablet(context)
//                                     ? 2 / 1
//                                     : 2 / 1.4),
//                         itemBuilder: (context, index) {
//                           return MyServicesCard(image: 'image', title: servicesData[index].toString(), description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",index: index,);
//                         },
//                       ),
//                     ),
//
//                     SizedBox(
//                       height: height * 0.06,
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
