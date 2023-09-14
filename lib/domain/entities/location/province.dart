import 'package:equatable/equatable.dart';

class Province extends Equatable {
  const Province(this.id, this.name);
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
