part of 'network_bloc.dart';

abstract class NetworkEvent {}

class NetworkObserve extends NetworkEvent {}

class NetworkNotify extends NetworkEvent {
  final bool isConnected;
  final ConnectivityResult type;

  NetworkNotify({this.isConnected = false, this.type = ConnectivityResult.none});
}
