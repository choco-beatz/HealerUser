import 'package:bloc/bloc.dart';
import 'package:healer_user/services/agora/agora_service.dart';

part 'agora_event.dart';
part 'agora_state.dart';

class AgoraBloc extends Bloc<AgoraEvent, AgoraState> {
  AgoraBloc() : super(AgoraInitial()) {
    on<InitializeAgora>(_onInitializeAgora);
    on<DisposeAgora>(_onDisposeAgora);
  }

  Future<void> _onInitializeAgora(
    InitializeAgora event,
    Emitter<AgoraState> emit,
  ) async {
    try {
      final agoraService = AgoraService();
      await agoraService.initializeAgora(event.appId);
      emit(AgoraLoadedState(agoraService: agoraService, isInitialized: true));
    } catch (error) {
      emit(AgoraErrorState(error.toString()));
    }
  }

   Future<void> _onDisposeAgora(
    DisposeAgora event,
    Emitter<AgoraState> emit,
  ) async {
    if (state is AgoraLoadedState) {
      final agoraService = (state as AgoraLoadedState).agoraService;
      await agoraService.dispose(); 
    }
    emit(AgoraInitial()); 
  }
}
