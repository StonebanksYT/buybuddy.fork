import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/dashboard/dashboard.dart';
import 'package:flutter_auth/Screens/home/dashboard/filterSide/filterConstants.dart';
import 'package:flutter_auth/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/controllers/controllers.dart';

/// Category Filter Section
class CategorySelectionPage extends StatelessWidget {
  /// using controller to maintain state of selected filters

  CategorySelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Column(
          children: majorCategories.map((majorcategory) {
            /// using expandablePanel from {expandable.dart} package
            return ExpandablePanel(
              theme: const ExpandableThemeData(
                  tapHeaderToExpand: true,
                  headerAlignment: ExpandablePanelHeaderAlignment.center),
              header: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  majorcategory,
                  style: GoogleFonts.getFont("Poppins", fontSize: 12),
                ),
              ),
              collapsed: Container(),
              expanded: Column(
                  children: subCategories[majorcategory]!.map((subCategory) {
                return SizedBox(
                  height: 30,
                  child: InkWell(
                      onTap: () {
                        final bool newValue = !controller.categoryFilterList
                            .contains(subCategory);
                        if (newValue) {
                          controller.addCategoryFilterList(subCategory);
                          deselectOtherSubCategories(majorcategory);
                        } else {
                          controller.removeCategoryFilterlist(subCategory);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Checkbox(
                                  activeColor: primaryColor,
                                  value: controller.categoryFilterList
                                      .contains(subCategory),
                                  onChanged: (value) {
                                    if (value == true) {
                                      controller
                                          .addCategoryFilterList(subCategory);
                                      deselectOtherSubCategories(majorcategory);
                                    } else {
                                      controller.removeCategoryFilterlist(
                                          subCategory);
                                    }
                                  }),
                            ),
                            subCategoryfilterText(subCategory)
                          ],
                        ),
                      )),
                );
              }).toList()),
            );
          }).toList(),
        );
      },
    );
  }

  void deselectSubCategories(String majorCategory) {
    for (var subCategory in subCategories[majorCategory]!) {
      controller.removeCategoryFilterlist(subCategory);
    }
  }

  void deselectOtherSubCategories(String selectedMajorCategory) {
    for (var majorCategory in subCategories.keys) {
      if (majorCategory != selectedMajorCategory) {
        deselectSubCategories(majorCategory);
      }
    }
  }
}

class LocationFilterPage extends StatelessWidget {

  LocationFilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        locationRadioBtn("Home"),
        locationRadioBtn("Institute"),
        locationRadioBtn("Custom Location")
      ],
    );
  }

  Widget locationRadioBtn(String value) {
    return Obx(
      () {
        return InkWell(
          onTap: () {
            controller.setLocationFilterValue(value);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Transform.scale(
                  scale: 0.7,
                  child: Radio<String>(
                    value: value,
                    activeColor: primaryColor,
                    groupValue: controller.locationFilterValue.value,
                    onChanged: (String? value) {
                      controller.setLocationFilterValue(value!);
                    },
                  ),
                ),
                subCategoryfilterText(value)
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget subCategoryfilterText(String subCategory) {
  return Text(
    subCategory,
    style: GoogleFonts.getFont("Poppins", fontSize: 12),
  );
}
