import 'package:abejita/app_constant.dart';
import 'package:abejita/models/ui.dart';
import 'package:abejita/models/samples.dart';
import 'package:abejita/services/search_history_service.dart';
import 'package:abejita/utils/utils.dart';
import 'package:abejita/widgets/iconed_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ClientSearchDelegate extends SearchDelegate<HistoryItem?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      var historyList = ValueNotifier(SearchHistoryService.getClients());

      return historyList.value.isEmpty
          ? Center(
              child: IconedTitle(icon: LucideIcons.search, title: "Ingrese un criterio de búsqueda"),
            )
          : ValueListenableBuilder(
              valueListenable: historyList,
              builder: (context, values, _) => ListView(
                padding: const EdgeInsets.all(AppScreen.standardPadding),
                children: [
                  ...values.map(
                    (e) =>
                        ListTile(leading: Icon(LucideIcons.history), title: Text(e.title), onTap: () => close(context, e)),
                  ),
                  if (values.isNotEmpty)
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await SearchHistoryService.clearClients();
                          historyList.value = [];
                        },
                        child: Text("Limpiar historial"),
                      ),
                    ),
                ],
              ),
            );
    }

    final results = query.isEmpty
        ? usersDatabase
        : usersDatabase.where(
            (u) =>
                u.name.toLowerCase().normalized.contains(query) ||
                u.surname.toLowerCase().normalized.contains(query) ||
                u.id.contains(query),
          );

    return query.isNotEmpty && results.isEmpty
        ? Center(child: IconedTitle(icon: LucideIcons.user_search))
        : ListView.separated(
            padding: const EdgeInsets.all(AppScreen.standardPadding),
            itemCount: results.length,
            separatorBuilder: (_, _) => const SizedBox(height: 2),
            itemBuilder: (context, index) {
              final user = results.elementAt(index);
              final fullName = "${user.name} ${user.surname}";

              return ListTile(
                leading: Icon(LucideIcons.contact),
                title: Text(fullName),
                onTap: () => close(context, HistoryItem(user.id, fullName)),
              );
            },
          );
  }
}
