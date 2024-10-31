import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../user/presentations/pages/account_detail_page.dart';
import '../bloc/update_info/update_info_cubit.dart';
import '../widgets/continue_button.dart';

class InfoTemplatePage extends StatelessWidget {
  final String title;
  final AccountAction action;

  const InfoTemplatePage({
    super.key,
    required this.title,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateAccountInfoCubit, UpdateAccountInfoState>(
      listener: (context, state) {
        if (state is UpdateSucceed) {
          showToast(S.current.success, context: context);
          Navigator.pop(context);
        } else if (state is UpdateFailed) {
          showToast(state.errorMessage, context: context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: defaultWhiteAppBar(context: context, titleText: title),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [_buildActionWidget()],
                    ),
                  ),
                ),
              ),
              ContinueButton(
                onTap: context.select((UpdateAccountInfoCubit cubit) =>
                        cubit.isUserChanged && cubit.state.isValid)
                    ? () => _executeAction(context)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionWidget() {
    switch (action) {
      case AccountAction.changeEmail:
        return const _EmailInput();
      case AccountAction.changePassword:
        return Container();
      case AccountAction.changeDisplayName:
        return Container();
      case AccountAction.changeBirthDate:
        return Container();
    }
  }

  void _executeAction(BuildContext context) {
    switch (action) {
      case AccountAction.changeEmail:
        context.read<UpdateAccountInfoCubit>().updateAccount();
        break;
      case AccountAction.changePassword:
        // TODO: Handle this case.
        break;
      case AccountAction.changeDisplayName:
        // TODO: Handle this case.
        break;
      case AccountAction.changeBirthDate:
        // TODO: Handle this case.
        break;
    }
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final isValid =
        context.select((UpdateAccountInfoCubit cubit) => cubit.state.isValid);

    return TextFormField(
      onChanged: context.read<UpdateAccountInfoCubit>().emailChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        border: const OutlineInputBorder(
          borderRadius: defaultFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        hintText: 'abc@example.com',
        labelText: 'Email',
        floatingLabelStyle:
            TextStyle(color: !isValid ? Colors.red : AppTheme.primaryColor),
        labelStyle: TextStyle(color: !isValid ? Colors.red : null),
        errorText: !isValid ? S.current.invalidEmail : null,
      ),
      cursorColor: AppTheme.primaryColor,
      textDirection: defaultTextDirection,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }
}
