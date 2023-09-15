part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  final bool isConnected;
  final ConnectivityResult type;

  const NetworkState({this.isConnected = false, this.type = ConnectivityResult.none});

  @override
  List<Object> get props => [isConnected, type];
}

class NetworkInitial extends NetworkState {
  const NetworkInitial();
}

class NetworkConnected extends NetworkState {
  const NetworkConnected({required ConnectivityResult type}) : super(isConnected: true, type: type);
}

class NetworkDisconnected extends NetworkState {
  const NetworkDisconnected();
}
