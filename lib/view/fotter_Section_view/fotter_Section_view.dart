import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSectionView extends StatefulWidget {
  const FooterSectionView({super.key});

  @override
  State<FooterSectionView> createState() => _FooterSectionViewState();
}

class _FooterSectionViewState extends State<FooterSectionView>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _socialController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _slideUpAnimation;
  late Animation<double> _logoSlideAnimation;
  late Animation<double> _socialSlideAnimation;
  late Animation<double> _quickLinksSlideAnimation;
  late Animation<double> _hoursSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Main fade controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Slide animations controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Social media animations controller
    _socialController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Main fade animation
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    // Slide up animation
    _slideUpAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    // Staggered animations for different sections
    _logoSlideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
      ),
    );

    _socialSlideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _socialController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _quickLinksSlideAnimation = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _hoursSlideAnimation = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOutBack),
      ),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _socialController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _socialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_fadeController, _slideController, _socialController]),
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade900,
                Colors.black,
                Colors.grey.shade900.withOpacity(0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideUpAnimation.value),
              child: Column(
                children: [
                  _buildMainFooterContent(context),
                  _buildBottomBar(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainFooterContent(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: isMobile ? 40 : 60,
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildBrandSection(),
        const SizedBox(height: 40),
        _buildQuickLinksSection(),
        const SizedBox(height: 40),
        _buildClinicHoursSection(),
        const SizedBox(height: 30),
        _buildNewsletterSection(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildBrandSection()),
        const SizedBox(width: 60),
        Expanded(flex: 1, child: _buildQuickLinksSection()),
        const SizedBox(width: 60),
        Expanded(flex: 1, child: _buildClinicHoursSection()),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _buildNewsletterSection()),
      ],
    );
  }

  Widget _buildBrandSection() {
    return Transform.translate(
      offset: Offset(0, _logoSlideAnimation.value),
      child: Column(
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // Logo and clinic name
          Row(
            mainAxisAlignment: Responsive.isMobile(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.purple.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.local_hospital,
                      color: Colors.white,
                      size: 40,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyText(
                    title: "HealthCare Plus",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  Text(
                    "Your Health, Our Priority",
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Description
          Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Text(
              "Providing exceptional healthcare services with compassion, expertise, and cutting-edge medical technology. Your wellness is our commitment.",
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 16,
                height: 1.6,
                letterSpacing: 0.3,
              ),
              textAlign: Responsive.isMobile(context)
                  ? TextAlign.center
                  : TextAlign.left,
            ),
          ),

          const SizedBox(height: 30),

          // Social media icons
          _buildSocialMediaIcons(),

          const SizedBox(height: 24),

          // Contact info
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcons() {
    final socialIcons = [
      {'icon': FontAwesomeIcons.facebook, 'color': const Color(0xFF1877F2), 'label': 'Facebook'},
      {'icon': FontAwesomeIcons.instagram, 'color': const Color(0xFFE4405F), 'label': 'Instagram'},
      {'icon': FontAwesomeIcons.twitter, 'color': const Color(0xFF1DA1F2), 'label': 'Twitter'},
      {'icon': FontAwesomeIcons.linkedin, 'color': const Color(0xFF0A66C2), 'label': 'LinkedIn'},
    ];

    return FadeTransition(
      opacity: _socialSlideAnimation,
      child: Wrap(
        alignment: Responsive.isMobile(context)
            ? WrapAlignment.center
            : WrapAlignment.start,
        children: socialIcons.asMap().entries.map((entry) {
          final index = entry.key;
          final social = entry.value;

          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 800 + (index * 200)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  margin: const EdgeInsets.only(right: 12, bottom: 8),
                  child: _buildSocialButton(
                    social['icon'] as IconData,
                    social['color'] as Color,
                    social['label'] as String,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, String label) {
    return Tooltip(
      message: label,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Handle social media navigation
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening $label...'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: color,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              child: FaIcon(
                icon,
                color: color,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    final contactItems = [
      {'icon': Icons.phone_rounded, 'text': '+1 (555) 123-4567'},
      {'icon': Icons.email_rounded, 'text': 'contact@healthcareplus.com'},
      {'icon': Icons.location_on_rounded, 'text': '123 Healthcare St, Medical City'},
    ];

    return Column(
      children: contactItems.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: Responsive.isMobile(context)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: Colors.blue.shade400,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                item['text'] as String,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildQuickLinksSection() {
    final quickLinks = ['Home', 'About Us', 'Services', 'Doctors', 'Contact Us', 'Appointments'];

    return Transform.translate(
      offset: Offset(0, _quickLinksSlideAnimation.value),
      child: Column(
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: const MyText(
              title: "Quick Links",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ...quickLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 600 + (index * 100)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 20),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            // Handle navigation
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.blue.shade400,
                                  size: 12,
                                ),
                                const SizedBox(width: 8),
                                MyText(
                                  title: link,
                                  fontSize: 16,
                                  color: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildClinicHoursSection() {
    final scheduleItems = [
      {'days': 'Monday - Friday', 'hours': '9:00 AM - 7:00 PM', 'status': 'open'},
      {'days': 'Saturday', 'hours': '9:00 AM - 5:00 PM', 'status': 'open'},
      {'days': 'Sunday', 'hours': 'Closed', 'status': 'closed'},
      {'days': 'Emergency', 'hours': '24/7 Available', 'status': 'emergency'},
    ];

    return Transform.translate(
      offset: Offset(0, _hoursSlideAnimation.value),
      child: Column(
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: const MyText(
              title: "Clinic Hours",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          ...scheduleItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return TweenAnimationBuilder<double>(
              duration: Duration(milliseconds: 700 + (index * 150)),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 25),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _getStatusColor(item['status']!).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: item['days']!,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item['hours']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _getStatusColor(item['status']!),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _getStatusColor(item['status']!),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return Column(
      crossAxisAlignment: Responsive.isMobile(context)
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        const MyText(
          title: "Stay Updated",
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 16),
        Text(
          "Subscribe to our newsletter for health tips and clinic updates.",
          style: TextStyle(
            color: Colors.grey.shade300,
            fontSize: 14,
            height: 1.5,
          ),
          textAlign: Responsive.isMobile(context)
              ? TextAlign.center
              : TextAlign.left,
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                child: Material(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      // Handle newsletter subscription
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 20 : 60,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ),
        ),
      ),
      child: Responsive.isMobile(context)
          ? Column(
        children: [
          Text(
            "© 2024 HealthCare Plus. All rights reserved.",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink("Privacy Policy"),
              Text(" • ", style: TextStyle(color: Colors.grey.shade600)),
              _buildFooterLink("Terms of Service"),
            ],
          ),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "© 2024 HealthCare Plus. All rights reserved.",
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              _buildFooterLink("Privacy Policy"),
              Text(" • ", style: TextStyle(color: Colors.grey.shade600)),
              _buildFooterLink("Terms of Service"),
              Text(" • ", style: TextStyle(color: Colors.grey.shade600)),
              _buildFooterLink("Cookie Policy"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          // Handle footer link navigation
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return Colors.green.shade400;
      case 'closed':
        return Colors.red.shade400;
      case 'emergency':
        return Colors.orange.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}



// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class FotterSectionView extends StatelessWidget {
//   const FotterSectionView({super.key});
//
//   Widget _buildContactSection(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//
//           mainAxisAlignment: Responsive.isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
//
//           children: [
//             Image.asset('assets/images/logo.png', width: 50, height: 50),
//             const SizedBox(height: 20),
//             const MyText(
//               title: "Clinic Name",
//               color: CupertinoColors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 33,
//               fontFamily: 'Oswald',
//             ),
//           ],
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: Responsive.isMobile(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: const FaIcon(FontAwesomeIcons.facebook, size: 30),
//               color: Colors.blueAccent,
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const FaIcon(FontAwesomeIcons.instagram, size: 30),
//               color: Colors.blueAccent,
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const FaIcon(FontAwesomeIcons.twitter, size: 30),
//               color: Colors.blueAccent,
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const FaIcon(FontAwesomeIcons.linkedin, size: 30),
//               color: Colors.blueAccent,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuickLinksSection(BuildContext context) {
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.start,
//       children: [
//         MyText(
//           title: "Quick Links",
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           color: MyColors.whiteColor,
//         ),
//         SizedBox(height: 20),
//         MyText(title: "Home", fontSize: 20, color: MyColors.whiteColor),
//         MyText(title: "About us", fontSize: 20, color: MyColors.whiteColor),
//         MyText(title: "Services", fontSize: 20, color: MyColors.whiteColor),
//         MyText(title: "Contact us", fontSize: 20, color: MyColors.whiteColor),
//       ],
//     );
//   }
//
//   Widget _buildClinicHoursSection(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.start : CrossAxisAlignment.start,
//       children: [
//         MyText(
//           title: "Clinic Hours",
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           color: MyColors.whiteColor,
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             MyText(title: "Mon-Fri", fontSize: 20, color: MyColors.whiteColor),
//             SizedBox(width: 40),
//             MyText(title: "9:00 - 7:00 PM", fontSize: 20, color: MyColors.whiteColor),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
//           children: [
//             MyText(title: "Saturday", fontSize: 20, color: MyColors.whiteColor),
//             SizedBox(width: 40),
//             MyText(title: "Closed", fontSize: 20, color: MyColors.whiteColor),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             MyText(title: "Sunday", fontSize: 20, color: MyColors.whiteColor),
//             SizedBox(width: 40),
//             MyText(title: "Closed", fontSize: 20, color: MyColors.whiteColor),
//           ],
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = Responsive.isMobile(context);
//
//     return Container(
//       // height: MediaQuery.of(context).size.height * 0.3,
//       padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 0),
//       alignment: Alignment.center,
//       width: MediaQuery.of(context).size.width,
//       color: Colors.black,
//       child: isMobile
//           ? Column(
//         mainAxisAlignment: Responsive.isMobile(context) ?  MainAxisAlignment.start : MainAxisAlignment.center,
//         crossAxisAlignment: Responsive.isMobile(context) ?  CrossAxisAlignment.start : CrossAxisAlignment.center,
//         children: [
//           _buildContactSection(context),
//           const SizedBox(height: 20),
//           _buildQuickLinksSection(context),
//           const SizedBox(height: 20),
//           _buildClinicHoursSection(context),
//         ],
//       )
//           : Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _buildContactSection(context),
//           _buildQuickLinksSection(context),
//           _buildClinicHoursSection(context),
//         ],
//       ),
//     );
//   }
// }
