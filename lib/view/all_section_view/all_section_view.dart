


import 'package:doctor_demo/view/about_section_view/about_section_view.dart';
import 'package:doctor_demo/view/contact_section_view/contact_section_view.dart';
import 'package:doctor_demo/view/header_section_view/header_section_view.dart';
import 'package:doctor_demo/view/home_section_view/home_section_view.dart';
import 'package:doctor_demo/view/our_expert_team_section_view/our_expert_team_section_view.dart';
import 'package:doctor_demo/view/our_services_section/our_services_section.dart';
import 'package:flutter/material.dart';

class AllSectionView extends StatelessWidget {
  const AllSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.3),
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            /// header section
            const HeaderSectionView(),
        
            /// home section
            const HomeSectionView(),

            /// about section
            const AboutSectionView(),

            /// our services
            OurServicesSection(),

            /// our expert team section
            OurExpertTeamSectionView(),
            SizedBox(height: 100,),

            /// contact section view
            ContactSectionView(),
        
          ],
        ),
      ),
    );
  }
}
