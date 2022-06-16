part of '../pages.dart';

class AutionWithOfferPage extends StatefulWidget {
  const AutionWithOfferPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AutionWithOfferPage> createState() => _AutionWithOfferPageState();
}

class _AutionWithOfferPageState extends State<AutionWithOfferPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as OneHomeworkModel;
    final auth = Provider.of<AuthServices>(context, listen: false);
    final size = MediaQuery.of(context).size;
    OneHomeworkBloc homeworksBloc = OneHomeworkBloc();
    homeworksBloc.getOneHomework(args.homework.id);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                  'https://concepto.de/wp-content/uploads/2018/08/f%C3%ADsica-e1534938838719.jpg'),
              _buttonOffer(size, auth.isLogged, args),
              Positioned(
                bottom: 30,
                child: SizedBox(
                  width: size.width,
                  height: 100,
                  child: const Align(
                    child: FloatMenu(),
                  ),
                ),
                top: 0,
              ),
            ],
          ),
          Container(
            color: Colors.yellow,
            padding: const EdgeInsets.all(16.0),
            child: const SimpleText(
              text: "Ofertas de los vendedores",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder(
            stream: homeworksBloc.oneHomeworkStream,
            builder: (BuildContext context,
                AsyncSnapshot<OneHomeworkModel> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.data!.offers.isEmpty) {
                return NoInformation(
                  message: 'No hay ofertas aun',
                  icon: Icons.search_off,
                  showButton: true,
                  iconButton: Icons.add,
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    /* scrollDirection: Axis.horizontal, */
                    itemCount: snapshot.data!.offers.length,
                    itemBuilder: (context, index) {
                      return PersonOfferHorizontal(
                        offer: snapshot.data!.offers[index],
                        /* active: index % 2 == 0, */
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buttonOffer(Size size, bool isLogged, OneHomeworkModel homework) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 170.0,
            ),
          ),
          Container(
            width: size.width * 0.75,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    0.0,
                    1.0,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SimpleText(
                            text: 'Afro Weed',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          TimerCounter(
                            endTime: DateTime.now().millisecondsSinceEpoch +
                                getDateDiff(homework.homework.resolutionTime)
                                    .inMilliseconds,
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          navigatorProtected(
                            context,
                            isLogged,
                            'makeOffer',
                            homework,
                          );
                        },
                        child: const SimpleText(
                          fontSize: 15,
                          text: "Hacer una oferta",
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
