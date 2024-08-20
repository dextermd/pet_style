import 'package:flutter/material.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/view/app/chat/widgets/chat_bubble.dart';
import 'package:pet_style/view/widget/my_text_field.dart';

class ChatScreen extends StatefulWidget {
  final String? receiverId;

  const ChatScreen({
    super.key,
    this.receiverId = '1',
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Чат',
        ),
        backgroundColor: AppColors.primarySecondElement,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                      alignment: index % 2 == 0
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: index % 2 == 0
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          ChatBubble(
                            message: 'Hello',
                            isCurrentUser: index % 2 == 0,
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          Container(
            color: AppColors.primaryTransparent,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    child: MyTextField(
                      contentPadding: 14,
                      controller: _messageController,
                      hintText: 'Введите сообщение',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
