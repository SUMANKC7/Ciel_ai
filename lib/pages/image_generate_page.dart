import 'package:ciel_ai/img_generate_bloc/img_generator_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageGeneratePage extends StatefulWidget {
  const ImageGeneratePage({super.key});

  @override
  State<ImageGeneratePage> createState() => _ImageGeneratePageState();
}

class _ImageGeneratePageState extends State<ImageGeneratePage> {
  final TextEditingController textEditingController = TextEditingController();
  final ImgGeneratorBlocBloc imgGeneratorBlocBloc = ImgGeneratorBlocBloc();

  @override
  void initState() {
    super.initState();
    imgGeneratorBlocBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF040E28),
      body: BlocConsumer<ImgGeneratorBlocBloc, ImgGeneratorBlocState>(
        bloc: imgGeneratorBlocBloc,
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          switch (state.runtimeType) {
            case (ImgGeneratorLoadingState):
              return  Center(child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/loading.gif",height: MediaQuery.sizeOf(context).height*0.5,width: double.maxFinite,),
                    Text("Generating Image", style: TextStyle(color: Colors.white,fontSize: 30),)
                  ],
                ),
              )
                
                
              
              );
            case (ImgGeneratorFailedState):
              return Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(color: Colors.white),
                ),
              );
            case ImgGeneratorSuccessState:
              final successState = state as ImgGeneratorSuccessState;
              return Container(
                child: Column(
                  
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.16,
                          ),
                          Text("Generate Image",
                              style: GoogleFonts.greatVibes(
                                  textStyle: TextStyle(
                                      fontSize:
                                          MediaQuery.sizeOf(context).height *
                                              0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      letterSpacing: 1))),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: 28, right: 28, top: 25, bottom: 25),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(successState.uint8list))),
                      ),
                    )),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            TextField(
                              style: TextStyle(color: Colors.white),
                              controller: textEditingController,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white60,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white60,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  hintText: "Enter your prompt",
                                  hintStyle: TextStyle(color: Colors.white60)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (textEditingController.text.isNotEmpty) {
                                    imgGeneratorBlocBloc.add(
                                        OnGenerateButtonClickedEvent(
                                            prompt:
                                                textEditingController.text));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    backgroundColor: Color(0xFFDFCF3D),
                                    side: BorderSide(color: Color(0xffDFCF3D))),
                                icon: Icon(
                                  Icons.generating_tokens,
                                  color: Color(0xff4E4E4E),
                                ),
                                label: Text(
                                  'Generate',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xff4E4E4E),
                                    // color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
