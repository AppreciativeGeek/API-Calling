//
//  ContentView.swift
//  API Calling
//
//  Created by James on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    @State private var searchResults = [Result]()
    
    var body: some View {
        NavigationView {
            List (searchResults) { result in
                Text(result.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Result: Identifiable {
    var id = UUID()
    var title : String
    var link : String
    var description : String
}
