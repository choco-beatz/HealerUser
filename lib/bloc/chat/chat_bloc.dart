import 'package:bloc/bloc.dart';
import 'package:healer_user/model/chat_model/chat_model.dart';
import 'package:healer_user/model/chat_model/message_model.dart';
import 'package:healer_user/services/chat/chat_service.dart';


part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatsEvent>((event, emit) async {
      emit(ChatLoading());
      try {
        final list = await fetchChats();
        emit(ChatsLoaded(list));
      } catch (e) {
        emit(ChatError('error from bloc${e.toString()}'));
      }
    });

    on<LoadMessagesEvent>((event, emit) async {
      emit(ChatLoading());
      try {
        
        final list = await fetchMessages(chatId: event.chatId);
        emit(MessagesLoaded(list));
      } catch (e) {
        emit(ChatError('error from bloc${e.toString()}'));
      }
    });
  }
}
