#!/bin/bash

env() {
    read -p "Bitte gebe die Server Adresse ein.
" host
    read -p "Bitte gebe dein Benutzernamen ein.
" user
    read -p "Bitte geb jetzt dein Passwort ein.
" password

    echo -e "FTP_PORT=21\nFTP_HOST=$host\nFTP_USER=$user\nFTP_PWD=$password" > .env
}

echo ""
echo "Hallo ich helfe dir kurz bei der Einrichtung deines neuen Webprojekts."
echo ""
sleep 1

while true
    do
        read -p "Wie soll dein neues Projekt heißen?
" projektname
        if [ -n "$projektname" ]
            then
                if [ ! -d "$projektname" ]
                    then
                        echo ""
                        echo "Super! Das Projekt wurde auf $projektname getauft."
                        echo ""
                        sleep 2.5
                        break
                        
                    else 
                        echo ""
                        echo "Es exestiert schon ein Ornder mit dem namen: $projektname"   
                        sleep 0.5
                        echo "Auf ein neues." 
                        echo ""
                        
                fi
            else
                echo ""
                echo "Keine Eingabe erkannt!!!"
                sleep 0.5
                echo ""
        fi  
done

# Hier wird der Projektordner angelegt
mkdir $projektname
cd $projektname

# Abfrage ob ftp Daten erstellt werden sollen
while true
    do
    read -p "Soll ich dir auch die .env datei anlegen,\n diese wird für die FTP Verbindung benötigt Yes(y) No(n).
" ftpcon
    case $ftpcon in
        [YyJj]* ) env; break;;
        [NnJj]* ) break;;
        * ) echo "Bitte antworte mit y für ja und n für nein"
    esac
done

echo ""
echo "Ich lade jetzt kurz alles was du brauchst und instaliere es.
Dies kann einige Minuten dauern."
sleep 2

# Lädt das aktuelle Gulpfile
gist="7617c5ca5943f482b0d8612d87ce778a"
git clone https://gist.github.com/$gist.git 
mv $gist/* ./ && rm -rf $gist

if [ -e "package.json" ] 
    then
        npm install --silent
    else
        echo "Ich konnte keine package.json Datei finden, ich breche jetzt ab."
        exit 1
fi

# Installiert alle abhängigkeiten
#npm install --silent 

# Gitignore anlegen
echo -e "node_modules\n.env" > .gitignore

# Erstellt die Ordnerstruktur
mkdir files
mkdir files/theme
mkdir files/theme/src
cd files/theme/src
mkdir js scss assets
mkdir assets/img
cd scss
touch main.scss
mkdir base abstract vendors components layouts pages
cd ../js
touch index.js
mkdir vendors
cd ../../../

# Fertig
echo "Es sind alle Packet installiert"
sleep 1
echo "Du Findest dein Projekt unter $PWD"
sleep 1
echo "Möge die macht mit dir sein."
