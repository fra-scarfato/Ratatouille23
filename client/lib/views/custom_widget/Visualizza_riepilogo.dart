import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratatouille23/controllers/Ordinazione_controller.dart';
import 'package:ratatouille23/models/Elemento_ordinato.dart';
import 'package:ratatouille23/views/custom_widget/barra_superiore.dart';
import 'package:ratatouille23/views/pagina_inizialeUI.dart';

import '../../models/Utente.dart';
import 'Finestra_attesa.dart';
import 'Finestra_conferma.dart';
import 'Finestra_errore.dart';

class Visualizza_riepilogo extends StatefulWidget{
  final int tavolo;
  final List<Elemento_ordinato> elementi_ordinati;
  final Utente utente;
  final Ordinazione_controller ordinazione_controller;

  Visualizza_riepilogo({required this.tavolo, required this.elementi_ordinati, required this.utente, required this.ordinazione_controller});
  @override
  Visualizza_riepilogo_ui createState() => Visualizza_riepilogo_ui();
}

class Visualizza_riepilogo_ui extends State<Visualizza_riepilogo>{
  TextEditingController noteController= TextEditingController();
  String note='';


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bubble.png"),
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const barra_superiore(text: 'Lista ordinazioni'),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 195,
                  child: ordine_card(widget.elementi_ordinati),
                ),
              ],
            )
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              var attesa = Finestra_attesa(context);
              FToast toast = FToast();
              toast.init(context);
              try{
                attesa.showDialogue();
                await widget.ordinazione_controller.registra_nuova_ordinazione(widget.tavolo, note, widget.elementi_ordinati, widget.utente);
                attesa.hideProgressDialogue();
                toast.showToast(
                    child: const Finestra_conferma(message: "Ordinazione effettuata correttamente"),
                    toastDuration: const Duration(seconds: 2),
                    gravity: ToastGravity.BOTTOM);
                    Navigator.of(context).popUntil(ModalRoute.withName("/ordinazioni"));
              }catch (error){
                attesa.hideProgressDialogue();
                toast.showToast(
                    child: const Finestra_errore(message: "Ordinazione non riuscita!"),
                    toastDuration: const Duration(seconds: 2),
                    gravity: ToastGravity.BOTTOM);
                }
              },
            label: const Text('CONFERMA ORDINE', style: TextStyle(color: Colors.white, fontSize: 24,),),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  SingleChildScrollView ordine_card(List<Elemento_ordinato> elementi_ordinati){
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
            color: Colors.white,
            elevation: 24.0,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(33.0))),
            child:Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tavolo n.',
                          style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                        ),
                        Text(
                          '${widget.tavolo}',
                          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.mode_edit_outlined,
                              size: 50,
                            )
                        ),
                        const SizedBox(width:16),
                        IconButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => pagina_inizialeUI(widget.utente)));
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 50,
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height:16),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: lista_elementi(widget.elementi_ordinati),
                    ),
                    TextFormField(
                      controller: noteController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 5.0
                            ),
                            borderRadius: BorderRadius.circular(50),

                          ),
                          hintText: 'Aggiungi note...',
                          hintStyle: const TextStyle(color: Colors.grey)
                      ),
                      onChanged: (text){
                        setState(() {
                          note=text;
                        });
                      },
                    ),
                  ],
                )
            )

        ),
      );
  }

  List<Widget> lista_elementi(List<Elemento_ordinato> elementi_ordinati) {
    double costo = _calcola_totale(elementi_ordinati);
    List<Widget> list=[];
    for(int i=0 ;i< elementi_ordinati.length; i++){
      if (i!=elementi_ordinati.length-1) {
        // print(elementi_ordinati[i].get_elemento().nome);
        list.add(buildRiga(elementi_ordinati[i].get_elemento().nome, elementi_ordinati[i].get_quantita() ,(elementi_ordinati[i].get_elemento().costo * elementi_ordinati[i].get_quantita())));
        list.add(const Divider(color: Colors.orange,));
      }
      else{
        list.add(buildRiga(elementi_ordinati[i].get_elemento().nome, elementi_ordinati[i].get_quantita() ,elementi_ordinati[i].get_elemento().costo));
        list.add(const Divider(color: Colors.orange,));
        list.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Totale:',
                      style: GoogleFonts.roboto(color: Colors.orange, fontSize: 36, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '$costo€',
                      style: GoogleFonts.roboto(fontSize: 40, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
        );
      }
    }
    return list;
  }

  Widget buildRiga(String get_nome_elemento, int get_quantita, double get_costo_elemento) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          get_nome_elemento,
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
        ),
        //SizedBox(width:100),
        Center(
          child: Text(
            '$get_quantita',
            style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic),
          ),
        ),
        //SizedBox(width:100),
        Text(
          '$get_costo_elemento€',
          style: GoogleFonts.roboto(fontSize: 36, fontStyle: FontStyle.italic, ),
        ),
        const SizedBox(width: 30),

      ],
    );
  }

  double _calcola_totale(List<Elemento_ordinato> elementi){
    double totale=0;
    for(int i=0;i<elementi.length;i++){
      totale=totale+(elementi[i].get_elemento().costo * elementi[i].get_quantita());
    }
    return double.parse(totale.toStringAsFixed(2));
  }
  //
  //
}