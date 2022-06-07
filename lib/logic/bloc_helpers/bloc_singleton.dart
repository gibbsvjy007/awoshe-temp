import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  ///
  /// Streams related to this BLoC
  ///
  BehaviorSubject<String> _controller = BehaviorSubject<String>();
  Function(String) get push => _controller.sink.add;
  Stream<String> get stream => _controller;

  BehaviorSubject<Map<String, dynamic>> _mapController = BehaviorSubject<Map<String, dynamic>>();
  Function(Map<String, dynamic>) get pushMap => _mapController.sink.add;
  Stream<Map<String, dynamic>> get streamMap => _mapController;

  /// Message Count
  BehaviorSubject<int> _unreadMessageController = BehaviorSubject<int>();
  Function(int) get unreadMessageCount => _unreadMessageController.sink.add;
  Stream<int> get unreadMessageCountStream => _unreadMessageController;

  closeStreamMap() {
  }
  ///
  /// Singleton factory
  ///
  static final GlobalBloc _bloc = new GlobalBloc._internal();
  factory GlobalBloc(){
    return _bloc;
  }
  GlobalBloc._internal();

  ///
  /// Resource disposal
  ///
  void dispose(){
    print("_________________disposing global bloc_______________");
    _controller?.close();
    _mapController?.close();
    _unreadMessageController?.close();
  }
}

GlobalBloc globalBloc = GlobalBloc();