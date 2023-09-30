import 'package:flutter/material.dart';
import '../../../core/utils/debouncer.dart';
import '../../resources.dart';

class SearchContainer extends StatefulWidget {
  final Function(String?) function;
  final VoidCallback? onClose;

  const SearchContainer({Key? key, required this.function, this.onClose}) : super(key: key);

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  final searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  String lastInputValue = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.getR(10))),
      child: TextFormField(
        controller: searchController,
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.text,
        autofocus: true,
        onFieldSubmitted: (String? value) {
          if (value!.isNotEmpty) {
            widget.function(value);
          } else {
            widget.function(null);
          }
        },
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'empty!';
          }
          return null;
        },
        onChanged: (String? value) {
          if (lastInputValue != value && value!.isNotEmpty) {
            lastInputValue = value;
            _debouncer.run(() {
              widget.function(value);
            });
          } else {
            _debouncer.run(() {
              widget.function(null);
            });
          }
          setState(() {});
        },
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        style: AppStyles.medium14,
        decoration: InputDecoration(
          hintText: 'Search ...',
          isDense: true,
          isCollapsed: true,
          hintStyle: TextStyle(
            fontSize: SizeConfig.getFontSize(14),
            height: SizeConfig.getH(1),
          ),
          filled: true,
          fillColor: AppColors.grey01.withOpacity(.2),
          contentPadding: symmetricPadding(6, 10),
          // border: InputBorder.none,
          border: outlineInputBorder(Colors.transparent),
          enabledBorder: outlineInputBorder(Colors.transparent),
          focusedBorder: outlineInputBorder(Colors.transparent),
          disabledBorder: outlineInputBorder(Colors.transparent),
          // prefixIcon: Icon(
          //   Icons.search,
          //   size: SizeConfig.getFontSize(20),
          //   color: dark.withOpacity(.5),
          // ),
          //prefixIconConstraints: BoxConstraints(minWidth: SizeConfig.getW(45)),
          suffixIconConstraints: BoxConstraints(minWidth: SizeConfig.getW(45)),
          suffixIcon: Padding(
            padding: symmetricPadding(0, 10),
            child: searchController.value.text.isEmpty
                ? Icon(
                    Icons.search,
                    size: SizeConfig.getFontSize(20),
                    color: AppColors.grey01.withOpacity(.5),
                  )
                : GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {
                        searchController.clear();
                        widget.function(null);
                        widget.onClose?.call();
                      });
                    },
                    child: Icon(
                      Icons.cancel_rounded,
                      color: AppColors.grey01.withOpacity(.5),
                      size: SizeConfig.getFontSize(20),
                    ),
                  ),
          ),
          // border: OutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder outlineInputBorder(boarderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(SizeConfig.getR(10))),
      borderSide: BorderSide(color: boarderColor, width: 1.5),
    );
  }
}
