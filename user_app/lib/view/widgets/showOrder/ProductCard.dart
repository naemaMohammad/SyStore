import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/view/widgets/showOrder/ProductCardConstants.dart';
import 'package:user_app/view/widgets/showOrder/RatingDialog.dart';

import '../../../controller/order/ShowOrderController.dart';


class ProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String size;
  final String color;
  final bool isSelected;
  final bool showRateButton;
  final int productId;
  final bool isRated;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    this.isSelected = false,
    this.showRateButton = false,
    required this.productId,
    required this.isRated,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final controller = Get.find<Showmycartcontroller>();

  late bool isRated = controller.ratedProducts.contains(widget.productId);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: ProductCardConstants.cardMarginVertical,
        horizontal: ProductCardConstants.cardMarginHorizontal,
      ),
      padding: const EdgeInsets.all(ProductCardConstants.cardPadding),
      decoration: _buildCardDecoration(context, isDark),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(isDark),
          const SizedBox(width: ProductCardConstants.imageSpacer),
          _buildProductDetails(context),
        ],
      ),
    );
  }

  BoxDecoration _buildCardDecoration(BuildContext context, bool isDark) {
    return BoxDecoration(
      color: isDark ? Colors.grey[850] : const Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(
        ProductCardConstants.cardBorderRadius,
      ),
      border: widget.isSelected
          ? Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: ProductCardConstants.cardBorderWidth,
            )
          : Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.shade200,
              width: ProductCardConstants.cardBorderWidthUnselected,
            ),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.black.withOpacity(0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildProductImage(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        ProductCardConstants.imageBorderRadius,
      ),
      child: Image.network(
        widget.image,
        width: ProductCardConstants.imageSize,
        height: ProductCardConstants.imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: ProductCardConstants.imageSize,
            height: ProductCardConstants.imageSize,
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              color: isDark ? Colors.white54 : Colors.black26,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: ProductCardConstants.detailsSpacer),
          _buildPrice(context),
          const SizedBox(height: ProductCardConstants.detailsSpacer),
          _buildSize(context),
          _buildColor(context),
          if (widget.showRateButton) ...[
            const SizedBox(height: ProductCardConstants.rateButtonSpacer),
            _buildRateButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: ProductCardConstants.titleFontSize,
        fontWeight: ProductCardConstants.titleFontWeight,
        fontFamily: 'Raleway',
        fontFamilyFallback: ['Cairo'],
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  Widget _buildPrice(BuildContext context) {
    return Text(
      "${widget.price} ${'currency'.tr}",
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: ProductCardConstants.priceFontSize,
        fontWeight: ProductCardConstants.priceFontWeight,
        fontFamily: 'NunitoSans',
        fontFamilyFallback: ['Tajawal'],
      ),
    );
  }

  Widget _buildSize(BuildContext context) {
    return Text(
      "${'27'.tr} ${widget.size}",
      style: TextStyle(
        fontFamily: 'NunitoSans',
        fontFamilyFallback: ['Tajawal'],
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
    );
  }

  Widget _buildColor(BuildContext context) {
    return Text(
      "${'28'.tr} ${widget.color}",
      style: TextStyle(
        fontFamily: 'NunitoSans',
        fontFamilyFallback: ['Tajawal'],
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
    );
  }

  Widget _buildRateButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        borderRadius: BorderRadius.circular(
          ProductCardConstants.rateButtonBorderRadius,
        ),
        onTap: isRated ? null : _handleRateButtonTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: ProductCardConstants.rateButtonPaddingHorizontal,
            vertical: ProductCardConstants.rateButtonPaddingVertical,
          ),
          decoration: BoxDecoration(
            color: isRated
                ? ProductCardConstants.rateButtonEvaluatedColor
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(
              ProductCardConstants.rateButtonBorderRadius,
            ),
          ),
          child: Text(
            isRated ? '42'.tr : '43'.tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: ProductCardConstants.rateButtonFontSize,
              fontFamily: 'Raleway',
              fontFamilyFallback: ['Cairo'],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRateButtonTap() {
    showDialog(
      context: context,
      builder: (context) => RatingDialog(
        productId: widget.productId,
        onRatingSubmitted: () {
          setState(() {
            isRated = true;
          });
        },
      ),
    );
  }
}
