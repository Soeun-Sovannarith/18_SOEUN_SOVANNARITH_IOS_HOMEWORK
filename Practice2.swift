let score = 82
let attendance = 95
let gpa = 3.6

var grade = ""

// Grade
if score >= 90 {
    grade = "A"
} else if score >= 80 {
    grade = "B"
} else if score >= 70 {
    grade = "C"
} else if score >= 50 {
    grade = "D"
} else {
    grade = "F"
}

print("Score: \(score)")
print("Grade: \(grade)")

// Result
if score >= 50 {
    print("Result: Pass")
} else {
    print("Result: Fail")
}

// Message
switch grade {
case "A":
    print("Message: Excellent!")
case "B", "C":
    print("Message: Good work, keep going!")
case "D":
    print("Message: You passed. Aim higher next time.")
default:
    print("Message: Please see your instructor.")
}

// Scholarship
if gpa >= 3.5 && attendance >= 90 {
    print("Scholarship: Eligible")
} else {
    print("Scholarship: Not eligible")
}

// Warning
if attendance < 75 || score < 50 {
    print("Warning: At risk")
} else {
    print("Warning: None")
}