// Practice 4.1 — Class Roster

var students = ["Dara", "Sok", "Bopha"]

// Add to the end
students.append("Rithy")

// Add to the front
students.insert("Vicheka", at: 0)

print("All Data: \(students)")
print("Count: \(students.count)")
print("First: \(students[0])")

// Remove position 2
students.remove(at: 2)

print("After removing: \(students)")

// Check if Dara exists
print("Has Dara: \(students.contains("Dara"))")

// Sorted copy
print("Sorted: \(students.sorted())")

print("")



// Practice 4.2 — Club Membership

var codingClub: Set = ["Dara", "Sok", "Bopha"]
let mathClub: Set = ["Sok", "Rithy", "Bopha"]

// Try adding Dara again
codingClub.insert("Dara")

print("Coding club size: \(codingClub.count)")

// Students in both clubs
let both = codingClub.intersection(mathClub)

// Students in either club
let allMembers = codingClub.union(mathClub)

print("In both clubs: \(both.sorted())")
print("All members: \(allMembers.sorted())")

print("")



// Practice 4.3 — Grade Book

var grades = [
    "Dara": 88,
    "Sok": 74
]

// Add Bopha
grades["Bopha"] = 91

// Change Sok's score
grades["Sok"] = 79

// Remove Dara
grades["Dara"] = nil

// Print Bopha's score
print("Bopha: \(grades["Bopha"] ?? 0)")

// Print Rithy's score
print("Rithy: \(grades["Rithy"] ?? 0)")

print("Entries: \(grades.count)")

// Loop through the dictionary
for (name, score) in grades {
    print("\(name) -> \(score)")
}