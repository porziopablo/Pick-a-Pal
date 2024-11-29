//
//  ContentView.swift
//  Pick-a-Pal
//
//  Created by Pablo Porzio (Modak) on 29/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var names: [String] = []
    @State private var nameToAdd = ""
    @State private var pickedName = ""
    @State private var shouldRemovePickedName = false
    @State private var storedNames: [String] = []
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Image(systemName: "person.3.sequence.fill")
                    .foregroundStyle(.tint)
                    .symbolRenderingMode(.hierarchical)
                Text("Pick-a-Pal")
            }
            .font(.title)
            .bold()
            
            Text(pickedName.isEmpty ? " " : pickedName)
                .font(.title2)
                .bold()
                .foregroundStyle(.tint)
            
            List {
                ForEach(names, id: \.description) { name in
                    Text(name)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            TextField("Add name", text: $nameToAdd)
                .autocorrectionDisabled()
                .onSubmit {
                    let trimmedName = nameToAdd.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !names.contains(where:{name in name == trimmedName}) {
                        if !trimmedName.isEmpty {
                            names.append(trimmedName)
                            nameToAdd = ""
                        }
                    }
                }
            Divider()
            Toggle("Remove when picked", isOn: $shouldRemovePickedName)
            Button {
                if let randomName = names.randomElement() {
                    pickedName = randomName
                    if shouldRemovePickedName {
                        names.removeAll {name in name == pickedName}
                    }
                } else {
                    pickedName = ""
                }
            } label : {
                Text("Pick Random Name")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
            HStack {
                Button  {
                    storedNames = names
                } label : {
                    Text("Save list")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
                Button  {
                    names = storedNames
                } label : {
                    Text("Load list")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
