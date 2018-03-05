package main

import (
	"gopkg.in/ini.v1"
	"fmt"
)

func main(){
	cfg, err := ini.Load("sample.ini")
	if err != nil{
		panic(err)
	}
	sec, err := cfg.GetSection("hoge")
	if err != nil{
		panic(err)
	}
	key, err := sec.GetKey("fuga")
	if err != nil{
		panic(err)
	}
	fmt.Printf(key.String())

}