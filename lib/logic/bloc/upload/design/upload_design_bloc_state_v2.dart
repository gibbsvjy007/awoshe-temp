import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:equatable/equatable.dart';

abstract class UploadDesignBlocStateV2 extends Equatable {
  final UploadDesignBlocEventType eventType;
  UploadDesignBlocStateV2(this.eventType);
}

class UploadDesignBlocStateInit extends UploadDesignBlocStateV2{
  UploadDesignBlocStateInit() : super(UploadDesignBlocEventType.INIT);
}

class UploadDesignBlocStateBusy extends UploadDesignBlocStateV2 {
  UploadDesignBlocStateBusy({UploadDesignBlocEventType eventType}) : super(eventType);
}

class UploadDesignBlocStateSuccess extends UploadDesignBlocStateV2 {
  UploadDesignBlocStateSuccess({UploadDesignBlocEventType eventType}) : super(eventType);
}

class UploadDesignBlocStateFail extends UploadDesignBlocStateV2{
  final String message;
  UploadDesignBlocStateFail({UploadDesignBlocEventType eventType, this.message}) : super(eventType);
}


class UploadDesignBlocUploadCollectionBusy extends UploadDesignBlocStateV2{
  UploadDesignBlocUploadCollectionBusy(UploadDesignBlocEventType eventType) : super(eventType);
}

class UploadDesignBlocUploadCollectionSuccess extends UploadDesignBlocStateV2{
  UploadDesignBlocUploadCollectionSuccess({UploadDesignBlocEventType eventType}) : super(eventType);
}

class UploadDesignBlocUploadCollectionFail extends UploadDesignBlocStateV2{
  final String message;
  UploadDesignBlocUploadCollectionFail({UploadDesignBlocEventType eventType,
    this.message}) : super(eventType);
}

class UploadDesignBlocReadCollectionSuccess extends UploadDesignBlocStateV2{
  UploadDesignBlocReadCollectionSuccess({UploadDesignBlocEventType eventType}) : super(eventType);
}

class CollectionValidationSuccess extends UploadDesignBlocStateV2{
  CollectionValidationSuccess(UploadDesignBlocEventType eventType) : super(eventType);
}

class CollectionValidationBusy extends UploadDesignBlocStateV2{
  CollectionValidationBusy(UploadDesignBlocEventType eventType) : super(eventType);
}

class CollectionValidationFails extends UploadDesignBlocStateV2{
  final String message;
  CollectionValidationFails({this.message, UploadDesignBlocEventType eventType}) : super(eventType);
}

class ProductValidationFails extends UploadDesignBlocStateV2{
  final String message;
  ProductValidationFails({this.message, UploadDesignBlocEventType eventType}) : super(eventType);
}

class ProductValidationBusy extends UploadDesignBlocStateV2{
  ProductValidationBusy(UploadDesignBlocEventType eventType) : super(eventType);
}

class ProductValidationSuccess extends UploadDesignBlocStateV2{
  ProductValidationSuccess(UploadDesignBlocEventType eventType) : super(eventType);
}