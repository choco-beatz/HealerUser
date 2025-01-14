import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/chat/chat_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/view/chat/screens/chat.dart';
import 'package:healer_user/view/chat/screens/message_screen.dart';
import 'package:healer_user/view/chat/widgets/message_card.dart';
import 'package:healer_user/view/widgets/appbar.dart';
import 'package:healer_user/view/widgets/floating_button.dart';

class Inbox extends StatelessWidget {
  final SocketService socketService;
  const Inbox({super.key, required this.socketService});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // log('ChatEvent');
      context.read<ChatBloc>().add(LoadChatsEvent());
    });
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CommonAppBar(
          title: 'Inbox',
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatsLoaded) {
            final chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                final participant = chat.participants.last;
                final lastMessageText = chat.lastMessage.text;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                create: (context) =>
                                    ChatBloc()..add(LoadMessagesEvent(chat.id)),
                                child: ChatScreen(
                                  id: chat.lastMessage.to,
                                  socketService: socketService,
                                ))));
                  },
                  child: MessageCard(
                    socketService: socketService,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    lastMessage: lastMessageText,
                    name:participant.profile.name,
                    image: participant.image,
                  ),
                );
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
      floatingActionButton: FloatingButton(
        text: ' Start a new chat',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) =>
                        TherapistBloc()..add(RequestStatusEvent(status: "Accepted")),
                    child: Chat(
                      socketService: socketService,
                    ),
                  )),
        ),
      ),
    );
  }
}
