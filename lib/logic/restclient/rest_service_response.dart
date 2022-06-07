class RestServiceResponse<T> {
  T content;
  bool success;
  String message;

  RestServiceResponse({this.content, this.success, this.message});
}


class MappedRestServiceResponse<T> {
  dynamic mappedResult;
  RestServiceResponse<T> networkServiceResponse;
  MappedRestServiceResponse(
      {this.mappedResult, this.networkServiceResponse});
}
