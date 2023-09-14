import 'package:equatable/equatable.dart';

abstract class CGS extends Equatable {
  CGS({required this.name, this.id});
  final String name;
  final int? id;
}
