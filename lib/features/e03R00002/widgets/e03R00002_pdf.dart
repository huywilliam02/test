
import 'package:account/core/constants/app_color.dart';
import 'package:account/core/utils/color_resources.dart';
import 'package:account/core/utils/icons.dart';
import 'package:account/core/utils/spaces.dart';
import 'package:account/core/widgets/button/common_button.dart';
import 'package:account/core/widgets/input/common_dropdown.dart';
import 'package:account/core/widgets/input/text_field_input.dart';
import 'package:account/core/widgets/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdfx/pdfx.dart';

class E03R00002Pdf extends StatefulWidget {
  const E03R00002Pdf({super.key});

  @override
  State<E03R00002Pdf> createState() => _E03R00002PdfState();
}

class _E03R00002PdfState extends State<E03R00002Pdf> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 8,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColor.c_F8FAFC,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              spaceH10,
              _buildButtonSave(),
              spaceH10,
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColor.c_F8FAFC,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.network("assets/icons/pdf.svg"),
                      Text(
                        "Kéo thả hoặc bấm vào đây để tải tập tin lên",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              spaceH20,
              Row(
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  const TextFieldInput(
                    title: "Tên file",
                    textAlignEndTitle: true,
                    isEnabled: false,
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 320,
                    child: CommonDropdown(
                      items: [
                       
                      ],
                      title: 'Loại hồ sơ',
                    ),
                  ),
                ],
              ),
              spaceH10,
              Row(
                children: [
                  const SizedBox(
                    width: 18,
                  ),
                  SizedBox(
                    width: 302,
                    child: TextFieldInput(
                      title: "Ngày",
                      textAlignEndTitle: true,
                      isEnabled: false,
                      suffixAssetUrl: IconsApp.calendar,
                      isShowSuffixIcon: true,
                      onChanged: (p0) {},
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CommonDropdown(
                      items: [
                        
                       
                      ],
                      title: 'Người ký ',
                    ),
                  ),
                ],
              ),
              spaceH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      ),
                      Text("Chứng từ scan",
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(
                    width: 442,
                    child: const TextFieldInput(
                      title: "Ghi chú",
                      textAlignEndTitle: true,
                      isEnabled: false,
                    ),
                  ),
                ],
              ),
              spaceH10,
              _buildButtonUpload(),
              spaceH10,
              Expanded(
                child: PDFViewer(
                    url:
                        'https://www.aeee.in/wp-content/uploads/2020/08/Sample-pdf.pdf'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildButtonSave() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 128,
          child: CommonButton(
            backgroundColor: ColorResources.buttonSave,
            buttonIcon: IconsApp.edit,
            textName: "Lưu và ký gửi",
          ),
        ),
      ],
    );
  }

  Row _buildButtonUpload() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 80,
          child: CommonButton(
            backgroundColor: ColorResources.buttonSave,
            buttonIcon: IconsApp.upload,
            textName: "Tải lên",
          ),
        ),
      ],
    );
  }
}
