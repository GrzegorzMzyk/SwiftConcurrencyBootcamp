//
//  DoCatchTryThrowsBootcamp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Grzegorz Mzyk on 15/10/2024.
//

import SwiftUI

// do-catch
// try
// throws

class DoCatchTryThrowsBootcampDataManager {
    
    let isActive: Bool = true
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive{
            return ("New text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive{
            return .success("New text")
        } else {
            return .failure(URLError(.badServerResponse))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive{
            return "New text"
        } else {
            throw URLError(.appTransportSecurityRequiresSecureConnection)
        }
    }
    
    func getTitle4() throws -> String {
        if isActive{
            return "Finnal text"
        } else {
            throw URLError(.appTransportSecurityRequiresSecureConnection)
        }
    }
}


class DoCatchTryThrowsBootcampModel: ObservableObject {
    let manager = DoCatchTryThrowsBootcampDataManager()
    @Published var text: String = "Starting text"
    
    func fetchTitle() {
        /*
      let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */
        /*
        let result = manager.getTitle2()
        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */
//        let newTitle = try? manager.getTitle3()
//        if let newTitle = newTitle {
//            self.text = newTitle
//        }
        do {
            let newTitle = try? manager.getTitle3()
            if let newTitle = newTitle {
                self.text = newTitle
            }
          
            
            let finalTitle = try manager.getTitle4()
            self.text = finalTitle
        } catch  {
            self.text = error.localizedDescription
        }
        
        
    }
    
}


struct DoCatchTryThrowsBootcamp: View {
    
    @StateObject private var viewModels = DoCatchTryThrowsBootcampModel()
    
    var body: some View {
        Text(viewModels.text)
            .frame(width:300, height:300)
            .background(Color.blue)
            .onTapGesture {
                viewModels.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTryThrowsBootcamp()
}
