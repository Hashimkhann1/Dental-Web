


import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:doctor_demo/view/about_section_view/about_section_view.dart';
import 'package:doctor_demo/view/contact_section_view/contact_section_view.dart';
import 'package:doctor_demo/view/fotter_Section_view/fotter_Section_view.dart';
import 'package:doctor_demo/view/header_section_view/header_section_view.dart';
import 'package:doctor_demo/view/home_section_view/home_section_view.dart';
import 'package:doctor_demo/view/our_expert_team_section_view/our_expert_team_section_view.dart';
import 'package:doctor_demo/view/our_services_section/our_services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSectionView extends StatefulWidget {
  const AllSectionView({super.key});

  @override
  State<AllSectionView> createState() => _AllSectionViewState();
}

class _AllSectionViewState extends State<AllSectionView> {

  late ScrollController scrollController;

  @override
  void initState() {

    scrollController = ScrollController();

    super.initState();

    scrollController.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height + scrollController.position.pixels).toInt()
      );
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.3),
      body: SingleChildScrollView(
        controller: scrollController,
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
            SizedBox(height: 80,),

            /// contact section view
            ContactSectionView(),
            SizedBox(height: 100),

            /// fotter section view
            FotterSectionView()

          ],
        ),
      ),
    );
  }
}
