import 'package:abejita/app_constant.dart';
import 'package:abejita/app_theme.dart';
import 'package:abejita/models/enums.dart';
import 'package:abejita/utils/utils.dart';
import 'package:abejita/widgets/app_slider.dart';
import 'package:abejita/widgets/folding_card.dart';
import 'package:abejita/widgets/number_field.dart';
import 'package:abejita/widgets/segmented_options_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LoanSimulator extends StatefulWidget {
  const LoanSimulator({super.key});

  @override
  State<LoanSimulator> createState() => _LoanSimulatorState();
}

class _LoanSimulatorState extends State<LoanSimulator> {
  var paymentFrecuencySelected = PaymentFrequency.weekly;
  int paymentTermSelected = 1;
  bool isAnualRate = false;
  bool isSimulatorVisible = true;
  bool isSimulatorContentVisible = true;
  double paymentRateSelected = 20;
  double amountSelected = 1000;

  @override
  Widget build(BuildContext context) {
    return FoldingCard(
      title: Text(
        "Simula tu préstamo",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      iconTitle: const Icon(LucideIcons.calculator, size: 16, color: AppTheme.primaryColor),
      showButtonContent: Text("Mostrar"),
      hideButtonContent: Text("Ocultar"),
      startExpanded: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10, bottom: 5), child: Text("¿Cuánto dinero necesitas?")),
          NumberField(
            initialValue: amountSelected,
            hintText: "0.00",
            min: 1000,
            needDecimal: true,
            increment: 500,
            onChanged: (value) => setState(() => amountSelected = value),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 0),
            child: AppSlider(
              initialValue: paymentTermSelected.toDouble(),
              showValueText: true,
              prefixValueText: "Plazo: ",
              suffixValueText: " ${paymentFrecuencySelected.suffixLabel.toLowerCase()}",
              max: paymentFrecuencySelected.numberForSlider,
              onChanged: (value) => setState(() => paymentTermSelected = value.toInt()),
            ),
          ),
          Center(
            child: SegmentedOptionsButtons<PaymentFrequency>(
              initialValue: paymentFrecuencySelected,
              onChanged: (value) => setState(() => paymentFrecuencySelected = value),
              items: [
                SegmentedOptionsItem(value: PaymentFrequency.daily, label: PaymentFrequency.daily.asName()),
                SegmentedOptionsItem(value: PaymentFrequency.weekly, label: PaymentFrequency.weekly.asName()),
                SegmentedOptionsItem(value: PaymentFrequency.biweekly, label: PaymentFrequency.biweekly.asName()),
                SegmentedOptionsItem(value: PaymentFrequency.monthly, label: PaymentFrequency.monthly.asName()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: AppSlider(
              min: 0,
              max: 45,
              showValueText: true,
              prefixValueText: "Tasa: ",
              suffixValueText: '%',
              initialValue: paymentRateSelected,
              increments: 5,
              showLabel: false,
              onChanged: (value) => setState(() => paymentRateSelected = value),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tasa anualizada", maxLines: 1, overflow: TextOverflow.ellipsis),
              Switch.adaptive(value: isAnualRate, onChanged: (value) => setState(() => isAnualRate = value)),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 350),
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withAlpha(32),
                borderRadius: AppScreen.borderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    final data = Utils.getLoanEstimate(
                      amount: amountSelected,
                      paymentTerm: paymentTermSelected,
                      rate: paymentRateSelected,
                    );

                    return Column(
                      children: [
                        Row(
                          children: [
                            Text("Capital:", style: Theme.of(context).textTheme.bodyLarge),
                            Expanded(child: Text(data.capital.toStringAsFixed(2), textAlign: TextAlign.end)),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("Interés:", style: Theme.of(context).textTheme.bodyLarge),
                            Expanded(child: Text(data.interest.toStringAsFixed(2), textAlign: TextAlign.end)),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              "Cuota ${paymentFrecuencySelected.asName().toLowerCase()}:",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                data.quota.toStringAsFixed(2),
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: FilledButton(child: Text("Solicitar préstamo"), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
