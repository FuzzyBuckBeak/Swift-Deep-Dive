import UIKit

var str = "Hello, playground"
struct Origin {
    let x: Int
    let y: Int
}

struct Size {
    let length: Int
    let breadth: Int
}
struct Rectangle {
    var origin: Origin
    let size: Size
}

//extension Rectangle {
//    mutating func translate(offset: Origin) {
//        origin = origin + offset
//    }
//}

func playMusic(randomizer: @escaping () -> String) {
    let music = randomizer
    print("\(music) is playing.")
}
playMusic {
    print("Sorry, I only have one playlist!")
    return "Taylor Swift"
}
