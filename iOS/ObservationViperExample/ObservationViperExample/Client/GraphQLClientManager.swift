//
//  GraphQLClientManager.swift
//  ObservationViperExample
//
//  Created by 酒井文也 on 2024/11/09.
//

import Apollo
import ApolloAPI
import Foundation

final class GraphQLClientManager {

    // MARK: - Singleton Instance

    static let shared = GraphQLClientManager()

    private init() {}

    // MARK: - Property

    let apollo = {
        // MEMO: Client作成部分に関する詳細な設定については公式ドキュメントを参考にすると良さそうです。
        // ドキュメント: https://www.apollographql.com/docs/ios/networking/client-creation
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let provider = DefaultInterceptorProvider(
            client: URLSessionClient(),
            store: store
        )
        // MEMO: エンドポイントはすでにサンプルとして公開されているものを利用する形としています。
        // 動作コード: http://localhost:4000/graphql
        let url = URL(string: "http://localhost:4000/graphql")!
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url,
            // MEMO: もしHeader用のAccessTokenを付与する場合はこちらを活用することになります。
            additionalHeaders: ["Authorization": "Bearer "]
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

// 実装の参考:
// 「apollo-ios」内のIssue内のディスカッションで紹介されていたコードを参考にしています。
// Apollo内で用意されているQuery & Mutationの実行処理をasync/awaitでラッピングしている。
// https://github.com/apollographql/apollo-ios/issues/2216

// MARK: - ApolloClient Extension

extension ApolloClient {

    // GraphQLのQueryをする処理をasync/awaitの処理内で実行する
    @discardableResult
    func fetchAsync<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .default,
        contextIdentifier: UUID? = nil,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Query.Data> {

        // MEMO: withCheckedThrowingContinuationでErrorをthrowする形にしています。
        return try await withCheckedThrowingContinuation { continuation in
            fetch(
                query: query,
                cachePolicy: cachePolicy,
                contextIdentifier: contextIdentifier,
                queue: queue
            ) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // GraphQLのMutationをする処理をasync/awaitの処理内で実行する
    @discardableResult
    func performAsync<Mutation: GraphQLMutation>(
        mutation: Mutation,
        publishResultToStore: Bool = true,
        queue: DispatchQueue = .main
    ) async throws -> GraphQLResult<Mutation.Data> {

        // MEMO: withCheckedThrowingContinuationでErrorをthrowする形にしています。
        return try await withCheckedThrowingContinuation { continuation in
            perform(
                mutation: mutation,
                publishResultToStore: publishResultToStore,
                queue: queue
            ) { result in
                switch result {
                case .success(let value):
                    continuation.resume(returning: value)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
