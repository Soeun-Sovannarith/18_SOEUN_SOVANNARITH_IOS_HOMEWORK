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
