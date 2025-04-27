import 'package:cek/core/components/custom-drawer.dart';
import 'package:cek/features/favorite/presentation/bloc/favorite_bloc.dart'; 
import 'package:cek/features/produk/data/datasources/produk_datasource.dart'; 
import 'package:cek/features/produk/domain/entities/produk.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePages extends StatelessWidget {
  const FavoritePages({super.key});

  @override
  Widget build(BuildContext context) {
    // DataSource for fetching Produk data
    final produkDataSource = ProdukRemoteDataSourceImplementation(
      firebaseFirestore: FirebaseFirestore.instance,
    );

    // Fetch all favorites when the page is first built
    Future.microtask(() {
      context.read<FavoriteBloc>().add(FavoriteEventGetAll());
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Produk'),
      ),
      drawer: const CustomDrawer(), // Sidebar
      body: BlocListener<FavoriteBloc, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteStateLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoriteStateLoadedAll) {
              return ListView.builder(
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = state.favorites[index];

                  return FutureBuilder<Produk>(
                    future: produkDataSource.getProdukById(
                        id: favorite
                            .produkId!), // Pass the 'id' of the favorite product
                    builder: (context, produkSnapshot) {
                      if (produkSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const ListTile(title: Text('Loading...'));
                      }

                      if (produkSnapshot.hasError) {
                        return const ListTile(
                            title: Text('Terjadi kesalahan produk'));
                      }

                      final produk = produkSnapshot.data;
                      if (produk == null) {
                        return const ListTile(
                            title: Text('Produk tidak ditemukan'));
                      }

                      return ListTile(
                        title: Text(produk.namaProduk), // Display product name
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Trigger delete event
                                context
                                    .read<FavoriteBloc>()
                                    .add(FavoriteEventDelete(id: favorite.id));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is FavoriteStateError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox(); // Empty state
          },
        ),
      ),
    );
  }
}
