import 'package:doctor_demo/l10n/app_localizations.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutSectionView extends StatefulWidget {
  const AboutSectionView({super.key});

  @override
  State<AboutSectionView> createState() => _AboutSectionViewState();
}

class _AboutSectionViewState extends State<AboutSectionView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _continuousController;

  late Animation<Offset> _slideAnimationForDescription;
  late Animation<Offset> _slideAnimationForImage;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<double> _textRevealAnimation;
  late Animation<double> _headingTextRevealAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _imageOpacity;
  late Animation<double> _containerScaleAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _cardElevationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    _continuousController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Title slide from top
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
    ));

    // Description slide from left
    _slideAnimationForDescription = Tween<Offset>(
      begin: const Offset(-0.6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutBack),
    ));

    // Image slide from right
    _slideAnimationForImage = Tween<Offset>(
      begin: const Offset(0.6, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 0.8, curve: Curves.easeOutBack),
    ));

    _imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    ));

    _textRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _headingTextRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.6, curve: Curves.easeOut),
      ),
    );

    _containerScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _floatingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _continuousController,
        curve: Curves.easeInOut,
      ),
    );

    _cardElevationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start continuous floating animation
    _continuousController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isMobile = Responsive.isMobile(context);

    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        if (Responsive.isTablet(context)) {
          if ((current.scrollOffsetValue >= 1370 &&
              current.scrollOffsetValue <= 1470) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        } else if (isMobile) {
          if ((current.scrollOffsetValue >= 830 &&
              current.scrollOffsetValue <= 940) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        } else {
          if ((current.scrollOffsetValue >= 900 &&
              current.scrollOffsetValue <= 1040) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        }
      },
      builder: (context, state) {
        if (Responsive.isTablet(context)) {
          if (state.scrollOffsetValue > 1380) {
            _controller.forward();
          }
        } else if (isMobile) {
          if (state.scrollOffsetValue > 860) {
            _controller.forward();
          }
        } else {
          if (state.scrollOffsetValue > 1000) {
            _controller.forward();
          }
        }

        return AnimatedBuilder(
          animation: Listenable.merge([_controller, _continuousController]),
          builder: (context, child) {
            return Container(
              width: width,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 60,
                vertical: isMobile ? 24 : 40,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade50,
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(
                child: ScaleTransition(
                  scale: _containerScaleAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? width - 32 : 1200,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: isMobile ? height * 0.03 : height * 0.06),

                        // Enhanced Title Section
                        SlideTransition(
                          position: _titleSlideAnimation,
                          child: FadeTransition(
                            opacity: _headingTextRevealAnimation,
                            child: Column(
                              children: [
                                // Badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16 : 20,
                                    vertical: isMobile ? 6 : 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: MyColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: MyColors.primaryColor.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        size: isMobile ? 14 : 16,
                                        color: MyColors.primaryColor,
                                      ),
                                      const SizedBox(width: 6),
                                      MyText(
                                        title: AppLocalizations.of(context)!.learnMoreAboutUs,
                                        fontSize: isMobile ? 12 : 14,
                                        color: MyColors.primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isMobile ? 16 : 20),

                                // Main Title
                                MyText(
                                  title: AppLocalizations.of(context)!.aboutOurClinic,
                                  fontSize: isMobile ? 32 : 48,
                                  fontWeight: FontWeight.w800,
                                  color: MyColors.primaryColor,
                                  fontFamily: 'Oswald',
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: isMobile ? 6 : 8),

                                // Subtitle
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
                                  child: MyText(
                                    title: AppLocalizations.of(context)!.aboutSubtitle,
                                    fontSize: isMobile ? 16 : 18,
                                    color: Colors.grey.shade600,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isMobile ? height * 0.04 : height * 0.06),

                        // Content Section
                        isMobile
                            ? Column(
                          children: [
                            SlideTransition(
                              position: _slideAnimationForImage,
                              child: _buildImageSection(height),
                            ),
                            const SizedBox(height: 24),
                            SlideTransition(
                              position: _slideAnimationForDescription,
                              child: _buildTextSection(context),
                            ),
                          ],
                        )
                            : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SlideTransition(
                                position: _slideAnimationForDescription,
                                child: _buildTextSection(context),
                              ),
                            ),
                            const SizedBox(width: 60),
                            Expanded(
                              flex: 1,
                              child: SlideTransition(
                                position: _slideAnimationForImage,
                                child: _buildImageSection(height),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: isMobile ? height * 0.04 : height * 0.06),

                        // Stats Section
                        _buildStatsSection(),

                        SizedBox(height: isMobile ? 24 : 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return FadeTransition(
      opacity: _textRevealAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Why Choose Us Section
          Container(
            padding: EdgeInsets.all(isMobile ? 20 : 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: isMobile ? 15 : 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isMobile ? 8 : 10),
                      decoration: BoxDecoration(
                        color: MyColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.medical_services,
                        color: MyColors.primaryColor,
                        size: isMobile ? 20 : 24,
                      ),
                    ),
                    SizedBox(width: isMobile ? 8 : 12),
                    Expanded(
                      child: MyText(
                        title: AppLocalizations.of(context)!.whyChooseUs,
                        fontSize: isMobile ? 20 : 24,
                        fontWeight: FontWeight.w700,
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 16 : 20),

                MyText(
                  title: AppLocalizations.of(context)!.aboutParagraph,
                  fontSize: isMobile ? 14 : 17,
                  color: Colors.grey.shade700,
                ),

                SizedBox(height: isMobile ? 16 : 20),

                // Feature List
                ..._buildFeatureList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureList() {
    final isMobile = Responsive.isMobile(context);
    final features = [
      {"icon": Icons.verified, "text": AppLocalizations.of(context)!.experience},
      {"icon": Icons.precision_manufacturing, "text": AppLocalizations.of(context)!.latestDental},
      {"icon": Icons.schedule, "text": AppLocalizations.of(context)!.flexible},
      {"icon": Icons.family_restroom, "text": AppLocalizations.of(context)!.familyFriendly},
    ];

    return features.map((feature) {
      return Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 10 : 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 5 : 6),
              decoration: BoxDecoration(
                color: MyColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                feature["icon"] as IconData,
                color: MyColors.primaryColor,
                size: isMobile ? 14 : 16,
              ),
            ),
            SizedBox(width: isMobile ? 10 : 12),
            Expanded(
              child: MyText(
                title: feature["text"] as String,
                fontSize: isMobile ? 13 : 15,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildImageSection(double height) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (isMobile ? 5 : 10) * _floatingAnimation.value),
          child: FadeTransition(
            opacity: _imageOpacity,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isMobile ? 20 : 25),
                boxShadow: [
                  BoxShadow(
                    color: MyColors.primaryColor.withOpacity(0.2),
                    blurRadius: isMobile ? 20 : 30,
                    offset: Offset(0, isMobile ? 10 : 15),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 20 : 25),
                child: Stack(
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1598256989800-fe5f95da9787?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGRlbnRpc3QlMjBjbGluaWN8ZW58MHwwfDB8fHwy',
                      height: _getImageHeight(height),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: _getImageHeight(height),
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
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
                          height: _getImageHeight(height),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyColors.primaryColor.withOpacity(0.7),
                                MyColors.primaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.medical_services,
                                  size: isMobile ? 40 : 60,
                                  color: Colors.white,
                                ),
                                SizedBox(height: isMobile ? 12 : 16),
                                MyText(
                                  title: "Modern Dental Facility",
                                  color: Colors.white,
                                  fontSize: isMobile ? 16 : 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // Overlay with play button (for virtual tour)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              // Handle virtual tour tap
                            },
                            child: Container(
                              padding: EdgeInsets.all(isMobile ? 16 : 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                color: MyColors.primaryColor,
                                size: isMobile ? 32 : 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getImageHeight(double screenHeight) {
    if (Responsive.isMobile(context)) {
      return screenHeight * 0.28;
    } else if (Responsive.isTablet(context)) {
      return screenHeight * 0.45;
    } else {
      return screenHeight * 0.50;
    }
  }

  Widget _buildStatsSection() {
    final isMobile = Responsive.isMobile(context);
    final stats = [
      {"number": AppLocalizations.of(context)!.fifteenPlus, "label": AppLocalizations.of(context)!.happyPatients},
      {"number": AppLocalizations.of(context)!.fifteenPlus, "label": AppLocalizations.of(context)!.yearsExperience},
      {"number": AppLocalizations.of(context)!.twentyFourHours, "label": AppLocalizations.of(context)!.emergencyCare},
      {"number": AppLocalizations.of(context)!.satisfaction, "label": AppLocalizations.of(context)!.satisfactionRate},
    ];

    return FadeTransition(
      opacity: _cardElevationAnimation,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 20 : 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor,
              MyColors.primaryColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
          boxShadow: [
            BoxShadow(
              color: MyColors.primaryColor.withOpacity(0.3),
              blurRadius: isMobile ? 15 : 20,
              offset: Offset(0, isMobile ? 8 : 10),
            ),
          ],
        ),
        child: isMobile
            ? GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            final stat = stats[index];
            return _buildStatItem(stat["number"]!, stat["label"]!);
          },
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.map((stat) =>
              _buildStatItem(stat["number"]!, stat["label"]!)
          ).toList(),
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(
          title: number,
          fontSize: isMobile ? 24 : 32,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontFamily: 'Oswald',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 2 : 4),
        MyText(
          title: label,
          fontSize: isMobile ? 12 : 14,
          color: Colors.white.withOpacity(0.9),
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _continuousController.dispose();
    super.dispose();
  }
}
