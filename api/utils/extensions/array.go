package extensions

func Last[T any](s []T) T {
	return (s)[len(s)-1]
}

func First[T any](s []T) T {
	return (s)[0]
}
