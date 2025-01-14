import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/agora/agora_bloc.dart';
import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
import 'package:healer_user/services/agora/constants.dart';
import 'package:healer_user/view/call/screens/audio_call_page.dart';
import 'package:healer_user/view/call/screens/video_call_page.dart';
import 'package:healer_user/view/call/widgets/contact_card.dart';
import 'package:healer_user/view/therapist/widgets/empty.dart';
import 'package:healer_user/view/therapist/widgets/therapist_detail.dart';
import 'package:healer_user/view/widgets/appbar.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AgoraBloc>().add(InitializeAgora(appId));
    });

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CommonAppBar(
          title: 'Therapists',
        ),
      ),
      body: BlocBuilder<TherapistBloc, TherapistState>(
        builder: (context, state) {
          if (state.list.isNotEmpty) {
            final therapists = state.list;

            return BlocBuilder<AgoraBloc, AgoraState>(
              builder: (context, agoraState) {
                if (agoraState is AgoraLoadedState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (agoraState is AgoraLoadedState &&
                    agoraState.agoraService != null) {
                  final agoraService = agoraState.agoraService;

                  return ListView.builder(
                    itemCount: therapists.length,
                    itemBuilder: (context, index) {
                      final therapist = therapists[index];

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TherapistDetails(therapist: therapist),
                          ),
                        ),
                        child: ContactCard(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          therapist: therapist,
                          onCall: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AudioCallPage(
                                  agoraService: agoraService,
                                  channelId: therapist.id,
                                  userId: uid,
                                ),
                              ),
                            );
                          },
                          onVideoCall: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoCallPage(
                                  agoraService: agoraService,
                                  channelId: therapist.id,
                                  userId: uid,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (agoraState is AgoraErrorState) {
                  print(agoraState.message);
                  return Center(
                    child: Text('Error: ${agoraState.message}'),
                  );
                } else {
                  return const Center(child: Text('Initializing Agora...'));
                }
              },
            );
          } else {
            return const Center(
                child: EmptyTherapist(
              description: "Only clients can call respective therapist",
            ));
          }
        },
      ),
    );
  }
  @override
void dispose() {
  context.read<AgoraBloc>().add(DisposeAgora());
  super.dispose();
}

}
