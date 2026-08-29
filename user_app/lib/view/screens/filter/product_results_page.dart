import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/product/product_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/view/widgets/product/product_card.dart';



class ProductResultsPage extends StatefulWidget {
  
  final Map<String, dynamic> filterParams;

  final String title;

  const ProductResultsPage({
    super.key,
    required this.filterParams,
    this.title = 'Filter',
  });

  @override
  State<ProductResultsPage> createState() => _ProductResultsPageState();
}

class _ProductResultsPageState extends State<ProductResultsPage> {
  final ProductController controller = Get.find<ProductController>();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.filterProducts(widget.filterParams);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }


  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF1E1E1E)
          : Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.title.tr,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
            fontFamily: AppFonts.heading(),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 1),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final List<ApiProductModel> products = controller.products;

      
        if (products.isEmpty) {
          return _buildEmptyState(isDark);
        }

        final bool appending = controller.isPaginating.value;
        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(15),
          itemCount: products.length + (appending ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            if (index == products.length) {
              
              return const Center(child: CircularProgressIndicator());
            }
            return ProductCard(product: products[index]);
          },
        );
      }),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: isDark ? AppColors.textSecondaryDarkHome : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            "no_results".tr,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.heading(),
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textDarkHome : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
