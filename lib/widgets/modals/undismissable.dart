import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UndissmisableModal extends StatelessWidget {
  final Widget child;

  const UndissmisableModal({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        type: MaterialType.card,
        elevation: 1,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        child: child,
      ),
    );
  }
}

Future<T> showUndissmisableModalBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) async {
  final result = await showCustomModalBottomSheet(
      duration: Duration(milliseconds: 100),
      isDismissible: false,
      context: context,
      builder: builder,
      containerWidget: (_, animation, child) => UndissmisableModal(
            child: child,
          ),
      expand: false);

  return result;
}
