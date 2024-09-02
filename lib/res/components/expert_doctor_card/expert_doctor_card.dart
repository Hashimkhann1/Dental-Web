

import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpertDoctorCard extends StatefulWidget {

  final String name;
  final String title;
  final String imagePath;

  const ExpertDoctorCard({
    super.key,
    required this.name,
    required this.title,
    required this.imagePath,
  });

  @override
  State<ExpertDoctorCard> createState() => _ExpertDoctorCardState();
}

class _ExpertDoctorCardState extends State<ExpertDoctorCard> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<Color?> _colorAnimtaion;
  late Animation<double> _headTextOpicatyAnimation;
  late Animation<double> _subTextOpicatyAnimation;

  bool isAnimate = false;

  @override
  void initState() {

    _controller = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 375)
    );

    _rotateAnimation = Tween(begin: math.pi / 2 ,end: 0.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0,0.5 , curve: Curves.fastOutSlowIn)));

    _colorAnimtaion = ColorTween(begin: Colors.transparent ,end: Colors.black.withOpacity(0.5)).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _headTextOpicatyAnimation = Tween(begin: 0.0 ,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0,0.9 , curve: Curves.fastOutSlowIn)));
    _subTextOpicatyAnimation = Tween(begin: 0.0 ,end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5,1.0 , curve: Curves.fastOutSlowIn)));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          isAnimate = !isAnimate;
          if (isAnimate) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background image
            SizedBox(
              height: height * 0.8,
              width: width,
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),

            isAnimate ? const SizedBox() : Positioned.fill(
              bottom: -(height * 0.16),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  color: MyColors.whiteColor,
                  ),
                  child: const MyText(title: "Tap to see Doctor About",fontSize: 20,fontWeight: FontWeight.bold,),
                ),
              ),
            ),


            Positioned(
              left: 0,
              child: SizedBox(
                width: Responsive.isTablet(context) ? width * 0.16 : Responsive.isMobile(context) ? width * 0.43 : width * 0.1,
                height: height,
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context , child) {
                      return Transform.rotate(
                        angle: _rotateAnimation.value,
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: _colorAnimtaion.value,
                        ),
                      );
                    }
                ),
              ),
            ),


            Positioned(
              right: Responsive.isTablet(context) ? -7.1 : -5.2,
              child: SizedBox(
                width: Responsive.isTablet(context) ? width * 0.16 : Responsive.isMobile(context) ? width * 0.5 : width * 0.1,
                height: height,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context , child) {
                    return Transform.rotate(
                      angle: _rotateAnimation.value,
                      alignment: Alignment.topRight,
                      child: Container(
                        color: _colorAnimtaion.value,
                      ),
                    );
                  }
                ),
              ),
            ),

            Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// name
                    AnimatedBuilder(
                      animation: _headTextOpicatyAnimation,
                      builder: (context , child) {
                        return Container(
                          // height: 40,
                          alignment: Alignment(0.0 , _headTextOpicatyAnimation.value - 1.1),
                          child: FadeTransition(opacity: _headTextOpicatyAnimation, child: const MyText(title: "Doctor Name",fontSize: 24,fontWeight: FontWeight.bold,color: MyColors.whiteColor,)),
                        );
                      },
                    ),

                    /// small description
                    AnimatedBuilder(
                        animation: _subTextOpicatyAnimation,
                        builder: (context , child) {
                          return Container(
                            // height: 40,
                            alignment: Alignment(0.0 , _subTextOpicatyAnimation.value - 1.1),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          // height: 70,
                          child: FadeTransition(opacity: _subTextOpicatyAnimation, child: const MyText(title: "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content typeface without relying on meaningful content.",fontSize: 16,color: MyColors.whiteColor,textAlign: TextAlign.center,)),
                        );
                      }
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
