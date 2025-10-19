import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pre_interview_task/theme/texts_style.dart';
import 'package:pre_interview_task/utils/dimensions.dart';
import 'package:pre_interview_task/widget/create_product_screen.dart';
import 'package:pre_interview_task/widget/left_panel_widget.dart';
import 'package:pre_interview_task/theme/app_colors.dart';
import 'package:pre_interview_task/utils/responsive.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: Responsive.isMobile(context) ? LeftPanelWidget() : null,
      appBar:
          Responsive.isMobile(context)
              ? AppBar(
                title: Text(
                  'Pre Interview Task',
                  style: TextsStyle.appTitleStyle,
                ),
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.menu, color: AppColors.white),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    );
                  },
                ),
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 2, 44, 128),
                        Color.fromARGB(255, 41, 114, 173),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                  ),
                  ),
                ),
              )
              : null,
      body: Row(
        children: [
          if (screenWidth >= 600) LeftPanelWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge ),
              child: CreateProductWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
