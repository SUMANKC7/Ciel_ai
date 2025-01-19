import 'package:ciel_ai/bloc/bloc_bloc.dart';
import 'package:ciel_ai/img_generate_bloc/img_generator_bloc_bloc.dart';
import 'package:ciel_ai/model/chat_message_model.dart';
import 'package:ciel_ai/pages/image_generate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlocBloc chatbloc = BlocBloc();
  TextEditingController userInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xFF040E28),
      body: BlocConsumer<BlocBloc, BlocState>(
        bloc: chatbloc,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ImgGeneratorLoadingState:
              return  Center(child: Image.asset("assets/loading.jpg"));
            case SuccessState:
              List<ChatMessageModel> messages =
                  (state as SuccessState).bothmessages;
              return Container(
                width: 375.w,
                height: 812.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/flower.jpg"),
                      fit: BoxFit.cover,
                      opacity: 1),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            'Ciel',
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF42A5F5).withOpacity(0.8),
                                Color(0xFF7BDCF9), // Light Cyan
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            style: GoogleFonts.audiowide(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  letterSpacing: 2),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                        const  ImageGeneratePage()));
                            },
                            child: Container(
                              width: 55.w,
                              height: 55.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF7BDCF9), // Light Cyan
                                    Color(0xFF42A5F5), // Electric Blue
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF7BDCF9).withOpacity(0.6),
                                    blurRadius: 15,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.image_search,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFF77A9).withOpacity(0.8),
                                          Color(0xFF7BDCF9).withOpacity(0.7),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      shape: BoxShape.rectangle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF7BDCF9)
                                              .withOpacity(0.6),
                                          blurRadius: 15,
                                          offset: Offset(0, 5),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      messages[index].parts.first.text,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.02,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 17),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: userInputController,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.sizeOf(context).height * 0.02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 1),
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                filled: true),
                          )),
                          SizedBox(
                            width: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (userInputController.text.isNotEmpty) {
                                String text = userInputController.text;
                                userInputController.clear();
                                chatbloc.add(
                                    OnUserMessageSendEvent(userMessage: text));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF42A5F5), // Electric Blue
                                    Color(0xFF7BDCF9), // Light Cyan
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(80),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF42A5F5).withOpacity(0.6),
                                    blurRadius: 20,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return Center(
                child: SizedBox(
                  child: Text("Some error occurred"),
                ),
              );
          }
        },
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  GradientText(
    this.text, {
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
