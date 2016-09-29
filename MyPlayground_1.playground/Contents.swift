//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var balance :Int  = 0
balance =  1_00_00_000


var distance : Double = 2.5

balance = Int(distance)

var dateWithTemp : (day:Int, month:Int, year:Int, averageTemperature: Double) = (3,2,2016,35.5)

let day = dateWithTemp.day

let (x,_,_,temp)  = dateWithTemp



let tuple = (1,2)

let anotherTuple = tuple

let firstValue = tuple.0

let testNumber :Int = 10
let evenOdd = testNumber % 2;

var answer = 0
answer += 11;

answer *= 10

answer >>= 3


let coordinate = (2,3)

let sameCoordinate = (2,3)

let anotheCoordinate = (3,4)

coordinate == sameCoordinate


coordinate < anotheCoordinate

let stringA = "café"
let stringB = "cafe\u{0301}"

let count1 = stringA.characters.count
let count2 = stringB.characters.count


if 2 < 3 {
print ("True")
}

let number = 10
switch (number) {
case let x where x % 2 == 0:
    print("Even \(x)")
default:
    print("Odd")
}

let coordinate3D = (0,0,0)

switch (coordinate3D) {
case (0,0,0) :
    print("Origin")
case (_,0,_) :
    print("On Y Axis")
case (0,_,_) :
    print("On X axis")
    
default :
    print("Somewhere in space")
}

let closedRange = 0...5
let halfRange = 0..<5

let hour = 6

switch (hour) {
    case 0...5:
    print("Early Morning")
case 6...11:
    print("Morning")
case 12...16:
    print("Afternoon")
case 17...24:
    print("Night")
    default :
    print("Invalid Hour")
}
var sum = 0
for i in 1...10 {
    sum += i
}


var i = 0
while i<10 {
    print(i)
    i += 1
}
print()
var j = 0
repeat {
print(j)
    j += 1
    if( j == 5){
        break
    }
} while j<10

print()
rowloop : for i in 1...10
        {
        columnloop:  for j in 1...10 {
                if i == j {
                    continue rowloop
                }
                print("\t\(j)\t")
            
            }
            print()
        }

var charOfA = ""

while charOfA.characters.count < 10 {
    charOfA += "A"
    print(charOfA)
}

func multiply(number a :Int, byNumber b: Int) -> Int {
    return a*b

}


multiply(number: 10, byNumber: 10)



func incrementAndPrint(inout a :Int, by value: Int) {
    a += value
    print(a)
}

var value = 10
incrementAndPrint(&value, by: 2)

func printFullName (firstName: String, _ lastName: String) {
    print("\(firstName) \(lastName)")
}




printFullName("Balaji", "Vadlamani")





func fullName (firstName: String, _ lastName: String) -> String {
    return firstName + " " + lastName
    
}

let myName = fullName("Balaji", "V")





func calculateFullName (firstName: String, _ lastName: String) -> (fullName: String, length: Int) {
    let fullName = firstName + " " + lastName
    return (fullName,fullName.characters.count)
}

let retValue = calculateFullName("Balaji", "V")

func add (number1 :Int, and number2: Int) -> Int {
    return number1 + number2
}

func subtract (number1 :Int, and number2: Int) -> Int {
    return number1 - number2
}

let addFunc : (Int, Int) -> Int = add

let result = addFunc(1,2)



func printResult (function : (Int,Int) ->Int, number1: Int, and number2:Int) {
    
    let result = function(number1, number2)
    print(result)
    
}


printResult(add, number1: 2, and: 3)

printResult(subtract, number1: 2, and: 3)

func isPrimeNumber(number :Int) -> Bool {
    
    if (number % 2 != 0) {
        
    }
    
    return false
}


let multiplyClosure : (Int, Int) ->Int

multiplyClosure = { (a , b)  in
    a * b
    
}

multiplyClosure(14,14)


func operateOnNumbers(a: Int, b: Int, operation: (Int,Int)->Int) ->Int {
    let result = operation(a,b)
    return result
}

operateOnNumbers(14, b: 14) { (a, b) in
    a*b
}

operateOnNumbers(14, b: 1) { (a, b) -> Int in
    a>>b
}

var sayHello : () -> Void = {
    print("Hello")
}

sayHello()


func fetchData(request :NSURL, completionHandler: (response : NSHTTPURLResponse) -> NSArray)
{
    
}
let url = NSURL(string:"http://google.com")
fetchData(url!) { (response) in
    return NSArray()
}

var setA : NSMutableSet = NSMutableSet(objects:"1","2","3","4","5" )

let setB : NSSet = NSSet(objects:"1","2","3")


setA.minusSet(setB as Set<NSObject>)

print(setA)

var myFavSong : String?

myFavSong = "rocking"

myFavSong  = nil

if let song = myFavSong  {
    myFavSong = nil
} else {
    myFavSong = "song1";
}
print(myFavSong!)

var authorName : String?

authorName = "Balaji"

var authorAge :Int? = 28

if let name = authorName, age = authorAge {
    print("name: \(name) age: \(age)")
}

let name = authorName ?? ""

print(name)

func divideIfWhole( number1:Int, number2:Int) -> Int? {
    let reminder = number1 % number2
    if  reminder == 0 {
        return number1 / number2
    }
    return nil
}

if let number = divideIfWhole(10, number2: 3) {
    print("Yep It devides \(number) times")
    
 } else {
    print("Not divisible :[")
}

let number1 = divideIfWhole(10, number2: 3) ??  0 ;

print("Yep It devides \(number1) times")




let list = Array<Int>()

let anotherList = [Int]() //alternate syntax

let  evenNumbers = [2,4,6,8,10]

let allZeros = [Int](count:5, repeatedValue:0)



var players = ["Alice", "Bob", "Cindy", "Dan"]

print(players.isEmpty)
print(players.first!)

print(players[3])

let upcomingPlayers = players[1...2]

print(players.contains("Bob"))

players.append("Eli")

players += ["Gina","Steve"]


players.insert("Frank", atIndex: 5)

players.removeLast()

let danPosition = players.indexOf("Dan")

players[5] = "Franklin"

players[0...1] = ["Bryan","Hemo"]

print(players)

players = players.sort()

for (index, player) in players.enumerate() {
    print("\(index+1). \(player)")
}

var scores = [4,2,8,5,9,3,6]

let totalScore = scores.reduce(0, combine: +)

print(scores.filter({  $0 > 4 }))

//give bonus score

let newScores = scores.map { $0 * 2}

print(newScores)

let array1 = [Int]()
let array2 = [1,2]
print(array2)

let array3: [String] = []




func removeOnce(itemToRemove: Int, fromArray: [Int]) -> [Int] {
    var anotherArray = fromArray
    if let index = anotherArray.indexOf(itemToRemove) {
        anotherArray.removeAtIndex(index)
    }
    return anotherArray

}


let resultArray = removeOnce(2, fromArray: [2,4,3,2,5,6])


func remove(itemToRemove: Int, fromArray: [Int]) -> [Int] {
    var anotherArray = fromArray

    anotherArray = anotherArray.filter { itemToRemove != $0
   
    }
    
    
    return anotherArray
}


let resultArray2 = remove(2,fromArray: [2,4,3,2,5,6]);


func reverse(array: [Int]) -> [Int] {
    var tempArray = array
    var leftIndex = 0, rightIndex = tempArray.count-1
    while  (leftIndex < rightIndex)
    {
        let temp = tempArray[leftIndex]
        tempArray[leftIndex] = tempArray[rightIndex]
        tempArray[rightIndex] = temp
        leftIndex += 1
        rightIndex -= 1
    }
    return tempArray
}


let reversedArray = reverse([1,2,3,4,5,6])


func randomFromZeroTo(number: Int) -> Int {
    return Int(arc4random_uniform(UInt32(number)))
}


func shuffleArray(array:[Int]) -> [Int] {
    var tempArray = [Int](count:array.count, repeatedValue:0)
    
    for number in  array {
        
        for _ in tempArray {
            let randomIndex = randomFromZeroTo(array.count)
            if tempArray[randomIndex] == 0 {
                tempArray[randomIndex] = number
                break
            }
        }
        
    }
    
    return tempArray
}

shuffleArray([1,2,3,4,5])
















