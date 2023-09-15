import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(const NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  void _observe(event, emit) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      log('NetworkBloc: Connectivity changed to $result');
      add(NetworkNotify(isConnected: result != ConnectivityResult.none, type: result));
    });
  }

  void _notifyStatus(NetworkNotify event, emit) {
    emit(event.isConnected
        ? NetworkConnected(type: event.type)
        : const NetworkDisconnected());
  }
}
