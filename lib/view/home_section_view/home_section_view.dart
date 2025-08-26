import 'package:doctor_demo/l10n/app_localizations.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HomeSectionView extends StatefulWidget {
  final VoidCallback? onBookAppointment;
  HomeSectionView({super.key,required this.onBookAppointment,});

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
                          title: AppLocalizations.of(context)!.welcomeToOurClinic,
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
                  title: AppLocalizations.of(context)!.homeTitle,
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
                    title: AppLocalizations.of(context)!.homeSubtitle,
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
                        _buildStatItem(AppLocalizations.of(context)!.fiveHondradPlus, AppLocalizations.of(context)!.happyPatients, isMobile),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(AppLocalizations.of(context)!.fifteenPlus, AppLocalizations.of(context)!.yearsExperience, isMobile),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStatItem(AppLocalizations.of(context)!.twentyFourHours, AppLocalizations.of(context)!.emergencyCare, isMobile),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      _buildStatItem(AppLocalizations.of(context)!.fiveHondradPlus, AppLocalizations.of(context)!.happyPatients, false),
                      const SizedBox(width: 40),
                      _buildStatItem(AppLocalizations.of(context)!.fifteenPlus, AppLocalizations.of(context)!.yearsExperience, false),
                      const SizedBox(width: 40),
                      _buildStatItem(AppLocalizations.of(context)!.twentyFourHours, AppLocalizations.of(context)!.emergencyCare, false),
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
      onPressed: widget.onBookAppointment,
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
            title: AppLocalizations.of(context)!.bookAppointment,
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
            title: AppLocalizations.of(context)!.learnMore,
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
