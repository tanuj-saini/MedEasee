import 'package:flutter/material.dart';

class CustomizableElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color buttonColor;
  final String buttonText;

  const CustomizableElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.buttonText,
  });

  @override
  _CustomizableElevatedButtonState createState() =>
      _CustomizableElevatedButtonState();
}

class _CustomizableElevatedButtonState extends State<CustomizableElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(
        onPressed: () {
          _animationController.forward();
          widget.onPressed();
          Future.delayed(Duration(milliseconds: 200), () {
            _animationController.reverse();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            widget.buttonText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 19.0,
            ),
          ),
        ),
      ),
    );
  }
}
