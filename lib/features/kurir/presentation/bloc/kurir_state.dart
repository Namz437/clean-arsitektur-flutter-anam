part of 'kurir_bloc.dart';

abstract class KurirState extends Equatable {}

class KurirInitial extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KurirStateLoading extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class KurirStateError extends KurirState {
  final String message;

  KurirStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class KurirStateLoadedAll extends KurirState {
  final List<Kurir> kurirs;

  KurirStateLoadedAll({required this.kurirs});

  @override
  // TODO: implement props
  List<Object?> get props => [kurirs];
}

class KurirStateLoaded extends KurirState {
  final Kurir kurirs;

  KurirStateLoaded({required this.kurirs});

  @override
  // TODO: implement props
  List<Object?> get props => [kurirs];
}

class KurirStateSuccess extends KurirState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

