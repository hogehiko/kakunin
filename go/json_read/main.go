package main
import (
	"fmt"
	"encoding/json"
	"log"
	)

type MyStruct struct{
	Name string `json:"name"`
}

func main(){
	var st MyStruct
	data := `
{"name": "hoge", "age":35}
`
	fmt.Printf("%v", []byte(data))
	if err:=json.Unmarshal([]byte(data), &st); err!=nil{
		log.Fatal(err)
	}
	fmt.Printf(st.Name)
}