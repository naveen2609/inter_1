import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inter_1/logic/controller/post_controller.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostController postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<PostMessageEvent>(_onAddPost);
    on<PostLoadEvent>(_onLoadPosts);
  }

  Future<void> _onAddPost(PostMessageEvent event, Emitter<PostState> emit) async {
    try {
      await postRepository.addPost(event.message, event.username);
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void _onLoadPosts(PostLoadEvent event, Emitter<PostState> emit) {
    emit(PostLoading());
    try {
      final postsStream = postRepository.getPosts();
      postsStream.listen((posts) {
        add(PostUpdatedEvent(posts));
      });
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
