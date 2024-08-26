import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_style/blocs/chat_bloc/chat_bloc.dart';
import 'package:pet_style/core/services/storage_services.dart';
import 'package:pet_style/core/theme/colors.dart';
import 'package:pet_style/data/model/message/message.dart';
import 'package:pet_style/view/app/chat/widgets/chat_bubble.dart';
import 'package:pet_style/view/widget/my_text_field.dart';

class ChatScreen extends StatefulWidget {
  final String? receiverId;
  final String? senderId;

  const ChatScreen({
    super.key,
    this.receiverId,
    this.senderId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String? localSenderId = StorageServices.getString('user_id');

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ConnectToSocketEvent(
        senderId: widget.senderId ?? localSenderId ?? '',
        receiverId: widget.receiverId ?? '1'));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат'),
        backgroundColor: AppColors.primarySecondElement,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatLoadedState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                }
              },
              builder: (context, state) {
                if (state is ChatLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatLoadedState &&
                    state.messages!.isNotEmpty) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.messages!.length,
                    itemBuilder: (context, index) {
                      final message = state.messages![index];
                      final isCurrentUser =
                          message.from == (widget.senderId ?? localSenderId);
                      return ListTile(
                        title: Container(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ChatBubble(
                            message: message.text ?? '',
                            isCurrentUser: isCurrentUser,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Нет сообщений'),
                  );
                }
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
                  onPressed: () {
                    final message = Message(
                      text: _messageController.text,
                      from: widget.senderId ?? localSenderId ?? '',
                      to: widget.receiverId ?? '1',
                      status: 0,
                    );
                    context.read<ChatBloc>().add(SendMessageEvent(message));
                    _messageController.clear();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });
                  },
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
