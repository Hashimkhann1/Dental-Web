import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyServicesCard extends StatefulWidget {
  const MyServicesCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  });

  final String image;
  final String title;
  final String description;
  final int index;

  @override
  State<MyServicesCard> createState() => _MyServicesCardState();
}

class _MyServicesCardState extends State<MyServicesCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> gridItemsScaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    gridItemsScaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.9, curve: Curves.easeOut)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final indexOffset = Responsive.isMobile(context) ? widget.index * 160  : Responsive.isTablet(context) ? widget.index * 100  : widget.index * 110; // Adjust this value based on your needs
    final mobileTriggerOffset = 1782 + indexOffset;
    final desktopTriggerOffset = 1530 + indexOffset;
    final tabletTriggerOffset = 2082 + indexOffset;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<DisplayOffset, ScrollOffset>(
      buildWhen: (previous, current) {
        bool shouldBuild = false;

        // Check if the animation is currently running
        if (_controller.isAnimating) {
          shouldBuild = true;
        } else {
          // Check if the device is mobile
          if (Responsive.isMobile(context)) {
            // Check if the scroll position is within the trigger range for mobile
            if (current.scrollOffsetValue >= mobileTriggerOffset &&
                current.scrollOffsetValue <= mobileTriggerOffset + 100) {
              shouldBuild = true;
            }
          }else if(Responsive.isTablet(context)) {
            if (current.scrollOffsetValue >= tabletTriggerOffset &&
                current.scrollOffsetValue <= tabletTriggerOffset + 100) {
              shouldBuild = true;
            }
          } else {
            // Check if the scroll position is within the trigger range for desktop
            if (current.scrollOffsetValue >= desktopTriggerOffset &&
                current.scrollOffsetValue <= desktopTriggerOffset + 100) {
              shouldBuild = true;
            }
          }
        }

        return shouldBuild;
      },
      builder: (context, state) {
        if (Responsive.isMobile(context)) {
          if (state.scrollOffsetValue >= mobileTriggerOffset) {
            _controller.forward();
          }
        }else if(Responsive.isTablet(context)) {
          if (state.scrollOffsetValue >= tabletTriggerOffset) {
            _controller.forward();
          }
        }
        else {
          if (state.scrollOffsetValue >= desktopTriggerOffset) {
            _controller.forward();
          }
        }

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ScaleTransition(
              scale: gridItemsScaleAnimation,
              child: Container(
                padding: EdgeInsets.all(Responsive.isMobile(context)
                    ? 16
                    : Responsive.isTablet(context)
                    ? 14
                    : 30),
                margin: Responsive.isTablet(context)
                    ? const EdgeInsets.only(left: 10, right: 10)
                    : EdgeInsets.symmetric(
                    horizontal: Responsive.isMobile(context) ? 10 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: MyColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// image
                    CircleAvatar(
                      radius: Responsive.isMobile(context)
                          ? 25
                          : Responsive.isTablet(context)
                          ? 40
                          : 36,
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context)
                          ? 5
                          : Responsive.isTablet(context)
                          ? height * 0.01
                          : height * 0.02,
                    ),

                    /// service name
                    MyText(
                      title: widget.title,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context)
                          ? 5
                          : Responsive.isTablet(context)
                          ? height * 0.01
                          : height * 0.02,
                    ),
                    MyText(
                      title: widget.description,
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

