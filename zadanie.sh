#!/bin/bash

# Funkcja do obliczania n-tego wyrazu ciągu Fibonacciego
fibonacci() {
    a=0
    b=1
    for (( i=2; i<=$1; i++ ))
    do
        fib=$((a + b))
        a=$b
        b=$fib
    done
    echo $b
}

# Funkcja do wyświetlania listy plików .txt
show_txt_files() {
    echo "Lista plików .txt:"
    find . -maxdepth 1 -type f -name "*.txt"
}

# Funkcja do odwracania zawartości pliku
reverse_file() {
    local filename="$1"
    if [[ -f "$filename" ]]; then
        # Wyświetlanie zawartości pliku
        cat "$filename"
        
        # Odwracanie zawartości pliku i zapisywanie w nowym pliku
        rev "$filename" > "$(dirname "$filename")/$(basename "$filename" .txt)_reversed.txt"
        echo "Zapisano odwróconą zawartość w pliku $(basename "$filename" .txt)_reversed.txt"
    else
        echo "Plik $filename nie istnieje."
    fi
}

# Sprawdzanie argumentów
if [[ "$1" == "-data" || "$1" == "--d" ]]; then
    # Wyświetlenie daty
    date
elif [[ "$1" == "-fib" || "$1" == "--f" ]]; then
    # Sprawdzenie, czy argument to liczba
    if [[ "$2" =~ ^[0-9]+$ ]] && [ "$2" -gt 0 ]; then
        # Wyświetlenie n-tego wyrazu ciągu Fibonacciego
        fibonacci "$2"
    else
        echo "Proszę podać liczbę naturalną jako argument."
    fi
elif [[ "$1" == "-pliki" || "$1" == "--p" ]]; then
    # Wyświetlenie plików .txt w bieżącym katalogu
    show_txt_files
elif [[ "$1" == "-zapis" || "$1" == "--z" ]]; then
    # Sprawdzenie, czy podano nazwę pliku
    if [[ -n "$2" ]]; then
        reverse_file "$2"
    else
        echo "Proszę podać nazwę pliku do zapisania."
    fi
elif [[ -z "$1" ]]; then
    # Wyświetlenie zawartości katalogu domowego, jeśli nie podano argumentu
    ls -l ~
else
    echo "Nieznany argument. Użyj: -data, -fib, -pliki, -zapis lub bez argumentu."
fi
