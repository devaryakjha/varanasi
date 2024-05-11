package extensions

func Last[T any](s []T) T {
	return (s)[len(s)-1]
}

func First[T any](s []T) T {
	return (s)[0]
}

func Filter[T any](s []T, f func(T) bool) []T {
	var r []T
	for _, v := range s {
		if f(v) {
			r = append(r, v)
		}
	}
	return r
}

func Map[T, U any](s []T, f func(T) U, limit int) []U {
	arrLen := len(s)
	if limit != 0 && arrLen > limit {
		arrLen = limit
	}
	r := make([]U, arrLen)
	for i := 0; i < arrLen; i++ {
		r[i] = f(s[i])
	}
	return r
}