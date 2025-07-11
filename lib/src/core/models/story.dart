import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'scene.dart';

part 'story.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Story extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final String? coverImageUrl;
  
  @HiveField(4)
  final String? coverImagePath;
  
  @HiveField(5)
  final List<Scene> scenes;
  
  @HiveField(6)
  final String authorId;
  
  @HiveField(7)
  final String authorName;
  
  @HiveField(8)
  final DateTime createdAt;
  
  @HiveField(9)
  final DateTime updatedAt;
  
  @HiveField(10)
  final List<String> tags;
  
  @HiveField(11)
  final bool isPublic;
  
  @HiveField(12)
  final bool isFavorite;
  
  @HiveField(13)
  final int playCount;
  
  @HiveField(14)
  final Duration? totalDuration;
  
  @HiveField(15)
  final String? firstSceneId;
  
  @HiveField(16)
  final List<String> endings;
  
  @HiveField(17)
  final Map<String, dynamic> metadata;
  
  @HiveField(18)
  final String language;
  
  @HiveField(19)
  final AgeGroup ageGroup;
  
  @HiveField(20)
  final int rating;
  
  const Story({
    required this.id,
    required this.title,
    required this.description,
    this.coverImageUrl,
    this.coverImagePath,
    required this.scenes,
    required this.authorId,
    required this.authorName,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    this.isPublic = false,
    this.isFavorite = false,
    this.playCount = 0,
    this.totalDuration,
    this.firstSceneId,
    this.endings = const [],
    this.metadata = const {},
    this.language = 'en',
    this.ageGroup = AgeGroup.all,
    this.rating = 0,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    String? id,
    String? title,
    String? description,
    String? coverImageUrl,
    String? coverImagePath,
    List<Scene>? scenes,
    String? authorId,
    String? authorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    bool? isPublic,
    bool? isFavorite,
    int? playCount,
    Duration? totalDuration,
    String? firstSceneId,
    List<String>? endings,
    Map<String, dynamic>? metadata,
    String? language,
    AgeGroup? ageGroup,
    int? rating,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      coverImagePath: coverImagePath ?? this.coverImagePath,
      scenes: scenes ?? this.scenes,
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      isPublic: isPublic ?? this.isPublic,
      isFavorite: isFavorite ?? this.isFavorite,
      playCount: playCount ?? this.playCount,
      totalDuration: totalDuration ?? this.totalDuration,
      firstSceneId: firstSceneId ?? this.firstSceneId,
      endings: endings ?? this.endings,
      metadata: metadata ?? this.metadata,
      language: language ?? this.language,
      ageGroup: ageGroup ?? this.ageGroup,
      rating: rating ?? this.rating,
    );
  }

  Scene? getSceneById(String sceneId) {
    try {
      return scenes.firstWhere((scene) => scene.id == sceneId);
    } catch (e) {
      return null;
    }
  }

  List<Scene> getEndingScenes() {
    return scenes.where((scene) => scene.isEnding).toList();
  }

  bool get hasMultipleEndings => getEndingScenes().length > 1;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImageUrl,
        coverImagePath,
        scenes,
        authorId,
        authorName,
        createdAt,
        updatedAt,
        tags,
        isPublic,
        isFavorite,
        playCount,
        totalDuration,
        firstSceneId,
        endings,
        metadata,
        language,
        ageGroup,
        rating,
      ];
}

@HiveType(typeId: 1)
enum AgeGroup {
  @HiveField(0)
  toddler, // 2-4 years
  
  @HiveField(1)
  preschool, // 4-6 years
  
  @HiveField(2)
  elementary, // 6-12 years
  
  @HiveField(3)
  teen, // 13-17 years
  
  @HiveField(4)
  adult, // 18+ years
  
  @HiveField(5)
  all, // All ages
}

extension AgeGroupExtension on AgeGroup {
  String get displayName {
    switch (this) {
      case AgeGroup.toddler:
        return 'Toddler (2-4)';
      case AgeGroup.preschool:
        return 'Preschool (4-6)';
      case AgeGroup.elementary:
        return 'Elementary (6-12)';
      case AgeGroup.teen:
        return 'Teen (13-17)';
      case AgeGroup.adult:
        return 'Adult (18+)';
      case AgeGroup.all:
        return 'All Ages';
    }
  }

  int get minAge {
    switch (this) {
      case AgeGroup.toddler:
        return 2;
      case AgeGroup.preschool:
        return 4;
      case AgeGroup.elementary:
        return 6;
      case AgeGroup.teen:
        return 13;
      case AgeGroup.adult:
        return 18;
      case AgeGroup.all:
        return 0;
    }
  }
}