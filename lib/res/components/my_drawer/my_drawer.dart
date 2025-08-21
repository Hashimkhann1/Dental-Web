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
    final isMobile = width < 600;

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            // Header Section - Responsive
                            _buildHeader(height, isMobile),

                            // Menu Section - Flexible
                            _buildMenuSection(width, height, isMobile),

                            // Spacer to push contact to bottom
                            const Spacer(),

                            // Contact Section - Compact on mobile
                            _buildContactSection(height, isMobile),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(double height, bool isMobile) {
    return SlideTransition(
      position: _logoSlideAnimation,
      child: FadeTransition(
        opacity: _logoFadeAnimation,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? height * 0.02 : height * 0.04,
            horizontal: 20,
          ),
          child: Column(
            children: [
              // Logo/Icon - Smaller on mobile
              Container(
                width: isMobile ? 60 : 80,
                height: isMobile ? 60 : 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      MyColors.primaryColor,
                      MyColors.primaryColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(isMobile ? 15 : 20),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.local_hospital,
                  color: Colors.white,
                  size: isMobile ? 30 : 40,
                ),
              ),

              SizedBox(height: isMobile ? 12 : 16),

              // Clinic Name - Responsive font size
              MyText(
                title: "HealthCare Plus",
                fontSize: isMobile ? 22 : 28,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Oswald',
                letterSpacing: 1.2,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: isMobile ? 6 : 8),

              // Tagline - Smaller on mobile
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: isMobile ? 4 : 6,
                ),
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
                    fontSize: isMobile ? 10 : 12,
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

  Widget _buildMenuSection(double width, double height, bool isMobile) {
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
                  fontSize: isMobile ? 14 : 16,
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
                        isMobile: isMobile,
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
    required bool isMobile,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: isMobile ? 6 : 8),
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
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: isMobile ? 10 : 14,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isMobile ? 6 : 8),
                    decoration: BoxDecoration(
                      color: isHovered
                          ? MyColors.primaryColor.withOpacity(0.15)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      size: isMobile ? 18 : 20,
                      color: isHovered
                          ? MyColors.primaryColor
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MyText(
                      title: title,
                      fontSize: isMobile ? 14 : 16,
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
                      size: isMobile ? 12 : 14,
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

  Widget _buildContactSection(double height, bool isMobile) {
    return FadeTransition(
      opacity: _contactFadeAnimation,
      child: Container(
        padding: EdgeInsets.all(isMobile ? 16 : 20),
        margin: EdgeInsets.all(isMobile ? 12 : 16),
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
                  padding: EdgeInsets.all(isMobile ? 6 : 8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.contact_support_rounded,
                    color: MyColors.primaryColor,
                    size: isMobile ? 18 : 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MyText(
                    title: "Get in Touch",
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: isMobile ? 12 : 16),

            // Contact Items
            _buildContactItem(
              icon: Icons.phone_rounded,
              text: "+1 (555) 123-4567",
              label: "Call Us",
              isMobile: isMobile,
            ),

            SizedBox(height: isMobile ? 8 : 12),

            _buildContactItem(
              icon: Icons.email_rounded,
              text: "contact@healthcareplus.com",
              label: "Email Us",
              isMobile: isMobile,
            ),

            SizedBox(height: isMobile ? 12 : 16),

            // Emergency Notice
            Container(
              padding: EdgeInsets.all(isMobile ? 8 : 12),
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
                    size: isMobile ? 14 : 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "24/7 Emergency Care Available",
                      style: TextStyle(
                        fontSize: isMobile ? 10 : 12,
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
    required bool isMobile,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 4 : 6),
          decoration: BoxDecoration(
            color: MyColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            color: MyColors.primaryColor,
            size: isMobile ? 14 : 16,
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
                  fontSize: isMobile ? 10 : 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyText(
                title: text,
                fontSize: isMobile ? 12 : 14,
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