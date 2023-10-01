// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) => JsonMatch(
      id: json['id'] as String,
      numberOfPlayers: json['numberOfPlayers'] as int,
      maxPoints: json['maxPoints'] as int,
      status: $enumDecode(_$MatchStatusEnumMap, json['status']),
      players: (json['players'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, JsonPlayer.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
      'id': instance.id,
      'numberOfPlayers': instance.numberOfPlayers,
      'maxPoints': instance.maxPoints,
      'status': _$MatchStatusEnumMap[instance.status]!,
      'players': instance.players,
    };

const _$MatchStatusEnumMap = {
  MatchStatus.waitingForPlayers: 'waitingForPlayers',
  MatchStatus.playing: 'playing',
  MatchStatus.summary: 'summary',
  MatchStatus.finished: 'finished',
};
