// Lab 2 — Course Enrollment Manager

class Course {
    let code: String
    let title: String
    let capacity: Int
    var enrolledStudents: [String]

    init(code: String, title: String, capacity: Int) {
        self.code = code
        self.title = title
        self.capacity = capacity
        self.enrolledStudents = []
    }

    var seatsLeft: Int {
        return capacity - enrolledStudents.count
    }

    func isEnrolled(_ student: String) -> Bool {
        return enrolledStudents.contains(student)
    }

    func enroll(_ student: String) {
        enrolledStudents.append(student)
    }
}

enum EnrollmentError: Error {
    case courseDoesNotExist
    case alreadyEnrolled
    case courseFull
}

let courses = [
    Course(
        code: "SWE101",
        title: "Swift Fundamentals",
        capacity: 2
    ),
    Course(
        code: "UX110",
        title: "Intro to UX",
        capacity: 30
    )
]

func findCourse(by code: String) -> Course? {
    return courses.first {
        $0.code == code
    }
}

func enroll(student: String, in courseCode: String) throws {
    guard let course = findCourse(by: courseCode) else {
        throw EnrollmentError.courseDoesNotExist
    }

    guard !course.isEnrolled(student) else {
        throw EnrollmentError.alreadyEnrolled
    }

    guard course.seatsLeft > 0 else {
        throw EnrollmentError.courseFull
    }

    course.enroll(student)

    print("Enrolled \(student) in \(courseCode)")
}

let enrollmentRequests = [
    ("Dara", "SWE101"),
    ("Sok", "SWE101"),
    ("Dara", "SWE101"),
    ("Bopha", "SWE101"),
    ("Rithy", "CS999")
]

for request in enrollmentRequests {
    let student = request.0
    let courseCode = request.1

    do {
        try enroll(student: student, in: courseCode)
    } catch EnrollmentError.alreadyEnrolled {
        print("Skipped: \(student) is already enrolled")
    } catch EnrollmentError.courseFull {
        print("Rejected \(student): \(courseCode) is full")
    } catch EnrollmentError.courseDoesNotExist {
        print("Rejected \(student): \(courseCode) does not exist")
    } catch {
        print("Rejected \(student): unknown error")
    }
}

if let swiftCourse = findCourse(by: "SWE101") {
    let roster = swiftCourse.enrolledStudents.sorted()

    print("")
    print("\(swiftCourse.title): \(roster.joined(separator: ", "))")
    print("Seats left: \(swiftCourse.seatsLeft)")
}