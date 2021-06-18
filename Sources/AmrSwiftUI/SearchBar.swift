//
//  SearchBar.swift
//  AmrSwiftUI
//
//  Created by Amr Aboelela on 6/17/21.
//  Copyright © 2021 Amr Aboelela. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SearchBar: View {
    @Binding var searchText: String
    var startSearchCallback: (() -> Void)?
    var updateDataCallback: (() -> Void)?
    
    public init(searchText: Binding<String>, startSearchCallback: (() -> Void)?, updateDataCallback: (() -> Void)?) {
        self._searchText = searchText
        self.startSearchCallback = startSearchCallback
        self.updateDataCallback = updateDataCallback
    }
    
    public var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("search", text: $searchText, onEditingChanged: { isEditing in
                    startSearchCallback?()
                }, onCommit: {
                    print("onCommit")
                })
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
                Button(action: {
                    searchText = ""
                    updateDataCallback?()
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
    }
}


#if DEBUG
@available(iOS 13.0, *)
@available(macOS 10.15, *)
struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""
    
    static var previews: some View {
        SearchBar(
            searchText: $searchText,
            startSearchCallback: {
                print("startSearchCallback")
            }, updateDataCallback: {
                print("updateDataCallback")
            }
        )
    }
}
#endif

