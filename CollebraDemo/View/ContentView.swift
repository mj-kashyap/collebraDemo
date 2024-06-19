//
//  ContentView.swift
//  CollebraDemo
//
//  Created by Manoj Kumar on 19/06/24.
//

import SwiftUI
import CoreData

struct NotesView: View {
    @StateObject var viewModel = NotesViewModel()
    @State private var showingAddNote = false
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes, id: \.self) { note in
                    VStack(alignment: .leading) {
                        Text(note.title ?? "")
                            .font(.headline)
                        Text(note.content ?? "")
                            .font(.subheadline)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                showingAddNote.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
        .onAppear {
            viewModel.fetchNotes()
        }
    }

    //MARK: - Delete notes
    func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let note = viewModel.notes[index]
            viewModel.deleteNote(note: note)
        }
    }
}

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var content = ""
    var viewModel: NotesViewModel

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Content", text: $content)
            }
            .navigationTitle("Add Note")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.addNote(title: title, content: content)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}


private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    NotesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
