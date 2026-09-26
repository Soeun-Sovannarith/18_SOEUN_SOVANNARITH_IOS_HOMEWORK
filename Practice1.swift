// ========================================
// Practice 1.1 — Student Profile
// ========================================

// Student information
let studentID = 1001
var name = "Dara"
var age: Int = 20
var gpa: Double = 3.75
var isActive = true

print("===== STUDENT PROFILE =====")
print("")
print("ID: \(studentID)")
print("Name: \(name)")
print("Age: \(age)")
print("GPA: \(gpa)")
print("Active: \(isActive)")

// Update GPA
gpa = 3.90

print("Updated GPA: \(gpa)")


print("")

// ========================================
// Practice 1.2 — Score Average Calculator
// ========================================

let score1 = 80
let score2 = 90
let score3 = 85

// Calculate total
let total = score1 + score2 + score3

// Calculate average as a Double
let average = Double(total) / 3.0

// Round down to a whole number
let roundedAverage = Int(average)

// Build label
let label = "Total: " + String(total)

// Print results
print("Total: \(total)")
print("Average: \(average)")
print("Rounded average: \(roundedAverage)")
print("Label -> \(label)")