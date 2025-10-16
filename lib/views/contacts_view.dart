import 'package:abejita/app_constant.dart';
import 'package:abejita/layouts/main_layout.dart';
import 'package:abejita/models/samples.dart';
import 'package:abejita/services/search_history_service.dart';
import 'package:abejita/utils/utils.dart';
import 'package:abejita/views/dialogs/new_client_dialog.dart';
import 'package:abejita/views/searches/client_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ContactsView extends StatelessWidget {
  static const String routeName = '/contacts';

  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Clientes",
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
      floatingActionButton: FloatingActionButton(
        hoverElevation: 5,
        child: Icon(LucideIcons.user_round_plus),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const Dialog.fullscreen(backgroundColor: Colors.amber, child: NewClientDialog()),
          );
        },
      ),
      child: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.only(
            right: AppScreen.standardPadding,
            left: AppScreen.standardPadding,
            bottom: AppScreen.standardPadding,
          ),
          itemCount: usersDatabase.length,
          separatorBuilder: (_, _) => const SizedBox(height: 2),
          itemBuilder: (context, index) {
            final user = usersDatabase[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
              child: ListTile(
                isThreeLine: true,
                shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(radius: 26, backgroundImage: NetworkImage(user.avatarUrl)),
                title: Text(
                  "${user.name} ${user.surname}",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.id.asCedulaFormat ?? "", style: Theme.of(context).textTheme.bodyMedium),
                    Text(user.email, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    useSafeArea: true,
                    elevation: 2,
                    showDragHandle: true,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
