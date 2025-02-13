import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scp/utils/grapgQLconfig.dart';
import 'package:scp/utils/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

final String aboutText =
    "Institute Counselling Services, NIT Rourkela is a noble initiative by the former Director, Prof. Animesh Biswas. This service deals with various important aspects of a student’s life. It addresses Academic, Financial, Mental and Socio-cultural issues, ensuring a seamless transition from home to hostel life for the freshmen and making life at NITR more enjoyable. \n\n"
    "The objective of ICS is to prepare the students for a confident approach towards life and to bring about a voluntary change in themselves. The goal of counselling is to help individuals overcome their immediate problems and also to equip them to meet future problems. The goals of counselling are appropriately concerned with fundamental and basic aspects such as self-understanding and self-actualization.\n\n"
    "The service has 7 faculty members, including the Head of Unit, Prof. Pawan Kumar and 12 Student Coordinators and 11 Prefects. The Coordinators monitor the overall functioning, manage the events, programs and initiatives of ICS. Each Prefect has been assigned a set number of mentors who in turn take care of the mentees from the freshman year. Experienced mentors interact with the freshers to bridge the Junior-Senior gap and also provide personal and professional support. Professional support is provided to all the students and faculty of the institute through online counselling platform YourDOST. Institute Counselling Services also has at their premises at campus a Counsellor and a Psychiatrist, who professionally deal with various students and faculty isssues. ";

final String readFaculties = """
query Faculties{
  getFaculties {
    id
    name
    designation
  }
}
""";

final String readCordinators = """
query Coordinator{
  getCoordinators{
    id
    name
    contact
    email
  }
}
""";

final String readPrefect = """
query Prefect{
  getPrefects{
    id
    name
    contact
    email
  }
}
""";

class AboutSCP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 39, 45, 1),
        title: Text(
          "About ICS",
          style: TextStyle(
            fontFamily: 'PfDin',
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Center(
                child: Text(
                  "ABOUT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 20, bottom: 30),
              child: Text(
                aboutText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'PfDin',
                  color: Color.fromRGBO(25, 39, 45, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Center(
                child: Text(
                  "FACULTY MEMBERS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.screenWidth * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            GraphQLProvider(
              client: valueclient,
              child: Query(
                options: QueryOptions(document: gql(readFaculties)),
                builder: (QueryResult? result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result!.data == null) {
                    return Container();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result.data!["getFaculties"].length,
                      itemBuilder: (BuildContext context, int index) {
                        var ref = result.data!["getFaculties"];
                        return contactCard(context, ref[index]["name"],
                            ref[index]["designation"], "");
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "ADVISOR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            contactCard(
                context, "Amlan Das", "amlandas08@gmail.com", "8637252603"),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "COORDINATORS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            GraphQLProvider(
              client: valueclient,
              child: Query(
                options: QueryOptions(document: gql(readCordinators)),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.data == null) {
                    return Container();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result.data!["getCoordinators"].length,
                      itemBuilder: (BuildContext context, int index) {
                        var ref = result.data!["getCoordinators"];
                        return contactCard(context, ref[index]["name"],
                            ref[index]["email"], ref[index]["contact"]);
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 15),
              child: Center(
                child: Text(
                  "PREFECTS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'PfDin',
                    color: Color.fromRGBO(74, 232, 190, 1),
                  ),
                ),
              ),
            ),
            GraphQLProvider(
              client: valueclient,
              child: Query(
                options: QueryOptions(document: gql(readPrefect)),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.data == null) {
                    return Container();
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: result.data!["getPrefects"].length,
                      itemBuilder: (BuildContext context, int index) {
                        var ref = result.data!["getPrefects"];
                        return contactCard(context, ref[index]["name"],
                            ref[index]["email"], ref[index]["contact"]);
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactCard(
      BuildContext context, String name, String position, String contact) {
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        if (contact != "") {
          launchUrl(Uri.parse("tel://" + contact));
        } else {}
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textScaleFactor * 20,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w800),
              ),
            ),
            Text(
              position,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: textScaleFactor * 15,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            ),
            Text(
              contact,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: textScaleFactor * 15,
                  fontFamily: 'PfDin',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
