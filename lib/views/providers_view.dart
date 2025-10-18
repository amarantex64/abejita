import 'package:abejita/app_constant.dart';
import 'package:abejita/layouts/main_layout.dart';
import 'package:abejita/models/samples.dart';
import 'package:abejita/services/search_history_service.dart';
import 'package:abejita/utils/utils.dart';
import 'package:abejita/views/dialogs/new_client_dialog.dart';
import 'package:abejita/views/searches/client_search_delegate.dart';
import 'package:abejita/widgets/list_view_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ProvidersView extends StatelessWidget {
  static const String routeName = '/providers';
  static const String title = 'Prestadores';

  const ProvidersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Búsqueda de ${title.toLowerCase()}",
      preventFocusOnSearchTap: true,
      onSearchTap: () async {
        final history = await showSearch(context: context, delegate: ClientSearchDelegate());
        await SearchHistoryService.addClient(history);
      },
      onSearchChanged: (value) async {
        if (value.isNotEmpty) {
          final history = await showSearch(context: context, query: value, delegate: ClientSearchDelegate());
          await SearchHistoryService.addClient(history);
        }
      },
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.only(
            right: AppScreen.standardPadding,
            left: AppScreen.standardPadding,
            bottom: AppScreen.standardPadding,
          ),
          itemCount: providersDatabase.length,
          separatorBuilder: (_, _) => const SizedBox(height: 2),
          itemBuilder: (context, index) {
            final provider = providersDatabase[index];

            return ListViewElement(
              title: provider.fullName,
              subtitle: provider.whatsAppAccount,
              footer: provider.email,
              avatarUrl: provider.avatarUrl,
              modalBottomSheetOptions: [
                ListTile(
                  leading: const Icon(LucideIcons.pencil),
                  title: const Text('Editar'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(LucideIcons.trash),
                  title: const Text('Eliminar'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
