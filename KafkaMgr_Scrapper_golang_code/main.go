package main

import (
	"os"
)

// define url
// var url = string(os.Args[1]) // To pass the topics url on the argument 1
var topicsUrl = "https://localhost:9001/th/cmak/clusters/transformation-hub/topics"

// var consumersUrl = string(os.Args[2]) // To pass the topics url on the argument 1
var consumersUrl = "https://127.0.0.1:9001/th/cmak/clusters/transformation-hub/consumers"

func main() {
	topicScrapper()
	consumerScrapper()
}

// Check errors
func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}

// Check passed arguments
func ChechArgLen(ar []string) {
	if len(ar) != 2 {
		os.Exit(1)
	}
}
