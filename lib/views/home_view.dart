import 'package:abejita/app_constant.dart';
import 'package:abejita/app_theme.dart';
import 'package:abejita/layouts/main_layout.dart';
import 'package:abejita/widgets/loan_simulator.dart';
import 'package:abejita/widgets/resume_main_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final widthMainCard = AppScreen.isWide(context) ? context.width * 0.4 : context.width * 0.45;

    return MainLayout(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryColor,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        spacing: 8,
                        children: [
                          CircleAvatar(child: Icon(LucideIcons.user)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hola, Josué Jeremías Brito Amarante",
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white70),
                                ),
                                Text(
                                  "Tu crédito está en buen estado",
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResumeMainCard(
                          title: 'Último préstamo',
                          amount: "RD\$ 0.00",
                          subtitle: "Preaprobado",
                          icon: LucideIcons.coins,
                          maxWidth: widthMainCard,
                        ),
                        ResumeMainCard(
                          title: 'Próximo pago',
                          amount: "RD\$ 0.00",
                          subtitle: "Vence el 15 de octubre de 2025",
                          icon: LucideIcons.hand_coins,
                          maxWidth: widthMainCard,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LoanSimulator(),
                    Text(
                      "Resumen Financiero",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      children: [
                        _NumberCard(title: 'Total prestado', number: "5"),
                        _NumberCard(title: 'Total prestado', number: "8000000000000000000000000000"),
                        _NumberCard(title: 'Total prestado', number: "600"),
                        _NumberCard(title: 'Total prestado', number: "4"),
                        _NumberCard(title: 'Total prestado', number: "20"),
                        _NumberCard(title: 'Total prestado', number: "30"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberCard extends StatelessWidget {
  final String title;
  final String number;

  const _NumberCard({required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 120, maxWidth: 200),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: AppScreen.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 8),
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
