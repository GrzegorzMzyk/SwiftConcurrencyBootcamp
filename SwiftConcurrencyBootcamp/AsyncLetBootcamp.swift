//
//  AsyncLetBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Grzegorz Mzyk on 20/10/2024.
//

import SwiftUI

struct AsyncLetBootcamp: View {
    
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/300")!
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame( height: 150)
                    }
                }
            }
            .navigationTitle("Async Let 🥳")
            .onAppear {
                Task {
                    do {
                        
                        async let fetchImage1 = fetchImages()
                        async let fetchImage2 = fetchImages()
                        async let fetchImage3 = fetchImages()
                        async let fetchImage4 = fetchImages()
                        
                        let (image1, image2, image3, image4) =
                        await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
                        self.images.append(contentsOf: [image1, image2, image3, image4])
//
//                        let image1 = try await fetchImages()
//                        self.images.append(image1)
//                        
//                        let image2 = try await fetchImages()
//                        self.images.append(image2)
//                        
//                        let image3 = try await fetchImages()
//                        self.images.append(image3)
//                        
//                        let image4 = try await fetchImages()
//                        self.images.append(image4)
                    } catch {
                        
                    }
                }
            }
        }
    }
    
    func fetchImages() async throws -> UIImage {
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

#Preview {
    AsyncLetBootcamp()
}
