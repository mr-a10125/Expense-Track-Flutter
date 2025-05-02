import 'package:flutter/material.dart';
import '../constants.dart';

class LoadingButton extends StatelessWidget {

  final String title;
  final bool isLoading;
  final VoidCallback onTap;

  const LoadingButton({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryThemeColor,
          ),
          child: Center(
            child: isLoading? Image.asset(
              'assets/animations/btn_loading_gif.gif',
              width: 50,
              height: 50,
            ): Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
