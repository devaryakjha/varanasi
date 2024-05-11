package utils

import "fmt"

func CreateSubtitleFromFollowerCount(followerCount int) string {
	// This function creates a subtitle from the follower count
	// e.g. 43236993 followers -> 43,236,993 Fans
	return fmt.Sprintf("%s Fans", FormatNumber(followerCount))
}

