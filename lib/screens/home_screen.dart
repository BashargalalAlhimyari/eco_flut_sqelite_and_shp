import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/theme/theme_provider.dart';
import 'package:flutter_application_2/providers/category_provider.dart';
import 'package:flutter_application_2/providers/product_provider.dart';
import 'package:flutter_application_2/screens/cart_screen.dart';
import 'package:flutter_application_2/widgets/cart_badge.dart';
import 'package:flutter_application_2/widgets/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // جلب البيانات فور الدخول للشاشة
    Future.microtask(() {
      context.read<CategoriesProvider>().fetchCategories();
      context.read<ProductsProvider>().fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'متجري الذكي',
          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          // زر تبديل الثيم
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // هنا سنضيف لاحقاً منطق البحث
            },
          ),
          // داخل AppBar في ملف HomeScreen
  CartBadge(
    child: IconButton(
      icon: const Icon(Icons.shopping_cart_outlined),
      onPressed: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => const CartScreen())
        );
      },
    ),
  ),
  // الأزرار الأخرى (الثيم، البحث...)

        ],
      ),
      body: Consumer2<ProductsProvider, CategoriesProvider>(
        builder: (context, prodProvider, catProvider, child) {
          // 1. حالة التحميل
          if (catProvider.state == CategoryState.loading || prodProvider.state == ProductState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. حالة الخطأ
          if (prodProvider.state == ProductState.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(prodProvider.errorMessage),
                  ElevatedButton(
                    onPressed: () => prodProvider.fetchAllProducts(),
                    child: const Text("إعادة المحاولة"),
                  )
                ],
              ),
            );
          }

          // 3. عرض البيانات
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16, bottom: 20),
            itemCount: catProvider.categories.length,
            itemBuilder: (context, index) {
              final categoryName = catProvider.categories[index];
              // تصفية المنتجات حسب الفئة الحالية
              final categoryProducts = prodProvider.products
                  .where((p) => p.category == categoryName)
                  .toList();

              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500 + (index * 100)),
                curve: Curves.easeOutQuart,
                builder: (context, double value, child) {
                  return Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: Opacity(opacity: value, child: child),
                  );
                },
                child: _buildCategorySection(context, categoryName, categoryProducts),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String categoryName, List products) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName.toUpperCase(), // جعل اسم الفئة كبير ليعطي مظهراً رسمياً
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: theme.colorScheme.primary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // ننتقل هنا لصفحة مخصصة لهذه الفئة فقط
                },
                child: const Text('عرض الكل'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 280, // زدنا الارتفاع قليلاً ليعطي مساحة للظلال
          child: products.isEmpty 
              ? const Center(child: Text("لا توجد منتجات في هذه الفئة"))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10), // مساحة للظل
                      child: SizedBox(
                        width: 170,
                        child: ProductCard(product: products[index]),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}