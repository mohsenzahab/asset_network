import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City(this.id, this.name);
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
