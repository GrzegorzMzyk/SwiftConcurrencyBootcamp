//
//  SwiftConcurrencyBootcampApp.swift
//  SwiftConcurrencyBootcamp
//
//  Created by Grzegorz Mzyk on 15/10/2024.
//

import SwiftUI

@main
struct SwiftConcurrencyBootcampApp: App {
    var body: some Scene {
        WindowGroup {
            DownloadImageAsync()
        }
    }
}
