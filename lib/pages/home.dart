import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/const.dart';
import 'package:job_portal/models/job.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                // title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Appwrite Jobs",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextButton(
                      child: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400),
                      ),
                      onPressed: () async {
                        await appwriteService.signOut().then((value) {
                          if (value) {
                            Navigator.of(context).pushReplacementNamed('/signin');
                          }
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(height: 64),
                // sub title
                Text(
                  "Find your dream\nAppwrite jobs",
                  style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 24),

                // ElevatedButton(
                //   child: Text("Demo Data"),
                //   onPressed: () {
                //     appwriteService.addSampleData();
                //   },
                // ),

                // job list
                FutureBuilder(
                  future: appwriteService.getJobList(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentList> snapshot) {
                    // has error
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var docs = snapshot.data;

                    var jobList = docs!.convertTo<Job>((map) => Job.fromMap(Map<String, dynamic>.from(map)));

                    return LayoutBuilder(builder: (context, constraints) {
                      return Wrap(
                        direction: Axis.vertical,
                        children: jobList.map((jobItem) {
                          return Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            width: constraints.maxWidth,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // logo
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white30,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Image.network(
                                          jobItem.logo,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    // title
                                    Text(jobItem.title, style: Theme.of(context).textTheme.headline4!),
                                    const SizedBox(height: 8),

                                    // location
                                    Row(
                                      children: [
                                        Text(
                                          jobItem.company + "    " + jobItem.location,
                                          style: Theme.of(context).textTheme.headline6!,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),

                                    // description
                                    Text(
                                      jobItem.description,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),

                                    const SizedBox(height: 16)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 32)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
