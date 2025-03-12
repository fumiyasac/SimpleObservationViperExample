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

// ミドルウェアを設定する (※コンソール出力するロガーやキャッシュの設定等)
server.use(middlewares);

// ログイン処理
// Sample: curl -X POST -H "Content-Type: application/json" -d '{"email":"just1factory@gmail.com", "password":"iwasbornin1984"}' http://localhost:3001/v1/auth/login
server.post("/v1/auth/login", (request, response) => {
  const { email, password } = request.body;
  // ログイン内容チェック
  if (email !== 'just1factory@gmail.com' || password !== 'iwasbornin1984'){    
    response.status(401).json("Unauthorized");
    return;
  }
  // アクセストークン生成
  const accessToken = jwt.sign({ email, password }, JWT_SECRET, {
    expiresIn: EXPIRATION,
  });
  console.log(accessToken);
  response.status(200).json({ token: accessToken });
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
    // 認証成功時はステータスコードと（デバッグ用に）設定されていたトークンを返す
    response.status(200).json({ token: accessToken });
  } catch (e) {
    response.status(401).json("Unauthorized");
  }
});

// 各種表示用データ取得処理
server.get("/v1/galleries", (_, response) => {
  const galleries = db.galleries;
  response.status(200).json(galleries);
});

server.get("/v1/pickup_feeds", (_, response) => {
  const pickupFeeds = db.pickupFeeds;
  response.status(200).json(pickupFeeds);
});

server.get("/v1/category_feeds", (_, response) => {
  const categoryFeeds = db.categoryFeeds.sort((former: any, latter: any) => former.rank - latter.rank);
  response.status(200).json(categoryFeeds);
});

server.get("/v1/info_feed", (request, response) => {
  const targetId = request.url.split("?page=")[1];
  const infoFeeds = db.infoFeeds.filter((infoFeed: any) => infoFeed.page == targetId);
  response.status(200).json(...infoFeeds);
});

// ルーティングを設定する
server.use(router);

// Helmetを設定する
server.use(helmet);

// サーバをポート3001で起動する
server.listen(3001, () => {
  console.log('SimpleObservationViperExample Mock Server is running...');
});