import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left),
        tooltip: S.current.backToPreviousPage,
        color: Colors.black,
        onPressed: () {},
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
