import 'package:equatable/equatable.dart';

class UploadDesignState extends Equatable {
  UploadDesignState(
      {this.isBusy: false,
      this.isSuccess: false,
      this.isFailure: false,
      this.isDetailSuccess: false,
      this.noProductReference: false,
      this.isUpdate: false,
      this.isCollectionCreated: false,
      this.isCollectionCreateError: false,
      this.message});

  final bool isBusy;
  final bool isSuccess;
  final bool isDetailSuccess;
  final bool isFailure;
  final bool noProductReference;
  final bool isUpdate;
  final bool isCollectionCreated;
  final bool isCollectionCreateError;
  final String message;

  factory UploadDesignState.noAction() {
    return UploadDesignState();
  }

  factory UploadDesignState.busy() {
    return UploadDesignState(
      isBusy: true,
    );
  }

  factory UploadDesignState.success() {
    return UploadDesignState(
      isSuccess: true,
    );
  }

  factory UploadDesignState.noProductRef() {
    return UploadDesignState(
      noProductReference: true,
    );
  }

  factory UploadDesignState.detailSuccess() {
    return UploadDesignState(
      isDetailSuccess: true,
    );
  }

  factory UploadDesignState.updateSuccess() {
    return UploadDesignState(
      isUpdate: true,
    );
  }

  factory UploadDesignState.feedTypeSuccess() {
    return UploadDesignState(
      isCollectionCreated: true,
    );
  }

  factory UploadDesignState.feedTypeError(String message) {
    return UploadDesignState(
      isCollectionCreateError: true,
      message: message
    );
  }

  factory UploadDesignState.failure(String message) {
    return UploadDesignState(isFailure: true, message: message);
  }
}
