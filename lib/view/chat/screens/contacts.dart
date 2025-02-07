import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/chat/chat_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/view/chat/screens/message_screen.dart';
import 'package:healer_user/view/chat/widgets/chat_card.dart';
import 'package:healer_user/view/chat/widgets/message_card.dart';
import 'package:healer_user/view/widgets/empty.dart';
import 'package:healer_user/view/widgets/appbar.dart';
import 'package:healer_user/view/widgets/loading.dart';
import 'package:intl/intl.dart';

class Therapists extends StatelessWidget {
  final SocketService socketService;

  const Therapists({super.key, required this.socketService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CommonAppBar(
          title: 'Therapists',
        ),
      ),
      body: BlocBuilder<TherapistBloc, TherapistState>(
        builder: (context, therapistState) {
          if (therapistState is TherapistLoading) {
            return const Loading();
          } else if (therapistState is RequestStatusLoaded) {
            final therapists = therapistState.list;

            if (therapists.isEmpty) {
              return const Center(
                child: Empty(
                  title: 'No Conversations Yet',
                  subtitle:
                      'Once a therapist accepts your request, you can start chatting with them here. Stay tuned',
                  image: 'asset/emptyChat.jpg',
                ),
              );
            }

            return BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Loading();
                } else if (state is ChatsLoaded) {
                  final chats = state.chats;

                  return ListView.builder(
                    itemCount: therapists.length,
                    itemBuilder: (context, index) {
                      final therapist = therapists[index];

                      // Ensure index is within bounds of chats list
                      final chat = (index < chats.length) ? chats[index] : null;

                      if (chat == null) {
                        // If there is no chat for this therapist
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: therapist.profile.name,
                                image: therapist.image,
                                id: therapist.id,
                                socketService: socketService,
                              ),
                            ),
                          ),
                          child: ChatCard(
                            socketService: socketService,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            therapist: therapist,
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ChatBloc()
                                    ..add(LoadMessagesEvent(chat.id)),
                                  child: ChatScreen(
                                    name: therapist.profile.name,
                                    image: therapist.image,
                                    id: therapist.id,
                                    socketService: socketService,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: MessageCard(
                            socketService: socketService,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            lastMessage: chat.lastMessage.text,
                            name: therapist.profile.name,
                            time: DateFormat('hh:mm a')
                                .format(chat.lastMessage.createdAt),
                            image: therapist.image,
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return const Center(child: Text('Error loading chats'));
                }
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
