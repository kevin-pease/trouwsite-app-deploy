#!/bin/sh

case $1 in
    "-install")
        while true; do
            read -p "Warning: subdirectory trouwsite-app will be permanently deleted. Continue? (y/n): " yn
            case $yn in
                [Yy]* ) 
                    sudo rm -r trouwsite-app
                    git clone https://github.com/kevin-pease/trouwsite-app.git
                    cp credentials.txt trouwsite-app
                    sudo systemctl start docker
                    # cp Dockerfile trouwsite-app
                    sudo docker-compose rm -fs
                    sudo docker-compose up --build -d 
                    break
                    ;;
                [Nn]* ) echo "Aborted deployment."
                    ;;
                * ) echo "Please answer 'y' or 'n'."
                    ;;
            esac
        done
        ;;
    "-all")
        sudo systemctl start docker
        sudo docker-compose rm -fs
        sudo docker-compose up --build -d 
        ;;
    "-stop")
        docker-compose rm -fs
        ;;
    "-shell")
        sudo docker exec -it trouwsite-app /bin/bash
        ;;
    "--help")
        echo "Usage:
        run -install      : clone from git repo, build and run containers using docker compose
        run -all          : run containers using docker compose
        run -shell        : shell into trouwsite-app container
        run -stop         : stop all running containers"
        ;;
    *)
        echo "Invalid arguments. Use run --help for more information on usage."
esac

