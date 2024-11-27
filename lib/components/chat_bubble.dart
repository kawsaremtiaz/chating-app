import 'package:flutter/material.dart';
import 'package:kchat/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // light vs dark mode for correct bubble colors
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade500)
            : (isDarkMode ? Colors.grey.shade300 : Colors.grey.shade100),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
