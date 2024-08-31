
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactSectionView extends StatelessWidget {
  const ContactSectionView({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      width: Responsive.isMobile(context) ? width * 0.95 : Responsive.isTablet(context) ? width * 0.94 : width * 0.68,
      padding: const EdgeInsets.all(16.0),
      child: Responsive.isMobile(context) ? Column(
        children: [
          _buildContactUsSection(context),
          const SizedBox(height: 32),
          _buildBookAppointmentForm(context),
        ],
      ) : Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildContactUsSection(context),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 2,
            child: _buildBookAppointmentForm(context),
          ),
        ],
      ),
    );
  }
}


Widget _buildContactUsSection(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const MyText(title: "Contact Us",fontSize: 30,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
      const SizedBox(height: 8),
      MyText(title: "Make An\nAppointment",fontSize: Responsive.isMobile(context) ? 50 : 60,fontWeight: FontWeight.w800,fontFamily: 'Oswald',letterSpacing: 2,),
      const SizedBox(height: 8),
      Text(
        "Feel free to ask something we are here",
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 32),
      _buildContactDetail(Icons.phone, "Call Us At", "(+91) 8888888888"),
      const SizedBox(height: 16),
      _buildContactDetail(Icons.email, "Email Us On", "info@example.com"),
      const SizedBox(height: 16),
      _buildContactDetail(Icons.location_on, "Address", "111 Adelaide, Australia"),
    ],
  );
}

Widget _buildContactDetail(IconData icon, String title, String detail) {
  return Row(
    children: [
      CircleAvatar(
        radius: 24,
        backgroundColor: Colors.blue,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(title: title,fontSize: 21,fontWeight: FontWeight.bold,),
          MyText(title: detail,fontSize: 17,fontWeight: FontWeight.bold,color: MyColors.blackColor.withOpacity(0.6),),
        ],
      ),
    ],
  );
}

Widget _buildBookAppointmentForm(BuildContext context) {

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Book Appointment",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Responsive.isMobile(context) ? Column(
          children: [
            _buildTextField("Name"),
            const SizedBox(height: 16),
            _buildTextField("Email"),
            const SizedBox(height: 16),
            _buildTextField("Number"),
            const SizedBox(height: 16),
            _buildTextField("Address"),
          ],
        ) : Row(
          children: [
            Expanded(
              child: _buildTextField("Name"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField("Email"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Responsive.isMobile(context) ? SizedBox() : Row(
          children: [
            Expanded(
              child: _buildTextField("Number"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField("Address"),
            ),
          ],
        ),
        SizedBox(height: Responsive.isMobile(context) ? 8 : 16),
        _buildTextField("Message", maxLines: 4),
        const SizedBox(height: 24),
        MyTextButton(title: "Submit",fontSize: 18,fontWeight: FontWeight.bold,backgroundColor: MyColors.primaryColor,textColor: CupertinoColors.white,width: 124,height: 38,borderRadius: 8,)
      ],
    ),
  );
}

Widget _buildTextField(String label, {int maxLines = 1}) {
  return TextField(
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
