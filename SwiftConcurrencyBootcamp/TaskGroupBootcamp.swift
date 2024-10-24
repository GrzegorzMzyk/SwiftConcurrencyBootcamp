//
//  TaskGroupBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Grzegorz Mzyk on 20/10/2024.
//

import SwiftUI

class TaskGroupBootcampDataManager {
    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
            async let fetchImages1 = fetchImages(url: "https://picsum.photos/300")
            async let fetchImages2 = fetchImages(url: "https://picsum.photos/300")
            async let fetchImages3 = fetchImages(url: "https://picsum.photos/300")
            async let fetchImages4 = fetchImages(url: "https://picsum.photos/300")
            let (image1, image2, image3, image4) = await (try fetchImages1, try fetchImages2, try fetchImages3, try fetchImages4)
            return [image1, image2, image3, image4]
    
    }
    
   private func fetchImages(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw URLError(.badURL) }
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
}


class TaskGroupBootcampViewModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    let manager = TaskGroupBootcampDataManager()
    
    func getImages() async {
        if let images = try? await manager.fetchImagesWithAsyncLet() {
            self.images.append(contentsOf: images)
        }
        
    }
}


struct TaskGroupBootcamp: View {
    @StateObject private var viewModel = TaskGroupBootcampViewModel()
    
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame( height: 150)
                    }
                }
            }
            .navigationTitle("Task Group 🥳")
            .task {
                await viewModel.getImages()
            }
        }
    }
}


#Preview {
    TaskGroupBootcamp()
}
