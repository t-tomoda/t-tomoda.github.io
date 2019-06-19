//　放物運動（Buttonクラス）                                T. Tomoda, 2019/6/18

class Button {
  int nb;                //ボタン番号
  String str = "";       //ボタンの名前
  float xb;              //ボタン左端x座標
  float theta;           //投げる方向（水平面となす角度、単位：ラジアン）

  Button(int nb0, String str0) { //コンストラクタ
    nb = nb0;            //ボタン番号を設定
    str = str0;          //ボタンの名前を設定
    xb = wb * nb;        //ボタン左端x座標 = ボタンの幅 * ボタン番号
    fill(255);           //白色
    rect(xb, 0, wb, hb); //(xb, 0)を左上の頂点とする幅wb、高さhbの白い長方形を描画
    fill(0);             //黒色
    text(str, xb + 10, hb / 2 + 8); //長方形の中にボタンの名前を黒で表示
  }

  void mousePressed() {
    //マウスクリックした位置がボタン領域内かどうかの判断
    if (xb < mouseX && mouseX < xb + wb && 0 < mouseY && mouseY < hb) {
      switch(nb) { //ボタン番号（0～5）によって異なる処理をする
        case 0:
          theta = PI * 40 / 180; //40°
          c = color(0, 255, 0);  //緑
          break;

        case 1:
          theta = PI / 4;        //45°
          c = color(255, 0, 0);  //赤
          break;

        case 2:
          theta = PI * 50 / 180; //50°
          c = color(0, 0, 255);  //青
          break;

        case 3:
          theta = PI / 2;        //90°
          c = color(0);          //黒
          break;

        case 4: //空気抵抗有無の切り替え
          resistance = 1 - resistance; //0なら1に、1なら0に
          fill(255);                                   //白色
          rect(xb, 0, wb, hb);                         //ボタン領域を白く塗りつぶす
          fill(0);                                     //黒色
          text(str4[resistance], xb + 10, hb / 2 + 8); //"抵抗なし"または"抵抗あり"と表示
          break;

        case 5: //Reset
          fill(204); //明灰色
          rect(0, hb, width, height - hb); //ボールの運動領域を明灰色に塗りつぶす
          //マス目の横線と縦線を描き直す
          line(0,        height - unit,     width,    height - unit);
          line(0,        height - unit * 2, width,    height - unit * 2);
          line(unit,     hb,                unit,     height);
          line(unit * 2, hb,                unit * 2, height);
          line(unit * 3, hb,                unit * 3, height);
          line(unit * 4, hb,                unit * 4, height);

          resistance = 0; //空気抵抗なし
          break;

        default:
          break;
      }

      if (0 <= nb && nb <= 3) { //ボタン番号が0～3の場合
        x = 0;                          //初期位置（ウィンドウ左端）
        y = height;                     //初期位置（ウィンドウ下端）
        delta_r = 2.5;                  //"初速度"の大きさ
        delta_x = delta_r * cos(theta); //x方向の"初速度"
        delta_y = delta_r * sin(theta); //y方向の"初速度"
        fill(c);                        //ボールの色
      }
    }
  }
}