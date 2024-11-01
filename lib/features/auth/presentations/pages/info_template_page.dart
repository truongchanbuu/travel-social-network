import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../../../config/themes/app_theme.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../../../user/presentations/bloc/user_cubit.dart';
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
        if (state is UpdateSucceed && !state.user.isLoggedIn) {
          showToast(S.current.reLogin);
        } else if (state is UpdateSucceed) {
          showToast(S.current.success, context: context);
          context.read<UserCubit>().getUser(state.user.id);
          Navigator.pop(context);
        } else if (state is UpdateFailed) {
          showToast(state.errorMessage, context: context);
        } else if (state is EmailVerifying) {
          showToast(S.current.verifyEmailAnnounce, context: context);
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
                        (cubit.isUserChanged || _isPasswordChanged(cubit)) &&
                        cubit.state.isValid)
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
        return const _PasswordInput();
      case AccountAction.changeDisplayName:
        return const _DisplayNameInput();
      case AccountAction.changeBirthDate:
        return Container();
      case AccountAction.changePhoneNumber:
        return const _PhoneInput();
    }
  }

  void _executeAction(BuildContext context) {
    context.read<UpdateAccountInfoCubit>().updateAccount();
  }

  bool _isPasswordChanged(UpdateAccountInfoCubit cubit) =>
      cubit.state is PasswordChanged && cubit.state.password.isValid;
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final isValid =
        context.select((UpdateAccountInfoCubit cubit) => cubit.state.isValid);
    final isProgressing = context
        .select((UpdateAccountInfoCubit cubit) => cubit.state is EmailChanged);

    return TextField(
      onChanged: context.read<UpdateAccountInfoCubit>().emailChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
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

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  late final TextEditingController textEditingController;

  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final isValid =
        context.select((UpdateAccountInfoCubit cubit) => cubit.state.isValid);
    final isProgressing = context.select(
        (UpdateAccountInfoCubit cubit) => cubit.state is PasswordChanged);
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _isHidden = !_isHidden),
          icon: Icon(
            _isHidden ? Icons.visibility : Icons.visibility_off,
            color: !isValid
                ? Colors.red
                : isProgressing
                    ? AppTheme.primaryColor
                    : null,
          ),
        ),
        labelText: S.current.password,
        semanticCounterText: S.current.passwordRequirement,
        border: const OutlineInputBorder(
          borderRadius: defaultFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        floatingLabelStyle: TextStyle(
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        labelStyle: TextStyle(
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        counterText: '',
        errorMaxLines: 2,
        errorText: !isValid ? S.current.passwordRequirement : null,
      ),
      obscureText: _isHidden,
      textDirection: defaultTextDirection,
      cursorColor: AppTheme.primaryColor,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.send,
      onChanged: context.read<UpdateAccountInfoCubit>().passwordChanged,
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput();

  static const maxPhoneNum = 10;
  @override
  Widget build(BuildContext context) {
    final isValid =
        context.select((UpdateAccountInfoCubit cubit) => cubit.state.isValid);
    final isProgressing = context.select(
        (UpdateAccountInfoCubit cubit) => cubit.state is PhoneNumberChanged);

    return TextField(
      onChanged: context.read<UpdateAccountInfoCubit>().phoneNumberChanged,
      cursorColor: AppTheme.primaryColor,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.phone,
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        border:
            const OutlineInputBorder(borderRadius: defaultFieldBorderRadius),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        labelStyle: TextStyle(
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        floatingLabelStyle: TextStyle(
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        hintText: S.current.phoneSearchHintText,
        errorText: isValid ? null : S.current.invalidPhoneNumberError,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxPhoneNum),
      ],
      keyboardType: TextInputType.phone,
      textAlign: TextAlign.start,
      textDirection: defaultTextDirection,
    );
  }
}

class _DisplayNameInput extends StatelessWidget {
  const _DisplayNameInput();

  @override
  Widget build(BuildContext context) {
    final isValid =
        context.select((UpdateAccountInfoCubit cubit) => cubit.state.isValid);
    final isProgressing = context.select(
        (UpdateAccountInfoCubit cubit) => cubit.state is DisplayNameChanged);

    return TextField(
      onChanged: context.read<UpdateAccountInfoCubit>().displayNameChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: !isValid
              ? Colors.red
              : isProgressing
                  ? AppTheme.primaryColor
                  : null,
        ),
        border: const OutlineInputBorder(
          borderRadius: defaultFieldBorderRadius,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.primaryColor),
        ),
        hintText: S.current.displayName,
        labelText: S.current.displayName,
        floatingLabelStyle:
            TextStyle(color: !isValid ? Colors.red : AppTheme.primaryColor),
        labelStyle: TextStyle(color: !isValid ? Colors.red : null),
        errorText: !isValid ? S.current.invalidEmail : null,
      ),
      cursorColor: AppTheme.primaryColor,
      textDirection: defaultTextDirection,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}
