part of '../widgets.dart';

class CustomFormbuilderFetchDropdown extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  const CustomFormbuilderFetchDropdown({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeworkServices = HomeworkServices();
    return FutureBuilder(
      future: homeworkServices.getSubjectAndLevels(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return Row(
            children: [
              SimpleText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FormBuilderDropdown(
                      name: formFieldName,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      /* initialValue: category[0], */
                      hint: Text(placeholder),
                      validator: FormBuilderValidators.required(),
                      items: snapshot.data!
                          .map((category) => DropdownMenuItem(
                              value: category, child: Text(category)))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
