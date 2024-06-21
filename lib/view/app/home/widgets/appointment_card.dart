import 'package:flutter/material.dart';
import 'package:pet_style/core/theme/colors.dart';

class AppointmentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Image imageLeft;
  final Image imageRight;

  const AppointmentCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageLeft,
    required this.imageRight,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.containerColor.withOpacity(0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: imageLeft),
                Flexible(child: imageRight),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.primaryText.withOpacity(0.5),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            // add elevation button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryElement,
                  foregroundColor: AppColors.primaryLinkText,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Записаться',
                    style: TextStyle(fontSize: 14, color: AppColors.whiteText)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
