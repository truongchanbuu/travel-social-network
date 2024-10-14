import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<UpdateContentEvent>(_onContentUpdated);
  }

  void _onContentUpdated(UpdateContentEvent event, Emitter<PostState> emit) {
    emit(ContentUpdated(content: event.content.trim(), images: event.images));
  }
}
