// stores ExpansionPanel state information
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'dart:io';

import 'package:pdf_render/pdf_render.dart';

class ViewPecaAutosPage extends StatefulWidget {
  ViewPecaAutosPage(
      {Key key,
      this.peca,
      this.titulo,
      this.pagina,
      this.data,
      this.autoriaNome})
      : super(key: key);

  File peca;
  String titulo;
  String data;
  String autoriaNome;
  int pagina;

  @override
  ViewPecaAutosPageState createState() => ViewPecaAutosPageState();
}

class ViewPecaAutosPageState extends State<ViewPecaAutosPage> {
  String pathPDF = "";
  PdfPageImage pageImage;
  static const scale = 100.0 / 72.0;
  static const margin = 4.0;
  static const padding = 1.0;
  static const wmargin = (margin + padding) * 2;
  static final controller = ScrollController();
  PDFPage pageOne;
  PDFDocument doc;

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  @override
  initState() {
    super.initState();
  
    loadDocument();
  }

  loadDocument() async {
    doc = await PDFDocument.fromFile(widget.peca);

    setState(() { 
      print(doc != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    var appBar = PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          centerTitle: true,
          title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.titulo,
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                Text(
                  widget.autoriaNome,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                /* Text(
                    widget.data,
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                ), */
              ]),
        ));

    return Scaffold(
      body: Center(
            child: doc == null
                ? Center(child: CircularProgressIndicator())
                : PDFViewer2(document: doc, pageFirst: widget.pagina)),
      appBar: appBar
    );
  }
}
