
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  List<String> projectImages = [
    'crm.png',
    'thu_ngan.png',
    'bhyt.png',
    'clinic.png',
    'his.png',
    'kham_suc_khoe.png',
    'quan_ly_pttt.png',
    'lab.png',
    'cdha_tdcn.png',
    'pacs.png',
    'quyet_dinh_hop_dong.png',
    'he_thong_kho.png',
    'nha_thuoc.png',
    'nhan_su_tien_luong.png',
    'tai_chinh_ke_toan.png',
    'hoa_don.png',
    'ngan_sach.png',
    'cong_thanh_toan.png',
    'bao_cao.png',
    'emr.png',
    'ky_so.png',
    'quan_ly_chat_luong.png',
    'du_lieu_dung_chung.png',
    'quan_tri.png',
    'kho_du_lieu_lam_san.png',
  ];

  List<String> quickAccess = [
    'qua_trinh_dieu_tri.png',
    'danh_sach_nguoi_benh_noi_tru.png',
    'danh_sach_nguoi_benh_ngoai_tru.png',
    'ho_so_dieu_duong.png',
    'ho_so_bac_si.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Chào buổi sáng, BS. Trần Thanh Sơn',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50, top: 20),
            width: MediaQuery.of(context).size.width * 0.85,
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              crossAxisCount: 11,
              children: List.generate(
                25,
                (index) => GestureDetector(
                    onTap: () {
                      if (projectImages[index] == 'du_lieu_dung_chung.png')
                        Navigator.of(context).pushNamed(
                            '/shared_data/medical_record_template_management_screen');
                    },
                    child:
                        Image.asset('assets/images/${projectImages[index]}')),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, top: 50),
              child: Text(
                'Truy cập nhanh',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w800,
                  color: AppColors.textBlack,
                ),
              )),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            width: MediaQuery.of(context).size.width * 0.7,
            child: GridView.count(
              // mainAxisSpacing: 30,
              crossAxisSpacing: 30,
              shrinkWrap: true,
              crossAxisCount: 5,
              children: List.generate(
                5,
                (index) => Image.asset('assets/images/${quickAccess[index]}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
