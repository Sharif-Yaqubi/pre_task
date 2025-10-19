import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final Color backgroundColor;
  final Color textColor;

  const ProductProfileAvatar({
    super.key,
    this.imageUrl,
    this.size = 100,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.textColor = const Color(0xFF757575),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      child: ClipOval(
        child:
            imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
                : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Icon(
          Icons.production_quantity_limits,
          size: size * 0.5,
          color: textColor,
        ),
      ),
    );
  }
}
