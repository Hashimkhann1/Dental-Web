import 'package:doctor_demo/l10n/app_localizations.dart';
import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ExpertDoctorCard extends StatefulWidget {
  final String name;
  final String title;
  final String imagePath;
  final bool isActive;

  const ExpertDoctorCard({
    super.key,
    required this.name,
    required this.title,
    required this.imagePath,
    this.isActive = false,
  });

  @override
  State<ExpertDoctorCard> createState() => _ExpertDoctorCardState();
}

class _ExpertDoctorCardState extends State<ExpertDoctorCard>
    with TickerProviderStateMixin {

  late AnimationController _hoverController;
  late AnimationController _tapController;
  late AnimationController _pulseController;

  late Animation<double> _overlayAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<Color?> _shadowColorAnimation;

  bool _isExpanded = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startPulseAnimation();
  }

  void _initializeAnimations() {
    // Hover animation controller
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Tap animation controller
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Pulse animation controller for inactive cards
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Overlay animation (for tap reveal)
    _overlayAnimation = Tween<double>(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(
        parent: _tapController,
        curve: Curves.easeInOut,
      ),
    );

    // Scale animation (for hover effect)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOut,
      ),
    );

    // Text opacity animation
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _tapController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    // Slide animation for text
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _tapController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack),
      ),
    );

    // Pulse animation
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Border radius animation
    _borderRadiusAnimation = Tween<double>(begin: 12.0, end: 20.0).animate(
      CurvedAnimation(
        parent: _hoverController,
        curve: Curves.easeOut,
      ),
    );

    // Shadow color animation
    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: Colors.blue.withOpacity(0.3),
    ).animate(_hoverController);
  }

  void _startPulseAnimation() {
    if (!widget.isActive) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  void didUpdateWidget(ExpertDoctorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _startPulseAnimation();
    }
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _tapController.forward();
        _pulseController.stop();
      } else {
        _tapController.reverse();
        if (!widget.isActive) _startPulseAnimation();
      }
    });
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
      if (hovering) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _hoverController,
        _tapController,
        _pulseController,
      ]),
      builder: (context, child) {
        return MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: GestureDetector(
            onTap: _handleTap,
            child: Transform.scale(
              scale: widget.isActive
                  ? _scaleAnimation.value
                  : _pulseAnimation.value * _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
                  boxShadow: [
                    BoxShadow(
                      color: _shadowColorAnimation.value ?? Colors.black.withOpacity(0.1),
                      blurRadius: _isHovering ? 25 : 15,
                      offset: Offset(0, _isHovering ? 15 : 8),
                      spreadRadius: _isHovering ? 2 : 0,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    _buildBackgroundImage(),
                    _buildGradientOverlay(),
                    _buildAnimatedOverlay(),
                    _buildCardContent(),
                    if (!_isExpanded) _buildTapHint(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned.fill(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Image.network(
          widget.imagePath,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey.shade200,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                  color: Colors.blue.shade600,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child: const Center(
                child: Icon(
                  Icons.error_outline,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.3),
              Colors.black.withOpacity(0.7),
            ],
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(_overlayAnimation.value * 0.3),
              Colors.purple.withOpacity(_overlayAnimation.value * 0.4),
              Colors.black.withOpacity(_overlayAnimation.value * 0.6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isExpanded) _buildExpandedContent(),
            _buildBasicInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Transform.translate(
      offset: Offset(0, _slideAnimation.value),
      child: FadeTransition(
        opacity: _textOpacityAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About ${widget.name.split(' ').first}",
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Dedicated healthcare professional with extensive experience in ${widget.title.toLowerCase()}. Committed to providing exceptional patient care with the latest medical techniques and technologies.",
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 13 : 14,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade600,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "4.9/5 Rating",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Available",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: widget.name,
          fontSize: Responsive.isMobile(context) ? 20 : 24,
          fontWeight: FontWeight.bold,
          color: MyColors.whiteColor,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade600.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: MyText(
            title: widget.title,
            fontSize: Responsive.isMobile(context) ? 12 : 14,
            fontWeight: FontWeight.w500,
            color: MyColors.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTapHint() {
    return Positioned(
      top: 16,
      right: 16,
      child: AnimatedOpacity(
        opacity: _isHovering ? 1.0 : 0.7,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.touch_app,
                size: 16,
                color: Colors.grey.shade700,
              ),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context)!.tapForDetails,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}