import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Marketplace Arief',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Model Data Produk dengan tambahan atribut 'stock'
class Product {
  final String name;
  final String price;
  final int rawPrice;
  final String imageUrl;
  final String category;
  final String description;
  int stock;

  Product({
    required this.name,
    required this.price,
    required this.rawPrice,
    required this.imageUrl,
    required this.category,
    required this.description,
    required this.stock,
  });
}

// Model Item Keranjang
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// Model Riwayat Pesanan dengan status aktif/dibatalkan
class OrderHistoryItem {
  final String orderId;
  final List<CartItem> items;
  final int totalAmount;
  final String date;
  String status;

  OrderHistoryItem({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.date,
    this.status = 'Diproses',
  });
}

// 0. HALAMAN LOGIN
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'arief.setiawan@students.utdi.ac.id');
  final _passwordController = TextEditingController(text: '123456');
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_bag_rounded, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 16),
                const Text(
                  'Mini Marketplace',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
                const SizedBox(height: 8),
                const Text('Silakan login untuk mulai berbelanja', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainPage()),
                        );
                      }
                    },
                    child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman Utama dengan Bottom Navigation Bar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<CartItem> cartItems = [];
  final List<OrderHistoryItem> orderHistory = [];

  final List<Product> products = [
    Product(
      name: 'Sepatu Merk Wisdom',
      price: 'Rp 350.000',
      rawPrice: 350000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Sepatu%20Merk%20Wisdom.png',
      category: 'Sepatu',
      description: 'Sepatu olahraga nyaman dengan bahan berkualitas tinggi dan sirkulasi udara yang baik.',
      stock: 5,
    ),
    Product(
      name: 'Jam Tangan Swiss',
      price: 'Rp 500.000',
      rawPrice: 500000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Jam%20Tangan%20Swiss.png',
      category: 'Aksesoris',
      description: 'Jam tangan elegan untuk melengkapi gaya harian Anda, tahan air hingga kedalaman 30 meter.',
      stock: 1,
    ),
    Product(
      name: 'Tas Laptop Merk Asther',
      price: 'Rp 275.000',
      rawPrice: 275000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Tas%20Laptop%20Merk%20Asther.png',
      category: 'Tas',
      description: 'Tas ransel kokoh dengan kompartemen khusus laptop 15 inci dan slot USB charger.',
      stock: 8,
    ),
    Product(
      name: 'Jaket Hoodie',
      price: 'Rp 190.000',
      rawPrice: 190000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/sandbox/Jaket%20Hoodie%20Merk%20Anonim.png',
      category: 'Pakaian',
      description: 'Hoodie fleece tebal yang hangat, nyaman dipakai saat cuaca dingin maupun berkendara.',
      stock: 4,
    ),
    Product(
      name: 'Jam Tangan Taktikal',
      price: 'Rp 190.000',
      rawPrice: 190000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Jam%20Tangan%20Taktikal.png',
      category: 'Aksesoris',
      description: 'Jam tangan taktis yang tangguh, tahan guncangan dan cocok untuk aktivitas outdoor.',
      stock: 6,
    ),
    Product(
      name: 'Sepatu Merk Vans',
      price: 'Rp 190.000',
      rawPrice: 190000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Sepatu%20Merk%20Fans.png',
      category: 'Sepatu',
      description: 'Sepatu casual trendy untuk gaya hidup sehari-hari, santai dan tetap stylish.',
      stock: 0, // Contoh stok habis
    ),
    Product(
      name: 'Tas Laptop Polos',
      price: 'Rp 190.000',
      rawPrice: 190000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Tas%20Laptop%20Polos.png',
      category: 'Tas',
      description: 'Tas laptop dengan desain minimalis polos, simpel dan elegan untuk kerja atau kuliah.',
      stock: 7,
    ),
    Product(
      name: 'Tas Ransel Army',
      price: 'Rp 190.000',
      rawPrice: 190000,
      imageUrl: 'https://6af557802741083616a7e43e.imgix.net/Tas%20Ransel%20Army.png',
      category: 'Tas',
      description: 'Tas ransel motif army yang kokoh, berkapasitas besar untuk petualangan atau harian.',
      stock: 5,
    ),
  ];

  void addToCart(Product product, int qty) {
    setState(() {
      int index = cartItems.indexWhere((item) => item.product.name == product.name);
      if (index >= 0) {
        cartItems[index].quantity += qty;
      } else {
        cartItems.add(CartItem(product: product, quantity: qty));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil menambahkan ${product.name} ($qty) ke keranjang!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(products: products, onAddToCart: addToCart),
      SearchCategoryPage(products: products, onAddToCart: addToCart),
      CartPage(
        cartItems: cartItems,
        onCheckoutSuccess: (newOrder) {
          setState(() {
            for (var cartItem in newOrder.items) {
              cartItem.product.stock -= cartItem.quantity;
              if (cartItem.product.stock < 0) cartItem.product.stock = 0;
            }
            orderHistory.add(newOrder);
            cartItems.clear();
          });
        },
      ),
      OrderHistoryPage(
        orders: orderHistory,
        onCancelOrder: (orderId) {
          setState(() {
            final order = orderHistory.firstWhere((o) => o.orderId == orderId);
            order.status = 'Dibatalkan';
            for (var item in order.items) {
              item.product.stock += item.quantity;
            }
          });
        },
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cari & Kategori'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// 1. MENU BERANDA
class HomePage extends StatelessWidget {
  final List<Product> products;
  final Function(Product, int) onAddToCart;

  const HomePage({super.key, required this.products, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Marketplace Arief'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Selamat Datang, Arief!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    SizedBox(height: 4),
                    Text('Temukan produk fashion & aksesoris terbaik untuk gaya harianmu.', style: TextStyle(fontSize: 13, color: Colors.black54)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Katalog Unggulan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index], onAddToCart: onAddToCart);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. MENU PENCARIAN & KATEGORI
class SearchCategoryPage extends StatefulWidget {
  final List<Product> products;
  final Function(Product, int) onAddToCart;

  const SearchCategoryPage({super.key, required this.products, required this.onAddToCart});

  @override
  State<SearchCategoryPage> createState() => _SearchCategoryPageState();
}

class _SearchCategoryPageState extends State<SearchCategoryPage> {
  String searchQuery = '';
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    final categories = ['Semua', 'Sepatu', 'Aksesoris', 'Tas', 'Pakaian'];

    final filteredProducts = widget.products.where((product) {
      final matchesSearch = product.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'Semua' || product.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari & Kategori Produk'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari produk impianmu...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filteredProducts.isEmpty
                  ? const Center(child: Text('Produk tidak ditemukan.', style: TextStyle(color: Colors.black54)))
                  : GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: filteredProducts[index], onAddToCart: widget.onAddToCart);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget Produk
class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product, int) onAddToCart;

  const ProductCard({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock = product.stock <= 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: isOutOfStock
            ? null
            : () async {
          final result = await Navigator.push<int>(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(product: product)),
          );
          if (result != null && result > 0) {
            onAddToCart(product, result);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: ColorFiltered(
                  colorFilter: isOutOfStock
                      ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                      : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(product.price, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(
                    isOutOfStock ? 'Stok Habis' : 'Stok: ${product.stock}',
                    style: TextStyle(fontSize: 11, color: isOutOfStock ? Colors.red : Colors.grey.shade700, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. HALAMAN DETAIL PRODUK
class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    bool isOutOfStock = widget.product.stock <= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product.imageUrl,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 260,
                color: Colors.grey.shade200,
                child: const Center(child: Icon(Icons.broken_image, size: 60, color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(widget.product.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      Chip(label: Text(widget.product.category, style: const TextStyle(fontSize: 11))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(widget.product.price, style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(
                    isOutOfStock ? 'Stok Habis' : 'Sisa Stok: ${widget.product.stock}',
                    style: TextStyle(fontSize: 13, color: isOutOfStock ? Colors.red : Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 24),
                  const Text('Deskripsi Produk:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(widget.product.description, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                  const SizedBox(height: 24),
                  if (!isOutOfStock) ...[
                    Row(
                      children: [
                        const Text('Jumlah Pesanan: ', style: TextStyle(fontSize: 15)),
                        IconButton(
                          onPressed: () => setState(() { if (quantity > 1) quantity--; }),
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => setState(() {
                            if (quantity < widget.product.stock) quantity++;
                          }),
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          Navigator.pop(context, quantity);
                        },
                        child: const Text('Tambah ke Keranjang', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ] else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Maaf, stok produk ini sedang habis dan tidak dapat ditambahkan ke keranjang.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. KERANJANG & CHECKOUT
class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(OrderHistoryItem) onCheckoutSuccess;

  const CartPage({super.key, required this.cartItems, required this.onCheckoutSuccess});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int get totalPrice {
    return widget.cartItems.fold(0, (sum, item) => sum + (item.product.rawPrice * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Keranjang belanja Anda masih kosong.', style: TextStyle(fontSize: 15, color: Colors.black54)))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      item.product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                    ),
                    title: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${item.product.price} x ${item.quantity}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Pembayaran:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Rp $totalPrice', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                          cartItems: List.from(widget.cartItems),
                          totalPrice: totalPrice,
                          onCheckoutSuccess: widget.onCheckoutSuccess,
                        ),
                      ),
                    );
                  },
                  child: const Text('Lanjut ke Checkout / Pembayaran', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final int totalPrice;
  final Function(OrderHistoryItem) onCheckoutSuccess;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.onCheckoutSuccess,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedPaymentMethod = 'Transfer Bank (BCA/Mandiri)';
  final List<String> paymentMethods = [
    'Transfer Bank (BCA/Mandiri)',
    'E-Wallet (GoPay/OVO/Dana)',
    'Bayar di Tempat (COD)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Pembayaran'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Alamat Pengiriman', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            const Text('Arief Setiawan\nJl. Ringroad Selatan, Bantul, Yogyakarta', style: TextStyle(color: Colors.black54)),
            const Divider(height: 24),
            const Text('Pilih Metode Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...paymentMethods.map((method) {
              return RadioListTile<String>(
                title: Text(method, style: const TextStyle(fontSize: 14)),
                value: method,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              );
            }),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Tagihan:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Rp ${widget.totalPrice}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final newOrder = OrderHistoryItem(
                    orderId: 'TRX-${DateTime.now().millisecond}',
                    items: widget.cartItems,
                    totalAmount: widget.totalPrice,
                    date: '12 Nov 2026',
                    status: 'Diproses',
                  );
                  widget.onCheckoutSuccess(newOrder);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
                        (route) => route.isFirst,
                  );
                },
                child: const Text('Konfirmasi & Bayar Sekarang', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Berhasil'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 90),
              const SizedBox(height: 20),
              const Text('Transaksi Berhasil!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text('Stok produk telah diperbarui dan pesanan tercatat di Riwayat.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('Kembali ke Beranda', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 5. RIWAYAT PESANAN
class OrderHistoryPage extends StatelessWidget {
  final List<OrderHistoryItem> orders;
  final Function(String) onCancelOrder;

  const OrderHistoryPage({super.key, required this.orders, required this.onCancelOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: orders.isEmpty
          ? const Center(child: Text('Belum ada riwayat pesanan.', style: TextStyle(color: Colors.black54)))
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          bool isCancelled = order.status == 'Dibatalkan';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Chip(
                        label: Text(order.status, style: const TextStyle(color: Colors.white, fontSize: 11)),
                        backgroundColor: isCancelled ? Colors.red : Colors.green,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  Text(order.date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Divider(height: 16),
                  ...order.items.map((item) => Text('- ${item.product.name} (${item.quantity}x)', style: const TextStyle(fontSize: 13))),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Rp ${order.totalAmount}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                  if (!isCancelled) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        icon: const Icon(Icons.cancel, size: 18),
                        label: const Text('Batalkan Pesanan'),
                        onPressed: () {
                          onCancelOrder(order.orderId);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Pesanan ${order.orderId} berhasil dibatalkan.')),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 6. PROFIL PENGGUNA
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Text('AS', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Arief Setiawan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('arief.setiawan@students.utdi.ac.id', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.school, color: Colors.blueAccent),
                    title: const Text('Universitas'),
                    subtitle: const Text('Universitas Teknologi Digital Indonesia (UTDI)'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.blueAccent),
                    title: const Text('Mata Kuliah'),
                    subtitle: const Text('Framework Mobile'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.blueAccent),
                    title: const Text('Versi Aplikasi'),
                    subtitle: const Text('1.0.0 (UTS Edition)'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Keluar (Logout)', style: TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}