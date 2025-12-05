//
//  ImageView.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 03/12/2025.
//

import Combine
import SwiftUI

// ViewModel for async image loading with caching
class ImageLoaderViewModel: ObservableObject {
    @Published var resource: UIImage?

    let cache: URLCache = URLCache(
        memoryCapacity: 1024 * 1024 * 100,
        diskCapacity: 1024 * 1024 * 100
    )
    var cancellable: Set<AnyCancellable> = .init()

    /// Loads an image from URL with caching support
    /// - Parameters
    ///     url: URL?
    func load(url: URL?) {
        guard let url else { return }

        let config = URLSessionConfiguration.default
        config.urlCache = cache

        let session = URLSession(configuration: config)
        session.configuration.requestCachePolicy = .returnCacheDataElseLoad

        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad

        // Return cached image if available
        if let cacheResponse = cache.cachedResponse(for: request) {
            self.resource = UIImage(data: cacheResponse.data)
            return
        }

        // Fetch from network
        session.dataTaskPublisher(for: request)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let http = response as? HTTPURLResponse,
                    http.statusCode == 200
                else {
                    return nil
                }

                guard !data.isEmpty else {
                    return nil
                }

                return UIImage(data: data)
            })
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { resource in
                self.resource = resource
            }
            .store(in: &cancellable)
    }
}

// Async image view with placeholder and caching
struct ImageView: View {
    @StateObject var viewModel: ImageLoaderViewModel

    let url: URL?

    init(_ url: URL?) {
        self.url = url
        let vm = ImageLoaderViewModel()
        vm.load(url: url)
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        Group {
            if let uiImage = viewModel.resource {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
                    .overlay(
                        ProgressView()
                    )
            }
        }
    }
}
