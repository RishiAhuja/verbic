import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageView extends StatefulWidget {
  final String url;
  ImageView({this.url});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  int _progress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
      });
    });

    print(widget.url);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [IconButton(icon: Icon(Icons.download), onPressed: () async{

          try {
            // Saved with this method.
            Fluttertoast.showToast(
                msg: "Downloading..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            var imageId = await ImageDownloader.downloadImage("${widget.url}");
            if (imageId == null) {
              return;
            }

            // Below is a method of obtaining saved image information.
            var fileName = await ImageDownloader.findName(imageId);
            print(fileName);
            var path = await ImageDownloader.findPath(imageId);
            print(path);
            var size = await ImageDownloader.findByteSize(imageId);
            print(size);
            var mimeType = await ImageDownloader.findMimeType(imageId);
            print(mimeType);

            Fluttertoast.showToast(
                msg: "Image Downloaded Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );

          } on PlatformException catch (error) {
            print(error);
            Fluttertoast.showToast(
                msg: "Failed To Download Image",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey[900],
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

        },)],
      ),
      body: Column(
        children: [
          InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: "${widget.url}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(height: 25,),
          Text(
            'Drag with two fingers to zoom',
            style: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}
