import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurExpertTeamSectionView extends StatelessWidget {
  const OurExpertTeamSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: 1200,
      // height: height * 0.6,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText(
            title: "Our Expert Doctors",
            fontSize: Responsive.isMobile(context) ? 34 : 50,
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
            fontFamily: 'Oswald',
          ),
          const SizedBox(height: 8),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 3, // Number of team members
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2 / 2, // Aspect ratio of the card
            ),
            itemBuilder: (context, index) {
              return _buildTeamMemberCard(
                  name: teamMembers[index]['name']!,
                  title: teamMembers[index]['title']!,
                  imagePath: teamMembers[index]['imagePath']!,
                  context: context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(
      {required String name,
      required String title,
      required String imagePath,
      required BuildContext context}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            imagePath,
            height: MediaQuery.of(context).size.height * 0.8,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 60,
          left: 100,
          // right: 0,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 55,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  title: name,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                MyText(
                  title: title,
                  fontSize: 15,
                  color: MyColors.blackColor.withOpacity(0.7),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

final List<Map<String, String>> teamMembers = [
  {
    'name': 'Natali Jones',
    'title': 'Oral Surgeon',
    'imagePath':
        'https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg',
  },
  {
    'name': 'David Green',
    'title': 'Oral Surgeon',
    'imagePath':
        'https://www.shutterstock.com/image-photo/healthcare-medical-staff-concept-portrait-600nw-2281024823.jpg'
  },
  {
    'name': 'Amy Walker',
    'title': 'Oral Surgeon',
    'imagePath':
        'https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-4.1.0&q=45&auto=format&w=926&fit=clip'
  },
];
