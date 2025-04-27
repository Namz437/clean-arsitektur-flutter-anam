import 'package:equatable/equatable.dart';

class Keranjang extends Equatable {
  final String id;
  final String? produkUid;
  final int jumlah;
  final String? harga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Keranjang({
    required this.id,
    this.produkUid,
    required this.jumlah,
    this.harga,
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props =>
      [id, produkUid, jumlah, harga, createdAt, updatedAt];
}