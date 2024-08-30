import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class AboutSectionView extends StatelessWidget {
  const AboutSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: Responsive.isMobile(context) ? width : width * .72,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.06),
          const MyText(
            title: "About us",
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
            fontFamily: 'Oswald',
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
              Expanded(flex: 1, child: _buildText(context)),
              const SizedBox(width: 20),
              Expanded(flex: 1, child: _buildImage(height)),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return MyText(
      title:
      "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available "
          "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available.",
      fontSize: Responsive.isMobile(context) ? 17 : 20,
      color: Colors.black.withOpacity(0.7),
    );
  }

  Widget _buildImage(double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
      child: Image.network(
        'https://images.unsplash.com/photo-1598256989800-fe5f95da9787?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGRlbnRpc3QlMjBjbGluaWN8ZW58MHwwfDB8fHwy',
        height: height * 0.42,
        fit: BoxFit.cover,
      ),
    );
  }
}
