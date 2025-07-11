import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'scene.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class Scene extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final String text;
  
  @HiveField(3)
  final String? backgroundImageUrl;
  
  @HiveField(4)
  final String? backgroundImagePath;
  
  @HiveField(5)
  final String? backgroundAnimationUrl;
  
  @HiveField(6)
  final String? backgroundAnimationPath;
  
  @HiveField(7)
  final String? narrationAudioUrl;
  
  @HiveField(8)
  final String? narrationAudioPath;
  
  @HiveField(9)
  final String? ambientAudioUrl;
  
  @HiveField(10)
  final String? ambientAudioPath;
  
  @HiveField(11)
  final List<SceneChoice> choices;
  
  @HiveField(12)
  final List<SecretZone> secretZones;
  
  @HiveField(13)
  final List<SceneEffect> effects;
  
  @HiveField(14)
  final bool isEnding;
  
  @HiveField(15)
  final Duration? duration;
  
  @HiveField(16)
  final Map<String, dynamic> metadata;
  
  @HiveField(17)
  final int order;
  
  @HiveField(18)
  final String? voiceId;
  
  @HiveField(19)
  final double voiceSpeed;
  
  @HiveField(20)
  final double voicePitch;
  
  @HiveField(21)
  final String? musicUrl;
  
  @HiveField(22)
  final String? musicPath;
  
  @HiveField(23)
  final double musicVolume;
  
  @HiveField(24)
  final double ambientVolume;
  
  const Scene({
    required this.id,
    required this.title,
    required this.text,
    this.backgroundImageUrl,
    this.backgroundImagePath,
    this.backgroundAnimationUrl,
    this.backgroundAnimationPath,
    this.narrationAudioUrl,
    this.narrationAudioPath,
    this.ambientAudioUrl,
    this.ambientAudioPath,
    this.choices = const [],
    this.secretZones = const [],
    this.effects = const [],
    this.isEnding = false,
    this.duration,
    this.metadata = const {},
    this.order = 0,
    this.voiceId,
    this.voiceSpeed = 1.0,
    this.voicePitch = 1.0,
    this.musicUrl,
    this.musicPath,
    this.musicVolume = 0.5,
    this.ambientVolume = 0.3,
  });

  factory Scene.fromJson(Map<String, dynamic> json) => _$SceneFromJson(json);
  Map<String, dynamic> toJson() => _$SceneToJson(this);

  Scene copyWith({
    String? id,
    String? title,
    String? text,
    String? backgroundImageUrl,
    String? backgroundImagePath,
    String? backgroundAnimationUrl,
    String? backgroundAnimationPath,
    String? narrationAudioUrl,
    String? narrationAudioPath,
    String? ambientAudioUrl,
    String? ambientAudioPath,
    List<SceneChoice>? choices,
    List<SecretZone>? secretZones,
    List<SceneEffect>? effects,
    bool? isEnding,
    Duration? duration,
    Map<String, dynamic>? metadata,
    int? order,
    String? voiceId,
    double? voiceSpeed,
    double? voicePitch,
    String? musicUrl,
    String? musicPath,
    double? musicVolume,
    double? ambientVolume,
  }) {
    return Scene(
      id: id ?? this.id,
      title: title ?? this.title,
      text: text ?? this.text,
      backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
      backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
      backgroundAnimationUrl: backgroundAnimationUrl ?? this.backgroundAnimationUrl,
      backgroundAnimationPath: backgroundAnimationPath ?? this.backgroundAnimationPath,
      narrationAudioUrl: narrationAudioUrl ?? this.narrationAudioUrl,
      narrationAudioPath: narrationAudioPath ?? this.narrationAudioPath,
      ambientAudioUrl: ambientAudioUrl ?? this.ambientAudioUrl,
      ambientAudioPath: ambientAudioPath ?? this.ambientAudioPath,
      choices: choices ?? this.choices,
      secretZones: secretZones ?? this.secretZones,
      effects: effects ?? this.effects,
      isEnding: isEnding ?? this.isEnding,
      duration: duration ?? this.duration,
      metadata: metadata ?? this.metadata,
      order: order ?? this.order,
      voiceId: voiceId ?? this.voiceId,
      voiceSpeed: voiceSpeed ?? this.voiceSpeed,
      voicePitch: voicePitch ?? this.voicePitch,
      musicUrl: musicUrl ?? this.musicUrl,
      musicPath: musicPath ?? this.musicPath,
      musicVolume: musicVolume ?? this.musicVolume,
      ambientVolume: ambientVolume ?? this.ambientVolume,
    );
  }

  bool get hasChoices => choices.isNotEmpty;
  bool get hasSecretZones => secretZones.isNotEmpty;
  bool get hasBackground => backgroundImageUrl != null || backgroundImagePath != null;
  bool get hasAnimation => backgroundAnimationUrl != null || backgroundAnimationPath != null;
  bool get hasNarration => narrationAudioUrl != null || narrationAudioPath != null;
  bool get hasAmbientAudio => ambientAudioUrl != null || ambientAudioPath != null;
  bool get hasMusic => musicUrl != null || musicPath != null;

  @override
  List<Object?> get props => [
        id,
        title,
        text,
        backgroundImageUrl,
        backgroundImagePath,
        backgroundAnimationUrl,
        backgroundAnimationPath,
        narrationAudioUrl,
        narrationAudioPath,
        ambientAudioUrl,
        ambientAudioPath,
        choices,
        secretZones,
        effects,
        isEnding,
        duration,
        metadata,
        order,
        voiceId,
        voiceSpeed,
        voicePitch,
        musicUrl,
        musicPath,
        musicVolume,
        ambientVolume,
      ];
}

@HiveType(typeId: 3)
@JsonSerializable()
class SceneChoice extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String text;
  
  @HiveField(2)
  final String targetSceneId;
  
  @HiveField(3)
  final Map<String, dynamic> conditions;
  
  @HiveField(4)
  final Map<String, dynamic> effects;
  
  @HiveField(5)
  final bool isVisible;
  
  @HiveField(6)
  final String? iconUrl;
  
  @HiveField(7)
  final String? iconPath;
  
  @HiveField(8)
  final ChoiceStyle style;

  const SceneChoice({
    required this.id,
    required this.text,
    required this.targetSceneId,
    this.conditions = const {},
    this.effects = const {},
    this.isVisible = true,
    this.iconUrl,
    this.iconPath,
    this.style = ChoiceStyle.button,
  });

  factory SceneChoice.fromJson(Map<String, dynamic> json) => _$SceneChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$SceneChoiceToJson(this);

  @override
  List<Object?> get props => [
        id,
        text,
        targetSceneId,
        conditions,
        effects,
        isVisible,
        iconUrl,
        iconPath,
        style,
      ];
}

@HiveType(typeId: 4)
@JsonSerializable()
class SecretZone extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final double x;
  
  @HiveField(2)
  final double y;
  
  @HiveField(3)
  final double width;
  
  @HiveField(4)
  final double height;
  
  @HiveField(5)
  final String? targetSceneId;
  
  @HiveField(6)
  final String? action;
  
  @HiveField(7)
  final Map<String, dynamic> effects;
  
  @HiveField(8)
  final String? hint;

  const SecretZone({
    required this.id,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    this.targetSceneId,
    this.action,
    this.effects = const {},
    this.hint,
  });

  factory SecretZone.fromJson(Map<String, dynamic> json) => _$SecretZoneFromJson(json);
  Map<String, dynamic> toJson() => _$SecretZoneToJson(this);

  @override
  List<Object?> get props => [
        id,
        x,
        y,
        width,
        height,
        targetSceneId,
        action,
        effects,
        hint,
      ];
}

@HiveType(typeId: 5)
@JsonSerializable()
class SceneEffect extends Equatable {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final EffectType type;
  
  @HiveField(2)
  final Map<String, dynamic> parameters;
  
  @HiveField(3)
  final Duration delay;
  
  @HiveField(4)
  final Duration duration;

  const SceneEffect({
    required this.id,
    required this.type,
    this.parameters = const {},
    this.delay = Duration.zero,
    this.duration = const Duration(seconds: 1),
  });

  factory SceneEffect.fromJson(Map<String, dynamic> json) => _$SceneEffectFromJson(json);
  Map<String, dynamic> toJson() => _$SceneEffectToJson(this);

  @override
  List<Object?> get props => [id, type, parameters, delay, duration];
}

@HiveType(typeId: 6)
enum ChoiceStyle {
  @HiveField(0)
  button,
  
  @HiveField(1)
  card,
  
  @HiveField(2)
  text,
  
  @HiveField(3)
  icon,
}

@HiveType(typeId: 7)
enum EffectType {
  @HiveField(0)
  fadeIn,
  
  @HiveField(1)
  fadeOut,
  
  @HiveField(2)
  slideIn,
  
  @HiveField(3)
  slideOut,
  
  @HiveField(4)
  zoom,
  
  @HiveField(5)
  shake,
  
  @HiveField(6)
  glow,
  
  @HiveField(7)
  particle,
  
  @HiveField(8)
  typewriter,
}