//　花火（Ballクラス）                                       T. Tomoda, 2019/7/5

class Ball {
  float x, y;                      //小玉の位置
  float delta_x, delta_y, delta_r; //小玉の速度と速さ
  float d = 0;                     //小玉の直径
  float res_factor = 0.01;         //空気抵抗の大きさを表す係数
  int count_draw = 0;              //Ballクラスのdraw()が呼ばれる回数のカウント

  Ball() { //コンストラクタ
    x = width/2;  //小玉の初期位置（横方向）：ウィンドウの中央
    y = height/4; //小玉の初期位置（縦方向）：ウィンドウの上端から1/4
  }

  //小玉を描画
  void draw() {
    delta_y -= 0.01; //重力加速度によるy方向の速度変化

    //速度の２乗に比例する空気抵抗による減速
    delta_r = sqrt(delta_x*delta_x + delta_y*delta_y);
    delta_x -= delta_x * delta_r * res_factor; //x方向の減速
    delta_y -= delta_y * delta_r * res_factor; //y方向の減速

    x += delta_x;          //xの変化
    y -= delta_y;          //yの変化
    if (count_draw < 60) { //大玉爆発後の1秒間
      d += 0.02;             //小玉の直径を増やす
    } else {               //大玉爆発1秒後以降
      d -= 0.003;            //小玉の直径を減らす
      if (d < 0) {           //マイナスになったら
        d = 0;               //0に設定
      }
    }

    ellipse(x, y, d, d);   //(x, y)を中心とする直径dの円を描画
    count_draw++;          //小玉のdraw()のカウントを1だけ増やす
  }
}