part of '../widgets.dart';

class CustomFormbuilderFetchDropdown extends StatelessWidget {
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
                text: "Categoria",
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              Expanded(
                child: FormBuilderDropdown(
                  name: "category",
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  /* initialValue: category[0], */
                  hint: const Text('Categoria'),
                  validator: FormBuilderValidators.required(),
                  items: snapshot.data!
                      .map((category) => DropdownMenuItem(
                          value: category, child: Text("$category")))
                      .toList(),
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
