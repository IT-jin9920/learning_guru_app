import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String message;
  final String time;
  final bool showNotification;

  const ChatItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.message,
    required this.time,
    this.showNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(imagePath),
          ),
          if (showNotification)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF03002F),
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
