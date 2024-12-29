import 'package:flutter/material.dart';

import '../../../../core/theme/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          gradient: const LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shadowColor: AppPallete.transparentColor,
            backgroundColor: AppPallete.transparentColor,
            fixedSize: const Size(395, 55)),
        child: Text(
          buttonText,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
