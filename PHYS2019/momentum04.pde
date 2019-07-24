//　運動量保存則（気体の拡散）                              T. Tomoda, 2019/7/24

float d = 10;                 //ボールの直径
float r = d / 2;              //ボールの半径
float length, half_length;    //ボールの運動領域(正方形)の辺の長さとその半分
int NUM = 200;                //ボールの数
Ball[] ball = new Ball[NUM];  //ボールの配列を生成
int count_draw = 0;           //draw()が呼ばれる回数のカウント、初期化

int DIM = 10;                 //ヒストグラムの区間数
int[] sum_lef = new int[DIM]; //区間ごとの数を入れる配列(仕切の左側)
int[] sum_rig = new int[DIM]; //区間ごとの数を入れる配列(仕切の右側)
int sum_l = 0;                //全区間のボールの総数(仕切の左側)
int sum_r = 0;                //全区間のボールの総数(仕切の右側)
int sum = 0;                  //全区間のボールの総数(左右合計)

void setup() {
  size(800, 650);
  length = width / 2;
  half_length = length / 2;
  PFont font = createFont("MS-Gothic", 20); //フォント生成
  textFont(font);                           //使用フォントの設定
  for (int i = 0; i < NUM; i++) {
    ball[i] = new Ball(); //ボールのオブジェクトを生成して配列に代入
    //ボールの位置と速度をランダムに初期化
    ball[i].set(random(r, length - r), random(r, length - r), //x, y
                random(-5, 5), random(-5, 5));                //vx, vy
  }
}

void draw() {
  noStroke();                    //輪郭線なし
  fill(255);                     //白色
  rect(0, 0, width, length + d); //ボールの運動領域(+α)を塗りつぶす

  fill(0); //黒色(仕切と壁)
  rect(length - 1,                0,   2, half_length - 20); //仕切(上半分)
  rect(length - 1, half_length + 20,   2, half_length - 20); //仕切(下半分)
  rect(0, length, width, 2); //下の壁

  for (int i = 0; i < NUM - 1; i++) {
    for (int j = i + 1; j < NUM; j++) {
      ball[i].collision(ball[j]); //i番目とj番目のボールの衝突(速度変化)の計算
    }
  }

  for (int i = 0; i < NUM; i++) {
    ball[i].draw(); //個々のボールを描画
  }

  //速度分布のヒストグラム表示(300フレームごとに更新)
  if (count_draw % 300 == 0) {
    fill(255);                               //白色
    rect(0, length, width, height - length); //ヒストグラム表示領域を塗りつぶす
    histogram(sum_lef, sum,  60, 610);       //ヒストグラム表示(仕切左側)
    histogram(sum_rig, sum, 460, 610);       //ヒストグラム表示(仕切右側)

    //表示後、次の表示用に変数の初期化
    for (int i = 0; i < DIM; i++) {
      sum_lef[i] = 0;
      sum_rig[i] = 0;
    }
    sum_l = 0;
    sum_r = 0;
    sum = 0;
  }

  //個々のボールについて、速度(vx)の絶対値に基づきNUM個の区間に分類してカウント
  for (int i = 0; i < NUM; i++) {
    int k = int(abs(ball[i].vx)); //i番目のボールの速度(x成分)の絶対値(整数化)
    if (k < DIM) {
      if(ball[i].x < width /2) { //仕切の左側のボール
        sum_lef[k]++; //k番目の区間のボールのカウントを1増やす
        sum_l++;      //ボールのカウントを1増やす
      } else {                   //仕切の右側のボール
        sum_rig[k]++; //k番目の区間のボールのカウントを1増やす
        sum_r++;      //ボールのカウントを1増やす
      }
      sum++;          //ボールのカウントを1増やす(左右を区別せずに)
    }
  }

  count_draw++;    //draw()が呼ばれる回数のカウントを1だけ増やす
}

//ヒストグラム表示関数
void histogram(int[] data, int sum, float x0, float y0) {
  //(x0, y0) ヒストグラムの座標原点
  fill(0);
  stroke(0);

  line(x0, y0, x0 + 220, y0);             //横軸
  for (int i = 0; i < 12; i+=2) {
    float x = x0 + i * 20 - 5;
    if (i == 10) {
      x -= 5; //2桁の場合は左へシフト
    }
    text(str(i), x, y0 + 20);             //横軸（数値 0, 2, … , 10）
  }
  text("|vx| (px/fr)", x0 + 230, y0 + 5); //横軸（変数名と単位）

  line(x0, y0 - 150, x0, y0);             //縦軸
  for (int i = 0; i < 4; i++) {
    float y = y0 - i * 50;
    line(x0 - 5, y, x0, y);               //縦軸（目盛）
    if (i == 0) {
      text("0",          x0 - 17, y + 5); //縦軸（数値 0）
    } else {
      text(str(i) + "0", x0 - 28, y + 5); //縦軸（数値 10, 20, 30）
    }
  }
  text("(%)", x0 - 32, y0 - 168);         //縦軸（単位）
  text("速度(x成分)の分布", x0 + 40, y0 - 168); //標題

  //ヒストグラムの表示
  fill(192); //灰色
  stroke(0); //輪郭黒色
  for (int i = 0; i < DIM; i++) {
    float data_height = 500 * data[i] / float(sum);
    rect(x0 + i * 20, y0 - data_height, 20, data_height);
  } 
}