// ⭐️参考: json-serverの実装に関する参考資料
// https://blog.eleven-labs.com/en/json-server
// ⭐️関連1: TypeScriptで始めるNode.js入門
// https://ics.media/entry/4682/
// ⭐️関連2: JSON ServerをCLIコマンドを使わずTypescript＆node.jsからサーバーを立てるやり方
// https://deep.tacoskingdom.com/blog/151
// ⭐️関連3: JSON Serverで30秒で認証機能付きモックREST APIを構築する
// https://tech-blog.rakus.co.jp/entry/20201029/rest-api

// Mock用のJSONレスポンスサーバーの初期化設定
import jsonServer from 'json-server';
import helmet from 'helmet';
import bodyParser from 'body-parser';
import jwt from 'jsonwebtoken';
import fs from 'fs';

const server = jsonServer.create();

// JSON形式のリクエスト対応
server.use(bodyParser.urlencoded({ extended: true }));
server.use(bodyParser.json());

// 署名
const JWT_SECRET = "jwt_json_server";
// 有効時間
const EXPIRATION = "1h";

// Database構築用のJSONファイル
const router = jsonServer.router('db/db.json');

// データーベース
const db = JSON.parse(fs.readFileSync('db/db.json', 'utf8'));

// 各種設定用
const middlewares = jsonServer.defaults();

// TODO: 後で消す
// 👉 ルーティングを変更する
// const rewrite_rules = jsonServer.rewriter({
// 	"/api/v1/users" : "/get_users",
// });

// ミドルウェアを設定する (※コンソール出力するロガーやキャッシュの設定等)
server.use(middlewares);

// ログイン処理
// Sample: curl -X POST -H "Content-Type: application/json" -d '{"email":"just1factory@gmail.com", "password":"iwasbornin1984"}' http://localhost:3001/v1/auth/login
server.post("/v1/auth/login", (request, response) => {
  const { email, password } = request.body;
  // ログイン内容チェック
  if (email === 'just1factory@gmail.com' && password !== 'iwasbornin1984' ){ 
    response.status(401).json("Unauthorized");
    return;
  }
  // アクセストークン生成
  const accessToken = jwt.sign({ email, password }, JWT_SECRET, {
    expiresIn: EXPIRATION,
  });
	console.log(accessToken);
	response.status(200).json({ accessToken });
});

// トークン検証処理
// Sample: curl -X POST -H 'Content-Type: application/json;charset=utf-8' -H 'Authorization: Bearer {My Token Value}' http://localhost:3001/v1/auth/verify
server.post("/v1/auth/verify", (request, response) => {
  // 形式チェック
  if (request.headers.authorization === undefined || request.headers.authorization.split(" ")[0] !== "Bearer") {
    response.status(401).json("Unauthorized");
    return;
  }
  // 認証チェック
  try {
		const accessToken = request.headers.authorization.split(" ")[1];
    const decode = jwt.verify(accessToken, JWT_SECRET);
		console.log(decode);
    // 認証に成功した場合は、next関数を実行しJSON Serverの機能を利用する
		response.status(200).json({ message: 'Success! Your token is verifies!', accessToken: accessToken });
  } catch (e) {
    response.status(401).json("Unauthorized");
  }
});

// 各種表示用データ取得処理
server.get("/v1/users", (_, response) => {
  const users = db.users;
  response.status(200).json({ users });
});

// TODO: 後で消す
// 👉 受信したリクエストにおいてGET送信時のみ許可する
// server.use(function (req, res, next) {
// 	if (req.method === 'GET') {
// 			next();
// 	}
// });

// ルーティングを設定する
server.use(router);

// Helmetを設定する
server.use(helmet);

// サーバをポート3001で起動する
server.listen(3001, () => {
  console.log('SimpleObservationViperExample Mock Server is running...');
});