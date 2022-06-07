import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  HomeState([List props = const []]) : super(props);
}

class FeedUninitialized extends HomeState {
  @override
  String toString() => 'FeedUninitialized';
}

class FeedError extends HomeState {
  @override
  String toString() => 'FeedError';
}

class FeedLoaded extends HomeState {
  final List<DocumentSnapshot> feeds;
  final bool hasReachedMax;

  FeedLoaded({
    this.feeds,
    this.hasReachedMax,
  }) : super([feeds, hasReachedMax]);

  FeedLoaded copyWith({
    List<DocumentSnapshot> feeds,
    bool hasReachedMax,
  }) {
    return FeedLoaded(
      feeds: feeds ?? this.feeds,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() =>
      'FeedLoaded { feeds: ${feeds.length}, hasReachedMax: $hasReachedMax }';
}