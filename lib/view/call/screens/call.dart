// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:healer_user/bloc/agora/agora_bloc.dart';
// import 'package:healer_user/bloc/therapist/therapist_bloc.dart';
// import 'package:healer_user/constants/colors.dart';
// import 'package:healer_user/model/therapist_model/therapist_model.dart';
// import 'package:healer_user/services/agora/constants.dart';
// import 'package:healer_user/view/call/screens/audio_call_page.dart';
// import 'package:healer_user/view/call/screens/video_call_page.dart';
// import 'package:healer_user/view/call/widgets/contact_card.dart';
// import 'package:healer_user/view/therapist/widgets/empty.dart';
// import 'package:healer_user/view/therapist/widgets/therapist_detail.dart';
// import 'package:healer_user/view/widgets/appbar.dart';
// import 'package:healer_user/view/widgets/loading.dart';

// class Contacts extends StatefulWidget {
//   const Contacts({super.key});

//   @override
//   State<Contacts> createState() => _ContactsState();
// }

// class _ContactsState extends State<Contacts> {
//   late AgoraBloc _agoraBloc;

//   @override
//   void initState() {
//     super.initState();
//     _agoraBloc = context.read<AgoraBloc>();
//     // Initialize Agora once when the widget is first created
//     _agoraBloc.add(InitializeAgora(appId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(50),
//         child: CommonAppBar(title: 'Therapists'),
//       ),
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<AgoraBloc, AgoraState>(
//             listener: (context, agoraState) {
//               if (agoraState is AgoraError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Agora Error: ${agoraState.error}')),
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<TherapistBloc, TherapistState>(
//           builder: (context, state) {
//             if (state is TherapistLoading) {
//               return const Loading();
//             } else if (state is RequestStatusLoaded) {
//               final therapists = state.list;

//               return BlocBuilder<AgoraBloc, AgoraState>(
//                 builder: (context, agoraState) {
//                   // Handle different Agora initialization states
//                   if (agoraState is AgoraInitial) {
//                     return const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircularProgressIndicator(),
//                           SizedBox(height: 16),
//                           Text('Initializing Agora...'),
//                         ],
//                       ),
//                     );
//                   } else if (agoraState is AgoraLoadedState) {
//                     return ListView.builder(
//                       itemCount: therapists.length,
//                       itemBuilder: (context, index) {
//                         final therapist = therapists[index];
//                         return ContactCard(
//                           height: MediaQuery.of(context).size.height,
//                           width: MediaQuery.of(context).size.width,
//                           therapist: therapist,
//                           onCall: () => _navigateToAudioCall(
//                               context, therapist, agoraState),
//                           onVideoCall: () => _navigateToVideoCall(
//                               context, therapist, agoraState),
//                           onDetails: () => Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   TherapistDetails(therapist: therapist),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else if (agoraState is AgoraError) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.error, color: red, size: 50),
//                           Text(
//                               'Agora Initialization Failed: ${agoraState.error}'),
//                           ElevatedButton(
//                             onPressed: () =>
//                                 _agoraBloc.add(InitializeAgora(appId)),
//                             child: const Text('Retry'),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               );
//             } else {
//               return const Center(
//                 child: EmptyTherapist(
//                   description: "Only clients can call respective therapist",
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   void _navigateToAudioCall(BuildContext context, TherapistModel therapist,
//       AgoraLoadedState agoraState) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AudioCallPage(
//           agoraService: agoraState.agoraService,
//           channelId: therapist.id,
//           userId: uid,
//         ),
//       ),
//     );
//   }

//   void _navigateToVideoCall(BuildContext context, TherapistModel therapist,
//       AgoraLoadedState agoraState) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VideoCallPage(
//           agoraService: agoraState.agoraService,
//           channel: channel,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _agoraBloc.add(DisposeAgora());
//     super.dispose();
//   }
// }
