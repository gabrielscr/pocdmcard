import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_dmcard_web/main-controller.dart';
import 'package:poc_dmcard_web/widget/text-widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() {
  runApp(DMApp());
}

class DMRoutes {
  static final String home = '/home';
  static final String form = '/form';
}

class DMPages {
  static final pages = [
    GetPage(
      name: DMRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: DMRoutes.form,
      page: () => FormPage(),
    ),
  ];
}

class DMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POC DMCard Web',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      getPages: DMPages.pages,
      initialRoute: DMRoutes.home,
    );
  }
}

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> menuKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Scaffold(
          key: menuKey,
          appBar: AppBar(
              title: TextWidget(text: 'POC DMCard Web'),
              elevation: 0.2,
              leading: sizingInfo.deviceScreenType == DeviceScreenType.mobile ||
                      sizingInfo.deviceScreenType == DeviceScreenType.tablet
                  ? IconButton(
                      onPressed: () => menuKey.currentState?.openDrawer(),
                      icon: Icon(Icons.short_text_rounded))
                  : SizedBox.shrink()),
          drawer: Drawer(
            child: renderMenu(),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(DMRoutes.form);
              }),
          body: Container(
            child: Row(
              children: [
                sizingInfo.deviceScreenType == DeviceScreenType.mobile ||
                        sizingInfo.deviceScreenType == DeviceScreenType.tablet
                    ? SizedBox.shrink()
                    : renderMenu(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey[100],
                        padding: EdgeInsets.all(20),
                        width: Get.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Olá, usuário.',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                  TextWidget(
                                    text: 'Esta é uma prova de conceito',
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                  ),
                                  renderCards(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.separated(
                                separatorBuilder: (context, index) => Divider(),
                                itemCount: 100,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: ListTile(
                                      title: TextWidget(
                                        text: 'Título $index',
                                      ),
                                      subtitle: TextWidget(
                                        text: 'Subtitulo $index',
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }

  renderMenu() {
    return Container(
      width: 250,
      color: Colors.grey[200],
      child: Column(
        children: [
          SizedBox(height: Get.height * 0.05),
          TextWidget(
            text: 'Menu',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: Get.height * 0.05),
          renderMenuItem(title: 'Menu 1', subtitle: 'Description 1'),
          renderMenuItem(title: 'Menu 2', subtitle: 'Description 2'),
          renderMenuItem(title: 'Menu 3', subtitle: 'Description 3'),
          renderMenuItem(title: 'Menu 4', subtitle: 'Description 4'),
          renderMenuItem(title: 'Menu 5', subtitle: 'Description 5'),
          renderMenuItem(title: 'Menu 6', subtitle: 'Description 6'),
        ],
      ),
    );
  }

  renderMenuItem({String? title, String? subtitle}) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: TextWidget(text: title!),
          subtitle: TextWidget(text: subtitle!),
          trailing: Icon(Icons.arrow_right_rounded),
        ),
        Divider()
      ],
    );
  }

  renderCards() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: Get.width * 0.35,
                height: 100,
                child: Center(
                    child: TextWidget(text: 'Olha só como eu sou responsivo')),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: Get.width * 0.35,
                height: 100,
                child: Center(
                    child: TextWidget(text: 'Olha só como eu sou responsivo')),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: Get.width * 0.35,
                height: 100,
                child: Center(
                    child: TextWidget(text: 'Olha só como eu sou responsivo')),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                width: Get.width * 0.35,
                height: 100,
                child: Center(
                    child: TextWidget(text: 'Olha só como eu sou responsivo')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FormPage extends StatelessWidget {
  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInfo) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextWidget(text: 'Formulário de teste'),
        ),
        body: Container(
          child: ListView(
            children: [renderFormMobile(sizingInfo), renderFormWeb(sizingInfo)],
          ),
        ),
      );
    });
  }

  renderFormMobile(SizingInformation sizingInfo) {
    if (sizingInfo.deviceScreenType == DeviceScreenType.mobile)
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextWidget(text: 'Essa é a versão mobile'),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Form 1'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Form 2'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    TextWidget(text: 'Esse é um Toggle 1'),
                    Obx(() => Switch(
                        value: controller.toggle1.value,
                        onChanged: (v) {
                          controller.toggle1.value = v;
                        })),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextWidget(text: 'Esse é um Toggle 2'),
                    Obx(() => Switch(
                        value: controller.toggle2.value,
                        onChanged: (v) {
                          controller.toggle2.value = v;
                        })),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    TextWidget(text: 'Esse é um Checkbox 1'),
                    Obx(() => Checkbox(
                        value: controller.checkbox1.value,
                        onChanged: (v) {
                          controller.checkbox1.value =
                              !controller.checkbox1.value;
                        })),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextWidget(text: 'Esse é um Checkbox 2'),
                    Obx(() => Checkbox(
                        value: controller.checkbox2.value,
                        onChanged: (v) {
                          controller.checkbox2.value =
                              !controller.checkbox2.value;
                        })),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Column(
                  children: [
                    TextWidget(text: 'Esse é um Select 1'),
                    DropdownButtonFormField(
                        value: 0,
                        onChanged: (v) => print(v),
                        items: List.generate(4, (index) {
                          return DropdownMenuItem<int>(
                              value: index,
                              child: TextWidget(text: 'Item $index'));
                        }))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextWidget(text: 'Esse é um Select 2'),
                    DropdownButtonFormField(
                        value: 0,
                        onChanged: (v) => print(v),
                        items: List.generate(4, (index) {
                          return DropdownMenuItem<int>(
                              value: index,
                              child: TextWidget(text: 'Item $index'));
                        }))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Column(
                  children: [
                    TextWidget(text: 'Esse é um Slider 1'),
                    Obx(() => Slider(
                        min: 10,
                        max: 100,
                        value: controller.slider1.value,
                        onChanged: (value) {
                          controller.slider1.value = value;
                        }))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    TextWidget(text: 'Esse é um Slider 2'),
                    Obx(() => Slider(
                        min: 10,
                        max: 100,
                        value: controller.slider2.value,
                        onChanged: (value) {
                          controller.slider2.value = value;
                        }))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      labelText: 'Form grande 1'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      labelText: 'Form grande 2'),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 50,
                  child: TextButton(
                      onPressed: () {},
                      child: TextWidget(text: 'Botão de texto')),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: TextWidget(text: 'Botão com borda'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  width: Get.width,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: TextWidget(text: 'Botão com elevação')),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width,
                  height: 50,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.phone_android),
                  ),
                )
              ],
            )
          ],
        ),
      );
    else
      return SizedBox.shrink();
  }

  renderFormWeb(SizingInformation sizingInfo) {
    if (sizingInfo.deviceScreenType == DeviceScreenType.desktop ||
        sizingInfo.deviceScreenType == DeviceScreenType.tablet)
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextWidget(text: 'Essa é a versão web e tablet'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Form 1'),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Form 2'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    TextWidget(text: 'Esse é um Toggle 1'),
                    Obx(() => Switch(
                        value: controller.toggle1.value,
                        onChanged: (v) {
                          controller.toggle1.value = v;
                        })),
                  ],
                )),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Row(
                  children: [
                    TextWidget(text: 'Esse é um Toggle 2'),
                    Obx(() => Switch(
                        value: controller.toggle2.value,
                        onChanged: (v) {
                          controller.toggle2.value = v;
                        })),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    TextWidget(text: 'Esse é um Checkbox 1'),
                    Obx(() => Checkbox(
                        value: controller.checkbox1.value,
                        onChanged: (v) {
                          controller.checkbox1.value =
                              !controller.checkbox1.value;
                        })),
                  ],
                )),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Row(
                  children: [
                    TextWidget(text: 'Esse é um Checkbox 2'),
                    Obx(() => Checkbox(
                        value: controller.checkbox2.value,
                        onChanged: (v) {
                          controller.checkbox2.value =
                              !controller.checkbox2.value;
                        })),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    TextWidget(text: 'Esse é um Select 1'),
                    DropdownButtonFormField(
                        value: 0,
                        onChanged: (v) => print(v),
                        items: List.generate(4, (index) {
                          return DropdownMenuItem<int>(
                              value: index,
                              child: TextWidget(text: 'Item $index'));
                        }))
                  ],
                )),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Column(
                  children: [
                    TextWidget(text: 'Esse é um Select 2'),
                    DropdownButtonFormField(
                        value: 0,
                        onChanged: (v) => print(v),
                        items: List.generate(4, (index) {
                          return DropdownMenuItem<int>(
                              value: index,
                              child: TextWidget(text: 'Item $index'));
                        }))
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    TextWidget(text: 'Esse é um Slider 1'),
                    Obx(() => Slider(
                        min: 10,
                        max: 100,
                        value: controller.slider1.value,
                        onChanged: (value) {
                          controller.slider1.value = value;
                        }))
                  ],
                )),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                    child: Column(
                  children: [
                    TextWidget(text: 'Esse é um Slider 2'),
                    Obx(() => Slider(
                        min: 10,
                        max: 100,
                        value: controller.slider2.value,
                        onChanged: (value) {
                          controller.slider2.value = value;
                        }))
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        labelText: 'Form grande 1'),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        labelText: 'Form grande 2'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: TextButton(
                        onPressed: () {},
                        child: TextWidget(text: 'Botão de texto')),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: TextWidget(text: 'Botão com borda'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: TextWidget(text: 'Botão com elevação')),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.phone_android),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    else
      return SizedBox.shrink();
  }
}
