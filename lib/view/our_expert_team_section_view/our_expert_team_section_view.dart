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

  // Add a flag to track if animation has been triggered
  bool _hasAnimationStarted = false;

  // Add a GlobalKey to measure widget position
  final GlobalKey _sectionKey = GlobalKey();

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

    // Carousel animation controller - faster timing
    _carouselController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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

    // Carousel animations - start earlier for smoother effect
    _carouselScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _carouselController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
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

  // Check if section is visible using RenderBox
  bool _isSectionVisible() {
    if (_sectionKey.currentContext == null) return false;

    final RenderBox? renderBox = _sectionKey.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return false;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if at least 30% of the section is visible
    final visibleTop = position.dy < screenHeight;
    final visibleBottom = (position.dy + size.height) > screenHeight * 0.3;

    return visibleTop && visibleBottom;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      key: _sectionKey, // Add the key here
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 1400),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<DisplayOffset, ScrollOffset>(
        buildWhen: (previous, current) {
          // Always rebuild when scroll changes or animation is running
          return true;
        },
        builder: (context, state) {
          // Use visibility check instead of hardcoded scroll values
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_hasAnimationStarted && _isSectionVisible()) {
              _hasAnimationStarted = true;
              _controller.forward();
              // Start carousel animation immediately with the main animation
              _carouselController.forward();
            }
          });

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