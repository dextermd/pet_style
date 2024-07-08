import 'package:flutter/material.dart';
import 'package:pet_style/core/theme/colors.dart';

class AppBarBack extends StatelessWidget implements PreferredSizeWidget {
  final Function() onPressed;
  final String title;

  const AppBarBack({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_back_ios),
      ),
      backgroundColor: AppColors.primarySecondElement,
      title: Text(title),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}