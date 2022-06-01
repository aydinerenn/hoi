// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hoi/colors.dart';
import 'package:hoi/style.dart';

class DestinationDetail extends StatefulWidget {
  final String imagePath;
  const DestinationDetail(this.imagePath);

  @override
  _DestinationDetailState createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return DestinationPage(
      controller: _controller,
      imagePath: widget.imagePath,
    );
  }
}

class DestinationPage extends StatelessWidget {
  final imagePath;
  DestinationPage(
      {Key key, @required AnimationController controller, this.imagePath})
      : animation = DestinationPageEnterAnimation(controller),
        super(key: key);
  final DestinationPageEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) => _buildAnimation(context),
    );
  }

  Hero _buildAnimation(BuildContext context) {
    return Hero(
      tag: imagePath,
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white70,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  // height: MediaQuery.of(context).size.height - 350,
                  height: animation.barHeight.value,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.secondaryColor,
                        AppColor.tertiaryColor,
                      ],
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryText(text: 'İstanbul', size: 24),
                          SizedBox(height: 10),
                          PrimaryText(
                              text:
                                  'İstanbul… Şarkılara, şiirlere, romanlara konu olmuş bir kültür ve tarih mozaiği… Dünyada eşi benzeri bulunmayan ve Avrupa ile Asya kıtaları üzerinde tarihi ve kültürel dokusuyla göz kamaştıran camiler, saraylar, parklar ve köşkler şehri İstanbul’u keşfetmek çok heyecanlı ve eğlenceli olacaktır.',
                              size: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white38),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PrimaryText(
                                text: 'Gezilebilecek Yerler',
                                size: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              PrimaryText(
                                  text: '18',
                                  size: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white24),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 160,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                hotDestinationCard(
                                    'assets/ormanPark/belgrad_ormani.jpg',
                                    'Belgrad Ormanı',
                                    '18 Tourist Place',
                                    context),
                                hotDestinationCard(
                                    'assets/ormanPark/gulhane_parki.jpg',
                                    'Gülhane Parkı',
                                    '18 Tourist Place',
                                    context),
                                hotDestinationCard(
                                    'assets/ormanPark/yildiz_parki.jpg',
                                    'Yıldız Parkı',
                                    '18 Tourist Place',
                                    context),
                                hotDestinationCard(
                                    'assets/ormanPark/macka_parki.jpg',
                                    'Maçka Parkı',
                                    '18 Tourist Place',
                                    context),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget hotDestinationCard(String imagePath, String placeName,
      String touristPlaceCount, BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DestinationDetail(imagePath)))
      },
      child: Stack(children: [
        Container(
          height: 160,
          width: 160,
          margin: EdgeInsets.only(right: 25),
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            height: 160,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColor.secondaryColor, Colors.transparent]),
            ),
          ),
        ),
      ]),
    );
  }
}

class DestinationPageEnterAnimation {
  DestinationPageEnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 600).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.5),
          ),
        );

  final AnimationController controller;
  final Animation<double> barHeight;
}
