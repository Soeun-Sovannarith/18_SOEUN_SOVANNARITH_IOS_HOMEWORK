# Student Academic Management System

## Run

From the `Project` directory:

```bash
swiftc main.swift -o academic-manager
./academic-manager
```

The app is interactive and reads input with `readLine()`. It can also be opened as an Xcode Command Line Tool.

## Design choices

- `struct Student` models one student. Its computed `average` and `grade` keep derived values close to the data they describe.
- `[Int: Student]` stores students by ID, making exact lookup, updates, duplicate checks, and deletion direct and efficient.
- `while` loops repeat input until valid data is entered, while `switch` dispatches menu choices and grade ranges.
- `guard` provides early validation exits, and `ValidationError` gives specific, reusable error messages.
- `filter`, `sorted`, `compactMap`, and `reduce` express searching, filtering, ordering, and report calculations clearly.
- Optional `String?` email and optional `Double?` average represent information that may be absent without using fake values.

## Explanation slides

### Slide 1: Structs and computed properties

```swift
struct Student {
	let id: Int
	var scores: [Int]

	var average: Double? {
		guard !scores.isEmpty else { return nil }
		return Double(scores.reduce(0, +)) / Double(scores.count)
	}
}
```

Why did I use it here? A struct groups a student's related values. The computed property calculates the average whenever it is needed, so the stored data cannot become inconsistent with a separately stored average.

### Slide 2: Dictionary storage

```swift
var students: [Int: Student] = [:]
let student = students[id]
```

Why did I use it here? The ID is unique and is the main lookup key. A dictionary makes finding, updating, checking duplicates, and deleting a student direct and avoids scanning every student.

### Slide 3: Optionals and guard

```swift
guard let average else { return "—" }
```

Why did I use it here? A student may have no scores, so there is no meaningful numeric average. `Double?` models that absence explicitly, and `guard` handles it safely in reports.

### Slide 4: Loops and readLine validation

```swift
while true {
	let input = readLine() ?? ""
	guard let value = Int(input) else { continue }
	return value
}
```

Why did I use it here? User input is unpredictable. The loop asks again after invalid input, and `readLine()` is optional because input can end unexpectedly.

### Slide 5: Switch and ranges

```swift
switch average {
case 90...100: return "A"
case 80..<90: return "B"
default: return "F"
}
```

Why did I use it here? Grade boundaries are ordered ranges. A `switch` makes each rule visible and prevents a long chain of overlapping conditions.

### Slide 6: Higher-order collection methods

```swift
let matches = students.values.filter {
	$0.name.localizedCaseInsensitiveContains(query)
}
```

Why did I use it here? `filter` describes the search operation directly and keeps the code focused on the condition rather than manual index management. The same style is used for reports and sorting.
