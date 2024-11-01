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

class InputFieldConfig {
  final IconData icon;
  final String labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final List<TextInputFormatter>? formatters;
  final void Function(String) onChanged;

  const InputFieldConfig({
    required this.icon,
    required this.labelText,
    this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.formatters,
    required this.onChanged,
  });
}

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
      listener: _handleStateChanges,
      child: SafeArea(
        child: Scaffold(
          appBar: defaultWhiteAppBar(context: context, titleText: title),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: _buildInputField(context),
                ),
              ),
              _buildContinueButton(context),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, UpdateAccountInfoState state) {
    if (state is UpdateSucceed) {
      _handleUpdateSuccess(context, state);
    } else if (state is UpdateFailed) {
      showToast(state.errorMessage, context: context);
    } else if (state is EmailVerifying) {
      showToast(S.current.verifyEmailAnnounce, context: context);
    }
  }

  void _handleUpdateSuccess(BuildContext context, UpdateSucceed state) {
    if (!state.user.isLoggedIn) {
      showToast(S.current.reLogin);
      return;
    }
    showToast(S.current.success, context: context);
    context.read<UserCubit>().getUser(state.user.id);
    Navigator.pop(context);
  }

  Widget _buildInputField(BuildContext context) {
    final cubit = context.read<UpdateAccountInfoCubit>();

    final configs = {
      AccountAction.changeEmail: InputFieldConfig(
        icon: Icons.person,
        labelText: 'Email',
        hintText: 'abc@example.com',
        keyboardType: TextInputType.emailAddress,
        onChanged: cubit.emailChanged,
      ),
      AccountAction.changePassword: InputFieldConfig(
        icon: Icons.lock,
        labelText: S.current.password,
        keyboardType: TextInputType.visiblePassword,
        isPassword: true,
        onChanged: cubit.passwordChanged,
      ),
      AccountAction.changePhoneNumber: InputFieldConfig(
        icon: Icons.phone,
        labelText: S.current.phoneNumber,
        keyboardType: TextInputType.phone,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        onChanged: cubit.phoneNumberChanged,
      ),
      AccountAction.changeDisplayName: InputFieldConfig(
        icon: Icons.person,
        labelText: S.current.displayName,
        hintText: S.current.displayName,
        keyboardType: TextInputType.name,
        onChanged: cubit.displayNameChanged,
      ),
    };

    final config = configs[action];
    if (config == null) return Container();

    return CustomInputField(config: config);
  }

  Widget _buildContinueButton(BuildContext context) {
    return ContinueButton(
      onTap: context.select((UpdateAccountInfoCubit cubit) {
        final isChanged = cubit.isUserChanged ||
            (cubit.state is PasswordChanged && cubit.state.password.isValid);
        return isChanged && cubit.state.isValid
            ? () => cubit.updateAccount()
            : null;
      }),
    );
  }
}

class CustomInputField extends StatefulWidget {
  final InputFieldConfig config;

  const CustomInputField({
    super.key,
    required this.config,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isHidden = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAccountInfoCubit, UpdateAccountInfoState>(
      builder: (context, state) {
        final isValid = state.isValid;
        final isProgressing = state is EmailChanged ||
            state is PasswordChanged ||
            state is PhoneNumberChanged ||
            state is DisplayNameChanged;

        return TextField(
          focusNode: _focusNode,
          controller: _controller,
          onChanged: widget.config.onChanged,
          decoration: _buildInputDecoration(isValid, isProgressing),
          obscureText: widget.config.isPassword && _isHidden,
          keyboardType: widget.config.keyboardType,
          textDirection: defaultTextDirection,
          cursorColor: AppTheme.primaryColor,
          inputFormatters: widget.config.formatters,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(bool isValid, bool isProgressing) {
    final color = !isValid
        ? Colors.red
        : isProgressing
            ? AppTheme.primaryColor
            : null;

    return InputDecoration(
      prefixIcon: Icon(widget.config.icon, color: color),
      suffixIcon: widget.config.isPassword
          ? IconButton(
              onPressed: () => setState(() => _isHidden = !_isHidden),
              icon: Icon(
                _isHidden ? Icons.visibility : Icons.visibility_off,
                color: color,
              ),
            )
          : null,
      border: const OutlineInputBorder(
        borderRadius: defaultFieldBorderRadius,
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primaryColor),
      ),
      labelText: widget.config.labelText,
      hintText: widget.config.hintText,
      floatingLabelStyle: TextStyle(color: color),
      labelStyle: TextStyle(color: color),
      errorText: !isValid ? _getErrorText() : null,
      errorMaxLines: 2,
    );
  }

  String _getErrorText() {
    if (widget.config.isPassword) return S.current.passwordRequirement;
    if (widget.config.keyboardType == TextInputType.emailAddress) {
      return S.current.invalidEmail;
    }
    if (widget.config.keyboardType == TextInputType.phone) {
      return S.current.invalidPhoneNumberError;
    }

    return S.current.invalidInput;
  }
}
