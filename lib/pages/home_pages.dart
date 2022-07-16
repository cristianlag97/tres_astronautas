import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tres_astronautras/global/matrixCount.dart';
import 'package:tres_astronautras/providers/form_matrix.dart';
import 'package:tres_astronautras/providers/theme_provider.dart';
import 'package:tres_astronautras/ui/colors.dart';
import 'package:tres_astronautras/ui/input_decoration.dart';
import 'package:tres_astronautras/widget/header.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              HeaderNasa(),
              SizedBox(height: 40),
              Home()
            ],
          ),
        ),
      )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final formState = Provider.of<FormMatrix>(context);

    return Container(
      child: formState.isGenerated
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _TableIsland(),
          const Text('Número de islas:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text('${formState.counterIslands}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          const SizedBox(height: 20),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: orange,
            child:Container(
              padding: const EdgeInsets.symmetric(horizontal:60,vertical:15),
              child: const Text(
                'Volver a intentar',
                style: TextStyle(color:Colors.white),
              )
            ),
            onPressed: (){
              formState.isGenerated = false;
            }
          )
        ],
      )
      : _Forms(),
    );
  }
}

class _Forms extends StatefulWidget {
  _Forms({Key? key}) : super(key: key);

  @override
  State<_Forms> createState() => _FormsState();
}

class _FormsState extends State<_Forms> {
  @override
  Widget build(BuildContext context) {

    final islandsProvider = Provider.of<FormMatrix>(context);
    final theme = Provider.of<ThemeProvider>(context).isDark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 200,
      decoration: _boxDecoration(theme),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Form(
                  key: islandsProvider.formKey,
                  child: TextFormField(
                    showCursor: true,
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.matrixInputDecoration(//* Styles *//
                        hintText: '',
                        labelText: 'Ingresa un valor',
                      prefixIcon: Icons.numbers_outlined
                    ),
                    cursorColor: Colors.grey.shade500,
                    controller: islandsProvider.rowController,
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                  ),
                ),
              ],
            )
          ),
          const SizedBox(height: 15.0),
          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,/*  */
            elevation: 0,
            color: orange,
            child:Container(
              padding: const EdgeInsets.symmetric(horizontal:60,vertical:15),
              child: const Text(
                'Ingresar',
                style: TextStyle(color:Colors.white),
              )
            ),
            onPressed: (){
              FocusScope.of(context).unfocus();
              islandsProvider.columnController.text = islandsProvider.rowController.text;
              MatrixCount.validateInputs(islandsProvider, context);
            }
          )
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration(theme) => BoxDecoration(
    color: theme ? darkMode : lightgrey,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: theme ? lightDark.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(5, 2),
      ),
    ],
  );
}

class _TableIsland extends StatefulWidget {
  const _TableIsland({Key? key}) : super(key: key);


  @override
  State<_TableIsland> createState() => _TableIslandState();
}

class _TableIslandState extends State<_TableIsland> {
  @override
  Widget build(BuildContext context) {
    final islandsProvider = Provider.of<FormMatrix>(context);
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Table(
            border: TableBorder.symmetric(inside: const BorderSide(width: 1, color: Colors.black87), outside: const BorderSide(width: 1, color: Colors.black87)),
            children: islandsProvider.gridSecond.entries.map((filaGrid) {
              int fila = filaGrid.key;
              Map<int, int> segundoGrid = filaGrid.value.asMap();
              return TableRow(
                children: segundoGrid.entries.map((celdaGrid) {
                  int celda = celdaGrid.key;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        islandsProvider.grid[fila][celda] = celdaGrid.value == 1 ? 0 : 1;
                        MatrixCount.generateToMatrix(islandsProvider);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: celdaGrid.value == 1 ? lightGreen :  lightBlue
                      ),
                      alignment: Alignment.center,
                      height: 40,
                      child: Text('${celdaGrid.value}' ,style: const TextStyle(color: Colors.black))
                    )
                  );
                }).toList()
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}