import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/constants/app_sizes.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import 'package:invoice_maker/core/utils/app_button.dart';
import 'package:invoice_maker/core/utils/app_text_styles.dart';
import 'package:invoice_maker/providers/tab_provider.dart';
import 'package:invoice_maker/view/dashboard_screen/estimates_screen/estimates_screen.dart';
import 'package:invoice_maker/view/dashboard_screen/invoice_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String? selectedTabText;

  final List<Tab> _tabs = [
    const Tab(text: AppStrings.createInvoice),
    const Tab(text: AppStrings.createEstimate),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    // Add listener to detect tab changes
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        selectedTabText = _tabs[_tabController.index].text;
        context.read<TabProvider>().changeTitle(newTitle: selectedTabText!);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: _tabs,
              labelStyle:
                  AppTextStyles.helveticaNeue(AppColors.black, FontWeight.bold),
              unselectedLabelStyle: AppTextStyles.helveticaNeue(
                  AppColors.darkGrey, FontWeight.normal),
              indicatorColor: AppColors.black,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              Center(child: InvoiceScreen()),
              Center(child: EstimatesScreen()),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButton(
                type: ButtonType.invoice,
                label: context.watch<TabProvider>().title,
                action: () {},
                textColor: AppColors.white,
                fontSize: AppSizes.s20,
                borderColor: AppColors.white,
                backgroundColor: AppColors.black,
              ),
              const SizedBox(
                height: AppSizes.s5,
              ),
            ],
          )),
    );
  }
}
