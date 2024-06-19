//
//  NotesViewModel.swift
//  CollebraDemo
//
//  Created by Manoj Kumar on 19/06/24.
//

import Foundation
import Combine
import CoreData

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private var cancellables: Set<AnyCancellable> = []

    //MARK: - fetch all saved notes from core data
    func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            self.notes = try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch notes: \(error)")
        }
    }

    //MARK: - Add notes to core data
    func addNote(title: String, content: String) {
        let newNote = Note(context: CoreDataManager.shared.context)
        newNote.title = title
        newNote.content = content
        CoreDataManager.shared.saveContext()
        fetchNotes()
    }
    
    //MARK: - Delete notes
    func deleteNote(note: Note) {
        CoreDataManager.shared.context.delete(note)
        CoreDataManager.shared.saveContext()
        fetchNotes()
    }
}
