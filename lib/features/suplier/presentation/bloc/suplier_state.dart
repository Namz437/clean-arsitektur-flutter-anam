part of 'suplier_bloc.dart';

abstract class SuplierState extends Equatable {}

class SuplierInitial extends SuplierState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuplierStateLoading extends SuplierState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SuplierStateError extends SuplierState {
  final String message;

  SuplierStateError({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SuplierStateLoadedAll extends SuplierState {
  final List<Suplier> supliers;

  SuplierStateLoadedAll({required this.supliers});

  @override
  // TODO: implement props
  List<Object?> get props => [supliers];
}

class SuplierStateLoaded extends SuplierState {
  final Suplier supliers;

  SuplierStateLoaded({required this.supliers});

  @override
  // TODO: implement props
  List<Object?> get props => [supliers];
}

class SuplierStateSuccess extends SuplierState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}