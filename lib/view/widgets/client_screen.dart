import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../core/utils/add_new_client.dart';
import '../../core/utils/app_text_styles.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/global_key.dart';
import '../../providers/client_provider.dart';
import '../../providers/form_provider.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<ClientProvider>(context, listen: false).fetchAllClients();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var ctx = navigatorKey.currentContext!;
    return Consumer<ClientProvider>(
      builder: (context, clientProvider, child) {
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppSizes.s16.r),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: AppStrings.searchText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.s15),
                        ),
                        fillColor: AppColors.darkGrey),
                  ),
                ),
                const SizedBox(
                  height: AppSizes.s14,
                ),
                buildAddClientButton(onSaveClient),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSizes.s6.r),
                    child: Consumer<ClientProvider>(
                      builder: (context, provider, child) {
                        switch (provider.state) {
                          case AppUIStates.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );

                          case AppUIStates.empty:
                            return Center(
                              child: Text(
                                AppStrings.noClientsText,
                                style: AppTextStyles.helveticaNeue(
                                    AppColors.grey,
                                    FontWeight.w500,
                                    AppSizes.s16.r),
                              ),
                            );

                          case AppUIStates.success:
                            return ListView.builder(
                              itemCount: provider.clients.length,
                              itemBuilder: (context, index) {
                                final client = provider.clients[index];
                                return ListTile(
                                  title: Text(client.clientName),
                                  onTap: () {
                                    provider.selectClient(client);
                                    Navigator.pop(ctx);
                                  },
                                );
                              },
                            );

                          case AppUIStates.none:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (clientProvider.isLoading)
              Positioned.fill(
                child: Container(
                  color: AppColors.darkGrey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void onSaveClient() {
    if (Provider.of<FormProvider>(navigatorKey.currentContext!, listen: false)
        .validateClientForm()) {
      final clientProvider = Provider.of<ClientProvider>(
          navigatorKey.currentContext!,
          listen: false);
      final newClient = clientProvider.createClientModel();
      clientProvider.setLoading(true);
      if (clientProvider.saveToClients) {
        clientProvider.addClient(newClient).then(
          (_) {
            clientProvider.selectClient(newClient);
            if (navigatorKey.currentContext!.mounted) {
              Navigator.pop(navigatorKey.currentContext!);
              Future.delayed(
                Durations.short4,
                () {
                  if (navigatorKey.currentContext!.mounted) {
                    Navigator.pop(navigatorKey.currentContext!);
                  }
                },
              );
            }
            clientProvider.clearForm();
          },
        ).whenComplete(() => clientProvider.setLoading(false));
      } else {
        clientProvider.selectClient(newClient);
        Navigator.pop(navigatorKey.currentContext!);
        Future.delayed(
          Durations.short4,
          () {
            if (navigatorKey.currentContext!.mounted) {
              Navigator.pop(navigatorKey.currentContext!);
            }
          },
        );
        clientProvider.clearForm();
      }
    }
  }
}
