//
//  SearchBar.swift
//  AmrSwiftUI
//
//  Created by Amr Aboelela on 6/17/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//

import SwiftUI

public protocol SearchBarDelegate {
    var searchText: String {get set}
    func startSearch()
    func updateData()
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public struct SearchBar: View {
    @Binding var searchBarDelegate: SearchBarDelegate
    
    public var body: some View {
        HStack {
            #if os(iOS)
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("search", text: $searchBarDelegate.searchText, onEditingChanged: { isEditing in
                    searchBarDelegate.startSearch()
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                Button(action: {
                    searchBarDelegate.searchText = ""
                    searchBarDelegate.updateData()
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchBarDelegate.searchText == "" ? 0 : 1)
                }
                
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            #endif
        }
    }
}

#if DEBUG
class PostsViewModelTest: SearchBarDelegate {
    var searchText = ""
    
    func startSearch() {
        print("startSearch")
    }
    
    func updateData() {
        print("updateData")
    }
}

@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct SearchBar_Previews: PreviewProvider {
    @State static var postsViewModelTest: SearchBarDelegate = PostsViewModelTest()
    
    static var previews: some View {
        SearchBar(searchBarDelegate: $postsViewModelTest)
    }
}

#endif

