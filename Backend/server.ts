// ⭐️参考: json-serverの実装に関する参考資料
// https://blog.eleven-labs.com/en/json-server
// ⭐️関連1: TypeScriptで始めるNode.js入門
// https://ics.media/entry/4682/
// ⭐️関連2: JSON ServerをCLIコマンドを使わずTypescript＆node.jsからサーバーを立てるやり方
// https://deep.tacoskingdom.com/blog/151

// Mock用のJSONレスポンスサーバーの初期化設定
import jsonServer from 'json-server';
import helmet from 'helmet';
import bodyParser from 'body-parser';

const server = jsonServer.create();

// Database構築用のJSONファイル
const router = jsonServer.router('db/db.json');

// 各種設定用
const middlewares = jsonServer.defaults();

// TODO: 後で消す
// 👉 ルーティングを変更する
const rewrite_rules = jsonServer.rewriter({
	"/api/v1/users" : "/get_users",
});

// ミドルウェアを設定する (※コンソール出力するロガーやキャッシュの設定等)
server.use(middlewares);

// TODO: 後で消す
// 👉 受信したリクエストにおいてGET送信時のみ許可する
server.use(function (req, res, next) {
	if (req.method === 'GET') {
			next();
	}
});

// ルーティングを設定する
server.use(router);

// Helmetを設定する
server.use(helmet);

// サーバをポート3001で起動する
server.listen(3001, () => {
  console.log('SimpleObservationViperExample Mock Server is running...');
});