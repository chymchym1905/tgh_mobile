import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.message});
  final List<String> message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset('assets/icons/Qiqidead.jpg'),
          Text(message.join('\n')),
        ],
      ),
    );
  }
}
