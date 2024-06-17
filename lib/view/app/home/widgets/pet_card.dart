import 'package:flutter/material.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/view/widget/base_container.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset('assets/images/petp.jpeg'),
          ),
          
        ],
      ),
    );
  }
}

class AddPetCard extends StatelessWidget {
  const AddPetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
            width: 1,
            color: AppColors.primaryHintText,
            style: BorderStyle.solid),
      ),
      child: const Center(
        child: Icon(Icons.add_circle_rounded),
      ),
    );
  }
}
