// ignore_for_file: library_private_types_in_public_api

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:student_corner/componant/audio_widget.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/modal/material_modal_new.dart';

int _activeExpansitionIndex = 0;

class AudioPlayerScreen extends StatefulWidget {
  final String mainId;
  final String subId;
  const AudioPlayerScreen({Key? key, required this.mainId, required this.subId})
      : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late Future<List<MaterialModelNew>> materialModal;

  @override
  void initState() {
    super.initState();
    materialModal = materialModalNew(widget.mainId, widget.subId);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/png/material_back.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: SecondaryAppbar(
                title: 'Audio',
                color: Colors.white,
                homeIndex: 0,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: materialModal,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    List<MaterialModelNew> modal = snapshot.data;
                    if (modal[0].status == 200) {
                      return SingleChildScrollView(
                        child: Column(
                          children: component(modal, context, size),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  } else {
                    return const CircularProgressIndicator.adaptive();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> component(
    List<MaterialModelNew> modal, BuildContext context, Size size) {
  List<Widget> element = [];
  for (var i = 0; i < modal[0].data.length; i++) {
    final PageManager pageManager = PageManager(modal[0].data[i].url);
    element.add(AudioTile(
      i: i,
      pageManager: pageManager,
      modal: modal,
    ));
  }
  return element;
}

class AudioTile extends StatefulWidget {
  const AudioTile({
    Key? key,
    required this.i,
    required PageManager pageManager,
    required this.modal,
  })  : _pageManager = pageManager,
        super(key: key);

  final int i;
  final PageManager _pageManager;
  final List<MaterialModelNew> modal;

  @override
  State<AudioTile> createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          _activeExpansitionIndex =
              (_activeExpansitionIndex == widget.i ? null : widget.i)!;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: _activeExpansitionIndex == widget.i,
          headerBuilder: (context, isExpanded) => TextFieldCus(
              text: widget.modal[0].data[widget.i].title,
              color: Colors.black,
              fontSize: 18.0,
              width: 0.7,
              textAlign: TextAlign.start,
              fontFamily: 'Hanuman-bold'),
          body: ListTile(
            title: Column(
              children: [
                ValueListenableBuilder<ProgressBarState>(
                  valueListenable: widget._pageManager.progressNotifier,
                  builder: (_, value, __) {
                    return ProgressBar(
                      progress: value.current,
                      buffered: value.buffered,
                      total: value.total,
                      onSeek: widget._pageManager.seek,
                    );
                  },
                ),
                ValueListenableBuilder<ButtonState>(
                  valueListenable: widget._pageManager.buttonNotifier,
                  builder: (_, value, __) {
                    switch (value) {
                      case ButtonState.loading:
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 32.0,
                          height: 32.0,
                          child: const CircularProgressIndicator(),
                        );
                      case ButtonState.paused:
                        return IconButton(
                          icon: const Icon(Icons.play_arrow),
                          iconSize: 32.0,
                          onPressed: widget._pageManager.play,
                        );
                      case ButtonState.playing:
                        return IconButton(
                          icon: const Icon(Icons.pause),
                          iconSize: 32.0,
                          onPressed: widget._pageManager.pause,
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
