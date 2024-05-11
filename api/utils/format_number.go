package utils

import (
	"golang.org/x/text/language"
	"golang.org/x/text/message"
)

func FormatNumber(number int) string {
	p := message.NewPrinter(language.English)
	return p.Sprintf("%d", number)
}