import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class HeaderSectionView extends StatefulWidget {
  const HeaderSectionView({
    super.key,
    this.homeOnTap,
    required this.aboutOnTap,
    required this.servicesOnTap,
    required this.contactOnTap,
    required this.drawertOnTap,
  });

  final void Function()? homeOnTap;
  final void Function()? aboutOnTap;
  final void Function()? servicesOnTap;
  final void Function()? contactOnTap;
  final void Function()? drawertOnTap;

  @override
  State<HeaderSectionView> createState() => _HeaderSectionViewState();
}

class _HeaderSectionViewState extends State<HeaderSectionView>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _menuSlideAnimation;

  int _hoveredIndex = -1;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _menuSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      _headerController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _headerFadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor,
              MyColors.primaryColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: Responsive.isMobile(context) ? 70 : 100,
        width: MediaQuery.of(context).size.width,
        child: Responsive.isMobile(context)
            ? _buildMobileHeader()
            : _buildDesktopHeader(),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return SlideTransition(
      position: _logoSlideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: MyColors.primaryColor,
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const MyText(
                  title: "Dentist",
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: MyColors.whiteColor,
                ),
              ],
            ),
            // Menu button
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.drawertOnTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu,
                    size: 28,
                    color: MyColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo section
          SlideTransition(
            position: _logoSlideAnimation,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: MyColors.primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MyText(
                      title: "Dentist",
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: MyColors.whiteColor,
                    ),
                    MyText(
                      title: "Care & Smile",
                      fontSize: 12,
                      color: MyColors.whiteColor.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation menu
          SlideTransition(
            position: _menuSlideAnimation,
            child: Row(
              children: [
                _buildNavItem("Home", 0, widget.homeOnTap),
                const SizedBox(width: 32),
                _buildNavItem("About us", 1, widget.aboutOnTap),
                const SizedBox(width: 32),
                _buildNavItem("Services", 2, widget.servicesOnTap),
                const SizedBox(width: 32),
                _buildNavItem("Contact us", 3, widget.contactOnTap),
                const SizedBox(width: 40),
                _buildAppointmentButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index, VoidCallback? onTap) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            ),
            child: MyText(
              title: title,
              fontSize: 18,
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentButton() {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton(
          onPressed: () {
            // Add appointment booking logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: MyColors.primaryColor,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: MyColors.primaryColor,
              ),
              const SizedBox(width: 8),
              const MyText(
                title: "Book Now",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/components/my_text_button.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:flutter/material.dart';
//
// class HeaderSectionView extends StatelessWidget {
//   const HeaderSectionView({
//     super.key,
//     this.homeOnTap,
//     required this.aboutOnTap,
//     required this.servicesOnTap,
//     required this.contactOnTap,
//     required this.drawertOnTap,
//   });
//
//   final void Function()? homeOnTap;
//   final void Function()? aboutOnTap;
//   final void Function()? servicesOnTap;
//   final void Function()? contactOnTap;
//   final void Function()? drawertOnTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: MyColors.primaryColor,
//       height: Responsive.isMobile(context) ? 50 : 100,
//       width: MediaQuery.of(context).size.width,
//       child: Responsive.isMobile(context)
//           ? Align(
//         alignment: Alignment.centerLeft,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: drawertOnTap,
//             child: const Icon(
//               Icons.menu,
//               size: 34,
//               color: MyColors.whiteColor,
//             ),
//           ),
//         ),
//       )
//           : Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           /// logo
//           Row(
//             children: [
//               Image.asset(
//                 'assets/images/logo.png',
//                 width: 50,
//                 height: 50,
//               ),
//               const MyText(
//                 title: "Dentist",
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30,
//                 color: MyColors.whiteColor,
//               )
//             ],
//           ),
//
//           /// buttons
//           Row(
//             children: [
//               MyTextButton(
//                 title: "Home",
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 textColor: MyColors.whiteColor,
//                 onTap: homeOnTap,
//               ),
//               const SizedBox(
//                 width: 28,
//               ),
//               MyTextButton(
//                 title: "About us",
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 textColor: MyColors.whiteColor,
//                 onTap: aboutOnTap,
//               ),
//               const SizedBox(
//                 width: 28,
//               ),
//               MyTextButton(
//                 title: "Services",
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 textColor: MyColors.whiteColor,
//                 onTap: servicesOnTap,
//               ),
//               const SizedBox(
//                 width: 28,
//               ),
//               MyTextButton(
//                 title: "Contact us",
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 textColor: MyColors.whiteColor,
//                 onTap: contactOnTap,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//
