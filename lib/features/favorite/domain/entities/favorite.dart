import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String id;
  final String? produkId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Favorite({
    required this.id,
    this.produkId,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props =>
      [id, produkId, createdAt, updatedAt];
}