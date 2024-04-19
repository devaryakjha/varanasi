package models

type Page struct {
	Title string `json:"title"`
	Blocks []Block `json:"blocks"`
}