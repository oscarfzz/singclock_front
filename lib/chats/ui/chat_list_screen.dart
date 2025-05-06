import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:signclock/blocs/auth_hydrated/auth_hy_bloc.dart';
import 'package:signclock/chats/utils/dio_client.dart';

import 'package:signclock/api_services/chat_service.dart';
import 'package:signclock/chats/ui/widgets/chat_list_item.dart';
import 'package:signclock/models/api_response_model.dart';
import 'package:signclock/constant/theme.dart';
import 'package:signclock/widgets/header_logo_layout.dart';

import '../../nav_bar/navigation_cubit.dart';
import '../model/chat_model.dart';
import 'add_chat.dart';
import 'chat_dash_view.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  static const routeName = "chat-list";

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<ChatModel>? _groups;
  bool _isLoaded = false;

  late AuthHyBloc _authHyBloc;
  late ChatService _chatService;

  @override
  void initState() {
    super.initState();
    _authHyBloc = context.read<AuthHyBloc>();
    final dioClient = DioClient(_authHyBloc);
    _chatService = ChatService(dioClient.instance, _authHyBloc);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _updateData();
      }
    });
  }

  Future<void> _updateData() async {
    try {
      final user = _authHyBloc.state.user;
      final token = _authHyBloc.state.token;
      if (user != null && token != null) {
        final response = await _chatService.getChats(user);
        // final response = await ChatRepository().getChats(user, token);
        _updateList(response);
      } else {
        _showErrorMessage("Usuario o token inválido.");
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      _showErrorMessage('Error inesperado, disculpe las molestias.$error');
    }
  }

  void _updateList(ApiResponseModel<List<ChatModel>> response) {
    if (!mounted) return;
    if (response.status == "error") {
      _showErrorMessage(response.msg);
      return;
    }
    setState(() {
      _groups = response.data;
      _isLoaded = true;
    });
  }

  void _showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HeaderLogoLayout(child: _buildGroupsList(context)),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: kPrimaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          context.read<NavigationCubit>().navigateTo(2, const AddChat());
        },
      ),
    );
  }

  Widget _buildGroupsList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => _isLoaded = false);
        await _updateData();
      },
      child: _isLoaded ? _buildChatsList() : _buildProgressIndicator(),
    );
  }

  Widget _buildChatsList() {
    final double indentWidth = MediaQuery.of(context).size.width * 0.07;

    return ListView.separated(
      itemCount: _groups!.length,
      itemBuilder: (context, index) {
        return ChatListItem(
          item: _groups![index],
          onPressed: () {
            context.read<NavigationCubit>().navigateTo(
                  2,
                  ChatDashView(chat: _groups![index]),
                );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: const Color.fromARGB(255, 197, 191, 191),
        height: 1,
        indent: indentWidth,
        endIndent: indentWidth,
      ),
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
}
