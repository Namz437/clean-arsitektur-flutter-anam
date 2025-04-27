import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/keranjang/presentation/bloc/keranjang_bloc.dart';
import 'package:cek/features/produk/data/datasources/produk_datasource.dart';
import 'package:cek/features/produk/domain/entities/produk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeranjangPages extends StatelessWidget {
  const KeranjangPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Panggil event getAll sekali saat build pertama
    Future.microtask(() {
      context.read<KeranjangBloc>().add(KeranjangEventGetAll());
    });

    // DataSource untuk ambil data Produk
    final produkDataSource = ProdukRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Pages'),
      ),
      drawer: const CustomDrawer(), // Sidebar
      body: BlocListener<KeranjangBloc, KeranjangState>(
        listener: (context, state) {
          if (state is KeranjangStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<KeranjangBloc, KeranjangState>(
          builder: (context, state) {
            if (state is KeranjangStateLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is KeranjangStateLoadedAll) {
              return ListView.builder(
                itemCount: state.keranjangs.length,
                itemBuilder: (context, index) {
                  final keranjang = state.keranjangs[index];

                  return FutureBuilder<Produk?>( 
                    future: keranjang.produkUid != null
                        ? produkDataSource.getProdukById(id: keranjang.produkUid!)
                        : Future.value(null),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(title: Text("Loading..."));
                      }

                      final produk = snapshot.data;
                      final namaProduk = produk?.namaProduk ?? 'Tidak ada produk';

                      return ListTile(
                        title: Text(namaProduk), 
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jumlah: ${keranjang.jumlah}'),
                            Text('Harga: ${keranjang.harga}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Anda bisa menambahkan logika untuk edit jika diperlukan
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<KeranjangBloc>().add(KeranjangEventDelete(id: keranjang.id));
                                context.read<KeranjangBloc>().add(KeranjangEventGetAll());
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is KeranjangStateError) {
              return Center(child: Text(state.message));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
