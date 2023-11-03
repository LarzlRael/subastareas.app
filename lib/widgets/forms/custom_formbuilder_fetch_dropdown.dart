part of '../widgets.dart';

class CustomFormBuilderFetchDropdown extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  const CustomFormBuilderFetchDropdown({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = context.read<HomeworksProvider>();
    final sharedPreferences = UserPreferences();
    return sharedPreferences.getSubjectsList.isEmpty
        ? FutureSubjectCategory(
            sharedPreferences: sharedPreferences,
            title: title,
            homeworkServices: homeworkServices,
            formFieldName: formFieldName,
            placeholder: placeholder)
        : LocalSubjectCategory(
            sharedPreferences: sharedPreferences,
            title: title,
            formFieldName: formFieldName,
            placeholder: placeholder);
  }
}

class FutureSubjectCategory extends StatelessWidget {
  const FutureSubjectCategory({
    Key? key,
    required this.homeworkServices,
    required this.sharedPreferences,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  final HomeworksProvider homeworkServices;
  final UserPreferences sharedPreferences;
  final String title;
  final String formFieldName;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeworkServices.getSubjectAndLevels(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        sharedPreferences.setSubjectsList = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            const SizedBox(
              width: 10,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: FormBuilderDropdown(
                  name: formFieldName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeholder,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  /* initialValue: category[0], */

                  validator: FormBuilderValidators.required(),
                  items: snapshot.data!
                      .map((category) => DropdownMenuItem(
                          value: category, child: Text(category)))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LocalSubjectCategory extends StatelessWidget {
  const LocalSubjectCategory({
    Key? key,
    required this.sharedPreferences,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  final UserPreferences sharedPreferences;
  final String title;
  final String formFieldName;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleText(
          text: title,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(
          width: 10,
        ),
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FormBuilderDropdown(
              name: formFieldName,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              /* initialValue: category[0], */
              validator: FormBuilderValidators.required(),
              items: sharedPreferences.getSubjectsList
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
