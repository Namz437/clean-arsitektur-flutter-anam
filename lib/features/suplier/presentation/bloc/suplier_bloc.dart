import 'package:bloc/bloc.dart';
import 'package:cek/features/suplier/data/models/suplier_model.dart';
import 'package:cek/features/suplier/domain/entities/suplier.dart';
import 'package:cek/features/suplier/domain/usecases/suplier_usecase.dart';
import 'package:equatable/equatable.dart';

part 'suplier_event.dart';
part 'suplier_state.dart';

class SuplierBloc extends Bloc<SuplierEvent, SuplierState> {
  final SuplierUsecasesAddSuplier suplierUsecasesAdd;
  final SuplierUsecasesEditSuplier suplierUsecasesEditSuplier;
  final SuplierUsecasesDeleteSuplier suplierUsecasesDeleteSuplier;
  final SuplierUsecasesGetAll suplierUsecasesGetAll;
  final SuplierUsecasesGetById suplierUsecasesGetById;
  SuplierBloc(
      {required this.suplierUsecasesAdd,
      required this.suplierUsecasesEditSuplier,
      required this.suplierUsecasesDeleteSuplier,
      required this.suplierUsecasesGetAll,
      required this.suplierUsecasesGetById})
      : super(SuplierInitial()) {
    on<SuplierEventAdd>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecasesAdd.execute(suplier: event.suplierModel);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventEdit>((event, emit) async {
      emit(SuplierStateLoading());
      final data =
          await suplierUsecasesEditSuplier.execute(suplier: event.suplierModel);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventDelete>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecasesDeleteSuplier.execute(id: event.id);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateSuccess());
        },
      );
    });
    on<SuplierEventGetAll>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateLoadedAll(supliers: r));
        },
      );
    });
    on<SuplierEventGetById>((event, emit) async {
      emit(SuplierStateLoading());
      final data = await suplierUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(SuplierStateError(message: l.toString()));
        },
        (r) {
          emit(SuplierStateLoaded(supliers: r));
        },
      );
    });
  }
}
