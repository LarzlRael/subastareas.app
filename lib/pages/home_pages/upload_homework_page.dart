part of '../pages.dart';

class UploadHomeworkPage extends StatefulWidget {
  const UploadHomeworkPage({Key? key}) : super(key: key);

  @override
  State<UploadHomeworkPage> createState() => _UploadHomeworkPageState();
}

class _UploadHomeworkPageState extends State<UploadHomeworkPage> {
  /* final format = DateFormat("dd-MM-yyyy hh:mm"); */

  final sizeTabIcon = 35.0;
  final colorTab = Colors.grey;
  @override
  Widget build(BuildContext context) {
    /* final authServices = Provider.of<AuthServices>(context, listen: true); */
    return Scaffold(
      appBar: AppBarTitle(
        title: 'Subir nueva tarea',
        fontSize: 15,
        appBar: AppBar(),
      ),
      body: DefaultTabController(
        length: tabsOptions().length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            /* backgroundColor:
                theme.getDarkTheme ? Colors.transparent : Colors.grey[100], */
            toolbarHeight: 20,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              padding: const EdgeInsets.only(bottom: 20),
              tabs: tabsOptions(),
            ),
          ),
          body: const TabBarView(
            children: [
              UploadHomeworkWithFile(homework: null),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadHomeworkWithFile extends StatefulWidget {
  final Homework? homework;
  const UploadHomeworkWithFile({
    Key? key,
    this.homework,
  }) : super(key: key);

  @override
  State<UploadHomeworkWithFile> createState() => _UploadHomeworkWithFileState();
}

class _UploadHomeworkWithFileState extends State<UploadHomeworkWithFile> {
  late HomeworksProvider homeworksProvider;
  late AuthProvider authService;
  late bool isNewHomework;

  @override
  void initState() {
    super.initState();
    if (widget.homework != null) {
      homework = widget.homework!;
    }
    authService = context.read<AuthProvider>();
    homeworksProvider = context.read<HomeworksProvider>();
  }

  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  Homework homework = Homework(
    visible: true,
    id: 0,
    title: '',
    description: '',
    offeredAmount: 0,
    fileUrl: null,
    fileType: '',
    resolutionTime: DateTime.now(),
    category: '',
    observation: '',
    status: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    user: CommentUser(
      id: 0,
      profileImageUrl: '',
      username: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    isNewHomework = homework.id == 0;
    return Scaffold(
      appBar: isNewHomework
          ? null
          : AppBarWithBackIcon(
              appBar: AppBar(),
            ),
      body: SafeArea(
        child: uploadHomework(),
      ),
    );
  }

  Widget uploadHomework() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        /* height: MediaQuery.of(context).size.height, */
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: FormBuilder(
          initialValue: {
            'title': homework.title,
            'offered_amount': homework.offeredAmount.toString(),
            /* 'category': homework.category, */
            'resolutionTime': homework.resolutionTime,
          },
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  /* SimpleText(
                    text:
                        'Tu saldo actual es de: ${authService.user.wallet.balanceTotal}',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    bottom: 10,
                  ), */
                  Text(
                    'Tu saldo actual es de: ${authService.user.wallet.balanceTotal}',
                    style: const TextStyle(
                      fontSize: 20,
                      /* color: Colors.grey[600], */
                    ),
                  ),
                  const CustomFileField(
                    name: 'file',
                    isRequired: false,
                  ),
                  const CustomFormBuilderTextArea(
                    name: 'title',
                    title: 'Escribe tu pregunta',
                    icon: Icons.person,
                  ),
                  CustomRowFormBuilderTextField(
                    name: 'offered_amount',
                    placeholder: 'Presupuesto ',
                    keyboardType: TextInputType.number,
                    suffixIcon: FontAwesomeIcons.coins,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.max(
                            authService.user.wallet.balanceTotal),
                        FormBuilderValidators.min(1),
                      ],
                    ),
                  ),
                  CustomDatePicker(
                    name: 'resolutionTime',
                    suffixIcon: FontAwesomeIcons.calendarDays,
                    placeholder: 'Tiempo de resolución : ',
                    keyboardType: TextInputType.datetime,
                    validator: FormBuilderValidators.compose([
                      (selectedDateTime) {
                        if (selectedDateTime == null) {
                          return 'Selecciona una fecha';
                        }
                        if (selectedDateTime
                            .difference(DateTime.now())
                            .isNegative) {
                          return 'Selected DateTime is in the future';
                        }
                        return null;
                      }
                    ]),
                  ),
                  const CustomFormBuilderFetchDropdown(
                    formFieldName: 'category',
                    placeholder: 'Seleccione una categoria',
                    title: 'Categoria :',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  !_isLoading
                      ? FillButton(
                          label: isNewHomework ? "Subir tarea" : "Editar tarea",
                          borderRadius: 20,
                          textColor: Colors.white,
                          onPressed: uploadOrEditHomework,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void uploadOrEditHomework() async {
    final validationSuccess = _formKey.currentState!.validate();

    if (!validationSuccess) return;
    _formKey.currentState!.save();

    final Map<String, String> data = {
      'title': _formKey.currentState!.value['title'],
      'offered_amount': _formKey.currentState!.value['offered_amount'],
      'category': _formKey.currentState!.value['category'],
      'resolutionTime':
          _formKey.currentState!.value['resolutionTime'].toString(),
    };

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    homeworksProvider
        .uploadOrUpdateHomework(
      homework.id,
      data,
      pathFile: _formKey.currentState!.value['file'] != null
          ? _formKey.currentState!.value['file'][0].path
          : null,
    )
        .then((value) {
      _successUploaded(value);
    });

    /* showFilterBottomMenuSheetxD(); */
  }

  void _successUploaded(
    bool result,
  ) {
    setState(() {
      _isLoading = false;
    });
    if (result) {
      context.push('/my_homeworks_page', extra: 0);
      _formKey.currentState!.reset();
      GlobalSnackBar.show(
        context,
        'Tarea subida correctamente',
        backgroundColor: Colors.green,
      );
    } else {
      GlobalSnackBar.show(
        context,
        'Error al subir tarea',
        backgroundColor: Colors.red,
      );
    }
  }

  showFilterBottomMenuSheetxD() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const SafeArea(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
