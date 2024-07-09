import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_image_demo/widgets/chat_picture_preview.dart';

void main() {
  runApp(const GetMaterialApp(
    home: Home(),
  ));
}

class Controller extends GetxController {
  List<String> pictureUrls = [
    'https://img.zcool.cn/community/010d5c5b9d17c9a8012099c8781b7e.jpg@1280w_1l_2o_100sh.jpg',
    'https://boot-img.xuexi.cn/image/1006/process/b5e3a02d382649ff8565323f48320b36.jpg',
    'https://ts1.cn.mm.bing.net/th/id/R-C.d2b3a4779fd2b9af70103d485bc8b664?rik=Xm7zutXMpsp91Q&riu=http%3a%2f%2fup.deskcity.org%2fpic_source%2fd2%2fb3%2fa4%2fd2b3a4779fd2b9af70103d485bc8b664.jpg&ehk=%2fh%2fipXq8Ihn81SbQdkphnzweLFLUGfD1%2fXncDcbLgRE%3d&risl=&pid=ImgRaw&r=0',
    'https://img.zcool.cn/community/011f205c1df754a8012029ac2b3998.jpg@3000w_1l_0o_100sh.jpg',
    'https://tse4-mm.cn.bing.net/th/id/OIP-C.ISBPvQsr4cj54OhIP0dPpwHaLG?w=115&h=180&c=7&r=0&o=5&pid=1.7',
    'https://img.zcool.cn/community/0104d155fdc4416ac7251df855d682.jpg@3000w_1l_0o_100sh.jpg',
    'https://img.cgmol.com/excellentwork/20150729/191501_20150729103856ql7wk9qchh2lijy.jpg',
    'https://bpic.588ku.com/back_pic/06/11/77/75621df811753bb.jpg',
    'https://scpic.chinaz.net/files/pic/pic9/202009/apic27883.jpg',
    'https://img.tukuppt.com/ad_preview/00/18/86/5c99f1b30e47d.jpg!/fw/780',
    'https://img.zcool.cn/community/0104d155fdc4416ac7251df855d682.jpg@1280w_1l_2o_100sh.jpg',
    'https://ts1.cn.mm.bing.net/th/id/R-C.0bd5ff90452c9181a68df772e16cca47?rik=FbE%2bGrVs0MiStg&riu=http%3a%2f%2fpic.bizhi360.com%2fbbpic%2f43%2f10143.jpg&ehk=QmTn7S8Mfd4QeGCNl0mfbU%2bnxGEAMNe5YQeg4kKBIrE%3d&risl=&pid=ImgRaw&r=0',
    'https://pic.616pic.com/bg_w1180/00/00/81/zi58oHApHm.jpg!/fw/880',
    'https://img-baofun.zhhainiao.com/pcwallpaper_ugc_mobile/preview_jpg/81cfd45f881b9ef4721d552e5a78d196.jpg',
    'https://bpic.588ku.com/back_pic/06/09/78/78616e9763b39e4.jpg'
  ];

  //Preview the images
  void previewUrlPicture(
    List<String> urls, {
    int currentIndex = 0,
    String? heroTag,
    context,
  }) =>
      navigator
          ?.push(MaterialPageRoute(
        builder: (BuildContext context) => GestureDetector(
          onTap: () {
            Get.back();
          },
          child: ChatPicturePreview(
            currentIndex: currentIndex,
            images: urls,
            heroTag: heroTag,
            onLongPress: (pictureUrl) {
              //Do nothing
            },
          ),
        ),
      ))
          .then((value) {
        //Do nothing
      });
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('previews picture'))),
        body: Center(
          child: ElevatedButton(
            child: const Text("preview pictures"),
            onPressed: () {
              c.previewUrlPicture(c.pictureUrls);
            },
          ),
        ));
  }
}
