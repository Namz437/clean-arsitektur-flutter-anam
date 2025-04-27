import 'package:cek/core/components/cubit/option_cubit.dart';
import 'package:cek/core/routes/routes.dart';
import 'package:cek/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cek/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:cek/features/gudang/presentation/bloc/gudang_bloc.dart';
import 'package:cek/features/jenis_produk/presentation/bloc/jenis_produk_bloc.dart';
import 'package:cek/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:cek/features/kurir/presentation/bloc/kurir_bloc.dart';
import 'package:cek/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:cek/features/kategori_produk/presentation/bloc/kategori_produk_bloc.dart';
import 'package:cek/features/suplier/presentation/bloc/suplier_bloc.dart';
import 'package:cek/firebase_options.dart';
import 'package:cek/my_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; 

Future<void> main() async {
  usePathUrlStrategy(); // Aktifkan clean URL
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
         BlocProvider<OptionCubit>(
          create: (context) => OptionCubit(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            signInWithEmail: myinjection(),
            registerWithEmail: myinjection(),
          ),
        ),

        BlocProvider<ProdukBloc>(
          create: (context) => ProdukBloc(
            produkUsecasesAdd: myinjection(),
            produkUsecasesDeleteProduk: myinjection(),
            produkUsecasesEditProduk: myinjection(),
            produkUsecasesGetAll: myinjection(),
            produkUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<KategoriProdukBloc>(
          create: (context) => KategoriProdukBloc(
            kategoriprodukUsecasesAdd: myinjection(),
            kategoriprodukUsecasesDeleteProduk: myinjection(),
            kategoriprodukUsecasesEditProduk: myinjection(),
            kategoriprodukUsecasesGetAll: myinjection(),
            kategoriprodukUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<JenisProdukBloc>(
          create: (context) => JenisProdukBloc(
            jenisprodukUsecasesAdd: myinjection(),
            jenisprodukUsecasesDeleteJenisProduk: myinjection(),
            jenisprodukUsecasesEditJenisProduk: myinjection(),
            jenisprodukUsecasesGetAll: myinjection(),
            jenisprodukUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<SuplierBloc>(
          create: (context) => SuplierBloc(
            suplierUsecasesAdd: myinjection(),
            suplierUsecasesDeleteSuplier: myinjection(),
            suplierUsecasesEditSuplier: myinjection(),
            suplierUsecasesGetAll: myinjection(),
            suplierUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<GudangBloc>(
          create: (context) => GudangBloc(
            gudangUsecasesAdd: myinjection(),
            gudangUsecasesDeleteGudang: myinjection(),
            gudangUsecasesEditGudang: myinjection(),
            gudangUsecasesGetAll: myinjection(),
            gudangUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<KurirBloc>(
          create: (context) => KurirBloc(
            kurirUsecasesAdd: myinjection(),
            kurirUsecasesDeleteKurir: myinjection(),
            kurirUsecasesEditKurir: myinjection(),
            kurirUsecasesGetAll: myinjection(),
            kurirUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<KeranjangBloc>(
          create: (context) => KeranjangBloc(
            keranjangUsecasesAdd: myinjection(),
            keranjangUsecasesDeleteKeranjang: myinjection(),
            keranjangUsecasesEditKeranjang: myinjection(),
            keranjangUsecasesGetAll: myinjection(),
            keranjangUsecasesGetById: myinjection(),
          ),
        ),
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(
            favoriteUsecasesAdd: myinjection(),
            favoriteUsecasesDeleteFavorite: myinjection(),
            favoriteUsecasesEditFavorite: myinjection(),
            favoriteUsecasesGetAll: myinjection(),
            favoriteUsecasesGetById: myinjection(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: MyRouter().router,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
