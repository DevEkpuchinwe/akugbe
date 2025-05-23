import 'package:akugbe/screens/video_call.dart';
import 'package:akugbe/utils/navigator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../config/text_styles.dart';

class IndividualChat extends ConsumerStatefulWidget {
  const IndividualChat({super.key});

  @override
  ConsumerState createState() => _IndividualChatState();
}

class _IndividualChatState extends ConsumerState<IndividualChat> with AppNavigator {
  @override

  final TextEditingController _controller = TextEditingController();
  bool _isEmojiVisible = false; // Toggle for emoji keyboard
  FocusNode _focusNode = FocusNode();

  void _toggleEmojiKeyboard() {
    if (_isEmojiVisible) {
      _focusNode.requestFocus(); // Show normal keyboard
    } else {
      _focusNode.unfocus(); // Hide keyboard and show emoji picker
    }
    setState(() {
      _isEmojiVisible = !_isEmojiVisible;
    });
  }

  final List<Map<String, dynamic>> messages = [
    {"text": "Typing...", "isSent": false, "isTyping": true},
    {"text": "Yeah, It's really good!", "isSent": true},
    {"text": "Really?", "isSent": false},
    {"text": "I've tried the app", "isSent": true},
    {"text": "Hi, Evans", "isSent": true},
  ];

  Widget _chatBubble(String message, {required bool isSent}) {
    return Row(
      mainAxisAlignment:
      isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSent) _userAvatar(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          constraints: BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isSent ? Colors.black : Colors.grey[200],
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isSent ? Colors.white : Colors.black,
              fontSize: 14,
            ),
          ),
        ),
        if (isSent) _userAvatar(),
      ],
    );
  }

  Widget _userAvatar() {
    return CircleAvatar(
      radius: 12,
      backgroundImage: NetworkImage(
        "https://picsum.photos/id/237/200/300", // Replace with actual avatar image URL
      ),
    );
  }

  Widget _typingIndicator() {
    return Row(
      children: [
        _userAvatar(),
        SizedBox(width: 8),
        Text(
          "Typing...",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        config: Config(
          bottomActionBarConfig: BottomActionBarConfig(
            showSearchViewButton: false,
            backgroundColor: GlobalColors.whiteColor,
            buttonColor: Colors.grey,
            buttonIconColor: Colors.grey
          ),
          skinToneConfig: SkinToneConfig(enabled: true),
          searchViewConfig: SearchViewConfig(),
          categoryViewConfig: CategoryViewConfig(backgroundColor: GlobalColors.whiteColor),
          emojiViewConfig: EmojiViewConfig(

                columns: 8,
                emojiSizeMax: 28,
               backgroundColor: GlobalColors.whiteColor

          )
        ),
        onEmojiSelected: (category, emoji) {
          _controller.text += emoji.emoji;
        },
      ),
    );
  }

  Widget _messageInputField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
      controller: _controller,
          focusNode: _focusNode,
              decoration: InputDecoration(
                // suffixIcon: GestureDetector(
                //   onTap:_toggleEmojiKeyboard ,
                //     child: Icon(Icons.emoji_emotions_outlined, color: Colors.grey)),
                hintText: "Type your message",
                contentPadding:
                EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            5.verticalSpace,
            Row(
              children: [
                    GestureDetector(
                      onTap: (){
                        pop(context);
                      },
                        child: Icon(Icons.arrow_back_ios_new_rounded, size: 15,)),
                20.horizontalSpace,
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: 35,
                    height: 35,
                    child: ClipOval(
                      child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                          "https://picsum.photos/id/237/200/300"),
                    )),
                8.horizontalSpace,
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adeniyi Deborah",
                          style: smallNormalTextBold,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text("Online", style: smallNormalText!.copyWith(fontSize: 10), textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis)
                      ],
                    )),
                10.horizontalSpace,
                GestureDetector(
                  onTap: (){
                    pushTo(context, const VideoCall());
                  },
                    child: Icon(Icons.phone_outlined, color: GlobalColors.blackColor,))
              ],
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                reverse: true, // Makes messages start from bottom
                padding: EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if (message["isTyping"] == true) {
                    return _typingIndicator();
                  }
                  return _chatBubble(message["text"], isSent: message["isSent"]);
                },
              ),
            ),
            _messageInputField(),
            if (_isEmojiVisible) _buildEmojiPicker(),

          ],
        ),
      )),
    );
  }
}
