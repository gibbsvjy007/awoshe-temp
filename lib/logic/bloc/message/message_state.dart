import 'package:equatable/equatable.dart';

class MessageState extends Equatable {
  MessageState({
    this.isBusy: false,
    this.isSuccess: false,
    this.isFailure: false,
    this.message
  });

  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final String message;

  factory MessageState.noAction() {
    return MessageState();
  }

  factory MessageState.busy(){
    return MessageState(isBusy: true,);
  }

  factory MessageState.success(){
    return MessageState(isSuccess: true,);
  }

  factory MessageState.failure(String message){
    return MessageState(isFailure: true, message: message);
  }

}