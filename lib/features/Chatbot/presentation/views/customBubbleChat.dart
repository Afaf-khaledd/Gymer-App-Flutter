import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymer/core/components/BoldTextWidget.dart';
import 'package:gymer/core/utils/colors.dart';
import 'package:gymer/features/Chatbot/data/models/messageModel.dart';
import '../../../../core/utils/assets.dart';

class CustomBubbleChat extends StatefulWidget {
  final MessageModel msg;
  const CustomBubbleChat({super.key, required this.msg});

  @override
  State<CustomBubbleChat> createState() => _CustomBubbleChatState();
}

class _CustomBubbleChatState extends State<CustomBubbleChat> {
  String? selectedVideoUrl;
  int? selectedVideoIndex;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 2),
      child: Column(
        crossAxisAlignment: widget.msg.role == MessageRole.user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: widget.msg.role == MessageRole.user
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.msg.role == MessageRole.bot)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        AssetsManager.chatbotIcon,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 11),
                  decoration: BoxDecoration(
                    color: widget.msg.role == MessageRole.user
                        ? Color.fromRGBO(215, 179, 101, 0.2)
                        : const Color.fromRGBO(230, 232, 233, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: widget.msg.role == MessageRole.user
                      ? SelectableText(
                    widget.msg.message,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: ColorsManager.goldColorO1,
                    ),
                  )
                      : BoldTextWidget(text: widget.msg.message),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          if (widget.msg.video != null && widget.msg.video!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 24),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.msg.video!.asMap().entries.map((entry) {
                    String videoUrl = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        videoUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}