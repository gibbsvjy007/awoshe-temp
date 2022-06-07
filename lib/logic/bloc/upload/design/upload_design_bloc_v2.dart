import 'package:Awoshe/logic/bloc/upload/design/upload_design_bloc_state_v2.dart';
import 'package:Awoshe/logic/bloc/upload/design/upload_design_event_v2.dart';
import 'package:Awoshe/logic/services/collection_services_v2.dart';
import 'package:Awoshe/logic/services/upload_services_v2.dart';
import 'package:Awoshe/models/collection/collection.dart';
import 'package:Awoshe/models/product/product.dart';
import 'package:bloc/bloc.dart';

/// This BLoC component does the CRUD operations over products and over collections.
/// You just need dispatch the event that you want with dispatch(event) method
class UploadDesignBlocV2 extends Bloc<UploadDesignBlocEventV2, UploadDesignBlocStateV2> {

  ///TODO Soon will be product store
  Product product;
  List<Collection> collections = []..add( Collection.DEFAULT_TYPE );
  List<Product> products = [];
  // Product service
  final UploadServiceV2 _service = UploadServiceV2();
  // Collection service
  final CollectionService _collectionService = CollectionService();

  @override
  UploadDesignBlocStateV2 get initialState => UploadDesignBlocStateInit();

  // handling bloc events
  @override
  Stream<UploadDesignBlocStateV2> mapEventToState(UploadDesignBlocEventV2 event) async* {

    switch(event.eventType){
      case UploadDesignBlocEventType.UPLOAD:
        // if uploading a product
        if (event is UploadDesignBlocEventUpload){
          yield UploadDesignBlocStateBusy(eventType: event.eventType);
          try {
            // TODO - collection handling
            var product = Product(
              title: event?.title,
              description:  event?.description,
              price: event?.price,
              productType: event.productType,
              currency: event.currency,
              mainCategory: event.mainCategory,
              subCategory: event.subCategory,
              images: event.images,
              feedType: event.feedType,
//              collection: event?.collectionName,
              sizesInfo: event.sizesInfo,
              owner:event.owner
            );
            _service.create(product, event.userId).then((p) => product = p);
            yield UploadDesignBlocStateSuccess(eventType: event.eventType);
          }

          catch (ex){
            print(ex);
            yield UploadDesignBlocStateFail(eventType: event.eventType, message: ex.toString());
          }
        }

        // if uploading a collection
        else if (event is UploadDesignBlocEventUploadCollection){
          yield UploadDesignBlocUploadCollectionBusy(event.eventType);
          try {

            if (event.title.isEmpty)
              yield UploadDesignBlocUploadCollectionFail(
                  eventType: event.eventType, message: 'Collection must have a name.');
            else {
              var collection = Collection(
                  title: event.title,
                  description: event.description,
                  orientation: event.orientation,
                  ratioX: event.ratioX,
                  ratioY: event.ratioY,
                  displayType: event.displayType
              );
              collection = await _collectionService.createCollection(collection: collection,
                  userId: event.userId);
              collections.insert(1, collection);
              yield UploadDesignBlocUploadCollectionSuccess(eventType: event.eventType);
            }

          }

          catch (ex){
            yield UploadDesignBlocUploadCollectionFail(eventType: event.eventType, message: ex.toString());
          }
        }
        break;
      case UploadDesignBlocEventType.UPDATE:
        yield UploadDesignBlocStateBusy(eventType: event.eventType);
        if (event is UploadDesignBlocEventUpdate){
          try {

            var product = Product(
              id: event.id ?? this.product.id,
              title: event.title ?? this.product.title,
              productCare:  event.productCare ?? this.product.productCare,
              description:  event?.description ?? this.product.description,
              price: event?.price ?? this.product.price,
              currency: event.currency ?? this.product.currency,
              mainCategory: event.mainCategory ?? this.product.mainCategory,
              subCategory: event.subCategory ?? this.product.subCategory,
              images: event.images ?? this.product.images,
              availableColors:  event.availableColors ?? this.product.availableColors,
//              category: event.category ?? this.product.subCategory,
//              collectionName: event.category ?? this.product.collectionName,
              itemId: event.itemId ?? this.product.itemId,
              currentSizeIndex: event.currentSizeIndex ?? this.product.currentSizeIndex,
              customMeasurements: event.customMeasurements ?? this.product.customMeasurements,
              fabricTags: event.fabricTags ?? this.product.fabricTags,
              feedType: event.feedType ?? this.product.feedType,
              imageUrl: event.imageUrl ?? this.product.imageUrl,
              occassions: event.occassions ?? this.product.occassions,
              orderType: event.orderType ?? this.product.orderType,
              otherInfos: event.otherInfos ?? this.product.otherInfos,
              owner: event.owner ?? this.product.owner,
              productType: event.productType ?? this.product.productType,
              sizes: event.sizes ?? this.product.sizes,
              orientation: event.orientation ?? this.product.orientation,
              creator: this.product.creator,
              sizeText: event.sizesInfo?.sizesText ?? this.product.sizeText,
              sizesInfo: event.sizesInfo ?? this.product.sizesInfo,
              status: event.status ?? this.product.status,
            );

             _service.update(product, event.userId).then( (_) => this.product = product );
             await Future.delayed(Duration(seconds: 1));
            yield UploadDesignBlocStateSuccess(eventType: event.eventType);
          }
          catch (ex){
            print(ex);
            yield UploadDesignBlocStateFail(eventType: event.eventType, message: ex.toString());
          }
        }
        break;

      case UploadDesignBlocEventType.READ:
        yield UploadDesignBlocStateBusy(eventType: event.eventType);
        // if the read is a PRODUCT read
        if (event is UploadDesignBlocEventProductRead){
          try{
            var product = await _service.read(event.productId, event.userId);
            this.product = product;
            yield UploadDesignBlocStateSuccess(eventType: event.eventType);
          }

          catch (ex){
            print('$ex');
            yield UploadDesignBlocStateFail(eventType: event.eventType, message: ex.toString());
          }
        }
        // if the read is a COLLECTION read
        else if (event is UploadDesignBlocEventCollectionRead){
          try {
            var data = await _collectionService.getAllCollections(userId: event.userId);

            if (data!=null || data.isNotEmpty) {
              print(data);
              collections.addAll(data);
              yield UploadDesignBlocReadCollectionSuccess(eventType: event.eventType);
            }
            else
              yield UploadDesignBlocStateFail(eventType: event.eventType,
                  message: 'Was not possible read the collections');
          }
          catch (ex){
            print(ex);
            yield UploadDesignBlocStateFail(eventType: event.eventType, message: ex.toString());
          }
        }
        break;

      case UploadDesignBlocEventType.DELETE:
        yield UploadDesignBlocStateBusy(eventType: event.eventType);
        try {
          if (event is UploadDesignBlocEventRemove )
            _service.delete(event.productId, event.userId);

          yield UploadDesignBlocStateSuccess(eventType: event.eventType);
        }
        catch (ex){
          print(ex);
          yield UploadDesignBlocStateFail(eventType: event.eventType, message: ex.toString());
        }
        break;
      case UploadDesignBlocEventType.INIT:
        print('EVENT INIT');
        yield UploadDesignBlocStateInit();
        break;
    }

  }

}


