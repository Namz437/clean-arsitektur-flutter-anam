import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user =
        FirebaseAuth.instance.currentUser; 

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/736x/8d/31/8f/8d318f2e94f34b120775695965e25a89.jpg'), 
            ),
            accountName: Text(
              user?.displayName ?? 'Cek',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              user?.email ?? 'guest@example.com',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_bag,
                  text: 'Produk',
                  onTap: () => context.go('/produk'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.category,
                  text: 'Kategori Produk',
                  onTap: () => context.go('/kategori-produk'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.label,
                  text: 'Jenis Produk',
                  onTap: () => context.go('/jenis-produk'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.warehouse,
                  text: 'Gudang',
                  onTap: () => context.go('/gudang'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.local_shipping,
                  text: 'Kurir',
                  onTap: () => context.go('/kurir'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.store,
                  text: 'Suplier',
                  onTap: () => context.go('/suplier'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.shopping_cart,
                  text: 'Keranjang',
                  onTap: () => context.go('/keranjang'),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.favorite,
                  text: 'Favorite',
                  onTap: () => context.go('/favorite'),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                        },
                        child: const Text('Tidak'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut(); // Logout
                          Navigator.of(context).pop(); // Tutup dialog
                          context.go('/'); // Balik ke halaman login
                        },
                        child: const Text('Ya'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}