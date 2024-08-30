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

class _HomeSectionViewState extends State<HomeSectionView> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _textSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> imageOpacity;
  late Animation<double> textRevealAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(-0.4, 0.0),  // Start from outside left
      end: Offset(0.0, 0.0),  // End at normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(0.5, 0.0),  // Start from outside right
      end: Offset(0.0, 0.0),  // End at normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: const Interval(0.0, 0.9, curve: Curves.easeOut)));

    textRevealAnimation  = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.9 , curve: Curves.easeOut)));


    Future.delayed(const Duration(milliseconds: 1000),() {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: Responsive.isMobile(context) ? height * 0.88 : height * 0.75,
      color: MyColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Responsive.isMobile(context)
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildChildren(context, width, height),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildChildren(context, width, height),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context, double width, double height) {
    return [
      /// Sliding "Welcome" text from the left
      SlideTransition(
        position: _textSlideAnimation,
        child: FadeTransition(
          opacity: textRevealAnimation,
          child: Container(
            width: 410,
            child: Column(
              crossAxisAlignment: Responsive.isMobile(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.04 : 0),
                  child: MyText(
                    title: 'Welcome to Clinic Name',
                    fontSize: Responsive.isMobile(context) ? 46 : 70,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Oswald',
                    color: MyColors.whiteColor,
                    textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? width * 0.1 : 0),
                  child: MyText(
                    title: "A Smile for Every Family Member",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: MyColors.whiteColor,
                    textAlign: Responsive.isMobile(context) ? TextAlign.center : TextAlign.start,
                  ),
                ),
                const SizedBox(height: 20),
                MyTextButton(
                  title: "About Us",
                  fontSize: 18,
                  backgroundColor: MyColors.whiteColor,
                  textColor: MyColors.primaryColor,
                  width: 200,
                  height: Responsive.isMobile(context) ?  height * 0.07 : height * 0.06,
                  borderRadius: 30,
                ),
              ],
            ),
          ),
        ),
      ),

      const SizedBox(height: 30),

      /// Sliding Image from the right
      FadeTransition(
        opacity: imageOpacity,
        child: SlideTransition(
          position: _imageSlideAnimation,
          child: Image.network(
            'https://i.imgur.com/NIwGSeL_d.jpg?maxwidth=520&shape=thumb&fidelity=high',
            width: Responsive.isMobile(context) ? width * 0.86 : 560,
            height: Responsive.isMobile(context) ? height * 0.48 : 510,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    ];
  }
}
