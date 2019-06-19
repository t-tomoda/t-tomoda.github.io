//　放物運動　　　　　   　　　　　　　                     T. Tomoda, 2019/6/18

float x = -10;            //ボールの初期x座標（ウィンドウ外）
float y = 600;            //ボールの初期y座標（ウィンドウ外）
float delta_x = 0;        //x方向の"速度"
float delta_y = 0;        //y方向の"速度"
float delta_r = 0;        //"速さ"
float delta_vy = 0.01;    //y方向の"重力加速度"
float r = 5;              //ボールの半径
color c;                  //ボールの色

float wb = 130;           //ボタンの幅
float hb =  50;           //ボタンの高さ
float unit = 156;         //マス目の辺の長さ（最大到達距離の1/4）
String[] str4 = {"抵抗なし", "抵抗あり"}; //第4ボタンの表示名

int count_draw = 0;       //関数draw()が呼ばれる回数のカウント
int resistance = 0;       //空気抵抗なし(0)、あり(1)
float res_factor = 0.001; //空気抵抗の大きさを表す係数

Button button0;           //ボタン0
Button button1;           //ボタン1
Button button2;           //ボタン2
Button button3;           //ボタン3
Button button4;           //ボタン4
Button button5;           //ボタン5

void setup() {
  size(780, 518);

  PFont font = createFont("MS Gothic", 26); //フォント生成
  textFont(font);                           //使用フォントの設定

  //ボタンの生成
  button0 = new Button(0, "   40°");
  button1 = new Button(1, "   45°");
  button2 = new Button(2, "   50°");
  button3 = new Button(3, "   90°");
  button4 = new Button(4,   str4[0]); //最初は"抵抗なし"
  button5 = new Button(5, "  Reset");

  //マス目の横線と縦線
  line(0,        height - unit,     width,    height - unit);
  line(0,        height - unit * 2, width,    height - unit * 2);
  line(unit,     hb,                unit,     height);
  line(unit * 2, hb,                unit * 2, height);
  line(unit * 3, hb,                unit * 3, height);
  line(unit * 4, hb,                unit * 4, height);
}

void draw() {
  delta_y -= delta_vy;   //"重力加速度"によるy方向の"速度"の変化

  if (resistance == 1) { //空気抵抗ありの場合
    //速度の２乗に比例する空気抵抗による減速
    delta_r = sqrt(delta_x*delta_x + delta_y*delta_y);
    delta_x -= delta_x * delta_r * res_factor; //x方向の減速
    delta_y -= delta_y * delta_r * res_factor; //y方向の減速
  }

  x += delta_x; //ボールは右へ
  y -= delta_y; //delta_yの正負によりボールは上昇または下降

  if(count_draw % 4 == 0) {
    //draw()が4回呼ばれるごとに(x, y)を中心とする半径rの円を描画
    ellipse(x, y, r, r);
  }
  count_draw++; //カウントを1だけ増やす
}

void mousePressed() {
  //マウスがクリックされたらそれぞれのボタンのmousePressed()を呼ぶ
  button0.mousePressed();
  button1.mousePressed();
  button2.mousePressed();
  button3.mousePressed();
  button4.mousePressed();
  button5.mousePressed();
}