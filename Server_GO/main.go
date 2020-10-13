package main

import (
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

func YourHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Gorilla!\n"))
}

func YourHandler2(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Gorilla 2222!\n"))
}

func main() {
	r := mux.NewRouter()
	// Routes consist of a path and a handler function.
	r.HandleFunc("/", YourHandler)
	r.HandleFunc("/products/", YourHandler2)

	// Bind to a port and pass our router in
	log.Fatal(http.ListenAndServe(":8000", r))
}
