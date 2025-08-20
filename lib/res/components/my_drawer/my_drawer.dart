import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
    this.servicesOnTap,
    this.aboutOnTap,
    this.contactsOnTap,
    this.homeOnTap,
  });

  final void Function()? homeOnTap;
  final void Function()? aboutOnTap;
  final void Function()? servicesOnTap;
  final void Function()? contactsOnTap;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
    with TickerProviderStateMixin {

  late AnimationController _slideController;
  late AnimationController _fadeController;

  late Animation<Offset> _logoSlideAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _menuFadeAnimation;
  late Animation<double> _contactFadeAnimation;

  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _menuFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    _contactFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _slideController.forward();
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Drawer(
      child: AnimatedBuilder(
        animation: Listenable.merge([_slideController, _fadeController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                  MyColors.primaryColor.withOpacity(0.02),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header Section
                  _buildHeader(height),

                  // Menu Section
                  Expanded(
                    child: _buildMenuSection(width, height),
                  ),

                  // Contact Section
                  _buildContactSection(height),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(double height) {
    return SlideTransition(
      position: _logoSlideAnimation,
      child: FadeTransition(
        opacity: _logoFadeAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.04,
            horizontal: 20,
          ),
          child: Column(
            children: [
              // Logo/Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColors.primaryColor,
                      MyColors.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Colors.white,
                  size: 40,
                ),
              ),

              const SizedBox(height: 16),

              // Clinic Name
              const MyText(
                title: "HealthCare Plus",
                fontSize: 28,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald',
                letterSpacing: 1.2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Tagline
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: MyColors.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  "Your Health, Our Priority",
                  style: TextStyle(
                    fontSize: 12,
                    color: MyColors.primaryColor.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(double width, double height) {
    final menuItems = [
      {'title': 'Home', 'icon': Icons.home_rounded, 'onTap': widget.homeOnTap},
      {'title': 'About', 'icon': Icons.info_outline_rounded, 'onTap': widget.aboutOnTap},
      {'title': 'Services', 'icon': Icons.medical_services_rounded, 'onTap': widget.servicesOnTap},
      {'title': 'Contact Us', 'icon': Icons.contact_phone_rounded, 'onTap': widget.contactsOnTap},
    ];

    return FadeTransition(
      opacity: _menuFadeAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu Title
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 16),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                  letterSpacing: 0.5,
                ),
              ),
            ),

            // Menu Items
            ...menuItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 300 + (index * 100)),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.translate(
                    offset: Offset((1 - value) * 50, 0),
                    child: Opacity(
                      opacity: value,
                      child: _buildMenuItem(
                        title: item['title'] as String,
                        icon: item['icon'] as IconData,
                        onTap: item['onTap'] as void Function()?,
                        index: index,
                      ),
                    ),
                  );
                },
              );
            }).toList(),

            const SizedBox(height: 20),

            // Divider
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.grey.shade300,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required void Function()? onTap,
    required int index,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isHovered
              ? MyColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovered
                ? MyColors.primaryColor.withOpacity(0.2)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isHovered
                          ? MyColors.primaryColor.withOpacity(0.15)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: isHovered
                          ? MyColors.primaryColor
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyText(
                      title: title,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isHovered
                          ? MyColors.primaryColor
                          : Colors.grey.shade700,
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: isHovered ? 0.0 : 0.0,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: isHovered
                          ? MyColors.primaryColor
                          : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(double height) {
    return FadeTransition(
      opacity: _contactFadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor.withOpacity(0.05),
              MyColors.primaryColor.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: MyColors.primaryColor.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.contact_support_rounded,
                    color: MyColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: MyText(
                    title: "Get in Touch",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Contact Items
            _buildContactItem(
              icon: Icons.phone_rounded,
              text: "+1 (555) 123-4567",
              label: "Call Us",
            ),

            const SizedBox(height: 12),

            _buildContactItem(
              icon: Icons.email_rounded,
              text: "contact@healthcareplus.com",
              label: "Email Us",
            ),

            const SizedBox(height: 16),

            // Emergency Notice
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emergency,
                    color: Colors.red.shade600,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "24/7 Emergency Care Available",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: MyColors.primaryColor,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyText(
                title: text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MyColors.primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/components/my_text_button.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:flutter/material.dart';
//
//
// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key, this.servicesOnTap, this.aboutOnTap, this.contactsOnTap,this.homeOnTap});
//
//   final void Function()? homeOnTap;
//   final void Function()? aboutOnTap;
//   final void Function()? servicesOnTap;
//   final void Function()? contactsOnTap;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//
//     return Drawer(
//         child: Container(
//           color: Colors.white,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Column(
//                 children: [
//                   SizedBox(height: height * 0.14,),
//
//                   const Center(
//                     child: Padding(
//                         padding: EdgeInsets.only(top: 6.0),
//                         child: MyText(title: "Clinic Name",fontSize: 42,color: MyColors.primaryColor,fontWeight: FontWeight.bold,fontFamily: 'Oswald',letterSpacing: 2,)
//                     ),
//                   ),
//
//                   SizedBox(height: height * 0.1,),
//
//
//                   MyTextButton(
//                     width: width * 0.66,
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
//                     margin: EdgeInsets.only(left: width * 0.02),
//                     borderRadius: 6,
//                     title: "Home",
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     textColor: MyColors.primaryColor,
//                     onTap: homeOnTap,
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                   ),
//                   SizedBox(
//                     height: height * 0.01,
//                   ),
//                   MyTextButton(
//                     width: width * 0.66,
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
//                     margin: EdgeInsets.only(left: width * 0.02),
//                     borderRadius: 6,
//                     title: "About",
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     textColor: MyColors.primaryColor,
//                     onTap: aboutOnTap,
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                   ),
//                   SizedBox(
//
//                     height: height * 0.01,
//                   ),
//                   MyTextButton(
//                     width: width * 0.66,
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
//                     margin: EdgeInsets.only(left: width * 0.02),
//                     borderRadius: 6,
//                     title: "Services",
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     textColor:MyColors.primaryColor,
//                     onTap: servicesOnTap,
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                   ),
//                   SizedBox(
//                     height: height * 0.01,
//                   ),
//                   MyTextButton(
//                     width: width * 0.66,
//                     alignment: Alignment.topLeft,
//                     padding: const EdgeInsets.only(left: 6,top: 5,bottom: 5),
//                     margin: EdgeInsets.only(left: width * 0.02),
//                     borderRadius: 6,
//                     title: "Contact Us",
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     textColor: MyColors.primaryColor,
//                     onTap: contactsOnTap,
//                     backgroundColor: Colors.grey.withOpacity(0.2),
//                   ),
//                   SizedBox(
//                     height: height * 0.01,
//                   )
//                 ],
//               ),
//
//
//               /// contact
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const MyText(title: "+00 0000000000",fontSize: 20,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
//                     const MyText(title: "clinicName@gmail.com",fontSize: 20,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
//                     SizedBox(height: height * 0.04,)
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//     );
//   }
// }
