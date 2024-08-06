import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:perfqse/Views/audit/controller/controller_audit.dart';

class DashboardGestion extends StatefulWidget {
  const DashboardGestion({super.key});

  @override
  State<DashboardGestion> createState() => _DashboardGestionState();
}

class _DashboardGestionState extends State<DashboardGestion> {
  final ControllerAudit controllerAudit = Get.put(ControllerAudit());
  final storage = FlutterSecureStorage();
  final String location = "/gestion/accueil";
  bool _isHoveringBox1 = false;
  bool _isHoveringBox2 = false;
  bool _isHoveringBox3 = false;
  bool _isHoveringBox4 = false;
  bool _isHoveringBox5 = false;
  bool _isHoveringBox6 = false;
  bool _isHoveringBox7 = false;
  bool _isHoveringBox8 = false;
  bool _isHoveringBox9 = false;
  bool _isHoveringBox10 = false;
  bool _isHoveringBox11 = false;
  bool _isHoveringBox12 = false;

  bool isHoveredQSE = false;
  bool isHoveredQ = false;
  bool isHoveredS = false;

  bool _showInfo = false; // State to control the visibility of the information widget
  Offset _infoPosition = Offset.zero; // Position of the information widget
  String _infoText = ''; // Text of the information widget

  final GlobalKey _keyE = GlobalKey();
  final GlobalKey _keyQ = GlobalKey();
  final GlobalKey _keyS = GlobalKey();

  final Map<String, String> buttonInfo = {
    'keyE': "Je suis le bouton Er\nrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr\nrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr",
    'keyQ': "I'm the Q button",
    'keyS': "Helloooo!!! It'es me S",
  };
  String _activeKey = '';

  Future<void> _showDialogNoAcces() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Accès refusé'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Vous n'avez pas la référence d'accès à cet espace."),
                SizedBox(height: 20),
                Image.asset(
                  "assets/images/forbidden.png",
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void getAccess(String centerTitle) async {
    String? reference = await storage.read(key: "ref");
    List<String> ref = ["QX", "SX"]; // ["Q", "S", "E", "QSE"]
    if (reference != null) {
      ref = reference.split("\n");
    }
    if (ref.contains(centerTitle)) {
      controllerAudit.reference.value = centerTitle;
      context.go(location);
    } else {
      _showDialogNoAcces();
    }
  }

  void _showInformation(Offset position, String infoText) {
    setState(() {
      _showInfo = true;
      _infoPosition = position;
      _infoText = infoText;
    });
  }

  void _hideInformation() {
    setState(() {
      _showInfo = false;
    });
  }

  void _handleButtonTap(String key, GlobalKey buttonKey) {
    final RenderBox? renderBox = buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final Offset buttonPosition = renderBox.localToGlobal(renderBox.size.centerLeft(Offset.zero));
      final String infoText = buttonInfo[key] ?? 'Aucune information disponible';
      _showInformation(buttonPosition, infoText);
      setState(() {
        _activeKey = key;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _hideInformation,
        child: Stack(
          children: [
            // Full-screen GestureDetector to hide information when clicking outside
            Positioned.fill(
              child: GestureDetector(
                onTap: _hideInformation,
                child: Container(color: Colors.transparent),
              ),
            ),



            // Le text "SYSTEME DE MANAGEMENT INTEGRE"

            Positioned(
              top: 10,
              right: 200,
              child: InkWell(
                child: SizedBox(
                  height: 50,
                  width: 900,
                  child: Container(
                    // decoration: BoxDecoration(
                    //   // image: DecorationImage(
                    //   //   image: AssetImage("assets/images/barre_qse.jpg"),
                    //   //   fit: BoxFit.fitWidth,
                    //   // ),
                    //   color: Colors.grey, // Changez la couleur de fond selon vos besoins
                    //   border: Border.all(color: Colors.white, width: 2), // Bordure grise
                    //   borderRadius: BorderRadius.circular(20), // Bordure circulaire
                    // ),
                    child: Center(
                      child: Text(
                        'SYSTEME DE MANAGEMENT INTEGRE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF468FBC),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),






            // Première barre juste après les barres déroulantes

            Positioned(
              top: 100,
              right: 200,
              child: InkWell(
                child: SizedBox(
                  height: 160,
                  width: 900,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/barre_qse.jpg"),
                          fit: BoxFit.fitWidth),
                      color: Colors.grey, // Changez la couleur de fond selon vos besoins
                      border: Border.all(color: Colors.white, width: 2), // Bordure grise
                      borderRadius: BorderRadius.circular(20), // Bordure circulaire
                    ),
                    // child: Stack(
                    //   children: [
                    //     Positioned(
                    //       top: 15, // Positionner l'image en haut
                    //       left: 0,
                    //       right: 0, // Centrer horizontalement
                    //       child: SizedBox(
                    //         height: 50,
                    //         width: 80,
                    //         child: Image.asset("assets/images/barre_qse.jpg", fit: BoxFit.contain),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: 10, // Positionner le texte en bas avec un padding de 10
                    //       left: 500,
                    //       right: 0,
                    //       child: Text(
                    //         'Q',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 10, // Positionner le texte en bas avec un padding de 10
                    //       left: 0,
                    //       right: 0,
                    //       child: Text(
                    //         'S',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: 10, // Positionner le texte en bas avec un padding de 10
                    //       left: 0,
                    //       right: 500,
                    //       child: Text(
                    //         'E',
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
              ),
            ),


            // Les annotations qui suivront sont à lire du haut vers le bas et de la gauche vers la droite

            // 1

            Positioned(
              top: 300,
              right: 898,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox1 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox1 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox1 ? Colors.white38 : Colors.white, // Couleur de fond
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(18), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5, // Positionner l'image en haut
                            left: 0,
                            right: 140, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 50,
                              child: Image.asset("assets/images/gestion_QSE.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 10, // Positionner le texte en bas avec un padding de 10
                            left: 60,
                            right: 0,
                            child: Text(
                              'Politique QSE',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // 2

            Positioned(
              top: 300,
              right: 667,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox3 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox3 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox3 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5, // Positionner l'image en haut
                            left: 0,
                            right: 150, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 50,
                              child: Image.asset("assets/images/parties_interesses1.jpg", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 11, // Positionner le texte en bas avec un padding de 10
                            left: 45,
                            right: 0,
                            child: Text(
                              'Parties intéressées',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 3

            Positioned(
              top: 300,
              right: 436,//480,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox2 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox2 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox2 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 9, // Positionner l'image en haut
                            left: 0,
                            right: 150, // Centrer horizontalement
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset("assets/images/respo_autorites1.jpg", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 2, // Positionner le texte en bas avec un padding de 10
                            left: 50,
                            right: 0,
                            child: Text(
                              "Ressources et responsabilités",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 4

            Positioned(
              top: 300,
              right: 205,//480,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox5 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox5 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox5 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 9, // Positionner l'image en haut
                            left: 0,
                            right: 150, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/images/firm.jpg", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 1, // Positionner le texte en bas avec un padding de 10
                            left: 50,
                            right: 0,
                            child: Text(
                              "Fonctionnement général",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //5

            Positioned(
              top: 385,
              right: 898,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox4 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox4 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox4 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 08, // Positionner l'image en haut
                            left: 0,
                            right: 150, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/images/non_conformes_et_actions_cor.jpg", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 11, // Positionner le texte en bas avec un padding de 10
                            left: 0,
                            right: 0,
                            child: Text(
                              'Améliorations',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 6

            Positioned(
              top: 385,
              right: 667,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox6 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox6 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox6 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/icons/gestion_processus1.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // Positionner le texte en bas avec un padding de 10
                            left: 50,
                            right: 0,
                            child: Text(
                              'Gestion des processus',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 7

            Positioned(
              top: 385,
              right: 436,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox7 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox7 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox7 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/images/analyse-exploratoire.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 13, // Positionner le texte en bas avec un padding de 10
                            left: 52,
                            right: 0,
                            child: Text(
                              'Contexte',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 8

            Positioned(
              top: 385,
              right: 205,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox8 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox8 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox8 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/icons/environnement.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 3, // Positionner le texte en bas avec un padding de 10
                            left: 50,
                            right: 0,
                            child: Text(
                              'Aspets environnementaux',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // 9

            Positioned(
              top: 470,
              right: 898,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox9 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox9 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox9 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 08, // Positionner l'image en haut
                            left: 0,
                            right: 150, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/icons/impact-environnemental.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 11, // Positionner le texte en bas avec un padding de 10
                            left: 45,
                            right: 0,
                            child: Text(
                              'IES',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),



            // 10

            Positioned(
              top: 470,
              right: 667,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox10 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox10 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox10 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/icons/danger_et_incident.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // Positionner le texte en bas avec un padding de 10
                            left: 50,
                            right: 0,
                            child: Text(
                              'Dangers et incidents',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 11

            Positioned(
              top: 470,
              right: 436,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox11 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox11 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox11 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/icons/urgences1.png", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // Positionner le texte en bas avec un padding de 10
                            left: 52,
                            right: 0,
                            child: Text(
                              "Situations d'urgence",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 12

            Positioned(
              top: 470,
              right: 205,//50,
              child: MouseRegion(
                onEnter: (_) => setState(() {
                  _isHoveringBox12 = true;
                }),
                onExit: (_) => setState(() {
                  _isHoveringBox12 = false;
                }),
                child: InkWell(
                  onTap: () {
                    // action à effectuer
                    context.go("/gestion/profil");
                  },
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isHoveringBox12 ? Colors.white38 : Colors.white, // Change la couleur de fond lorsqu'on survole
                        border: Border.all(color: Colors.grey, width: 0), // Bordure grise
                        borderRadius: BorderRadius.circular(20), // Bordure circulaire
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 2, // Étendue de l'ombre
                            blurRadius: 5, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre (horizontal, vertical)
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10, // Positionner l'image en haut
                            left: 0,
                            right: 145, // Centrer horizontalement
                            child: SizedBox(
                              height: 30,
                              width: 40,
                              child: Image.asset("assets/images/images.jpg", fit: BoxFit.contain),
                            ),
                          ),
                          Positioned(
                            bottom: 13, // Positionner le texte en bas avec un padding de 10
                            left: 48,
                            right: 0,
                            child: Text(
                              'Moyens de maîtrise',
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


            // Gestion de l'entreprise Dropdown

            // Positioned(
            //   top: 30,
            //   right: 50,//480
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       setState(() {
            //         isHoveredQSE = true;
            //       });
            //     },
            //     onExit: (_) {
            //       setState(() {
            //         isHoveredQSE = false;
            //       });
            //     },
            //     child: AnimatedContainer(
            //       duration: Duration(milliseconds: 300),
            //       height: isHoveredQSE ? 390 : 45,
            //       width: 275,
            //       decoration: BoxDecoration(
            //         color: Color(0xFF468FBC),//Color(0xFFB0C0CF),
            //         borderRadius: BorderRadius.circular(8),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         ),
            //       ),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(8),
            //                   topRight: Radius.circular(8),
            //                 ),
            //                 border: Border.all(
            //                   color: Colors.grey,
            //                   width: 1,
            //                 ),
            //               ),
            //               padding: EdgeInsets.symmetric(vertical: 8),
            //               child: Text(
            //                 "Gestion de l'entreprise",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             if (isHoveredQSE)
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 child: Column(
            //                   children: [
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("QSE");
            //                         },
            //                         child: Text("Fonctionnement de l'entreprise"),
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("QSE");
            //                         },
            //                         child: Text("Responsabilités et autorités"),
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("QSE");
            //                         },
            //                         child: Text("Gestion du personnel"),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Gestion SM-QSE Dropdown

            // Positioned(
            //   top: 30,
            //   left: 60,
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       setState(() {
            //         isHoveredQ = true;
            //       });
            //     },
            //     onExit: (_) {
            //       setState(() {
            //         isHoveredQ = false;
            //       });
            //     },
            //     child: AnimatedContainer(
            //       duration: Duration(milliseconds: 300),
            //       height: isHoveredQ ? 390 : 45,
            //       width: 275,
            //       decoration: BoxDecoration(
            //         color: Color(0xFFD1DBE4),
            //         borderRadius: BorderRadius.circular(8),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         ),
            //       ),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(8),
            //                   topRight: Radius.circular(8),
            //                 ),
            //                 border: Border.all(
            //                   color: Colors.grey,
            //                   width: 1,
            //                 ),
            //               ),
            //               padding: EdgeInsets.symmetric(vertical: 8),
            //               child: Text(
            //                 "Gestion SM-QSE",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             if (isHoveredQ)
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 child: Column(
            //                   children: [
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("Q");
            //                         },
            //                         child: Text("Politique QSE"),
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("Q");
            //                         },
            //                         child: Text("Non conformités &\nactions correctives"),
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                   ],
            //                 ),
            //               ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            // Systeme SM-QSE Dropdown

            // Positioned(
            //   top: 30,
            //   right: 480,//50
            //   child: MouseRegion(
            //     onEnter: (_) {
            //       setState(() {
            //         isHoveredS = true;
            //       });
            //     },
            //     onExit: (_) {
            //       setState(() {
            //         isHoveredS = false;
            //       });
            //     },
            //     child: AnimatedContainer(
            //       duration: Duration(milliseconds: 300),
            //       height: isHoveredS ? 390 : 45,
            //       width: 275,
            //       decoration: BoxDecoration(
            //         color: Color(0xFFB0C0CF),//Color(0xFF468FBC),
            //         borderRadius: BorderRadius.circular(8),
            //         border: Border.all(
            //           color: Colors.grey,
            //           width: 1,
            //         ),
            //       ),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Container(
            //               width: double.infinity,
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.only(
            //                   topLeft: Radius.circular(8),
            //                   topRight: Radius.circular(8),
            //                 ),
            //                 border: Border.all(
            //                   color: Colors.grey,
            //                   width: 1,
            //                 ),
            //               ),
            //               padding: EdgeInsets.symmetric(vertical: 8),
            //               child: Text(
            //                 "Gestion SM-QSE",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            //               ),
            //             ),
            //             if (isHoveredS)
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(vertical: 10),
            //                 child: Column(
            //                   children: [
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("S");
            //                         },
            //                         child: Text("Parties intéressées"),
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                     SizedBox(
            //                       width: 245, // Fixed width for buttons
            //                       child: ElevatedButton(
            //                         onPressed: () {
            //                           getAccess("S");
            //                         },
            //                         child: Text("Gestion des processus"),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),


            // Information widget
            if (_showInfo)
              Positioned(
                top: _infoPosition.dy,
                left: _infoPosition.dx,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _infoText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
