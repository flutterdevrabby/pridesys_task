import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'character_response.g.dart';

@HiveType(typeId: 0)
class CharacterResponse {
  @HiveField(0)
  Info? info;

  @HiveField(1)
  List<Result>? results;

  CharacterResponse({this.info, this.results});

  CharacterResponse copyWith({Info? info, List<Result>? results}) =>
      CharacterResponse(
        info: info ?? this.info,
        results: results ?? this.results,
      );

  factory CharacterResponse.fromRawJson(String str) =>
      CharacterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "info": info?.toJson(),
    "results": results == null
        ? []
        : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 1)
class Info {
  @HiveField(0)
  int? count;
  @HiveField(1)
  int? pages;
  @HiveField(2)
  String? next;
  @HiveField(3)
  dynamic prev;

  Info({this.count, this.pages, this.next, this.prev});

  Info copyWith({int? count, int? pages, String? next, dynamic prev}) => Info(
    count: count ?? this.count,
    pages: pages ?? this.pages,
    next: next ?? this.next,
    prev: prev ?? this.prev,
  );

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    count: json["count"],
    pages: json["pages"],
    next: json["next"],
    prev: json["prev"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "pages": pages,
    "next": next,
    "prev": prev,
  };
}

@HiveType(typeId: 2)
class Result {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? species;
  @HiveField(4)
  String? type;
  @HiveField(5)
  String? gender;
  @HiveField(6)
  Location? origin;
  @HiveField(7)
  Location? location;
  @HiveField(8)
  String? image;
  @HiveField(9)
  List<String>? episode;
  @HiveField(10)
  String? url;
  @HiveField(11)
  DateTime? created;

  Result({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  Result copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
    Location? origin,
    Location? location,
    String? image,
    List<String>? episode,
    String? url,
    DateTime? created,
  }) => Result(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    type: type ?? this.type,
    gender: gender ?? this.gender,
    origin: origin ?? this.origin,
    location: location ?? this.location,
    image: image ?? this.image,
    episode: episode ?? this.episode,
    url: url ?? this.url,
    created: created ?? this.created,
  );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: json["origin"] == null ? null : Location.fromJson(json["origin"]),
    location: json["location"] == null
        ? null
        : Location.fromJson(json["location"]),
    image: json["image"],
    episode: json["episode"] == null
        ? []
        : List<String>.from(json["episode"]!.map((x) => x)),
    url: json["url"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin?.toJson(),
    "location": location?.toJson(),
    "image": image,
    "episode": episode == null
        ? []
        : List<dynamic>.from(episode!.map((x) => x)),
    "url": url,
    "created": created?.toIso8601String(),
  };
}

@HiveType(typeId: 3)
class Location {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? url;

  Location({this.name, this.url});

  Location copyWith({String? name, String? url}) =>
      Location(name: name ?? this.name, url: url ?? this.url);

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}
