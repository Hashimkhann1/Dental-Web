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

class _AboutSectionViewState extends State<AboutSectionView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimationForDescription;
  late Animation<Offset> _slideAnimationForImage;
  late Animation<double> textRevealAnimation;
  late Animation<double> headingTextRevelAnimation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> imageOpacity;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    );

    _slideAnimationForDescription = Tween<Offset>(
      begin: const Offset(0, 1), // Start position (below the screen)
      end: Offset.zero, // End position (original position)
    ).animate(CurvedAnimation(
      parent: _controller,
        curve: const Interval(0.0, 0.6 , curve: Curves.easeOut)

    ));

    _slideAnimationForImage = Tween<Offset>(
      begin: const Offset(0, 1), // Start position (below the screen)
      end: Offset.zero, // End position (original position)
    ).animate(CurvedAnimation(
      parent: _controller,
        curve: const Interval(0.0, 1.0 , curve: Curves.easeOut)
    ));


    imageOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeOut)));

    textRevealAnimation  = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.9 , curve: Curves.easeIn)));

    headingTextRevelAnimation = Tween<double>(begin: 100.0,end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.2,curve: Curves.easeOut))
    );

    textOpacityAnimation = Tween<double>(begin: 0.0,end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.1,curve: Curves.easeOut))
    );

    // Future.delayed(const Duration(milliseconds: 2000),() {
    //   _controller.forward();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<DisplayOffset, ScrollOffset>(

      buildWhen: (previous, current) {
        if(Responsive.isTablet(context)){
          if ((current.scrollOffsetValue >= 700 &&
              current.scrollOffsetValue <= 1300) ||
              _controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        }else{
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
        print(state.scrollOffsetValue);
    if(state.scrollOffsetValue > 1000){
      _controller.forward();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context , child) {
        return Container(
          width: Responsive.isMobile(context) ? width : width * .72,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.06),
              Container(
                padding: EdgeInsets.only(top: headingTextRevelAnimation.value),
                child: FadeTransition(
                  opacity: textOpacityAnimation,
                  child: const MyText(
                    title: "About us",
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                    fontFamily: 'Oswald',
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Responsive.isMobile(context)
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(context),
                  const SizedBox(height: 20),
                  _buildImage(height),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: SlideTransition(
                      position: _slideAnimationForDescription,
                      child: _buildText(context),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: SlideTransition(
                      position: _slideAnimationForImage,
                      child: _buildImage(height),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }
    );
  },
);
  }

  Widget _buildText(BuildContext context) {
    return FadeTransition(
      opacity: textRevealAnimation,
      child: MyText(
        title:
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
            "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
            "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
            "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
        fontSize: Responsive.isMobile(context) ? 17 : 20,
        color: Colors.black.withOpacity(0.7),
      ),
    );
  }

  Widget _buildImage(double height) {
    return FadeTransition(
      opacity: imageOpacity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
        child: Image.network(
          'https://images.unsplash.com/photo-1598256989800-fe5f95da9787?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGRlbnRpc3QlMjBjbGluaWN8ZW58MHwwfDB8fHwy',
          height: height * 0.42,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
