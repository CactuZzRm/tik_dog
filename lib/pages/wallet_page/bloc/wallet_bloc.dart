import 'package:bloc/bloc.dart';

import '../../../data/api/models/user_model.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {});
    on<WalletInitEvent>((event, emit) {
      final user = event.userModel;
      emit(WalletCurrentState(user: user));
    });
  }
}
