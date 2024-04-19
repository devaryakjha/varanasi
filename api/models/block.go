package models

type Orientation string

const (
	Vertical Orientation = "vertical"
	Horizontal Orientation = "horizontal"
)

type Block struct {
	Title string `json:"title"`
	Children []Media `json:"children"`
	Orientation Orientation `json:"orientation"`
}
