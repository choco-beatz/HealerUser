import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/services/chat/socket.dart';
import 'package:healer_user/view/chat/screens/message_screen.dart';
import 'package:healer_user/view/chat/widgets/chat_card.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';
import 'package:healer_user/view/widgets/appbar.dart';

class Chat extends StatelessWidget {
  final SocketService socketService;

  const Chat({super.key, required this.socketService});

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
        builder: (context, state) {
          final therapists = state.list;

          if (therapists.isEmpty) {
            return const Center(child: EmptyTherapist(description: 'Only clients can chat to their respective therapist',));
          }
          return ListView.builder(
            itemCount: therapists.length,
            itemBuilder: (context, index) {
              final therapist = therapists[index];
              print(therapist);
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
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
            },
          );
        },
      ),
    );
  }
}
