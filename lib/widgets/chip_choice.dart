part of 'widgets.dart';

class ChipChoice extends StatefulWidget {
  final List<String> elementsList;
  final Function onClickAction;
  /* final List<String> elementsList; */
  const ChipChoice({
    Key? key,
    required this.elementsList,
    required this.onClickAction,
  }) : super(key: key);

  @override
  _ChipChoiceState createState() => _ChipChoiceState();
}

class _ChipChoiceState extends State<ChipChoice> {
  /* List<String> elementsList = [
    'Matematica',
    'Programación',
    'Fisica',
    'Quimica',
    'Algebra',
    'Trigonometria',
    'Geometria',
  ]; */

  List<String> selectedElementList = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectChip(
      onClickAction: widget.onClickAction,
      reportList: widget.elementsList,
      onSelectionChanged: (selectedList) {
        setState(() {
          selectedElementList = selectedList;
        });
      },
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;
  final Function onClickAction;

  const MultiSelectChip({
    Key? key,
    required this.reportList,
    required this.onSelectionChanged,
    required this.onClickAction,
  }) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.map((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(1.5),
        child: ChoiceChip(
          /* selectedColor: Colors.blue, */
          label: SimpleText(
            text: item,
            fontSize: 15,
            /* fontWeight: FontWeight.bold, */
            color: Colors.black,
          ),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
              widget.onClickAction(item);
            });
          },
        ),
      ));
    }).toList();

    return choices;
  }
}
