package main

import "fmt"

func main(){
	str1 := "hoge"
	strp1 := &str1
	fmt.Printf(*strp1)
	*strp1 = "fuga"

	fmt.Printf(*strp1)
}