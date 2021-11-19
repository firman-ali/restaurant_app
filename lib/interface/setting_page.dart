import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_api/common/constant.dart';
import 'package:restaurant_app_api/provider/preference_provider.dart';
import 'package:restaurant_app_api/widget/show_snack_bar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Center(
                child: Text(
                  DataString.settingPageTitle,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              DataString.preferenceSettingTitle,
              style: Theme.of(context).textTheme.headline2,
            ),
            _buildListPreference(context),
          ],
        ),
      ),
    );
  }

  Widget _buildListPreference(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Material(
              child: ListTile(
                leading: const Icon(Icons.wb_sunny_outlined),
                title: const Text(DataString.darkThemeTitle),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  onChanged: (value) {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBar(DataString.themeMessageActive));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          showSnackBar(DataString.themeMessageCancle));
                    }
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text(DataString.scheduleNotificationTitle),
                trailing: Switch.adaptive(
                  value: provider.isScheduleActive,
                  onChanged: (value) async {
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBar(DataString.scheduleMessageActive),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSnackBar(DataString.scheduleMessageCancle),
                      );
                    }
                    provider.enableDailyNews(value);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
