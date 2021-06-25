import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class DetailsWidget extends StatefulWidget {
  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_outlined, size: 25, color: Colors.grey,),
                  Text("More details about this event",
                    style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1),),
                ],
              ),
            ),
            Html(
              defaultTextStyle: TextStyle(color: Colors.grey[700]),
              data:
              "<p>Bayelsa State Government has faulted the deductions of a total sum of N11.678bn by the Federal Government from its monthly revenue allocation over disputed oil wells with sister states.\n<p>The government described the deductions as &#8220;illegal&#8221;.\n<p>Governor Douye Diri&#8217;s Technical Adviser on Finance, Revenue and Accounts, Timipre Seipulou, said these during the income and expenditure briefing for the months of March and April 2021 at the state Ministry of Finance Conference Hall, Yenagoa, on Thursday.\n<p>He contended that although a lower court had ruled over the matter, the Federal Government should have allowed all the legal processes to be exhausted before making such deductions.\n<p>Seipulou complained that the state government had protested over the issue to no avail, noting that the N939.865m was being deducted monthly from the Bayelsa&#8217;s allocation, which payment was spread over a period of one year.\n"
                  "<p>Bayelsa State Government has faulted the deductions of a total sum of N11.678bn by the Federal Government from its monthly revenue allocation over disputed oil wells with sister states.\n<p>The government described the deductions as &#8220;illegal&#8221;.\n<p>Governor Douye Diri&#8217;s Technical Adviser on Finance, Revenue and Accounts, Timipre Seipulou, said these during the income and expenditure briefing for the months of March and April 2021 at the state Ministry of Finance Conference Hall, Yenagoa, on Thursday.\n<p>He contended that although a lower court had ruled over the matter, the Federal Government should have allowed all the legal processes to be exhausted before making such deductions.\n<p>Seipulou complained that the state government had protested over the issue to no avail, noting that the N939.865m was being deducted monthly from the Bayelsa&#8217;s allocation, which payment was spread over a period of one year.\n"

            )
          ],
        ),
      ),),
    );
  }

}
