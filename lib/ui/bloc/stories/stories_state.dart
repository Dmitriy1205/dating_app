part of 'stories_cubit.dart';

class StoriesState extends Equatable {
  final Status? status;
  final List<Story>? usersStory;
  final List<Stories>? currentUserStories;

  const StoriesState({
    this.status,
    this.usersStory,
    this.currentUserStories,
  });

  StoriesState copyWith({
    Status? status,
    List<Story>? usersStory,
    List<Stories>? currentUserStories,
  }) {
    return StoriesState(
      status: status ?? this.status,
      usersStory: usersStory ?? this.usersStory,
      currentUserStories: currentUserStories ?? this.currentUserStories,
    );
  }

  @override
  List<Object?> get props => [
        status,
        usersStory,
        currentUserStories,
      ];
}
