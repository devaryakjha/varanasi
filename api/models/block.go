package models

type Block struct {
	Title string `json:"title"`
	Children []Media `json:"children"`
}
