import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final String type;
  final String slug;
  final String nameWithType;
  final String path;
  final String pathWithType;
  const City({
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
    required this.path,
    required this.pathWithType,
    required this.code,
    required this.parentCode});
  final String code;

  final String parentCode;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        name: json['name'],
        type: json['type'],
        slug: json['slug'],
        nameWithType: json['name_with_type'],
        path: json['path'],
        pathWithType: json['path_with_type'],
        code: json['code'],
        parentCode: json['parent_code']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'slug': slug,
    'type': type,
    'name_with_type': nameWithType,
    'path_with_type': pathWithType,
    'code': code,
    'parent_code': parentCode,
  };

  @override
  String toString() {
    return 'city name: $name - parent code: $parentCode';
  }

  @override
  List<Object?> get props => [
    name,
    slug,
    type,
    nameWithType,
    pathWithType,
    code,
    parentCode
  ];
}