import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/my_Security&privacy.dart';
class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("About the App",style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Learn More About Eco-Step:',
                    style: TextStyle(
                        fontSize: 19,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontFamily: 'Lilita_one'
                    ),
                  ),
                  editdescriptiontextOption(
                    title: 'About Eco-Step:',
                    text:
                    "   Est fugiat assumenda aut reprehenderit Lorem ipsum"
                        " dolor sit amet. Et odio officia aut voluptate internos "
                        "estomnis vitae ut architecto sunt non tenetur fuga ut"
                        " provident vero. Quoaspernatur facere et consectetur ipsum "
                        "et facere corrupti est asperioresfacere. Est fugiat assumenda "
                        "aut reprehenderit voluptatem sed.Ea voluptates omnis aut sequi"
                        " sequi.Est dolore quae in aliquid ducimus et autem repellendus.Aut"
                        " ipsum Quis qui porro quasi aut minus placeat!Sit consequatur neque"
                        " ab vitae facere.\n"
                        "      Aut quidem accusantium nam alias autem eum officiis"
                        " placeat et omnis autemid officiis perspiciatis qui corrupti officia"
                        " eum aliquam provident. Eumvoluptas error et optio dolorum cum molestiae"
                        " nobis et odit molestiae quomagnam impedit sed fugiat nihil non nihil"
                        " vitae.Aut fuga sequi eum voluptatibus provident.\n"
                        "      Eos consequuntur voluptas"
                        " vel amet eaque aut dignissimos velit.Vel exercitationem quam vel eligendi"
                        " rerum At harum obcaecati et nostrum beatae?Ea accusantium dolores qui"
                        " rerum aliquam est perferendis mollitia et ipsum ipsaqui enim autem At"
                        " corporis sunt. Aut odit quisquam est reprehenderit itaque autaccusantium"
                        " dolor qui neque repellat.\n"
                        "\n"
                        "    Read about the app in more detail at"
                        "    www.eco_step.com",

                  ),
                ],
                controller: ScrollController(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
