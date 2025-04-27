import 'package:bloc/bloc.dart';
import 'package:cek/features/kurir/data/models/kurir_model.dart';
import 'package:cek/features/kurir/domain/entities/kurir.dart';
import 'package:cek/features/kurir/domain/usecases/kurir_usecase.dart';
import 'package:equatable/equatable.dart';

part 'kurir_event.dart';
part 'kurir_state.dart';

class KurirBloc extends Bloc<KurirEvent, KurirState> {
  final KurirUsecasesAddKurir kurirUsecasesAdd;
  final KurirUsecasesEditKurir kurirUsecasesEditKurir;
  final KurirUsecasesDeleteKurir kurirUsecasesDeleteKurir;
  final KurirUsecasesGetAll kurirUsecasesGetAll;
  final KurirUsecasesGetById kurirUsecasesGetById;
  KurirBloc(
      {required this.kurirUsecasesAdd,
      required this.kurirUsecasesEditKurir,
      required this.kurirUsecasesDeleteKurir,
      required this.kurirUsecasesGetAll,
      required this.kurirUsecasesGetById})
      : super(KurirInitial()) {
    on<KurirEventAdd>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesAdd.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventEdit>((event, emit) async {
      emit(KurirStateLoading());
      final data =
          await kurirUsecasesEditKurir.execute(kurir: event.kurirModel);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventDelete>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesDeleteKurir.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateSuccess());
        },
      );
    });
    on<KurirEventGetAll>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesGetAll.execute();
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoadedAll(kurirs: r));
        },
      );
    });
    on<KurirEventGetById>((event, emit) async {
      emit(KurirStateLoading());
      final data = await kurirUsecasesGetById.execute(id: event.id);
      data.fold(
        (l) {
          emit(KurirStateError(message: l.toString()));
        },
        (r) {
          emit(KurirStateLoaded(kurirs: r));
        },
      );
    });
  }
}
