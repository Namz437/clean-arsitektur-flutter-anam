import 'package:cek/features/produk/data/models/produk_model.dart';
import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProdukRemoteDataSource {
  Future<List<Produk>> getAllProduk();
  Future<Produk> getProdukById({required String id});
  // void tidak ada pengembalian
  Future<void> addProduk({required ProdukModel produk});
  Future<void> editProduk({required ProdukModel produk});
  Future<void> deleteProduk({required String id});
}

class ProdukRemoteDataSourceImplementation implements ProdukRemoteDataSource {
  //menggunakan firebase fire store
  final FirebaseFirestore firebaseFirestore;

  ProdukRemoteDataSourceImplementation({required this.firebaseFirestore});

  @override
  Future<void> addProduk({required ProdukModel produk}) async {
    await firebaseFirestore.collection('produks').add(produk.toFireStore());
  }

  @override
  Future<void> deleteProduk({required String id}) async {
    await firebaseFirestore.collection('produks').doc(id).delete();
  }

  @override
  Future<void> editProduk({required ProdukModel produk}) async {
    await firebaseFirestore
        .collection('produks')
        .doc(produk.id)
        .update(produk.toFireStore());
  }

  @override
  Future<List<Produk>> getAllProduk() async {
    final data = await firebaseFirestore.collection('produks').get();
    return data.docs
        .map(
          (e) => ProdukModel.fromFirestore(e),
        )
        .toList();
  }

  @override
  Future<Produk> getProdukById({required String id}) async {
    final data = await firebaseFirestore.collection('produks').doc(id).get();
    return ProdukModel.fromFirestore(data);
  }
}