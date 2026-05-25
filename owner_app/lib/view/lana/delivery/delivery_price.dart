import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owner_app/view/lana/settings/settings.dart';
import 'package:owner_app/view/lana/widgets/buttons/button.dart';

class DeliveryPricesScreen extends StatefulWidget {
  final bool isFromSettings;
  const DeliveryPricesScreen({super.key, this.isFromSettings = false});
  @override
  State<DeliveryPricesScreen> createState() => _DeliveryPricesScreenState();
}

class _DeliveryPricesScreenState extends State<DeliveryPricesScreen> {
  final List<Map<String, dynamic>> areas = [
    {"title": "area_1", "enabled": true},
    {"title": "area_2", "enabled": true},
    {"title": "area_3", "enabled": true},
    {"title": "area_4", "enabled": true},
    {"title": "area_5", "enabled": true},
    {"title": "area_6", "enabled": true},
    {"title": "area_7", "enabled": true},
    {"title": "area_8", "enabled": true},
    {"title": "area_9", "enabled": true},
    {"title": "area_10", "enabled": true},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: areas.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          // DESCRIPTION
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                "delivery_prices_desc".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Raleway',
                                  fontFamilyFallback: const ['Cairo'],
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                            );
                          }
                          final item = areas[index - 1];
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                // AREA NAME
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                    child: Text(
                                      item["title"].toString().tr,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'NunitoSans',
                                        fontFamilyFallback: const ['Tajawal'],
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ),
                                ),
                                // SWITCH
                                Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.grey.withOpacity(0.25),
                                      ),
                                    ),
                                  ),
                                  child: Switch(
                                    value: item["enabled"],
                                    activeColor: Colors.white,
                                    activeTrackColor: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                    onChanged: (value) {
                                      setState(() {
                                        item["enabled"] = value;
                                      });
                                    },
                                  ),
                                ),
                                // PRICE FIELD
                                Container(
                                  width: 70,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),

                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.grey.withOpacity(0.25),
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      textDirection: TextDirection.ltr,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "SYP".tr,
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.5),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: widget.isFromSettings ? "update".tr : "confirm".tr,

                      onPressed: () {
                        if (widget.isFromSettings) {
                          // update logic
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings()),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
