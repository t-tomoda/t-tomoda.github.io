// Hokan.pde   ラグランジュの補間多項式の応用例

int x1 = 0,   x2 = 100, x3 = 200, x4 = 300; // xの値のデータ
int y1 = 100, y2 = 400, y3 = 200, y4 = 300; // yの値のデータ
double a1, a2, a3, a4;
int xPoint[] = new int[301]; // int型の配列
int yPoint[] = new int[301]; // int型の配列

void setup() {  // 最初に呼ばれるメソッド
	size(450, 550); // ウィンドウのサイズ

	// ラグランジュの補間多項式の係数a1～a4を計算する
	a1 = y1 / (double)( (x1 - x2) * (x1 - x3) * (x1 - x4) );
	a2 = y2 / (double)( (x2 - x1) * (x2 - x3) * (x2 - x4) );
	a3 = y3 / (double)( (x3 - x1) * (x3 - x2) * (x3 - x4) );
	a4 = y4 / (double)( (x4 - x1) * (x4 - x2) * (x4 - x3) );

	for (int i = 0; i < 301; i++) {
		xPoint[i] = i;			  // 配列xPoint[]にxの値0～300を入れる
		yPoint[i] = p(xPoint[i]); // 配列yPoint[]にラグランジュの補間多項式で
								  // 計算したyの値を入れる
	}
}

int p(int x) {  // ラグランジュの補間多項式
	int value;

	value = (int)(  a1 * (x - x2) * (x - x3) * (x - x4)
				  + a2 * (x - x1) * (x - x3) * (x - x4)
				  + a3 * (x - x1) * (x - x2) * (x - x4)
				  + a4 * (x - x1) * (x - x2) * (x - x3) );

	return value;
}

void draw() {  // 描画のためのメソッド
	int i, xS = 50, yS = 50; // xS、ySはウィンドウの左上からの座標軸原点のズレ
	background(255); //背景を白に
	fill(0);		 //文字を黒に

	for (i = 0; i < 300; i++) {  // 隣接する点をつぎつぎと線分で結んで描画
		line(xS + xPoint[i  ], yS + yPoint[i  ],   // 線分の始点のx、y座標
			 xS + xPoint[i+1], yS + yPoint[i+1]);  // 線分の終点のx、y座標
	}

	text("x", xS + 360, yS + 5); // "x"という文字列
	line(xS, yS, xS + 350, yS);  // x軸
	for (i = 0; i <= 3; i++) {
		line(xS + i * 100, yS, xS + i * 100, yS + 400);  // 縦のグリッド線
		text(str(i * 100), xS + i * 100 - 3, yS - 5);    // xの値
	}

	text("y", xS - 2, yS + 465); // "y"という文字列
	line(xS, yS, xS, yS + 450);  // y軸
	for (i = 0; i <= 4; i++) {
		line(xS, yS + i * 100, xS + 300, yS + i * 100);  // 横のグリッド線
		text(str(i * 100), xS - 30, yS + i * 100 + 5);   // yの値
	}
}