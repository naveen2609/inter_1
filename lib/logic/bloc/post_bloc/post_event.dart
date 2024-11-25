part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostMessageEvent extends PostEvent {
  final String message;
  final String username;

  PostMessageEvent(this.message, this.username);

  @override
  List<Object?> get props => [message, username];
}

class PostLoadEvent extends PostEvent {}

class PostUpdatedEvent extends PostEvent {
  final List<Map<String, dynamic>> posts;

  PostUpdatedEvent(this.posts);

  @override
  List<Object?> get props => [posts];
}
