//
//  EditDestinationView.swift
//  iTour
//
//  Created by Allan Tweddle on 15/11/2023.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var newSightName = ""
    @State private var photosItem: PhotosPickerItem?
    @Environment(\.modelContext) private var modelContext
    var sortedSights: [Sight] {
        destination.sights.sorted {
            $0.name < $1.name
        }
    }

    var body: some View {
        Form {
            Section {
                if let imageData = destination.image {
                    if let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }

                PhotosPicker("Attach a photo", selection: $photosItem, matching: .images)
            }

            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)

            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }

            Section("Sights") {
                ForEach(sortedSights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSights)

                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)

                    Button("Add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: photosItem) {
            Task {
                destination.image = try? await photosItem?.loadTransferable(type: Data.self)
            }
        }
    }

    func addSight() {
        guard newSightName.isEmpty == false else { return }

        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }

    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sortedSights[index]
            modelContext.delete(sight)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)

        let example = Destination(name: "Example Destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
