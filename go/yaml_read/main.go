package main

import "gopkg.in/yaml.v2"
import "fmt"
import "log"

// MyStruct is here
type MyStruct struct{
	Name string `yaml:"name"`
}
func main(){
	data := `
name: hoge
name1: fuga
`
	result := MyStruct{}
	if err:=yaml.Unmarshal([]byte(data), &result); err!=nil{
		
		log.Fatal(err)
	}
	fmt.Println("hoge")
	fmt.Printf("%v", result)
	fmt.Println("fuga")

}