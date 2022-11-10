part of '../widgets.dart';

class CustomDropdown extends StatelessWidget {
  final String title;
  final String formFieldName;
  final String placeholder;
  final List<String> listItems;
  const CustomDropdown({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.listItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownItemsList(
      title: title,
      formFieldName: formFieldName,
      placeholder: placeholder,
      listItems: listItems,
    );
  }
}

class DropdownItemsList extends StatelessWidget {
  const DropdownItemsList({
    Key? key,
    required this.title,
    required this.formFieldName,
    required this.placeholder,
    required this.listItems,
  }) : super(key: key);

  final String title;
  final String formFieldName;
  final String placeholder;
  final List<String> listItems;

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
              items: listItems
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
