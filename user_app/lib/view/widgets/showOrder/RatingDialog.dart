import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/order/ShowOrderController.dart';

class RatingDialog extends StatefulWidget {
  final int productId;
  final VoidCallback onRatingSubmitted;

  const RatingDialog({
    super.key,
    required this.productId,
    required this.onRatingSubmitted,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "36".tr, 
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: 'Raleway',
          fontFamilyFallback: ['Cairo'],
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
      content: _buildRatingContent(context),
      actions: [_buildCancelButton(context), _buildSubmitButton(context)],
    );
  }

  Widget _buildRatingContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          itemCount: 5,
          itemSize: 35,
          unratedColor: Colors.grey.shade300,
          itemBuilder: (_, __) =>
              const Icon(Icons.star_rounded, color: Colors.amber),
          onRatingUpdate: (value) {
            setState(() {
              _rating = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        "39".tr, // "Cancel"
        style: TextStyle(
          fontFamily: 'NunitoSans',
          fontFamilyFallback: ['Tajawal'],
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _rating > 0 ? _handleSubmitRating : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        disabledBackgroundColor: Theme.of(
          context,
        ).colorScheme.primary.withOpacity(0.5),
      ),
      child: Text(
        "38".tr, // "Send"
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'Raleway',
          fontFamilyFallback: ['Cairo'],
        ),
      ),
    );
  }

  Future<void> _handleSubmitRating() async {
    final controller = Get.find<Showmycartcontroller>();

    final success = await controller.sendRating(
      productId: widget.productId,
      rating: _rating,
    );

    if (success) {
      _showSuccessOverlay();
      widget.onRatingSubmitted();
    }
  }

  void _showSuccessOverlay() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [_buildSuccessCard(), _buildSuccessIcon()],
            ),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  Widget _buildSuccessCard() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          Text(
            "40".tr, // "Thank You!"
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway',
              fontFamilyFallback: ['Cairo'],
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "41".tr, // "Your review has been submitted"
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'NunitoSans',
              fontFamilyFallback: ['Tajawal'],
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.25), blurRadius: 12),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, color: Colors.white, size: 38),
      ),
    );
  }
}
