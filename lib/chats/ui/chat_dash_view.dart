import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:intl/intl.dart';
import 'package:signclock/chats/model/request/create_chat_message_request.dart';
import 'package:signclock/chats/utils/dio_client.dart';

import 'package:signclock/api_services/messages_service.dart';

import '../../blocs/auth_hydrated/auth_hy_bloc.dart';
import '../../constant/theme.dart';
import '../../widgets/header_logo_layout.dart';

import '../model/chat_model.dart';

// ignore: must_be_immutable
class ChatDashView extends StatefulWidget {
  final ChatModel chat;

  const ChatDashView({super.key, required this.chat});

  @override
  State<ChatDashView> createState() => _ChatDashViewState();
}

class _ChatDashViewState extends State<ChatDashView> {
  late final ChatUser _actualUser;
  final List<ChatMessage> _messages = [];
  bool _isLoaded = false;

  late final AuthHyBloc _authHyBloc;
  late final MessageService _messageService;

  @override
  void initState() {
    super.initState();

    _authHyBloc = context.read<AuthHyBloc>();
    final dioClient = DioClient(_authHyBloc);
    _messageService = MessageService(dioClient.instance, _authHyBloc);
    _initializeUser();
    _loadMessages();
  }

  void _initializeUser() {
    _actualUser = ChatUser(
      id: _authHyBloc.state.user!.phoneId.toString(),
      firstName: _authHyBloc.state.user!.userName,
    );
  }

  Future<void> _loadMessages() async {
    try {
      final response = await _messageService.getChatMessages(
          chatId: widget.chat.chatId, page: 1, lastMessage: 0);

      if (response.data == null || response.data!.isEmpty) {
        _showErrorMessage('Sin mensajes.');
        setState(() => _isLoaded = true);
        return;
      }

      if (response.status == "error") {
        _showErrorMessage(response.msg);
        return;
      }

      setState(() {
        _messages
          ..clear()
          ..addAll(response.data!)
          ..sort((a, b) =>
              b.createdAt.compareTo(a.createdAt)); // Orden descendente

        _isLoaded = true;
      });
    } catch (error) {
      _showErrorMessage('Error inesperado, disculpe las molestias.');
    }
  }

  void _sendMessage(ChatMessage message) async {
    CreateChatMessageRequest request = CreateChatMessageRequest(
      chatId: widget.chat.chatId,
      message: message.text,
      userId: _authHyBloc.state.user!.phoneId,
      crud: "C",
    );

    try {
      final response = await _messageService.createMessage(
          message: request.message, chatId: request.chatId);

      if (response.status == "error") {
        _showErrorMessage(response.msg);
        return;
      }

      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: request.message,
            user: _actualUser,
            createdAt: DateTime.now(),
          ),
        );
      });
    } catch (error) {
      _showErrorMessage('Error en nuevo mensaje, disculpe las molestias.');
    }
  }

  void _showErrorMessage(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildMessagesList() {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoaded = false);
        await _loadMessages();
      },
      child: _isLoaded
          ? DashChat(
              currentUser: _actualUser,
              messageListOptions: MessageListOptions(
                  onLoadEarlier: () async {
                    if (kDebugMode) {
                      print('Solicitar mensajes más  viejos');
                    }
                  },
                  showDateSeparator: true,
                  dateSeparatorBuilder: (date) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        DateFormat.yMMMd().format(date),
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
              onSend: _sendMessage,
              messageOptions: MessageOptions(
                messageTextBuilder: (message, previousMessage, nextMessage) {
                  return Column(
                    crossAxisAlignment: message.user.id == _actualUser.id
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.text,
                        style: TextStyle(
                          color: message.user.id == _actualUser.id
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4), // Espacio entre texto y hora
                      Text(
                        DateFormat.Hm().format(message.createdAt),
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
                // messageTextBuilder: (message, previousMessage, nextMessage) {
                //   return Text(
                //     message.text,
                //     style: TextStyle(
                //       color: message.user.id == _actualUser.id
                //           ? Colors.white
                //           : Colors.black,
                //     ),
                //   );
                // },
                // // **Estilos Generales de los Mensajes**
                // containerColor:
                //     kPrimaryLightColor, // Color de fondo para otros usuarios
                // currentUserContainerColor:
                //     kPrimaryColor, // Color de fondo para el usuario actual
                // textColor: Colors.black87, // Color de texto para otros usuarios
                // currentUserTextColor:
                //     Colors.white, // Color de texto para el usuario actual

                // // **Padding y Margen de los Mensajes**
                // messagePadding:
                //     const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                // marginSameAuthor: const EdgeInsets.only(top: 2),
                // marginDifferentAuthor: const EdgeInsets.only(top: 15),

                // // **Avatares**
                // showCurrentUserAvatar:
                //     false, // Ocultar avatar del usuario actual
                // showOtherUsersAvatar: true, // Mostrar avatar de otros usuarios
                // showOtherUsersName:
                //     false, // Ocultar nombre de otros usuarios para una apariencia más limpia

                // // **Hora del Mensaje**
                // showTime: true,
                // timeFormat: DateFormat.Hm(), // Formato HH:mm
                // timeTextColor: Colors.grey[600],
                // timeFontSize: 12.0,
                // timePadding: const EdgeInsets.only(top: 5),

                // // **Decoración del Mensaje**
                // // Utilizamos `messageDecorationBuilder` para personalizar el fondo y los bordes
                // messageDecorationBuilder: (ChatMessage message,
                //     ChatMessage? previousMessage, ChatMessage? nextMessage) {
                //   bool isCurrentUser = message.user.id == _actualUser.id;
                //   return BoxDecoration(
                //     color: isCurrentUser ? kPrimaryColor : Colors.grey[300],
                //     borderRadius: BorderRadius.only(
                //       topLeft: const Radius.circular(12),
                //       topRight: const Radius.circular(12),
                //       bottomLeft: isCurrentUser
                //           ? const Radius.circular(12)
                //           : const Radius.circular(0),
                //       bottomRight: isCurrentUser
                //           ? const Radius.circular(0)
                //           : const Radius.circular(12),
                //     ),
                //   );
                // },

                // // **Construir la Hora del Mensaje al Final**
                // messageTimeBuilder: (ChatMessage message, bool isOwnMessage) {
                //   return Text(
                //     DateFormat.Hm().format(message.createdAt),
                //     style: TextStyle(
                //       color: Colors.grey[400],
                //       fontSize: 12,
                //     ),
                //   );
                // },
              ),
              messages: _messages,
            )
          : _buildProgressIndicator(),
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: CircularProgressIndicator(
          strokeWidth: 7,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HeaderLogoLayout(child: _buildMessagesList()),
    );
    // return HeaderLogoLayout(
    //   child:
    // );
  }
}
