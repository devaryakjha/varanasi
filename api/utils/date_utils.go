package utils

import "time"

func ParseDate(date string) (time.Time, error) {
	return time.Parse("02-01-2006", date)
}

func FormatDate(date time.Time, err error) string {
	if err != nil {
		return ""
	}
	return date.Format("January 2, 2006")
}