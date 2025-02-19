import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/utils/assets.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Chatbot/data/models/messageModel.dart';
import 'package:gymer/features/Chatbot/presentation/views/customBubbleChat.dart';
import 'package:gymer/features/Chatbot/presentation/views/initChatbotScreen.dart';

import '../view model/chatCubit/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  final String sessionId;
  const ChatScreen({super.key, required this.sessionId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().loadChatHistory(widget.sessionId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(messageText);
      messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => const InitChatbotScreen(),
        ),
        );}, icon: Icon(Icons.arrow_back_ios_rounded)),
        toolbarHeight: 90,
        elevation: 0,
        title: ListTile(
          title: Text(
            'GymTron',
            style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          subtitle: Row(
            children: [
              const Icon(Icons.circle_rounded, size: 10, color: Colors.green),
              const SizedBox(width: 3),
              Text(
                'Always active',
                style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: const Color.fromRGBO(114, 119, 122, 1)),
              ),
            ],
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.asset(
                AssetsManager.chatbotIcon,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List<MessageModel> messages = [];

                if (state is ChatHistoryLoaded || state is SendMessageSuccess) {
                  messages = state is ChatHistoryLoaded
                      ? state.messages
                      : (state as SendMessageSuccess).messages;
                } else if (state is ChatbotLoadingRes) {
                  messages = state.messages;
                } else if(state is ChatFailure){
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.redAccent, size: 50),
                        const SizedBox(height: 10),
                        Text(
                          "Something went wrong!",
                          style: GoogleFonts.dmSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => context.read<ChatCubit>().loadChatHistory(widget.sessionId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.goldColorO1,
                          ),
                          child: Text("Retry",style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),

                          ),
                      ],
                    ),
                  );
                }
                if (_scrollController.hasClients) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return CustomBubbleChat(msg: messages[index]);
                  },
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 19),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(22),
                  borderSide: const BorderSide(color: ColorsManager.goldColorO1, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsManager.goldColorO1, width: 0.7),
              ),
              child: Center(
                child: IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded, color: ColorsManager.goldColorO1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}