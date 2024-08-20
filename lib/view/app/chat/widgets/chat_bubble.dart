import 'package:flutter/material.dart';
import 'package:pet_style/core/theme/colors.dart';

class ChatBubble extends StatefulWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.isCurrentUser
            ? AppColors.primaryStatusOk
            : AppColors.primarySecondElement,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 20),
      child: Text(
        widget.message,
        style: const TextStyle(
          color: AppColors.whiteText,
        ),
      ),
    );
  }
}
