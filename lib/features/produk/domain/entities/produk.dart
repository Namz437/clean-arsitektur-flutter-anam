import 'package:equatable/equatable.dart';

class Produk extends Equatable {
  final String id;
  final String namaProduk;
  final String harga;
  final String deskripsi;
  final String? jenisProdukUid; 
  final String? kategoriProdukUid;
  final String? gudangUid;

  const Produk({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.deskripsi,
    this.jenisProdukUid, 
    this.kategoriProdukUid,
    this.gudangUid
  });

  @override
  List<Object?> get props => [
        id,
        namaProduk,
        harga,
        deskripsi,
        jenisProdukUid, 
        kategoriProdukUid,
        gudangUid
      ];
}
