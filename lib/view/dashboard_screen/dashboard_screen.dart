import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/definitions/route_names.dart';
import '../../providers/bottom_navigation_provider.dart';
import '../../providers/dashboard_provider.dart';
import 'estimates_view/estimates_screen.dart';
import 'invoices_view/invoice_screen.dart';
import 'reports_view/reports_screens.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/custom_floating_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Consumer<DashboardProvider>(
            builder: (context, dashboardProvider, child) =>
                Consumer<BottomNavigationProvider>(
              builder: (context, bottomNavigationProvider, child) {
                List<CenterButtonItems>? buttonItems =
                    bottomNavigationProvider.selectedOption ==
                            BottomBarOptions.invoices
                        ? [
                            CenterButtonItems(
                                label: DashboardAppBarButtons.invoices,
                                action: () {
                                  dashboardProvider.buttonTapped =
                                      DashboardAppBarButtons.invoices;
                                },
                                isTapped: dashboardProvider.buttonTapped ==
                                    DashboardAppBarButtons.invoices),
                            CenterButtonItems(
                                label: DashboardAppBarButtons.estimates,
                                action: () {
                                  dashboardProvider.buttonTapped =
                                      DashboardAppBarButtons.estimates;
                                },
                                isTapped: dashboardProvider.buttonTapped ==
                                    DashboardAppBarButtons.estimates)
                          ]
                        : null;
                return CustomAppBar(centerButtons: buttonItems);
              },
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomBar(),
        // FAButton for navigating to create invoice or estimate screen
        floatingActionButton: Consumer<DashboardProvider>(
          builder: (context, value, child) {
            if (value.buttonTapped == DashboardAppBarButtons.invoices) {
              return CustomFloatingButton(
                text: AppStrings.createInvoice,
                onPressed: () => Navigator.pushNamed(
                    context, RouteNames.createInvoiceScreen),
              );
            } else if (value.buttonTapped == DashboardAppBarButtons.estimates) {
              return CustomFloatingButton(
                text: AppStrings.createEstimate,
                onPressed: () => Navigator.pushNamed(
                    context, RouteNames.createEstimateScreen),
              );
            }

            return const SizedBox();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildMainUi());
  }

  Widget _buildMainUi() {
    return SingleChildScrollView(child: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Consumer<BottomNavigationProvider>(
          builder: (context, bottomNavigationProvider, child) {
        if (bottomNavigationProvider.selectedOption ==
            BottomBarOptions.invoices) {
          if (dashboardProvider.buttonTapped ==
              DashboardAppBarButtons.invoices) {
            return const InvoiceScreen();
          } else if (dashboardProvider.buttonTapped ==
              DashboardAppBarButtons.estimates) {
            return const EstimatesScreen();
          }
        } else if (bottomNavigationProvider.selectedOption ==
            BottomBarOptions.reports) {
          return const ReportsScreens();
        }
        return const SizedBox();
      });
    }));
  }
}
