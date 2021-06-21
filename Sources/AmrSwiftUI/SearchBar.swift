//
//  SearchBar.swift
//  AmrSwiftUI
//
//  Created by Amr Aboelela on 6/17/21.
//

import SwiftUI

#if canImport(Combine)
@available(macOS 10.15, *)
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
    
    @available(macOS 10.15, *)
    public var body: some View {
        #if os(iOS)
        if #available(iOS 14.0, *) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText, onEditingChanged: { beginsEditing in
                        if !beginsEditing {
                            startSearchCallback?()
                        }
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
        } else {
            // Fallback on earlier versions
        }
        #else
        if #available(macOS 11.0, *) {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText, onEditingChanged: { beginsEditing in
                        if !beginsEditing {
                            startSearchCallback?()
                        }
                    }, onCommit: {
                        print("onCommit")
                    })
                    .foregroundColor(.primary)
                    .disableAutocorrection(true)
                    Button(
                        action: {
                            searchText = ""
                            updateDataCallback?()
                        }
                    ) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .cornerRadius(10.0)
            }
        } else {
            // Fallback on earlier versions
        }
        #endif
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
#endif
