import 'package:flutter/material.dart';
import 'package:signclock/chats/model/chat_model.dart';
import 'package:signclock/constant/theme.dart';

class ChatListItem extends StatelessWidget {
  final ChatModel item;
  final void Function() onPressed;

  const ChatListItem({super.key, required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.account_circle, size: 50.0),
      title: Text(item.name ?? "--"),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              item.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      trailing: item.notReaded > 0
          ? Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  item.notReaded.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            )
          : null,
      onTap: () => onPressed(),
    );
  }
}
