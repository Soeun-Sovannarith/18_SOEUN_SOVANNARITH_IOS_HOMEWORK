// Practice 3.1 — Tables and Lists

// 7 times table
for number in 1...10 {
    print("7 x \(number) = \(7 * number)")
}

print("")

// Course topics
let topics = ["Variables", "Conditionals", "Loops", "Collections"]

for i in 0..<topics.count {
    print("\(i + 1). \(topics[i])")
}

print("")


// Practice 3.2 — Study Timer

var minutes = 0
var sessions = 0

while minutes < 100 {
    minutes += 25
    sessions += 1
    
    print("Session \(sessions): \(minutes) minutes")
}

print("Goal reached in \(sessions) sessions.")

var countdown = 3

repeat {
    print("\(countdown)...")
    countdown -= 1
} while countdown > 0

print("Break time!")

print("")


// ========================================
// Practice 3.3 — Score Scanner
// ========================================

let scores = [78, 92, -5, 64, 101, 88, -1, 70]

var validScores = 0
var total = 0

for score in scores {
    
    if score == -1 {
        print("End marker found. Stopping.")
        break
    }
    
    if score < 0 || score > 100 {
        print("\(score) skipped (invalid)")
        continue
    }
    
    print("\(score) accepted")
    validScores += 1
    total += score
}

print("Valid scores: \(validScores)")
print("Total: \(total)")