part of '../widgets.dart';

class WithdrawRequestCard extends StatelessWidget {
  final WithdrawalRequestsModel withdrawRequest;

  const WithdrawRequestCard({
    Key? key,
    required this.withdrawRequest,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          '/withdraw_request_detail',
          extra: withdrawRequest,
        );
      },
      child: Ink(
        child: Card(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ShowProfileImage(
                        profileImage: withdrawRequest.profileImageUrl,
                        userName: withdrawRequest.username.toCapitalized(),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SimpleText(
                            text: withdrawRequest.username.toCapitalized(),
                            fontSize: 18,
                            /* fontWeight: FontWeight.bold, */
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SimpleText(
                            text: withdrawRequest.email.toCapitalized(),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SimpleText(
                        text:
                            '${withdrawRequest.withdrawalRequestAmount.abs()} monedas',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      SimpleText(
                        text: convertTime(withdrawRequest.createdAt,
                            format: 'dd/MM/yyyy'),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
