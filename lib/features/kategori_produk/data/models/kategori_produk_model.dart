import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriProdukModel extends KategoriProduk {
  const KategoriProdukModel(
      {required super.id,
      required super.namaKategori,
      required super.deskripsi});

  factory KategoriProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return KategoriProdukModel(
        id: doc.id,
        namaKategori: data['namaKategori'],
        deskripsi: data['deskripsi']);
  }

  Map<String, dynamic> toFireStore() {
    return {'namaKategori': namaKategori, 'deskripsi': deskripsi};
  }
}