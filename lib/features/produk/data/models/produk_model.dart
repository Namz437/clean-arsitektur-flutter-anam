import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukModel extends Produk {
  const ProdukModel(
      {required super.id,
      required super.namaProduk,
      required super.harga,
      required super.deskripsi,
      required super.jenisProdukUid,
      required super.kategoriProdukUid,
      required super.gudangUid 
      });

  factory ProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProdukModel(
        id: doc.id,
        namaProduk: data['namaProduk'],
        harga: data['harga'],
        deskripsi: data['deskripsi'],
        jenisProdukUid: data['jenisProdukUid'],
        kategoriProdukUid: data['kategoriProdukUid'],
        gudangUid: data['gudangUid']
        );
  }

  Map<String, dynamic> toFireStore() {
    return {
      'namaProduk': namaProduk,
      'harga': harga,
      'deskripsi': deskripsi,
      if (jenisProdukUid != null) 'jenisProdukUid': jenisProdukUid,
      if (kategoriProdukUid != null) 'kategoriProdukUid': kategoriProdukUid,
      if (gudangUid != null) 'gudangUid': gudangUid

    };
  }
}
