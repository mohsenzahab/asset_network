// ignore_for_file: prefer_const_constructors_in_immutables

import 'cgs.dart';

class Stock extends CGS {
  Stock(
      {required super.name,
      super.id,
      this.typeId,
      this.username,
      this.maxValue,
      this.minValue,
      this.namadStatus,
      required this.lastPrice,
      required this.lastname,
      this.profileImageT});
  final int? typeId;
  final String? username;
  final String lastname;
  final int? profileImageT;
  final int? maxValue;
  final int? minValue;
  final String? namadStatus;
  final int? lastPrice;

  @override
  List<Object?> get props => [name, id, lastname, profileImageT];
}
