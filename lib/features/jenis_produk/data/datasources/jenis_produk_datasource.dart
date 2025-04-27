import 'package:cek/features/jenis_produk/data/models/jenis_produk_model.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class JenisProdukRemoteDataSource {
  Future<List<JenisProduk>> getAllJenisProduk();
  Future<JenisProduk> getJenisProdukById({required String id});
  // void tidak ada pengembalian
  Future<void> addJenisProduk({required JenisProdukModel jenisProduk});
  Future<void> editJenisProduk({required JenisProdukModel jenisProduk});
  Future<void> deleteJenisProduk({required String id});
}

class JenisProdukRemoteDataSourceImplementation implements JenisProdukRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  JenisProdukRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addJenisProduk({required JenisProdukModel jenisProduk}) async {
    await firebaseFirestore.collection('jenis-produks').add(jenisProduk.toFireStore());
  }

  @override
  Future<void> deleteJenisProduk({required String id}) async {
    await firebaseFirestore.collection('jenis-produks').doc(id).delete();
  }

  @override
  Future<void> editJenisProduk({required JenisProdukModel jenisProduk}) async {
    await firebaseFirestore
        .collection('jenis-produks')
        .doc(jenisProduk.id)
        .update(jenisProduk.toFireStore());
  }

  @override
  Future<List<JenisProduk>> getAllJenisProduk() async {
    final data = await firebaseFirestore.collection('jenis-produks').get();
    return data.docs
        .map(
          (e) => JenisProdukModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<JenisProduk> getJenisProdukById({required String id}) async {
    final data = await firebaseFirestore.collection('jenis-produks').doc(id).get();
    return JenisProdukModel.fromFirestore(data);
  }
}