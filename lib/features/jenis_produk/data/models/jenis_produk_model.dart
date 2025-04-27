import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JenisProdukModel extends JenisProduk {
  const JenisProdukModel(
      {required super.id,
      required super.namaJenis,
      required super.deskripsi,
      });

  factory JenisProdukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JenisProdukModel(
        id: doc.id,
        namaJenis: data['namaJenis'],
        deskripsi: data['deskripsi'],
        );
  }

  Map<String, dynamic> toFireStore() {
    return {'namaJenis': namaJenis, 'deskripsi': deskripsi};
  }
}