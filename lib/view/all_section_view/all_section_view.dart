


import 'package:doctor_demo/res/components/my_drawer/my_drawer.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/scroll_offset/scroll_offset.dart';
import 'package:doctor_demo/view/about_section_view/about_section_view.dart';
import 'package:doctor_demo/view/contact_section_view/contact_section_view.dart';
import 'package:doctor_demo/view/fotter_Section_view/fotter_Section_view.dart';
import 'package:doctor_demo/view/header_section_view/header_section_view.dart';
import 'package:doctor_demo/view/home_section_view/home_section_view.dart';
import 'package:doctor_demo/view/our_expert_team_section_view/our_expert_team_section_view.dart';
import 'package:doctor_demo/view/our_services_section/our_services_section.dart';
import 'package:doctor_demo/view_model/scroll_view_model/scroll_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllSectionView extends StatefulWidget {
  const AllSectionView({super.key});

  @override
  State<AllSectionView> createState() => _AllSectionViewState();
}

class _AllSectionViewState extends State<AllSectionView> {
  late ScrollController scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final homeSectinokey = GlobalKey();
  final aboutSectinokey = GlobalKey();
  final servicesSectinokey = GlobalKey();
  final contactSectinokey = GlobalKey();

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      context.read<DisplayOffset>().changeDisplayOffset(
          (MediaQuery.of(context).size.height + scrollController.position.pixels).toInt());
    });
    super.initState();
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white.withOpacity(0.3),
      drawer: MyDrawer(
        homeOnTap: () {
          ScrollViewModel.scrollToSection(homeSectinokey);
          Navigator.pop(context);
        },
        aboutOnTap: () {
          ScrollViewModel.scrollToSection(aboutSectinokey);
          Navigator.pop(context);
        },
        servicesOnTap: () {
          ScrollViewModel.scrollToSection(servicesSectinokey);
          Navigator.pop(context);
        },
        contactsOnTap: () {
          ScrollViewModel.scrollToSection(contactSectinokey);
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            /// header section
            HeaderSectionView(
              aboutOnTap: () {
                ScrollViewModel.scrollToSection(aboutSectinokey);
              },
              servicesOnTap: () {
                ScrollViewModel.scrollToSection(servicesSectinokey);
              },
              contactOnTap: () {
                ScrollViewModel.scrollToSection(contactSectinokey);
              },
              drawertOnTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),

            /// home section
            Container(key: homeSectinokey, child: const HomeSectionView()),

            /// about section
            Container(key: aboutSectinokey, child: const AboutSectionView()),

            /// our services
            Container(key: servicesSectinokey, child: const OurServicesSection()),

            /// our expert team section
            const OurExpertTeamSectionView(),
            const SizedBox(height: 30),

            /// contact section view
            Container(key: contactSectinokey, child: const ContactSectionView()),
            const SizedBox(height: 100),

            /// fotter section view
            const FotterSectionView()
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<DisplayOffset, ScrollOffset>(
        builder: (context, state) {
          return state.scrollOffsetValue > 1140
              ? FloatingActionButton(
            onPressed: _scrollToTop,
            backgroundColor: MyColors.primaryColor,
            child: const Icon(
              Icons.keyboard_double_arrow_up_sharp,
              color: MyColors.whiteColor,
              size: 32,
            ),
          )
              : const SizedBox();
        },
      ),
    );
  }
}

