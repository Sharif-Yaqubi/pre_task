import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pre_interview_task/enum/main_content_view.dart';
import 'package:pre_interview_task/utils/assets.dart';
import 'package:pre_interview_task/utils/dimensions.dart';
import 'package:pre_interview_task/widget/product_filter_sidebar_widget.dart';

class LeftPanelWidget extends ConsumerStatefulWidget {
  const LeftPanelWidget({super.key});

  @override
  ConsumerState<LeftPanelWidget> createState() => _LeftPanelWidgetState();
}

class _LeftPanelWidgetState extends ConsumerState<LeftPanelWidget> {
  MainContentView? _selectedView;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _selectedView = ref.read(mainContentViewProvider));
    });
  }

  void _handleItemTap(MainContentView view) {
    ref.read(mainContentViewProvider.notifier).state = view;
    setState(() => _selectedView = view);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(19, 5, 90, 1),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 2, 44, 128),
            Color.fromARGB(255, 41, 114, 173),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Expanded(
            child: ListView(
              children: [
                _NavItem(
                  icon: Assets.dashboard,
                  text: 'Dashboard',
                  isSelected: _selectedView == MainContentView.dashboard,
                  onTap: () {
                    _handleItemTap(MainContentView.dashboard);
                  },
                ),

                SizedBox(height: Dimensions.paddingSizeDefault),
                const ProductFilterSidebar(),
              ],
            ),
          ),
          _NavItem(
            icon: Assets.setting,
            text: 'Settings',
            isSelected: _selectedView == MainContentView.settings,
            onTap: () {
              _handleItemTap(MainContentView.settings);
            },
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            isSelected
                ? const Border(left: BorderSide(color: Colors.white, width: 3))
                : null,
        color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
      ),
      child: ListTile(
        leading: Image.asset(
          icon,
          width: Dimensions.paddingSizeExtraLarge,
          height: Dimensions.paddingSizeExtraLarge,
          color: isSelected ? Colors.white : Colors.white70,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontSize: Dimensions.fontSizeLarge.toDouble(),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Poppins',
          ),
        ),
        dense: true,
        onTap: onTap,
        hoverColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.white.withOpacity(0.2),
      ),
    );
  }
}
