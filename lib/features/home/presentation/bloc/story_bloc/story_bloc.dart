import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_event.dart';
import 'package:gramify/features/home/presentation/bloc/story_bloc/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitialState());
}
