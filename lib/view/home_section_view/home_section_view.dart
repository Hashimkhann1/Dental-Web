import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HomeSectionView extends StatefulWidget {
  const HomeSectionView({super.key});

  @override
  State<HomeSectionView> createState() => _HomeSectionViewState();
}

class _HomeSectionViewState extends State<HomeSectionView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _backgroundController;

  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _imageOpacity;
  late Animation<double> _textRevealAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    // Main animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // Background animation controller
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    // Text slide animation with bounce effect
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    // Image slide animation
    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(0.6, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
    ));

    // Image opacity animation
    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.9, curve: Curves.easeOut),
    ));

    // Text reveal animation
    _textRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.7, curve: Curves.easeOut),
      ),
    );

    // Button scale animation
    _buttonScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Background gradient animation
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _backgroundController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _controller.forward();
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _backgroundController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Container(
          width: width,
          // Fixed height calculation for mobile
          height: isMobile ? null : height * 0.85,
          constraints: BoxConstraints(
            minHeight: isMobile ? height * 0.92 : height * 0.9,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.primaryColor,
                MyColors.primaryColor.withOpacity(0.8 + 0.2 * _backgroundAnimation.value),
                MyColors.primaryColor.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 60,
                vertical: isMobile ? 20 : 40,
              ),
              child: isMobile
                  ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    ..._buildChildren(context, width, height),
                    SizedBox(height: height * 0.04),
                  ],
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildChildren(context, width, height),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context, double width, double height) {
    final isMobile = Responsive.isMobile(context);

    return [
      // Text content section
      SlideTransition(
        position: _textSlideAnimation,
        child: FadeTransition(
          opacity: _textRevealAnimation,
          child: Container(
            width: isMobile ? width - 32 : 480,
            constraints: BoxConstraints(
              maxWidth: isMobile ? width - 32 : 480,
            ),
            child: Column(
              crossAxisAlignment: isMobile
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Welcome badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: isMobile ? 14 : 16,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: MyText(
                          title: "Welcome to Our Clinic",
                          fontSize: isMobile ? 12 : 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 16 : 20),

                // Main heading - improved mobile sizing
                MyText(
                  title: 'Your Smile is\nOur Priority',
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Oswald',
                  color: MyColors.whiteColor,
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  height: 0,
                ),
                SizedBox(height: isMobile ? 16 : 20),

                // Subtitle - better mobile text handling
                Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
                  child: MyText(
                    title: "Professional dental care with a gentle touch. We provide comprehensive dental services for the whole family in a comfortable, modern environment.",
                    fontSize: isMobile ? 14 : 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 30),

                // Action buttons - improved mobile layout
                ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child:  Row(
                    mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      _buildPrimaryButton(context),
                      isMobile ? SizedBox(width: 8,) : SizedBox(width: 16),
                      _buildSecondaryButton(context),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 24 : 30),

                // Stats row - mobile version
                if (isMobile)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem("500+", "Patients", isMobile),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem("15+", "Years", isMobile),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem("24/7", "Emergency", isMobile),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      _buildStatItem("500+", "Happy Patients", false),
                      const SizedBox(width: 40),
                      _buildStatItem("15+", "Years Experience", false),
                      const SizedBox(width: 40),
                      _buildStatItem("24/7", "Emergency Care", false),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),

      SizedBox(width: isMobile ? 0 : 60),
      SizedBox(height: isMobile ? 32 : 0),

      // Image section - improved mobile sizing
      SlideTransition(
        position: _imageSlideAnimation,
        child: FadeTransition(
          opacity: _imageOpacity,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isMobile ? width - 32 : 500,
              maxHeight: isMobile ? height * 0.35 : 450,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: isMobile ? 15 : 20,
                  offset: Offset(0, isMobile ? 8 : 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
              child: Stack(
                children: [
                  Image.network(
                    'https://i.imgur.com/NIwGSeL_d.jpg?maxwidth=520&shape=thumb&fidelity=high',
                    width: isMobile ? width - 32 : 500,
                    height: isMobile ? height * 0.35 : 450,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: isMobile ? width - 32 : 500,
                        height: isMobile ? height * 0.35 : 450,
                        color: Colors.white.withOpacity(0.1),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: isMobile ? width - 32 : 500,
                        height: isMobile ? height * 0.35 : 450,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.medical_services,
                                size: isMobile ? 60 : 80,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              SizedBox(height: isMobile ? 12 : 16),
                              MyText(
                                title: "Professional Dental Care",
                                color: Colors.white.withOpacity(0.8),
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Overlay gradient
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return ElevatedButton(
      onPressed: () {
        // Add booking logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: MyColors.primaryColor,
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.3),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 28,
          vertical: isMobile ? 14 : 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: isMobile
            ? MainAxisSize.max
            : MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: isMobile ? 16 : 18,
            color: MyColors.primaryColor,
          ),
          const SizedBox(width: 8),
          MyText(
            title: "Book Appointment",
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: MyColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return OutlinedButton(
      onPressed: () {
        // Add learn more logic here
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white, width: 2),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 28,
          vertical: isMobile ? 14 : 18,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: isMobile
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: isMobile
            ? MainAxisSize.max
            : MainAxisSize.min,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: isMobile ? 16 : 18,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          MyText(
            title: "Learn More",
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        MyText(
          title: number,
          fontSize: isMobile ? 20 : 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        MyText(
          title: label,
          fontSize: isMobile ? 11 : 14,
          color: Colors.white.withOpacity(0.8),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }
}

// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/components/my_text_button.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:flutter/material.dart';
//
// class HomeSectionView extends StatefulWidget {
//   const HomeSectionView({super.key});
//
//   @override
//   State<HomeSectionView> createState() => _HomeSectionViewState();
// }
//
// class _HomeSectionViewState extends State<HomeSectionView> with TickerProviderStateMixin {
//
//   late AnimationController _controller;
//   late Animation<Offset> _textSlideAnimation;
//   late Animation<Offset> _imageSlideAnimation;
//   late Animation<double> imageOpacity;
//   late Animation<double> textRevealAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2300),
//     );
//
//     _textSlideAnimation = Tween<Offset>(
//       begin: Offset(-0.4, 0.0),  // Start from outside left
//       end: Offset(0.0, 0.0),  // End at normal position
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//
//     _imageSlideAnimation = Tween<Offset>(
//       begin: Offset(0.5, 0.0),  // Start from outside right
//       end: Offset(0.0, 0.0),  // End at normal position
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));
//
//     imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//         parent: _controller, curve: const Interval(0.0, 0.9, curve: Curves.easeOut)));
//
//     textRevealAnimation  = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.9 , curve: Curves.easeOut)));
//
//
//     Future.delayed(const Duration(milliseconds: 1000),() {
//       _controller.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Container(
//       width: width,
//       height: Responsive.isMobile(context) ? null : height * 0.75,
//       color: MyColors.primaryColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Responsive.isMobile(context)
//               ? Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: _buildChildren(context, width, height),
//           )
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: _buildChildren(context, width, height),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<Widget> _buildChildren(BuildContext context, double width, double height) {
//     return [
//       /// Sliding "Welcome" text from the left
//       SlideTransition(
//         position: _textSlideAnimation,
//         child: FadeTransition(
//           opacity: textRevealAnimation,
//           child: Container(
//             width: 410,
//             child: Column(
//               crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.04 : 0),
//                   child: MyText(
//                     title: 'Welcome to Clinic Name',
//                     fontSize: Responsive.isMobile(context) ? 46 : 70,
//                     fontWeight: FontWeight.w800,
//                     fontFamily: 'Oswald',
//                     color: MyColors.whiteColor,
//                     textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.1 : 0),
//                   child: MyText(
//                     title: "A Smile for Every Family Member",
//                     fontSize: 23,
//                     fontWeight: FontWeight.bold,
//                     color: MyColors.whiteColor,
//                     textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 MyTextButton(
//                   title: "Book Appointment",
//                   fontSize: 18,
//                   backgroundColor: MyColors.whiteColor,
//                   textColor: MyColors.primaryColor,
//                   width: 200,
//                   height: Responsive.isMobile(context) ?  height * 0.07 : height * 0.06,
//                   borderRadius: 30,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//       const SizedBox(height: 30),
//
//       /// Sliding Image from the right
//       FadeTransition(
//         opacity: imageOpacity,
//         child: SlideTransition(
//           position: _imageSlideAnimation,
//           child: Image.network(
//             'https://i.imgur.com/NIwGSeL_d.jpg?maxwidth=520&shape=thumb&fidelity=high',
//             width: Responsive.isMobile(context) ? width * 0.86 : Responsive.isTablet(context) ? width * 0.44 : 560,
//             height: Responsive.isMobile(context) ? height * 0.48 : Responsive.isTablet(context) ? height * 0.3 : 510,
//             fit: BoxFit.fitWidth,
//           ),
//         ),
//       ),
//     ];
//   }
// }
