import 'package:equatable/equatable.dart';

class Suplier extends Equatable{
  final String id;
  final String namaSuplier;
  final String nomorTelpon;
  final String alamat;

  const Suplier(
      {required this.id,
      required this.namaSuplier,
      required this.nomorTelpon,
      required this.alamat,
      });
      
        @override
        List<Object?> get props => [id, namaSuplier, nomorTelpon, alamat];
}
