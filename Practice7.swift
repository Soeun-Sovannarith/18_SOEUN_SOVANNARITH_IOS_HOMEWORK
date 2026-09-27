// Practice 7.1 — Missing Contact Details

struct Student {
    let name: String
    let email: String?
}

let students = [
    Student(name: "Dara", email: "dara@school.edu"),
    Student(name: "Sok", email: nil)
]

// Print email or fallback
for student in students {
    if let email = student.email {
        print("\(student.name): \(email)")
    } else {
        print("\(student.name): no email on file")
    }
}

// Use ?? to provide a default value
print("Sok's contact: \(students[1].email ?? "not provided")")

// Safely get email length using ?.
print("Dara's email length: \(students[0].email?.count ?? 0)")

// guard let: leave early if email is missing
func sendReminder(to student: Student) {
    guard let email = student.email else {
        print("Cannot remind \(student.name): missing email.")
        return
    }

    print("Reminder sent to \(email).")
}

sendReminder(to: students[0])
sendReminder(to: students[1])

print("")


// Practice 7.2 — Score Input Validator

enum ScoreError: Error {
    case notANumber
    case negative
    case above100
}

func parseScore(_ input: String) throws -> Int {
    guard let score = Int(input) else {
        throw ScoreError.notANumber
    }

    if score < 0 {
        throw ScoreError.negative
    }

    if score > 100 {
        throw ScoreError.above100
    }

    return score
}

let inputs = ["88", "-4", "120", "ninety"]

for input in inputs {
    do {
        let score = try parseScore(input)
        print("Saved score: \(score)")
    } catch ScoreError.notANumber {
        print("Error: \"\(input)\" is not a number.")
    } catch ScoreError.negative {
        print("Error: \(input) is negative.")
    } catch ScoreError.above100 {
        print("Error: \(input) is above 100.")
    } catch {
        print("Error: Unknown error.")
    }
}