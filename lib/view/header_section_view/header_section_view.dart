import 'package:doctor_demo/l10n/app_localizations.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageProvider = StateProvider<Locale>((ref) {
  return Locale('ar');
});


class HeaderSectionView extends ConsumerStatefulWidget {
  const HeaderSectionView({
    super.key,
    this.homeOnTap,
    required this.aboutOnTap,
    required this.servicesOnTap,
    required this.ourExpertOnTap,
    required this.drawertOnTap,
    required this.bookNowOnTap,
    this.onLanguageChanged,
  });

  final void Function()? homeOnTap;
  final void Function()? aboutOnTap;
  final void Function()? servicesOnTap;
  final void Function()? ourExpertOnTap;
  final void Function()? drawertOnTap;
  final void Function()? bookNowOnTap;
  final void Function(String language)? onLanguageChanged;

  @override
  ConsumerState<HeaderSectionView> createState() => _HeaderSectionViewState();
}

class _HeaderSectionViewState extends ConsumerState<HeaderSectionView>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _menuSlideAnimation;

  int _hoveredIndex = -1;
  bool _isLanguageDropdownOpen = false;
  String _selectedLanguage = 'Arabic'; // Initialize based on default locale

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _headerFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
    ));

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _menuSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      _headerController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch the current locale from the provider
    final currentLocale = ref.watch(languageProvider);

    // Update _selectedLanguage based on current locale
    _selectedLanguage = currentLocale.languageCode == 'en' ? 'English' : 'Arabic';

    return FadeTransition(
      opacity: _headerFadeAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.primaryColor,
              MyColors.primaryColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        height: Responsive.isMobile(context) ? 70 : 100,
        width: MediaQuery.of(context).size.width,
        child: Responsive.isMobile(context)
            ? _buildMobileHeader()
            : _buildDesktopHeader(),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return SlideTransition(
      position: _logoSlideAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo section
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 32,
                    height: 32,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: MyColors.primaryColor,
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                MyText(
                  title: AppLocalizations.of(context)!.dentist,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: MyColors.whiteColor,
                ),
              ],
            ),
            // Menu button and language
            Row(
              children: [
                _buildLanguageDropdown(),
                const SizedBox(width: 8),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.drawertOnTap,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu,
                        size: 28,
                        color: MyColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo section
          SlideTransition(
            position: _logoSlideAnimation,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.local_hospital,
                          color: MyColors.primaryColor,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: AppLocalizations.of(context)!.dentist,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: MyColors.whiteColor,
                    ),
                    MyText(
                      title: AppLocalizations.of(context)!.careAndSmile,
                      fontSize: 12,
                      color: MyColors.whiteColor.withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Navigation menu
          SlideTransition(
            position: _menuSlideAnimation,
            child: Row(
              children: [
                _buildNavItem(AppLocalizations.of(context)!.home, 0, widget.homeOnTap),
                const SizedBox(width: 32),
                _buildNavItem(AppLocalizations.of(context)!.aboutUs, 1, widget.aboutOnTap),
                const SizedBox(width: 32),
                _buildNavItem(AppLocalizations.of(context)!.services, 2, widget.servicesOnTap),
                const SizedBox(width: 32),
                _buildNavItem(AppLocalizations.of(context)!.ourExperts, 3, widget.ourExpertOnTap),
                const SizedBox(width: 30),
                _buildAppointmentButton(widget.bookNowOnTap),
                const SizedBox(width: 20),
                _buildLanguageDropdown(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return PopupMenuButton<String>(
      onSelected: (String language) {
        // Update the Riverpod provider with the new locale
        ref.read(languageProvider.notifier).state =
        language == 'English' ? const Locale('en') : const Locale('ar');

        // Call the callback if provided
        if (widget.onLanguageChanged != null) {
          widget.onLanguageChanged!(language == 'English' ? 'en' : 'ar');
        }
      },
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.translate,
              color: Colors.white,
              size: 20,
            ),
            if (!Responsive.isMobile(context)) ...[
              const SizedBox(width: 6),
              MyText(
                title: _selectedLanguage == 'English' ? 'EN' : 'AR',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 16,
              ),
            ],
          ],
        ),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<String>(
          value: 'English',
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.blue.shade100,
                  ),
                  child: Center(
                    child: Text(
                      '🇺🇸',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                MyText(
                  title: 'English',
                  fontSize: 16,
                  color: MyColors.primaryColor,
                  fontWeight: _selectedLanguage == 'English'
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
                if (_selectedLanguage == 'English') ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: MyColors.primaryColor,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Arabic',
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.green.shade100,
                  ),
                  child: Center(
                    child: Text(
                      '🇸🇦',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                MyText(
                  title: 'العربية',
                  fontSize: 16,
                  color: MyColors.primaryColor,
                  fontWeight: _selectedLanguage == 'Arabic'
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
                if (_selectedLanguage == 'Arabic') ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: MyColors.primaryColor,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(String title, int index, VoidCallback? onTap) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
            ),
            child: MyText(
              title: title,
              fontSize: 18,
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              color: MyColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentButton(void Function()? onPressed) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: MyColors.primaryColor,
            elevation: 4,
            shadowColor: Colors.black.withOpacity(0.3),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: MyColors.primaryColor,
              ),
              const SizedBox(width: 8),
              MyText(
                title: AppLocalizations.of(context)!.bookNow,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}