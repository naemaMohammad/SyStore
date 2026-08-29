import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:user_app/controller/ai_search/search_controller.dart';
import 'package:user_app/core/theme/color.dart';
import 'package:user_app/core/theme/theme.dart';
import 'package:user_app/data/model/product_model.dart';
import 'package:user_app/view/widgets/product/product_card.dart';



class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({super.key});

  @override 
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {

  final SearchController controller = Get.find<SearchController>();

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  
  List<ApiProductModel> _products = const [];

  
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onQueryChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _textController.removeListener(_onQueryChanged);
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

 
  void _onQueryChanged() {
    final query = _textController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _hasSearched = false;
        _products = const [];
      });
      controller.results.clear();
      controller.errorMessage.value = '';
    }
  }

  
  void _submitSearch() {
    final query = _textController.text.trim();
    if (query.isEmpty) return;
    _runSearch(query);
  }

  Future<void> _runSearch(String query) async {
  
    _focusNode.unfocus();

   
    try {
      await controller.aiSearch(query);
    } on DioException catch (e) {
      debugPrint('AI search DioException: ${e.response?.statusCode} ${e.message}');
    } catch (e, s) {
      debugPrint('AI search failed: $e\n$s');
    } finally {
  
      controller.isSearching.value = false;
    }

    if (!mounted) return;

    final hasError = controller.errorMessage.value.isNotEmpty;
    setState(() {
      _hasSearched = true;
      _products = hasError
          ? const []
          : controller.results
              .where((p) => p.isAvailable)
              .toList(growable: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          onPressed: () => Get.back(),
        ),
        toolbarHeight: 66,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: TextField(
          controller: _textController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _submitSearch(),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
          decoration: InputDecoration(
            hintText: "search".tr,
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.body(),
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
      
              _textController.clear();
              controller.errorMessage.value = '';
              controller.results.clear();
              setState(() {
                _hasSearched = false;
                _products = const [];
              });
              _focusNode.requestFocus();
            },
            icon: Icon(
              Icons.clear,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
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
     
        if (controller.isSearching.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!_hasSearched) {
          return _buildHintState(isDark);
        }

       
        if (controller.errorMessage.value.isNotEmpty) {
          return _buildErrorState(isDark);
        }

        if (_products.isEmpty) {
          return _buildEmptyState(isDark);
        }

        return GridView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: _products.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) =>
              ProductCard(
                product: _products[index]
              ,store: _products[index].store
              ),
        );
      }),
    );
  }

  Widget _buildHintState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: isDark ? AppColors.textSecondaryDarkHome : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            "search".tr,
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

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
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

  Widget _buildErrorState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 64,
            color: isDark ? AppColors.textSecondaryDarkHome : Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            "search_error".tr,
            style: TextStyle(
              fontSize: 16,
              fontFamily: AppFonts.heading(),
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textDarkHome : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _submitSearch,
            child: Text(
              "retry".tr,
              style: TextStyle(
                fontSize: 15,
                fontFamily: AppFonts.heading(),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
