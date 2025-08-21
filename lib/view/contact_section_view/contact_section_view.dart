import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/components/my_text_button.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactSectionView extends StatefulWidget {
  const ContactSectionView({super.key});

  @override
  State<ContactSectionView> createState() => _ContactSectionViewState();
}

class _ContactSectionViewState extends State<ContactSectionView>
    with TickerProviderStateMixin {

  late AnimationController _mainController;
  late AnimationController _formController;
  late AnimationController _contactController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _slideUpAnimation;
  late Animation<double> _formSlideAnimation;
  late Animation<double> _contactSlideAnimation;
  late Animation<double> _staggeredAnimation1;
  late Animation<double> _staggeredAnimation2;
  late Animation<double> _staggeredAnimation3;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Main controller for overall section
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Form animation controller
    _formController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Contact info animation controller
    _contactController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Main animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOut),
    );

    _slideUpAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutBack),
    );

    // Form animations
    _formSlideAnimation = Tween<double>(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _formController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // Contact info animations
    _contactSlideAnimation = Tween<double>(begin: -80.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _contactController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Staggered animations for contact details
    _staggeredAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contactController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _staggeredAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contactController,
        curve: const Interval(0.5, 0.9, curve: Curves.easeOut),
      ),
    );

    _staggeredAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _contactController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _mainController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _contactController.forward();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _formController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _formController.dispose();
    _contactController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: Listenable.merge([_mainController, _formController, _contactController]),
      builder: (context, child) {
        return Container(
          width: _getContainerWidth(width),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade50.withOpacity(0.5),
                Colors.white,
                Colors.purple.shade50.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 40),
          child: Transform.translate(
            offset: Offset(0, _slideUpAnimation.value),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Responsive.isMobile(context)
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactUsSection(),
        const SizedBox(height: 40),
        _buildBookAppointmentForm(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildContactUsSection(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildBookAppointmentForm(),
        ),
      ],
    );
  }

  Widget _buildContactUsSection() {
    return Transform.translate(
      offset: Offset(_contactSlideAnimation.value, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const MyText(
                    title: "Contact Us",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                MyText(
                  title: "Let's Start a\nConversation",
                  fontSize: Responsive.isMobile(context) ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Oswald',
                  letterSpacing: 1.2,
                  color: Colors.grey.shade800,
                ),
                const SizedBox(height: 12),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Text(
                    "We're here to help and answer any questions you might have. We look forward to hearing from you.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.6,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Contact details with staggered animations
          _buildAnimatedContactDetail(
            Icons.phone_rounded,
            "Call Us",
            "+1 (555) 123-4567",
            "Available 24/7",
            _staggeredAnimation1,
            Colors.green,
          ),

          const SizedBox(height: 24),

          _buildAnimatedContactDetail(
            Icons.email_rounded,
            "Email Us",
            "contact@healthcare.com",
            "Quick response guaranteed",
            _staggeredAnimation2,
            Colors.blue,
          ),

          const SizedBox(height: 24),

          _buildAnimatedContactDetail(
            Icons.location_on_rounded,
            "Visit Us",
            "123 Healthcare Street",
            "City, State 12345",
            _staggeredAnimation3,
            Colors.purple,
          ),

          if (Responsive.isMobile(context)) const SizedBox(height: 32),

          // Social media links
          if (!Responsive.isMobile(context)) ...[
            const SizedBox(height: 40),
            FadeTransition(
              opacity: _staggeredAnimation3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Follow Us",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildSocialButton(Icons.facebook, Colors.blue.shade700),
                      const SizedBox(width: 12),
                      _buildSocialButton(Icons.alternate_email, Colors.lightBlue),
                      const SizedBox(width: 12),
                      _buildSocialButton(Icons.phone_android, Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnimatedContactDetail(
      IconData icon,
      String title,
      String detail,
      String subtitle,
      Animation<double> animation,
      Color iconColor,
      ) {
    return FadeTransition(
      opacity: animation,
      child: Transform.translate(
        offset: Offset(0, (1 - animation.value) * 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: iconColor.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: iconColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [iconColor, iconColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    const SizedBox(height: 4),
                    MyText(
                      title: detail,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Icon(
        icon,
        color: color,
        size: 22,
      ),
    );
  }

  Widget _buildBookAppointmentForm() {
    return Transform.translate(
      offset: Offset(0, _formSlideAnimation.value),
      child: Container(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 18 : 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [MyColors.primaryColor, Colors.blue.shade600],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Book Appointment",
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 20 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Schedule your visit with us",
                        style: TextStyle(
                          fontSize: Responsive.isMobile(context) ? 12 : 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Form fields
              if (Responsive.isMobile(context))
                _buildMobileFormFields()
              else
                _buildDesktopFormFields(),

              const SizedBox(height: 24),

              _buildEnhancedTextField(
                controller: _messageController,
                label: "Message",
                hint: "Tell us about your symptoms or concerns...",
                maxLines: 4,
                icon: Icons.message_rounded,
              ),

              const SizedBox(height: 32),

              // Submit button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileFormFields() {
    return Column(
      children: [
        _buildEnhancedTextField(
          controller: _nameController,
          label: "Full Name",
          hint: "Enter your full name",
          icon: Icons.person_rounded,
        ),
        const SizedBox(height: 20),
        _buildEnhancedTextField(
          controller: _emailController,
          label: "Email",
          hint: "Enter your email address",
          icon: Icons.email_rounded,
        ),
        const SizedBox(height: 20),
        _buildEnhancedTextField(
          controller: _phoneController,
          label: "Phone Number",
          hint: "Enter your phone number",
          icon: Icons.phone_rounded,
        ),
        const SizedBox(height: 20),
        _buildEnhancedTextField(
          controller: _addressController,
          label: "Address",
          hint: "Enter your address",
          icon: Icons.location_on_rounded,
        ),
      ],
    );
  }

  Widget _buildDesktopFormFields() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildEnhancedTextField(
                controller: _nameController,
                label: "Full Name",
                hint: "Enter your full name",
                icon: Icons.person_rounded,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildEnhancedTextField(
                controller: _emailController,
                label: "Email",
                hint: "Enter your email address",
                icon: Icons.email_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildEnhancedTextField(
                controller: _phoneController,
                label: "Phone Number",
                hint: "Enter your phone number",
                icon: Icons.phone_rounded,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildEnhancedTextField(
                controller: _addressController,
                label: "Address",
                hint: "Enter your address",
                icon: Icons.location_on_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEnhancedTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: MyColors.primaryColor.withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: MyColors.primaryColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: maxLines > 1 ? 16 : 12,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.primaryColor, Colors.blue.shade600],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: MyColors.primaryColor.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _isSubmitting ? null : _handleSubmit,
          child: Container(
            alignment: Alignment.center,
            child: _isSubmitting
                ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "Submitting...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
                : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  "Book Appointment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Appointment request submitted successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

        // Clear form
        _formKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _addressController.clear();
        _messageController.clear();
      }
    }
  }

  double _getContainerWidth(double screenWidth) {
    if (Responsive.isMobile(context)) return screenWidth * 0.95;
    if (Responsive.isTablet(context)) return screenWidth * 0.9;
    return screenWidth * 0.85;
  }
}



// import 'package:doctor_demo/res/components/my_text.dart';
// import 'package:doctor_demo/res/components/my_text_button.dart';
// import 'package:doctor_demo/res/my_colors/my_colors.dart';
// import 'package:doctor_demo/res/responsive/responsive.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ContactSectionView extends StatelessWidget {
//   const ContactSectionView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final width = MediaQuery.of(context).size.width;
//
//     return Container(
//       width: Responsive.isMobile(context) ? width * 0.97 : Responsive.isTablet(context) ? width * 0.94 : width * 0.68,
//       padding: const EdgeInsets.all(16.0),
//       child: Responsive.isMobile(context) ? Column(
//         children: [
//           _buildContactUsSection(context),
//           const SizedBox(height: 32),
//           _buildBookAppointmentForm(context),
//         ],
//       ) : Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: _buildContactUsSection(context),
//           ),
//           const SizedBox(width: 32),
//           Expanded(
//             flex: 2,
//             child: _buildBookAppointmentForm(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// Widget _buildContactUsSection(BuildContext context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const MyText(title: "Contact Us",fontSize: 30,fontWeight: FontWeight.bold,color: MyColors.primaryColor,),
//       const SizedBox(height: 8),
//       MyText(title: "Make An\nAppointment",fontSize: Responsive.isMobile(context) ? 50 : 60,fontWeight: FontWeight.w800,fontFamily: 'Oswald',letterSpacing: 2,),
//       const SizedBox(height: 8),
//       Text(
//         "Feel free to ask something we are here",
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.grey[600],
//         ),
//       ),
//       const SizedBox(height: 32),
//       _buildContactDetail(Icons.phone, "Call Us At", "(+00) 000000000"),
//       const SizedBox(height: 16),
//       _buildContactDetail(Icons.email, "Email Us On", "clinicName@gmail.com.com"),
//       const SizedBox(height: 16),
//       _buildContactDetail(Icons.location_on, "Address", "111 city street etc"),
//     ],
//   );
// }
//
// Widget _buildContactDetail(IconData icon, String title, String detail) {
//   return Row(
//     children: [
//       CircleAvatar(
//         radius: 24,
//         backgroundColor: Colors.blue,
//         child: Icon(
//           icon,
//           color: Colors.white,
//         ),
//       ),
//       const SizedBox(width: 16),
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           MyText(title: title,fontSize: 21,fontWeight: FontWeight.bold,),
//           MyText(title: detail,fontSize: 17,fontWeight: FontWeight.bold,color: MyColors.blackColor.withOpacity(0.6),),
//         ],
//       ),
//     ],
//   );
// }
//
// Widget _buildBookAppointmentForm(BuildContext context) {
//
//   return Container(
//     padding: EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16),
//     decoration: BoxDecoration(
//       color: Colors.grey.withOpacity(0.1),
//       borderRadius: BorderRadius.circular(12),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Book Appointment",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Responsive.isMobile(context) ? Column(
//           children: [
//             _buildTextField("Name"),
//             const SizedBox(height: 16),
//             _buildTextField("Email"),
//             const SizedBox(height: 16),
//             _buildTextField("Number"),
//             const SizedBox(height: 16),
//             _buildTextField("Address"),
//           ],
//         ) : Row(
//           children: [
//             Expanded(
//               child: _buildTextField("Name"),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildTextField("Email"),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Responsive.isMobile(context) ? const SizedBox() : Row(
//           children: [
//             Expanded(
//               child: _buildTextField("Number"),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: _buildTextField("Address"),
//             ),
//           ],
//         ),
//         SizedBox(height: Responsive.isMobile(context) ? 8 : 16),
//         _buildTextField("Message", maxLines: 4),
//         const SizedBox(height: 24),
//         const MyTextButton(title: "Submit",fontSize: 18,fontWeight: FontWeight.bold,backgroundColor: MyColors.primaryColor,textColor: CupertinoColors.white,width: 124,height: 38,borderRadius: 8,)
//       ],
//     ),
//   );
// }
//
// Widget _buildTextField(String label, {int maxLines = 1}) {
//   return TextField(
//     maxLines: maxLines,
//     decoration: InputDecoration(
//       labelText: label,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//         borderSide: BorderSide.none
//       ),
//
//       filled: true,
//       fillColor: Colors.white,
//     ),
//   );
// }
