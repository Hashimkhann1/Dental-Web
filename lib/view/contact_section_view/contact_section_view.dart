import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:doctor_demo/view_model/contact_view_model/contact_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

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
  final _dateController = TextEditingController(); // Added date controller

  DateTime? _selectedDate; // Added selected date variable
  late ContactBloc _contactBloc;

  @override
  void initState() {
    super.initState();
    _contactBloc = ContactBloc();
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
    _dateController.dispose(); // Added dispose for date controller
    _contactBloc.close();
    super.dispose();
  }

  // Added date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: _contactBloc,
      child: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactError) {
            ContactBloc.showErrorDialog(context, state.error);
          } else if (state is FormSubmitted) {
            ContactBloc.showSuccessSnackBar(context);
            // Clear form
            _formKey.currentState!.reset();
            _nameController.clear();
            _emailController.clear();
            _phoneController.clear();
            _addressController.clear();
            _messageController.clear();
            _dateController.clear(); // Added clear for date controller
            _selectedDate = null; // Reset selected date
          } else if (state is FormSubmissionError) {
            ContactBloc.showErrorDialog(context, state.error);
          }
        },
        child: AnimatedBuilder(
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
        ),
      ),
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
            "What's App Us",
            "+92 313 9217887",
            "Available 24/7",
            _staggeredAnimation1,
            Colors.green,
            onTap: _handleWhatsAppTap,
          ),

          const SizedBox(height: 24),

          _buildAnimatedContactDetail(
            Icons.email_rounded,
            "Email Us",
            "hmk182002@gmail.com",
            "Quick response guaranteed",
            _staggeredAnimation2,
            Colors.blue,
            onTap: _handleEmailTap,
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

  // Handle WhatsApp tap
  void _handleWhatsAppTap() {
    _contactBloc.add(LaunchWhatsAppEvent());
  }

  // Handle Email tap
  void _handleEmailTap() {
    _contactBloc.add(LaunchEmailEvent());
  }

  Widget _buildAnimatedContactDetail(
      IconData icon,
      String title,
      String detail,
      String subtitle,
      Animation<double> animation,
      Color iconColor, {
        VoidCallback? onTap,
      }) {
    return FadeTransition(
      opacity: animation,
      child: Transform.translate(
        offset: Offset(0, (1 - animation.value) * 20),
        child: GestureDetector(
          onTap: onTap,
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
                if (onTap != null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade400,
                    size: 16,
                  ),
              ],
            ),
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

              const SizedBox(height: 20),

              // Date picker field
              _buildDatePickerField(),

              const SizedBox(height: 20),

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

  // Added date picker field widget
  Widget _buildDatePickerField() {
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
        controller: _dateController,
        readOnly: true,
        onTap: () => _selectDate(context),
        decoration: InputDecoration(
          labelText: "Appointment Date",
          hintText: "Select your preferred date",
          prefixIcon: Icon(
            Icons.calendar_today_rounded,
            color: MyColors.primaryColor.withOpacity(0.7),
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an appointment date';
          }
          return null;
        },
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
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final isSubmitting = state is FormSubmitting;

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
              onTap: isSubmitting ? null : _handleSubmit,
              child: Container(
                alignment: Alignment.center,
                child: isSubmitting
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
      },
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _contactBloc.add(SubmitFormEvent(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        message: _messageController.text,
        appointmentDate: _selectedDate!,
      ));
    }
  }

  double _getContainerWidth(double screenWidth) {
    if (Responsive.isMobile(context)) return screenWidth * 0.95;
    if (Responsive.isTablet(context)) return screenWidth * 0.9;
    return screenWidth * 0.85;
  }
}