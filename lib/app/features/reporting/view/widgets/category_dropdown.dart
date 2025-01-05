import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shams/app/config/constants.dart';
import 'package:shams/app/features/home/data/data_source/products_api_provider.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.itemList,
    required this.onSelected,
  });
  final List<DropdownMenuEntry<String>> itemList;
  final void Function(String?) onSelected;
  @override
  Widget build(BuildContext context) {
    final ProductsApiProvider productsApiProvider =
        Get.put(ProductsApiProvider(), tag: 'archive');
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 8),
          decoration: Constants.shamsBoxDecoration(context).copyWith(
            border: Border(
              right: BorderSide(
                color: Theme.of(context).colorScheme.primary.withAlpha(50),
                width: 8,
              ),
            ),
          ),
          child: DropdownMenu(
            enableFilter: true,
            requestFocusOnTap: true,
            hintText: 'اختيار',
            trailingIcon: SvgPicture.asset(
              'assets/svgs/angle-small-down.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            selectedTrailingIcon: SvgPicture.asset(
              'assets/svgs/angle-small-up.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 5.0),
              border: UnderlineInputBorder(borderSide: BorderSide.none),
            ),
            searchCallback: (entries, query) {
              final filteredEntries = entries.where((entry) {
                return entry.label.toLowerCase().contains(query.toLowerCase());
              }).toList();

              final count = filteredEntries.length;
              return count > entries.length ? entries.length : count;
            },
            onSelected: onSelected,
            // onSelected: (id) {
            //   print(id);
            //   productsApiProvider.fetchProducts(int.tryParse(id!) ?? 0);
            // },
            dropdownMenuEntries: itemList,
          ),
        ),
      ),
    );
  }
}
