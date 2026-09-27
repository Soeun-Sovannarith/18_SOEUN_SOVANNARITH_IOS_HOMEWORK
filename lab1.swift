// Lab 1 — Student Score Analyzer

struct Student {
    let name: String
    let score: Int
}

let students = [
    Student(name: "Dara", score: 88),
    Student(name: "Sok", score: 45),
    Student(name: "Bopha", score: 92),
    Student(name: "Rithy", score: 67),
    Student(name: "Vicheka", score: 73),
    Student(name: "Sophea", score: 39)
]

print("===== SCORE ANALYZER =====")
print("Students: \(students.count)")

if students.isEmpty {

    print("Class average: 0.00")

    print("")
    print("--- Results ---")
    print("No students to analyze.")

    print("")
    print("Highest: None")
    print("Lowest: None")
    print("Passing: None")

    print("")
    print("--- Ranking ---")
    print("No students to rank.")

} else {

    // Calculate class average
    let total = students.reduce(0) { total, student in
        total + student.score
    }

    let average = Double(total) / Double(students.count)

    print("Class average: \(average)")

    // Display pass or fail
    print("")
    print("--- Results ---")

    for student in students {

        let result: String

        if student.score >= 50 {
            result = "PASS"
        } else {
            result = "FAIL"
        }

        print("\(student.name): \(student.score) \(result)")
    }

    // Find highest score
    let highest = students.max { first, second in
        first.score < second.score
    }

    // Find lowest score
    let lowest = students.min { first, second in
        first.score < second.score
    }

    if let highest = highest {
        print("")
        print("Highest: \(highest.name) (\(highest.score))")
    }

    if let lowest = lowest {
        print("Lowest: \(lowest.name) (\(lowest.score))")
    }

    // Find passing students
    let passingStudents = students.filter { student in
        student.score >= 50
    }

    // Get names of passing students
    let passingNames = passingStudents.map { student in
        student.name
    }

    print("")
    print("Passing: \(passingNames.joined(separator: ", "))")

    // Sort students from highest to lowest
    let ranking = students.sorted { first, second in
        first.score > second.score
    }

    print("")
    print("--- Ranking ---")

    for (index, student) in ranking.enumerated() {
        print("\(index + 1). \(student.name) - \(student.score)")
    }
}

print("")
print("")
print("========================================")
print("")