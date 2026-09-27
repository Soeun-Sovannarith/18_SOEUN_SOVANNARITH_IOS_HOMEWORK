// Labs — Apply Multiple Concepts


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
    let total = students.reduce(0) { total, student in
        total + student.score
    }

    let average = Double(total) / Double(students.count)

    print("Class average: \(average)")

    print("")
    print("--- Results ---")

    for student in students {
        let result = student.score >= 50 ? "PASS" : "FAIL"
        print("\(student.name): \(student.score) \(result)")
    }

    let highest = students.max { first, second in
        first.score < second.score
    }

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

    let passingStudents = students.filter {
        $0.score >= 50
    }

    let passingNames = passingStudents.map {
        $0.name
    }

    print("")
    print("Passing: \(passingNames.joined(separator: ", "))")

    let ranking = students.sorted {
        $0.score > $1.score
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
