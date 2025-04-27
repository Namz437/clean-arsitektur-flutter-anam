import 'package:cek/features/Auth/presentation/pages/login_pages.dart';
import 'package:cek/features/Auth/presentation/pages/register_pages.dart';
import 'package:cek/features/favorite/presentation/pages/favorite_pages.dart';
import 'package:cek/features/gudang/presentation/pages/gudang_pages.dart';
import 'package:cek/features/jenis_produk/presentation/pages/jenis_produk_pages.dart';
import 'package:cek/features/keranjang/presentation/pages/keranjang_pages.dart';
import 'package:cek/features/kurir/presentation/pages/kurir_pages.dart';
import 'package:cek/features/produk/presentation/pages/produk_pages.dart';
import 'package:cek/features/kategori_produk/presentation/pages/kategori_produk_pages.dart';
import 'package:cek/features/suplier/presentation/pages/suplier_pages.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'login',
        builder: (context, state) => const LoginPages(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPages(),
      ),
      GoRoute(
        path: '/produk',
        name: 'produk',
        builder: (context, state) => const ProdukPages(),
      ),
      GoRoute(
        path: '/kategori-produk',
        name: 'kategoriProduk',
        builder: (context, state) => const KategoriProdukPages(),
      ),
      GoRoute(
        path: '/jenis-produk',
        name: 'jenisProduk',
        builder: (context, state) => const JenisProdukPages(),
      ),
      GoRoute(
        path: '/suplier',
        name: 'suplier',
        builder: (context, state) => const SuplierPages(),
      ),
      GoRoute(
        path: '/gudang',
        name: 'gudang',
        builder: (context, state) => const GudangPages(),
      ),
      GoRoute(
        path: '/kurir',
        name: 'kurir',
        builder: (context, state) => const KurirPages(),
      ),
      GoRoute(
        path: '/keranjang',
        name: 'keranjang',
        builder: (context, state) => const KeranjangPages(),
      ),
      GoRoute(
        path: '/favorite',
        name: 'favorite',
        builder: (context, state) => const FavoritePages(),
      ),
    ],
  );
}
