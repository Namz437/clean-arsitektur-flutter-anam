part of 'jenis_produk_bloc.dart';

abstract class JenisProdukState extends Equatable {}

class JenisProdukInitial extends JenisProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JenisProdukStateLoading extends JenisProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class JenisProdukStateError extends JenisProdukState {
  final String message;

  JenisProdukStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class JenisProdukStateLoadedAll extends JenisProdukState {
  final List<JenisProduk> jenisProduks;

  JenisProdukStateLoadedAll({required this.jenisProduks});

  @override
  // TODO: implement props
  List<Object?> get props => [jenisProduks];
}

class JenisProdukStateLoaded extends JenisProdukState {
  final JenisProduk jenisProduks;

  JenisProdukStateLoaded({required this.jenisProduks});

  @override
  // TODO: implement props
  List<Object?> get props => [jenisProduks];
}

class JenisProdukStateSuccess extends JenisProdukState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}