package main

import (
	"fmt"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	now := time.Now().Format(time.RFC1123)
	fmt.Fprintf(w, "Current date & time: %s\n", now)
}

func main() {
	http.HandleFunc("/", handler)
	addr := ":8080"
	fmt.Println("Starting server on", addr)
	if err := http.ListenAndServe(addr, nil); err != nil {
		fmt.Println("Server error:", err)
	}
}
