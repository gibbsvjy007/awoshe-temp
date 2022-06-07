import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'blog_bloc_event_v2.dart';

class BlogBlocState extends Equatable {
  final BlogBlocEvents eventType;
  BlogBlocState(this.eventType);
}

class BlogBlocStateSuccess extends BlogBlocState{
  BlogBlocStateSuccess({@required BlogBlocEvents eventType}) : super(eventType);
}

class BlogBlocStateBusy extends BlogBlocState{
  BlogBlocStateBusy({@required BlogBlocEvents eventType}) : super(eventType);
}

class BlogBlocStateInit extends BlogBlocState {
  BlogBlocStateInit() : super(BlogBlocEvents.INIT);
}

class BlogBlocStateFail extends BlogBlocState{
  final String message;
  BlogBlocStateFail({@required BlogBlocEvents eventType, this.message}) : super(eventType);
}