import 'package:autask/app/theme/app_spacing.dart';
import 'package:autask/core/constants/app_strings.dart';
import 'package:autask/features/ai_settings/presentation/cubit/ai_settings_cubit.dart';
import 'package:autask/features/ai_settings/presentation/cubit/ai_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class AiSettingsPage extends StatefulWidget {
  const AiSettingsPage({super.key});

  @override
  State<AiSettingsPage> createState() => _AiSettingsPageState();
}

class _AiSettingsPageState extends State<AiSettingsPage> {
  late final TextEditingController _apiKeyController;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.aiSettingsTitle)),
      body: BlocConsumer<AiSettingsCubit, AiSettingsState>(
        listener: (BuildContext context, AiSettingsState state) {
          if (state.status == AiSettingsStatus.success &&
              state.message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
          }

          if (state.status == AiSettingsStatus.error && state.message != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (BuildContext context, AiSettingsState state) {
          final AiSettingsCubit cubit = context.read<AiSettingsCubit>();

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: <Widget>[
              Text(
                AppStrings.aiSettingsDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: _apiKeyController,
                obscureText: !state.isKeyVisible,
                decoration: InputDecoration(
                  hintText: AppStrings.aiApiKeyHint,
                  suffixIcon: IconButton(
                    onPressed: cubit.toggleKeyVisibility,
                    icon: HeroIcon(
                      state.isKeyVisible ? HeroIcons.eyeSlash : HeroIcons.eye,
                      style: HeroIconStyle.outline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: state.status == AiSettingsStatus.loading
                          ? null
                          : () {
                              cubit.saveApiKey(apiKey: _apiKeyController.text);
                            },
                      icon: const HeroIcon(
                        HeroIcons.checkCircle,
                        style: HeroIconStyle.outline,
                      ),
                      label: const Text(AppStrings.aiSaveKeyButton),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (state.hasSavedKey)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppStrings.aiSavedKeyTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          state.maskedKey ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton.icon(
                          onPressed: state.status == AiSettingsStatus.loading
                              ? null
                              : () {
                                  cubit.deleteApiKey();
                                },
                          icon: const HeroIcon(
                            HeroIcons.trash,
                            style: HeroIconStyle.outline,
                          ),
                          label: const Text(AppStrings.aiDeleteKeyButton),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Text(AppStrings.aiNoSavedKeyLabel),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
