// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

// import '../../../injection_container.dart';

// part 'auth_loading_state.dart';

// class AuthLoadingCubit extends Cubit<AuthLoadingState> {
//   AuthLoadingCubit() : super(AuthLoadingInitial());

//   Future<void> authCallBackRequest(String link) async {
//     try {
//       await getIt<Dio>().get(link);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
