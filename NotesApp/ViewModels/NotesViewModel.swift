import Foundation
import SwiftUI

class NotesViewModel: ObservableObject {
    // Step 2: Store notes persistently
    @AppStorage("notesData") private var notesData: String = ""
    // Step 3: Manage a collection of notes
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }
    
    // Step 4: Initialize the class
    init() {
        loadNotes()
    }

    // Step 5: Add new notes
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote) // append the new Note data to the JSON
    }

    // Step 6: Update existing notes
    func updateNote(id: UUID, title: String, content: String) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].title = title
            notes[index].content = content
        }
    }

    // Step 7: Toggle completion
    func toggleCompletion(id: UUID) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes[index].isCompleted.toggle()
        }
    }

    // Step 8: Delete notes
    func deleteNotes(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }

    // Step 9: Save notes
    func saveNotes() {
        do {
            let data = try JSONEncoder().encode(notes)
            notesData = String(data: data, encoding: .utf8) ?? ""
        } catch {
            print("Error saving notes: \(error)")
        }
    }

    // Step 10: Load notes
    func loadNotes() {
        guard !notesData.isEmpty else { return }
        
        do {
            if let data = notesData.data(using: .utf8) {
                notes = try JSONDecoder().decode([Note].self, from: data)
            }
        } catch {
            print("Error loading notes: \(error)")
        }
    }
}
