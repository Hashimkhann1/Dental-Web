import 'package:doctor_demo/res/components/my_text.dart';
import 'package:doctor_demo/res/my_colors/my_colors.dart';
import 'package:doctor_demo/res/responsive/responsive.dart';
import 'package:flutter/material.dart';

class MyServicesCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final int index;
  final Animation<double> cardAnimation;
  final Animation<Offset> slideAnimation;

  const MyServicesCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.index,
    required this.cardAnimation,
    required this.slideAnimation,
  });

  @override
  State<MyServicesCard> createState() => _MyServicesCardState();
}

class _MyServicesCardState extends State<MyServicesCard>
    with TickerProviderStateMixin {

  late AnimationController _hoverController;
  late AnimationController _tapController;
  late AnimationController _shimmerController;

  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<double> _borderAnimation;
  late Animation<Color?> _shadowColorAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _backgroundAnimation;

  bool _isHovered = false;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startShimmerAnimation();
  }

  void _initializeAnimations() {
    // Hover animation controller
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Tap animation controller
    _tapController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Shimmer animation controller
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Elevation animation
    _elevationAnimation = Tween<double>(begin: 8, end: 25).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );

    // Scale animation
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );

    // Icon scale animation
    _iconScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.elasticOut),
    );

    // Border animation
    _borderAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );

    // Shadow color animation
    _shadowColorAnimation = ColorTween(
      begin: Colors.black.withOpacity(0.1),
      end: widget.color.withOpacity(0.3),
    ).animate(_hoverController);

    // Shimmer animation
    _shimmerAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    // Background animation
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOut),
    );
  }

  void _startShimmerAnimation() {
    Future.delayed(Duration(milliseconds: 1000 + (widget.index * 200)), () {
      if (mounted) {
        _shimmerController.forward().then((_) {
          if (mounted) {
            _shimmerController.reset();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _tapController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
      if (hovering) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    });
  }

  void _handleTap() {
    setState(() {
      _isTapped = true;
    });

    _tapController.forward().then((_) {
      if (mounted) {
        _tapController.reverse().then((_) {
          if (mounted) {
            setState(() {
              _isTapped = false;
            });
          }
        });
      }
    });

    // Handle service selection logic here
    _showServiceDetails();
  }

  void _showServiceDetails() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: Responsive.isDesktop(context) ? 600 : Responsive.isTablet(context) ? 500 : MediaQuery.of(context).size.width * 0.88,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                widget.color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [widget.color.withOpacity(0.1), widget.color.withOpacity(0.05)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: Responsive.isMobile(context) ? 30 : 48,
                ),
              ),
              SizedBox(height: Responsive.isMobile(context) ? 16 : 20),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 20 : 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Close"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Handle booking logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Book Now",
                        style: TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        widget.cardAnimation,
        _hoverController,
        _tapController,
        _shimmerController,
      ]),
      builder: (context, child) {
        return SlideTransition(
          position: widget.slideAnimation,
          child: FadeTransition(
            opacity: widget.cardAnimation,
            child: Transform.scale(
              scale: (0.7 + (0.3 * widget.cardAnimation.value)) *
                  _scaleAnimation.value *
                  (_isTapped ? 0.98 : 1.0),
              child: MouseRegion(
                onEnter: (_) => _handleHover(true),
                onExit: (_) => _handleHover(false),
                child: GestureDetector(
                  onTap: _handleTap,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: _shadowColorAnimation.value ?? Colors.black.withOpacity(0.1),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value / 2),
                          spreadRadius: _isHovered ? 2 : 0,
                        ),
                        if (_isHovered)
                          BoxShadow(
                            color: widget.color.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                            spreadRadius: 5,
                          ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Main card content
                          _buildCardContent(),

                          // Shimmer effect
                          _buildShimmerEffect(),

                          // Hover border effect
                          _buildHoverBorder(),

                          // Gradient overlay on hover
                          _buildGradientOverlay(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardContent() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and action button row
          Row(
            children: [
              Transform.scale(
                scale: _iconScaleAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.color.withOpacity(0.15),
                        widget.color.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.color.withOpacity(0.2),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.color,
                    size: 32,
                  ),
                ),
              ),
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? widget.color.withOpacity(0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered
                        ? widget.color.withOpacity(0.3)
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: _isHovered ? widget.color : Colors.grey.shade600,
                  size: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Title with enhanced styling
          MyText(
            title: widget.title,
            fontSize: Responsive.isMobile(context) ? 18 : 20,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),

          const SizedBox(height: 12),

          // Description
          Expanded(
            child: MyText(
              title: widget.description,
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 20),

          // Enhanced action button
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: _handleTap,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.grey.shade700,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      MyText(
                        title: "Learn More",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        if (_shimmerAnimation.value == -1.0) return const SizedBox.shrink();

        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.3),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
                begin: Alignment(-1.0 + _shimmerAnimation.value, -1.0),
                end: Alignment(1.0 + _shimmerAnimation.value, 1.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHoverBorder() {
    return AnimatedBuilder(
      animation: _borderAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: widget.color.withOpacity(_borderAnimation.value * 0.5),
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientOverlay() {
    return AnimatedBuilder(
      animation: _backgroundAnimation,
      builder: (context, child) {
        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  widget.color.withOpacity(_backgroundAnimation.value * 0.03),
                  Colors.transparent,
                  widget.color.withOpacity(_backgroundAnimation.value * 0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    );
  }
}