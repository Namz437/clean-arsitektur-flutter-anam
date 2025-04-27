import 'package:cek/core/components/cubit/option_cubit.dart';
import 'package:cek/features/Auth/data/datasources/auth_datasource.dart';
import 'package:cek/features/Auth/data/repositories/auth_repositories_implementation.dart';
import 'package:cek/features/Auth/domain/repositories/users_repositories.dart';
import 'package:cek/features/Auth/domain/usecases/auth_usecase.dart';
import 'package:cek/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cek/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:cek/features/favorite/data/repositories/favorite_repo_impl.dart';
import 'package:cek/features/favorite/domain/repositories/favorite_repo.dart';
import 'package:cek/features/favorite/domain/usecases/favorite_usecase.dart';
import 'package:cek/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:cek/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:cek/features/gudang/data/repositories/gudang_repo_impl.dart';
import 'package:cek/features/gudang/domain/repositories/gudang_repo.dart';
import 'package:cek/features/gudang/domain/usecases/gudang_usecase.dart';
import 'package:cek/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:cek/features/jenis_produk/data/datasources/jenis_produk_datasource.dart';
import 'package:cek/features/jenis_produk/data/repositories/jenis_produk_repo_impl.dart';
import 'package:cek/features/jenis_produk/domain/repositories/jenis_produk_repo.dart';
import 'package:cek/features/jenis_produk/domain/usecases/jenis_produk_uscase.dart';
import 'package:cek/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:cek/features/keranjang/data/datasources/keranjang_datasource.dart';
import 'package:cek/features/keranjang/data/repositories/keranjang_repo_impl.dart';
import 'package:cek/features/keranjang/domain/repositories/keranjang_repo.dart';
import 'package:cek/features/keranjang/domain/usecases/keranjang_usecase.dart';
import 'package:cek/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:cek/features/kurir/data/datasources/kurir_datasource.dart';
import 'package:cek/features/kurir/data/repositories/kurir_repo_impl.dart';
import 'package:cek/features/kurir/domain/repositories/kurir_repo.dart';
import 'package:cek/features/kurir/domain/usecases/kurir_usecase.dart';
import 'package:cek/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:cek/features/produk/data/datasources/produk_datasource.dart';
import 'package:cek/features/produk/data/repositories/produk_repo_impl.dart';
import 'package:cek/features/produk/domain/repositories/produk_repositories.dart';
import 'package:cek/features/produk/domain/usecases/produk_usecases.dart';
import 'package:cek/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:cek/features/kategori_produk/data/datasources/kategori_produk_datasource.dart';
import 'package:cek/features/kategori_produk/data/repositories/kategori_produk_repo_impl.dart';
import 'package:cek/features/kategori_produk/domain/repositories/kategori_produk_repo.dart';
import 'package:cek/features/kategori_produk/domain/usecases/kategori_produk_usecase.dart';
import 'package:cek/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:cek/features/suplier/data/datasources/suplier_datasource.dart';
import 'package:cek/features/suplier/data/repositories/suplier_repo_impl.dart';
import 'package:cek/features/suplier/domain/repositories/suplier_repo.dart';
import 'package:cek/features/suplier/domain/usecases/suplier_usecase.dart';
import 'package:cek/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

var myinjection = GetIt.instance;
Future<void> init() async {
  myinjection.registerLazySingleton(() => FirebaseAuth.instance);
  myinjection.registerLazySingleton(() => FirebaseFirestore.instance);
  // myinjection.registerLazySingleton(() => FirebaseStorage.instance);

  // Option
  myinjection.registerFactory(
    () => OptionCubit(),
  );


  /// FEATURE - AUTH
  // BLOC
  myinjection.registerFactory(
    () => AuthBloc(
      signInWithEmail: myinjection(),
      registerWithEmail: myinjection(),
    ),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => SignInWithEmail(repository: myinjection()),
  );

  myinjection.registerLazySingleton(
    () => RegisterWithEmail(repository: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoriesImplementation(dataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImplementation(firebaseAuth: myinjection()));


  /// FEATURE - PRODUK
  // BLOC
  myinjection.registerFactory(
    () => ProdukBloc(
        produkUsecasesAdd: myinjection(),
        produkUsecasesDeleteProduk: myinjection(),
        produkUsecasesEditProduk: myinjection(),
        produkUsecasesGetAll: myinjection(),
        produkUsecasesGetById: myinjection()),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => ProdukUsecasesAddProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesDeleteProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesEditProduk(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetAll(produkRepositories: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => ProdukUsecasesGetById(produkRepositories: myinjection()),
  );

  // REPOSITORY
  myinjection.registerLazySingleton<ProdukRepositories>(
    () => ProdukRepoImpl(produkRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<ProdukRemoteDataSource>(() =>
      ProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));


/// FEATURE - KATEGORI PRODUK
  // BLOC
  myinjection.registerFactory(
    () => KategoriProdukBloc(
        kategoriprodukUsecasesAdd: myinjection(),
        kategoriprodukUsecasesDeleteProduk: myinjection(),
        kategoriprodukUsecasesEditProduk: myinjection(),
        kategoriprodukUsecasesGetAll: myinjection(),
        kategoriprodukUsecasesGetById: myinjection()),
  );

  // USECASE
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecasesAddKategoriProduk(kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecasesDeleteKategoriProduk(kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecasesEditKategoriProduk(kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecasesGetAll(kategoriProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KategoriProdukUsecasesGetById(kategoriProdukRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<KategoriProdukRepo>(
    () => KategoriProdukRepoImpl(kategoriprodukRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KategoriProdukRemoteDataSource>(() =>
      KategoriProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));


/// FEATURE - JENIS PRODUK
  // BLOC
  myinjection.registerFactory(
    () => JenisProdukBloc(
        jenisprodukUsecasesAdd: myinjection(),
        jenisprodukUsecasesDeleteJenisProduk: myinjection(),
        jenisprodukUsecasesEditJenisProduk: myinjection(),
        jenisprodukUsecasesGetAll: myinjection(),
        jenisprodukUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => JenisProdukUsecasesAddJenisProduk(jenisProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisProdukUsecasesDeleteJenisProduk(jenisProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisProdukUsecasesEditJenisProduk(jenisProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisProdukUsecasesGetAll(jenisProdukRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => JenisProdukUsecasesGetById(jenisProdukRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<JenisProdukRepo>(
    () => JenisProdukRepoImpl(jenisprodukRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<JenisProdukRemoteDataSource>(() =>
      JenisProdukRemoteDataSourceImplementation(firebaseFirestore: myinjection()));


  /// FEATURE - SUPLIER
  // BLOC
  myinjection.registerFactory(
    () => SuplierBloc(
        suplierUsecasesAdd: myinjection(),
        suplierUsecasesDeleteSuplier: myinjection(),
        suplierUsecasesEditSuplier: myinjection(),
        suplierUsecasesGetAll: myinjection(),
        suplierUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => SuplierUsecasesAddSuplier(suplierRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesDeleteSuplier(suplierRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesEditSuplier(suplierRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesGetAll(suplierRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => SuplierUsecasesGetById(suplierRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<SuplierRepo>(
    () => SuplierRepoImpl(suplierRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<SuplierRemoteDataSource>(() =>
      SuplierRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

  
  /// FEATURE - GUDANG
  // BLOC
  myinjection.registerFactory(
    () => GudangBloc(
        gudangUsecasesAdd: myinjection(),
        gudangUsecasesDeleteGudang: myinjection(),
        gudangUsecasesEditGudang: myinjection(),
        gudangUsecasesGetAll: myinjection(),
        gudangUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => GudangUsecasesAddGudang(gudangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesDeleteGudang(gudangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesEditGudang(gudangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesGetAll(gudangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => GudangUsecasesGetById(gudangRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<GudangRepo>(
    () => GudangRepoImpl(gudangRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<GudangRemoteDataSource>(() =>
      GudangRemoteDataSourceImplementation(firebaseFirestore: myinjection()));


  /// FEATURE - KURIR
  // BLOC
  myinjection.registerFactory(
    () => KurirBloc(
        kurirUsecasesAdd: myinjection(),
        kurirUsecasesDeleteKurir: myinjection(),
        kurirUsecasesEditKurir: myinjection(),
        kurirUsecasesGetAll: myinjection(),
        kurirUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => KurirUsecasesAddKurir(kurirRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesDeleteKurir(kurirRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesEditKurir(kurirRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesGetAll(kurirRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KurirUsecasesGetById(kurirRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<KurirRepo>(
    () => KurirRepoImpl(kurirRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KurirRemoteDataSource>(() =>
      KurirRemoteDataSourceImplementation(firebaseFirestore: myinjection()));


  /// FEATURE - Keranjang
  // BLOC
  myinjection.registerFactory(
    () => KeranjangBloc(
        keranjangUsecasesAdd: myinjection(),
        keranjangUsecasesDeleteKeranjang: myinjection(),
        keranjangUsecasesEditKeranjang: myinjection(),
        keranjangUsecasesGetAll: myinjection(),
        keranjangUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesAddKeranjang(keranjangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesDeleteKeranjang(keranjangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesEditKeranjang(keranjangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesGetAll(keranjangRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => KeranjangUsecasesGetById(keranjangRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<KeranjangRepo>(
    () => KeranjangRepoImpl(keranjangRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<KeranjangRemoteDataSource>(() =>
      KeranjangRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

    /// FEATURE - Favorite
  // BLOC
  myinjection.registerFactory(
    () => FavoriteBloc(
        favoriteUsecasesAdd: myinjection(),
        favoriteUsecasesDeleteFavorite: myinjection(),
        favoriteUsecasesEditFavorite: myinjection(),
        favoriteUsecasesGetAll: myinjection(),
        favoriteUsecasesGetById: myinjection()),
  );

   // USECASE
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesAddFavorite(favoriteRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesDeleteFavorite(favoriteRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesEditFavorite(favoriteRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesGetAll(favoriteRepo: myinjection()),
  );
  myinjection.registerLazySingleton(
    () => FavoriteUsecasesGetById(favoriteRepo: myinjection()),
  );

   // REPOSITORY
  myinjection.registerLazySingleton<FavoriteRepo>(
    () => FavoriteRepoImpl(favoriteRemoteDataSource: myinjection()),
  );

  // DATA SOURCE
  myinjection.registerLazySingleton<FavoriteRemoteDataSource>(() =>
      FavoriteRemoteDataSourceImplementation(firebaseFirestore: myinjection()));

}


