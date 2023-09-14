import 'package:equatable/equatable.dart';

class District extends Equatable {
  const District(this.id, this.name);
  final int id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
