package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"

	_ "github.com/mattn/go-sqlite3"

	"html/template"
)

type Contact struct {
	FirstName       string
	MiddleName      string
	LastName        string
	Department      string
	Corporation     string
	WorkPhone       string
	MobilePhone     string
	Mail            string
	Photo           string
	Gender          string
	Status          string
	StatusBegin     string
	StatusEnd       string
	Position        string
	Id              int
	ServiceNumber   sql.NullString
	CodeNumber      sql.NullString
	Additionals     int
	Base            sql.NullString
	LFIO            string
	LDepartment     string
	LCorporation    string
	BirthDate       string
	IdMan           string
	AdditionalPhone string
}

type TodoPageData struct {
	PageTitle   string
	ContactList []Contact
}

type Contact_data struct {
	Count       int
	ContactList []Contact
}

func MainPageHandler(w http.ResponseWriter, r *http.Request) {
	t, err := template.ParseFiles("html/index.html")
	if err != nil {
		fmt.Fprintf(w, err.Error())
	}
	t.Execute(w, nil)

}

func respondWithJSON(w http.ResponseWriter, code int, payload interface{}) {
	response, _ := json.Marshal(payload)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	w.Write(response)
}

func ContactsHandler(w http.ResponseWriter, r *http.Request) {
	t, _ := template.ParseFiles("html/contacts.html")

	db, err := sql.Open("sqlite3", "data_base/database.sqlite3")
	if err != nil {
		panic(err)
	}
	defer db.Close()
	rows, err := db.Query("SELECT last_name, id FROM Contacts")
	if err != nil {
		panic(err)
	}
	defer rows.Close()
	Contacts := []Contact{}

	for rows.Next() {
		p := Contact{}
		err := rows.Scan(&p.LastName, &p.Id)
		if err != nil {
			fmt.Println(err)
			continue
		}
		Contacts = append(Contacts, p)
	}
	/*
		for _, p := range Contacts {
			fmt.Println(p.last_name, p.id)
		}
	*/

	data := TodoPageData{
		PageTitle:   "Contacts list",
		ContactList: Contacts,
	}

	for _, p := range data.ContactList {
		fmt.Println("ContactList " + p.LastName)
	}

	t.Execute(w, data)

}

func main() {

	r := mux.NewRouter()
	// Routes consist of a path and a handler function.
	r.HandleFunc("/", MainPageHandler)
	r.HandleFunc("/contacts/", ContactsHandler)
	r.HandleFunc("/contacts_2/", getUsers)
	r.HandleFunc("/corporation/", getCorporations)
	r.HandleFunc("/department/", getDepartaments)
	r.HandleFunc("/searchcontacts/", getContacts)

	// Bind to a port and pass our router in
	log.Fatal(http.ListenAndServe(":8000", r))

}

func getUsers(w http.ResponseWriter, r *http.Request) {

	var contacts_count int

	count, _ := strconv.Atoi(r.FormValue("count"))
	limit, _ := strconv.Atoi(r.FormValue("limit"))

	//fmt.Println("count " + strconv.Itoa(count))
	//fmt.Println("limit " + strconv.Itoa(limit))

	selection_contacts := fmt.Sprintf("SELECT first_name as FirstName, middle_name as MiddleName, last_name as LastName, department, corporation, work_phone, mobile_phone, mail, photo, gender, status, status_begin, status_end, position, id, service_number, code_number, additionals, base, l_FIO, l_department, l_corporation, birth_date, id_man, additional_phone FROM Contacts ORDER BY l_FIO ASC LIMIT %d, %d", count, limit)
	selection_count_contacts := fmt.Sprintf("SELECT COUNT(*) as count FROM Contacts")

	db, err := sql.Open("sqlite3", "data_base/database.sqlite3")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	rows, err := db.Query(selection_contacts)
	if err != nil {
		fmt.Println(err)
	}
	defer rows.Close()

	Contacts := []Contact{}

	for rows.Next() {
		p := Contact{}
		err := rows.Scan(&p.FirstName, &p.MiddleName, &p.LastName, &p.Department, &p.Corporation, &p.WorkPhone, &p.MobilePhone, &p.Mail, &p.Photo, &p.Gender, &p.Status, &p.StatusBegin, &p.StatusEnd, &p.Position, &p.Id, &p.ServiceNumber, &p.CodeNumber, &p.Additionals, &p.Base, &p.LFIO, &p.LDepartment, &p.LCorporation, &p.BirthDate, &p.IdMan, &p.AdditionalPhone)

		if err != nil {
			fmt.Println(err)
			continue
		}
		Contacts = append(Contacts, p)
	}

	///////////////////////
	///count
	//////////////////

	rows_count, err := db.Query(selection_count_contacts)
	if err != nil {
		fmt.Println(err)
	}
	defer rows_count.Close()

	for rows_count.Next() {
		err := rows_count.Scan(&contacts_count)
		if err != nil {
			fmt.Println(err)
			continue
		}

	}

	data := Contact_data{
		Count:       contacts_count,
		ContactList: Contacts,
	}
	/*
		for _, p := range data.ContactList {
			fmt.Println("ContactList " + p.LastName)
		}
	*/
	respondWithJSON(w, http.StatusOK, data)

}

func getCorporations(w http.ResponseWriter, r *http.Request) {
	var Corporation string
	var Corporations []string

	selectionCorporation := fmt.Sprintf("SELECT 'All' UNION SELECT corporation FROM Contacts where corporation <> '' GROUP BY corporation ORDER BY corporation")

	db, err := sql.Open("sqlite3", "data_base/database.sqlite3")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	rows, err := db.Query(selectionCorporation)
	if err != nil {
		fmt.Println(err)
	}
	defer rows.Close()

	for rows.Next() {

		err := rows.Scan(&Corporation)

		if err != nil {
			fmt.Println(err)
			continue
		}
		Corporations = append(Corporations, Corporation)
	}

	respondWithJSON(w, http.StatusOK, Corporations)

}

func getDepartaments(w http.ResponseWriter, r *http.Request) {
	var Department string
	var Departments []string

	selectionDepartment := fmt.Sprintf("SELECT 'All' UNION SELECT department FROM Contacts where department <> '' GROUP BY department ORDER BY department ")

	db, err := sql.Open("sqlite3", "data_base/database.sqlite3")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	rows, err := db.Query(selectionDepartment)
	if err != nil {
		fmt.Println(err)
	}
	defer rows.Close()

	for rows.Next() {

		err := rows.Scan(&Department)

		if err != nil {
			fmt.Println(err)
			continue
		}
		Departments = append(Departments, Department)
	}

	respondWithJSON(w, http.StatusOK, Departments)

}

func getContacts(w http.ResponseWriter, r *http.Request) {
	fmt.Println("r-request")
	b, _ := ioutil.ReadAll(r.Body)
	fmt.Printf("%s \n", string(b))

}
