import 'dart:convert';

class Story {
  final String? id;
  final String? avatar;
  final String? name;
  final List<Stories>? stories;

  Story({
    this.id,
    this.stories,
    this.avatar,
    this.name,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    final List<dynamic> storiesData =
        json['stories'] != null ? List.from(json['stories']) : [];
    final List<Stories> stories =
        storiesData.map((data) => Stories.fromJson(data)).toList();
    return Story(
      id: json["userId"],
      stories: stories,
      avatar: json['avatar'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "stories": jsonEncode(stories),
    };
  }
}

class Stories {
  final String? image;
  final String? date;

  Stories({
    this.image,
    this.date,
  });

  factory Stories.fromJson(Map<String, dynamic> json) {
    return Stories(
      image: json["image"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "date": date,
    };
  }
}
