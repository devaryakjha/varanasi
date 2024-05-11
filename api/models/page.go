package models

type Page struct {
	Title string `json:"title"`
	Blocks []Block `json:"blocks"`
	Paginated bool `json:"paginated"`
	Children []Media `json:"children"`
	Sequence int `json:"sequence"`
}