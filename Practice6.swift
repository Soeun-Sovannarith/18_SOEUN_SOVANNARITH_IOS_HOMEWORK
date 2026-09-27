// Practice 6.1 — Student Model (struct)

struct Student {
    let id: Int
    var name: String
    var gpa: Double

    func summary() -> String {
        return "\(id) - \(name) (GPA \(gpa))"
    }

    mutating func updateGPA(to newGPA: Double) {
        gpa = newGPA
    }
}

let original = Student(
    id: 1001,
    name: "Dara",
    gpa: 3.75
)

var copy = original

copy.updateGPA(to: 3.90)

print("Original: \(original.summary())")
print("Copy: \(copy.summary())")

print("")

// Practice 6.2 — People and Teachers (class)

class Person {
    var name: String

    init(name: String) {
        self.name = name
    }

    func introduce() -> String {
        return "Hi, I'm \(name)."
    }
}

class Teacher: Person {
    var subject: String

    init(name: String, subject: String) {
        self.subject = subject
        super.init(name: name)
    }

    override func introduce() -> String {
        return "Hi, I'm \(name) and I teach \(subject)."
    }
}

let teacherA = Teacher(
    name: "Ms. Sophea",
    subject: "Swift"
)

let teacherB = teacherA

teacherB.name = "Ms. Sophea"

print(teacherA.introduce())
print(teacherB.introduce())