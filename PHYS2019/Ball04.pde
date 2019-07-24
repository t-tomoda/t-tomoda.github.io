//　Ballクラス（気体の拡散）                                T. Tomoda, 2019/7/24

class Ball {
  float x, y;           //ボールの位置
  float vx = 0, vy = 0; //ボールの速度、初期化
  float d = 10;         //ボールの直径
  float r = d / 2;      //ボールの半径

  //ボールの位置と速度を設定する関数
  void set(float x0, float y0, float vx0, float vy0) {
    x = x0;
    y = y0;
    vx = vx0;
    vy = vy0;
  }
    
  //ボールを描画
  void draw() {
    //左右のウィンドウ境界で反射
    if (vx < 0 && x < r) {
      vx = -vx;
    }
    if (vx > 0 && width - r < x) {
      vx = -vx;
    }

    //中央の仕切りで反射（右向き→左向き）
    if (vx > 0 && length - r < x && x < length
        && (y < half_length - 20 || y > half_length + 20)) {
      vx = -vx;
    }

    //中央の仕切りで反射（左向き→右向き）
    if (vx < 0 && length < x && x < length + r
        && (y < half_length - 20 || y > half_length + 20)) {
      vx = -vx;
    }

    //上下のウィンドウ境界で反射
    if (vy < 0 && y < r) {
      vy = -vy;
    }
    if (vy > 0 && length - r < y) {
      vy = -vy;
    }

    x += vx; //速度に応じたxの変化
    y += vy; //速度に応じたyの変化

    fill(255, 0, 0);     //赤色
    noStroke();          //輪郭線無し
    ellipse(x, y, d, d); //(x, y)を中心とする直径dの円
  }

  //ボールの衝突(主に速度変化)の計算
  void collision(Ball b) {
    float dis = distance(this, b); //自ボールとボールbの中心間の距離
    float ex, ey, new_vx, new_vy, new_bvx, new_bvy;

    if (dis < d) { //ボールの中心間の距離が直径より小さかったら
      ex = (x - b.x) / dis; //ボールbから自ボールへ向かう単位ベクトルのx成分
      ey = (y - b.y) / dis; //ボールbから自ボールへ向かう単位ベクトルのy成分

      //弾性衝突(運動量保存、運動エネルギー保存)、かつ中心間を結ぶ方向に垂直な
      //速度成分は不変と仮定して衝突後の速度を計算し、仮の変数に代入
      new_vx  = vx - ((vx - b.vx) * ex + (vy - b.vy) * ey) * ex;
      new_vy  = vy - ((vx - b.vx) * ex + (vy - b.vy) * ey) * ey;
      new_bvx = b.vx + ((vx - b.vx) * ex + (vy - b.vy) * ey) * ex;
      new_bvy = b.vy + ((vx - b.vx) * ex + (vy - b.vy) * ey) * ey;

      //衝突後の速度を仮の変数から本来の変数に代入
      vx   = new_vx;
      vy   = new_vy;
      b.vx = new_bvx;
      b.vy = new_bvy;

      //接する位置に戻す(ボールの中心間の距離を直径に等しくするという微調整)
      x = b.x + d * ex;
      y = b.y + d * ey;
    }
  }

  // 2つのボールの距離を返す関数
  float distance(Ball b1, Ball b2) {
    return dist(b1.x, b1.y, b2.x, b2.y);
  }
}