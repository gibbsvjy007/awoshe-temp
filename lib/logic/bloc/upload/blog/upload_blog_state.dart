import 'package:equatable/equatable.dart';

class UploadBlogState extends Equatable {
  UploadBlogState(
      {this.isBusy: false,
        this.isSuccess: false,
        this.isFailure: false,
        this.isUpdate: false,
        this.message});

  final bool isBusy;
  final bool isSuccess;
  final bool isFailure;
  final bool isUpdate;
  final String message;

  factory UploadBlogState.noAction() {
    return UploadBlogState();
  }

  factory UploadBlogState.busy() {
    return UploadBlogState(
      isBusy: true,
    );
  }

  factory UploadBlogState.success() {
    return UploadBlogState(
      isSuccess: true,
    );
  }

  factory UploadBlogState.updateSuccess() {
    return UploadBlogState(
      isUpdate: true,
    );
  }

  factory UploadBlogState.failure(String message) {
    return UploadBlogState(isFailure: true, message: message);
  }
}
