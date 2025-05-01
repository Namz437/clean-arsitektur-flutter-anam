import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/favorite/data/datasources/favorite_datasource.dart';
import 'package:cek/features/favorite/data/models/favorite_model.dart';
import 'package:cek/features/gudang/data/datasources/gudang_datasource.dart';
import 'package:cek/features/keranjang/data/models/keranjang_model.dart';
import 'package:cek/features/produk/data/models/produk_model.dart';
import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:cek/features/produk/presentation/bloc/produk_bloc.dart';
import 'package:cek/features/jenis_produk/data/datasources/jenis_produk_datasource.dart';
import 'package:cek/features/jenis_produk/domain/entities/jenis_produk.dart';
import 'package:cek/features/kategori_produk/data/datasources/kategori_produk_datasource.dart';
import 'package:cek/features/kategori_produk/domain/entities/kategori_produk.dart';
import 'package:cek/features/gudang/domain/entities/gudang.dart';
import 'package:cek/features/keranjang/data/datasources/keranjang_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukPages extends StatelessWidget {
  const ProdukPages({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProdukBloc>().add(ProdukEventGetAll());

    // Datasource untuk ambil jenisProduk, kategoriProduk, dan gudang
    final jenisProdukDataSource = JenisProdukRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    final kategoriProdukDataSource =
        KategoriProdukRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    final gudangDataSource = GudangRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    final keranjangDataSource = KeranjangRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    final favoriteDataSource = FavoriteRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Produk Pages'),
        actions: [
          IconButton(
            onPressed: () {
              showProdukFormModal(context);
            },
            icon: Icon(Icons.plus_one),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: BlocListener<ProdukBloc, ProdukState>(
        listener: (context, state) {
          if (state is ProdukStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<ProdukBloc, ProdukState>(
          builder: (context, state) {
            if (state is ProdukStateLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProdukStateLoadedAll) {
              return ListView.builder(
                itemCount: state.produks.length,
                itemBuilder: (context, index) {
                  final produk = state.produks[index];

                  return FutureBuilder<List<dynamic>>(
                    future: Future.wait([
                      produk.jenisProdukUid != null
                          ? jenisProdukDataSource.getJenisProdukById(
                              id: produk.jenisProdukUid!)
                          : Future.value(null),
                      produk.kategoriProdukUid != null
                          ? kategoriProdukDataSource.getKategoriProdukById(
                              id: produk.kategoriProdukUid!)
                          : Future.value(null),
                      produk.gudangUid != null
                          ? gudangDataSource.getGudangById(
                              id: produk.gudangUid!)
                          : Future.value(null),
                    ]),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text("Loading..."));
                      }

                      final jenisProduk = snapshot.data?[0] as JenisProduk?;
                      final kategoriProduk =
                          snapshot.data?[1] as KategoriProduk?;
                      final gudang = snapshot.data?[2] as Gudang?;

                      final namaJenis =
                          jenisProduk?.namaJenis ?? 'Tidak ada jenis';
                      final namaKategori =
                          kategoriProduk?.namaKategori ?? 'Tidak ada kategori';
                      final namaGudang =
                          gudang?.namaGudang ?? 'Tidak ada gudang';

                      return ListTile(
                        title: Text(produk.namaProduk),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(produk.harga),
                            Text(namaJenis),
                            Text(namaKategori),
                            Text(namaGudang),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                showProdukFormModal(
                                  context,
                                  isEdit: true,
                                  produk: produk,
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<ProdukBloc>()
                                    .add(ProdukEventDelete(id: produk.id));
                                context
                                    .read<ProdukBloc>()
                                    .add(ProdukEventGetAll());
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () async {
                                // Fitur tambah produk ke keranjang
                                final keranjangItem = KeranjangModel(
                                  id: produk.id,
                                  produkUid: produk.id,
                                  jumlah: 1,
                                  harga: null,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  isNew: true,
                                );

                                try {
                                  // Pake keranjangDataSource buat nambahin item ke keranjang
                                  await keranjangDataSource.addKeranjang(
                                      keranjang: keranjangItem);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            '${produk.namaProduk} ditambahkan ke keranjang')),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Gagal menambahkan produk ke keranjang')),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () async {
                                // Fitur tambah produk ke daftar favorit
                                final favoriteItem = FavoriteModel(
                                  id: produk.id,
                                  produkId: produk.id,
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  isNew: true,
                                );

                                try {
                                  // Pake favoriteDataSource buat nambahin item ke favorit
                                  await favoriteDataSource.addFavorite(
                                      favorite: favoriteItem);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${produk.namaProduk} ditambahkan ke favorit'),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Gagal menambahkan produk ke favorit'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is ProdukStateError) {
              return Center(child: Text(state.message));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  void showProdukFormModal(BuildContext context,
      {bool isEdit = false, Produk? produk}) {
    final namaController =
        TextEditingController(text: isEdit ? produk?.namaProduk : '');
    final hargaController =
        TextEditingController(text: isEdit ? produk?.harga : '');
    final deskripsiController =
        TextEditingController(text: isEdit ? produk?.deskripsi : '');

    // Tambahkan kontroler untuk dropdown
    final jenisProdukUidController =
        TextEditingController(text: isEdit ? produk?.jenisProdukUid : null);
    final kategoriProdukUidController =
        TextEditingController(text: isEdit ? produk?.kategoriProdukUid : null);
    final gudangUidController =
        TextEditingController(text: isEdit ? produk?.gudangUid : null);

    // Fungsi untuk mengambil data jenis, kategori produk, dan gudang
    final jenisProdukDataSource = JenisProdukRemoteDataSourceImplementation(
        firebaseFirestore: FirebaseFirestore.instance);
    final kategoriProdukDataSource =
        KategoriProdukRemoteDataSourceImplementation(
            firebaseFirestore: FirebaseFirestore.instance);
    final gudangDataSource = GudangRemoteDataSourceImplementation(
        firebaseFirestore: FirebaseFirestore.instance);

    // Ambil data jenisProduk, kategoriProduk, dan gudang
    final Future<List<JenisProduk>> jenisProdukList =
        jenisProdukDataSource.getAllJenisProduk();
    final Future<List<KategoriProduk>> kategoriProdukList =
        kategoriProdukDataSource.getAllKategoriProduk();
    final Future<List<Gudang>> gudangList = gudangDataSource.getAllGudang();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              TextFormField(
                controller: hargaController,
                decoration: InputDecoration(labelText: 'Harga Produk'),
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              FutureBuilder<List<JenisProduk>>(
                future: jenisProdukList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final jenisProdukItems = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Jenis Produk'),
                    value: isEdit ? produk?.jenisProdukUid : null,
                    items: jenisProdukItems
                        .map((jenisProduk) => DropdownMenuItem<String>(
                              value: jenisProduk.id,
                              child: Text(jenisProduk.namaJenis),
                            ))
                        .toList(),
                    onChanged: (value) {
                      jenisProdukUidController.text = value!;
                    },
                  );
                },
              ),
              FutureBuilder<List<KategoriProduk>>(
                future: kategoriProdukList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final kategoriProdukItems = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Kategori Produk'),
                    value: isEdit ? produk?.kategoriProdukUid : null,
                    items: kategoriProdukItems
                        .map((kategoriProduk) => DropdownMenuItem<String>(
                              value: kategoriProduk.id,
                              child: Text(kategoriProduk.namaKategori),
                            ))
                        .toList(),
                    onChanged: (value) {
                      kategoriProdukUidController.text = value!;
                    },
                  );
                },
              ),
              FutureBuilder<List<Gudang>>(
                future: gudangList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final gudangItems = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Gudang'),
                    value: isEdit ? produk?.gudangUid : null,
                    items: gudangItems
                        .map((gudang) => DropdownMenuItem<String>(
                              value: gudang.id,
                              child: Text(gudang.namaGudang),
                            ))
                        .toList(),
                    onChanged: (value) {
                      gudangUidController.text = value!;
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  final produkBaru = Produk(
                    id: isEdit
                        ? produk?.id ?? ''
                        : '', // Menggunakan produk?.id jika isEdit, jika tidak, biarkan kosong
                    namaProduk: namaController.text,
                    harga: hargaController.text,
                    deskripsi: deskripsiController.text,
                    jenisProdukUid: jenisProdukUidController.text,
                    kategoriProdukUid: kategoriProdukUidController.text,
                    gudangUid: gudangUidController.text,
                  );

                  if (isEdit) {
                    // Edit Produk
                    context.read<ProdukBloc>().add(
                          ProdukEventEdit(
                              produkModel: ProdukModel.fromProduk(
                                  produkBaru)), // Mengonversi ke ProdukModel
                        );
                  } else {
                    // Tambah Produk
                    context.read<ProdukBloc>().add(
                          ProdukEventAdd(
                              produkModel: ProdukModel.fromProduk(
                                  produkBaru)), // Mengonversi ke ProdukModel
                        );
                  }

                  // Tutup halaman setelah aksi
                  Navigator.pop(context);
                },
                child: Text(isEdit ? 'Update Produk' : 'Tambah Produk'),
              )
            ],
          ),
        );
      },
    );
  }
}
