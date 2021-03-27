import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';

enum UserRole { mentor, mentee }

class SelectRoleView extends StatefulWidget {
  final Function(bool) onTap;

  const SelectRoleView({Key? key, required this.onTap}) : super(key: key);

  @override
  _SelectRoleViewState createState() => _SelectRoleViewState();
}

class _SelectRoleViewState extends State<SelectRoleView>
    with AutomaticKeepAliveClientMixin {
  bool isSelected = false;
  UserRole _userRole = UserRole.mentee;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Select your role',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                RoleSelectChip(
                  isSelected: isSelected,
                  roleText: 'Become a mentee',
                  onRoleSelect: (selectedRole) {
                    setState(() {
                      _userRole = selectedRole as UserRole;
                    });
                    print(selectedRole);
                  },
                  groupValue: _userRole,
                  value: UserRole.mentee,
                ),
                SizedBox(
                  height: 20,
                ),
                RoleSelectChip(
                  isSelected: isSelected,
                  roleText: 'Become a mentor',
                  onRoleSelect: (selectedRole) {
                    setState(() {
                      _userRole = selectedRole as UserRole;
                      isSelected = true;
                    });
                    print(selectedRole);
                  },
                  groupValue: _userRole,
                  value: UserRole.mentor,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomElevatedButton(
                    child: Text(
                      'NEXT',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                    ),
                    onPressed: () => widget.onTap(_userRole == UserRole.mentor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RoleSelectChip extends StatelessWidget {
  const RoleSelectChip({
    Key? key,
    required this.roleText,
    required this.onRoleSelect,
    required this.isSelected,
    required this.groupValue,
    required this.value,
  }) : super(key: key);

  final String roleText;
  final Function(Object) onRoleSelect;
  final bool isSelected;
  final Object groupValue;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.appColorTeal,
          ),
          borderRadius: BorderRadius.circular(50.0)),
      child: Theme(
        data: ThemeData(highlightColor: Colors.transparent),
        child: RadioListTile(
          dense: true,
          groupValue: groupValue,
          value: value,
          activeColor: CustomColors.appColorTeal,
          onChanged: (value) {
            onRoleSelect(value!);
          },
          title: Text(
            roleText,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 16,
                  color: CustomColors.appColorTeal,
                ),
          ),
        ),
      ),
    );
  }
}
