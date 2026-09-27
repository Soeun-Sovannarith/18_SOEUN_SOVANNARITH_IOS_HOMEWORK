import Foundation

struct Student {
	let id: Int
	var name: String
	var age: Int
	var email: String?
	var scores: [Int]

	var average: Double? {
		guard !scores.isEmpty else { return nil }
		return Double(scores.reduce(0, +)) / Double(scores.count)
	}

	var grade: String {
		guard let average else { return "—" }
		switch average {
		case 90...100: return "A"
		case 80..<90: return "B"
		case 70..<80: return "C"
		case 50..<70: return "D"
		default: return "F"
		}
	}
}

enum ValidationError: Error, CustomStringConvertible {
	case invalidWholeNumber(field: String)
	case invalidRange(field: String, lower: Int, upper: Int)
	case invalidEmail
	case duplicateID(Int)
	case missingStudent(Int)

	var description: String {
		switch self {
		case .invalidWholeNumber(let field): return "Error: \(field) must be a whole number."
		case .invalidRange(let field, let lower, let upper): return "Error: \(field) must be between \(lower) and \(upper)."
		case .invalidEmail: return "Error: Email must contain @."
		case .duplicateID(let id): return "Error: ID \(id) already exists."
		case .missingStudent(let id): return "Error: No student with ID \(id) exists."
		}
	}
}

var students: [Int: Student] = [:]

func readRequiredLine(_ prompt: String) -> String {
	while true {
		print(prompt, terminator: "")
		let value = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
		if !value.isEmpty { return value }
		print("Error: This value cannot be empty.")
	}
}

func readWholeNumber(_ prompt: String, field: String, range: ClosedRange<Int>? = nil) -> Int {
	while true {
		print(prompt, terminator: "")
		let input = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Int(input) else {
			print(ValidationError.invalidWholeNumber(field: field))
			continue
		}
		if let range, !range.contains(value) {
			print(ValidationError.invalidRange(field: field, lower: range.lowerBound, upper: range.upperBound))
			continue
		}
		return value
	}
}

func readOptionalEmail(_ prompt: String, current: String? = nil) -> String? {
	while true {
		print(prompt, terminator: "")
		let input = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
		if input.isEmpty { return current }
		guard input.contains("@") else {
			print(ValidationError.invalidEmail)
			continue
		}
		return input
	}
}

func readStudentID() -> Int {
	readWholeNumber("Student ID: ", field: "ID", range: 1...Int.max)
}

func averageText(for student: Student) -> String {
	guard let average = student.average else { return "—" }
	return String(format: "%.2f", average)
}

func studentLine(_ student: Student) -> String {
	let email = student.email ?? "not provided"
	return "ID: \(student.id) | Name: \(student.name) | Age: \(student.age) | Average: \(averageText(for: student)) | Grade: \(student.grade) | Email: \(email)"
}

func sortedStudents(_ values: [Student]) -> [Student] {
	values.sorted {
		if $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedSame { return $0.id < $1.id }
		return $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
	}
}

func printStudents(_ values: [Student]) {
	guard !values.isEmpty else {
		print("No students yet.")
		return
	}
	print("ID    Name                 Average  Grade")
	print("------------------------------------------")
	for student in sortedStudents(values) {
		print("\(student.id) | \(student.name) | \(averageText(for: student)) | \(student.grade)")
	}
}

func addStudent() {
	let id = readStudentID()
	guard students[id] == nil else {
		print(ValidationError.duplicateID(id))
		return
	}
	let name = readRequiredLine("Name: ")
	let age = readWholeNumber("Age: ", field: "Age", range: 16...60)
	let email = readOptionalEmail("Email (optional): ")
	students[id] = Student(id: id, name: name, age: age, email: email, scores: [])
	print("Student added.")
}

func viewStudents() {
	printStudents(Array(students.values))
}

func searchStudents() {
	let query = readRequiredLine("Search by ID or name: ")
	if let id = Int(query), let student = students[id] {
		print(studentLine(student))
		return
	}
	let matches = students.values.filter { $0.name.localizedCaseInsensitiveContains(query) }
	guard !matches.isEmpty else {
		print("Not found.")
		return
	}
	for student in sortedStudents(matches) { print(studentLine(student)) }
}

func updateStudent() {
	let id = readStudentID()
	guard var student = students[id] else {
		print(ValidationError.missingStudent(id))
		return
	}

	print("Name [\(student.name)]: ", terminator: "")
	let nameInput = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
	if !nameInput.isEmpty { student.name = nameInput }

	while true {
		print("Age [\(student.age)]: ", terminator: "")
		let ageInput = (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
		if ageInput.isEmpty { break }
		guard let age = Int(ageInput) else {
			print(ValidationError.invalidWholeNumber(field: "Age"))
			continue
		}
		guard (16...60).contains(age) else {
			print(ValidationError.invalidRange(field: "Age", lower: 16, upper: 60))
			continue
		}
		student.age = age
		break
	}

	student.email = readOptionalEmail("Email [\(student.email ?? "not provided")]: ", current: student.email)
	students[id] = student
	print("Student updated.")
}

func deleteStudent() {
	let id = readStudentID()
	guard students[id] != nil else {
		print(ValidationError.missingStudent(id))
		return
	}
	while true {
		print("Delete student \(id)? (y/n): ", terminator: "")
		switch (readLine() ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
		case "y", "yes":
			students.removeValue(forKey: id)
			print("Student deleted.")
			return
		case "n", "no":
			print("Deletion cancelled.")
			return
		default:
			print("Error: Please enter y or n.")
		}
	}
}

func addScore() {
	let id = readStudentID()
	guard var student = students[id] else {
		print(ValidationError.missingStudent(id))
		return
	}
	let score = readWholeNumber("Score: ", field: "Score", range: 0...100)
	student.scores.append(score)
	students[id] = student
	print("Score added.")
}

func classReport() {
	viewStudents()
	let averages = students.values.compactMap(\.average)
	guard !averages.isEmpty else {
		print("Class average: —")
		return
	}
	let classAverage = averages.reduce(0, +) / Double(averages.count)
	print("Class average: \(String(format: "%.2f", classAverage))")
}

func filterAndSort() {
	print("1. Filter by grade")
	print("2. Passing students")
	print("3. Failing students")
	print("4. Sort by name (A-Z)")
	print("5. Sort by average (high-low)")
	let choice = readWholeNumber("Choose an option: ", field: "Option", range: 1...5)
	let allStudents = Array(students.values)

	switch choice {
	case 1:
		let grade = readRequiredLine("Grade (A-F): ").uppercased()
		guard ["A", "B", "C", "D", "F"].contains(grade) else {
			print("Error: Grade must be A, B, C, D, or F.")
			return
		}
		printStudents(allStudents.filter { $0.grade == grade })
	case 2:
		printStudents(allStudents.filter { ["A", "B", "C", "D"].contains($0.grade) })
	case 3:
		printStudents(allStudents.filter { $0.grade == "F" })
	case 4:
		printStudents(allStudents.sorted {
			$0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
		})
	default:
		printStudents(allStudents.sorted { ($0.average ?? -1) > ($1.average ?? -1) })
	}
}

func printMenu() {
	print("""
	===== ACADEMIC MANAGER =====
	1. Add student
	2. View all students
	3. Search student
	4. Update student
	5. Delete student
	6. Add score
	7. Class report
	8. Filter & sort
	0. Exit
	""")
}

var running = true
while running {
	printMenu()
	print("Choose an option: ", terminator: "")
	switch readLine()?.trimmingCharacters(in: .whitespacesAndNewlines) {
	case "1": addStudent()
	case "2": viewStudents()
	case "3": searchStudents()
	case "4": updateStudent()
	case "5": deleteStudent()
	case "6": addScore()
	case "7": classReport()
	case "8": filterAndSort()
	case "0":
		print("Goodbye!")
		running = false
	default:
		print("Invalid option.")
	}
	if running { print() }
}
