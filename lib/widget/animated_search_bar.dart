import 'package:flutter/material.dart';
import 'package:pre_interview_task/utils/dimensions.dart';

class AnimatedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onSubmitted;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const AnimatedSearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.hintText = 'Search...',
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;
  late Animation<double> _borderRadiusAnimation;
  late Animation<Color?> _colorAnimation;

  bool get _hasText => widget.controller.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _widthAnimation = Tween<double>(begin: 500, end: 550).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _borderRadiusAnimation = Tween<double>(begin: 24, end: 16).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: Colors.grey.shade300,
      end: Colors.blue.shade100,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _clearText() {
    widget.controller.clear();
    setState(() {});
  }

  void _handleSearch() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!(widget.controller.text);
    }
    widget.focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: _widthAnimation.value,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(_borderRadiusAnimation.value),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSize,
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.blue.shade700,
                    size: 24,
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeLarge.toDouble(),
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontSize: Dimensions.fontSizeLarge.toDouble(),
                        color: Colors.grey.shade600,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeDefault,
                      ),
                      isDense: true,
                    ),
                    onSubmitted: widget.onSubmitted,
                    onChanged: widget.onChanged,
                  ),
                ),

                if (_hasText)
                  FadeTransition(
                    opacity: _animationController,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.5, 0),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.blue.shade700,
                          size: 20,
                        ),
                        onPressed: _clearText,
                        padding: const EdgeInsets.all(0),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),

                FadeTransition(
                  opacity: _animationController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade700,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _handleSearch,
                        padding: const EdgeInsets.all(
                          Dimensions.paddingSizeEight,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
