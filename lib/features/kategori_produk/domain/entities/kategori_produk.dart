import 'package:equatable/equatable.dart';

class KategoriProduk extends Equatable{
  final String id;
  final String namaKategori;
  final String deskripsi;
  

  const KategoriProduk(
      {required this.id,
      required this.namaKategori,
      required this.deskripsi,
      });
      
        @override
        List<Object?> get props => [id, namaKategori, deskripsi];
}
