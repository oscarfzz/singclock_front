import 'package:flutter/material.dart';
import 'package:signclock/constant/theme.dart';
import 'package:signclock/widgets/header_logo_layout.dart';
import 'dart:math' as math;

import '../model/chat_model.dart';

// ignore: must_be_immutable
class ChatView extends StatefulWidget {
  ChatModel group;

  ChatView({super.key, required this.group});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _inputMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderLogoLayout(
        child: LayoutBuilder(builder: ((context, constraints) {
      final double width = constraints.maxWidth * 0.9;
      final double top = constraints.maxHeight - 65;
      final double left = (constraints.maxWidth - width) / 2;

      return Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              top: top,
              left: left,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, top: 5, bottom: 5, right: 2),
                width: width,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 128),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputMessageController,
                        cursorColor: kPrimaryColor,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          hintText: 'Escribe algo...',
                          contentPadding: EdgeInsets.all(0),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(left: 4, bottom: 4),
                      icon: Transform.rotate(
                        angle: -45 * math.pi / 180,
                        child: const Icon(
                          Icons.send,
                        ),
                      ),
                      iconSize: 22,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: kPrimaryColor, // <-- Button color
                        foregroundColor: Colors.white, // <-- Splash color
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              )),
        ],
      );
    })));
  }
}
