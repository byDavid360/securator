#!/bin/bash

#################################################################################################################
######################################Script creado por byDavid360###############################################
####################################https://github.com/byDavid360################################################
#################################################################################################################

estilo=$(which figlet)
fecha=$(date)           #recojo la fecha en una variable para posteriormente incluirla en el fichero de contraseñas

#con este if inicial, comprobamos simplemente si figlet (libreria para crear titulo estetico)  esta instalado
if [ -n "$estilo" ]; then
        echo -e "\n"
        figlet Securator
else
        echo "Bienvenido a Securator"
fi

echo -e "Este script genera una contraseña aleatoria a partir de una longitud dada\nusando la libreria openssl y la guarda en el fichero securator.txt (creado automati$

#compruebo si esta openssl instalado
libreria=$(which openssl)

#funcion que me crea la contraseña. De este modo, puedo invocarla depues de la instalacion de openssl (en caso de que el usuario haya decidido instalarla)
crear_contrasenia(){

        echo -e "\nEscribe un concepto para la contraseña:"
        read concepto
        echo -e "\nIntroduce la longitud de la contraseña: "
        read longitud
        echo -e "\nContrasenia generada: "

        #editando el for, podriamos crear varias contraseñas a la vez
        for i in $(seq 1);
        do

                #guardo el comando que genera la contrasenia en una variable
                contrasenia=$(openssl rand -base64 48 | cut -c1-$longitud)

                #como lo guardé previamente en una variable, me es mas sencillo escribirlo de color rojo (cuestion estetica)
                echo -e "\e[1;31m$contrasenia\e[0m"
                echo -e "\n"
        done


#escribimos en el fichero securator.txt la fecha, el concepto y la propia contraseña.

        echo " " >> securator.txt
        echo "Fecha: $fecha" >> securator.txt
        echo "Concepto: $concepto" >> securator.txt
        echo "Contraseña: $contrasenia" >> securator.txt
        echo " " >> securator.txt
}

if [ -n "$libreria" ]; then

        crear_contrasenia

#si no esta instalada openssl, ofrecemos al usuario instalarla
else
        echo "Parece que la libreria openssl no esta instalada en tu equipo."
        echo "¿Deseas instalarla?"
        read respuesta

        if [ $respuesta = "si" ]; then
                sudo apt-get install openssl
                echo -e "\nLA LIBRERIA openssl SE HA INSTALADO EXITOSAMENTE.\n"
                crear_contrasenia       #invoco la funcion para crear la contraseña despues de haber instalado la libreria openssl
        else
                echo De acuerdo...
        fi
fi

