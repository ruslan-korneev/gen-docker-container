gen-container() {
  while true; do
    read "container?Which container do you want to run? (postgres, redis, quit): "
    case $container in
      postgres)
        echo "Creating a Postgres container."

        read "project?Enter your project name: "
        read "username?Enter your Postgres user name: "
        read -s "password?Enter your Postgres password: "
        echo ""
        read "port?Enter your external port number: "
        echo ""

        echo "Creating volume..."
        docker volume create $project-db
        echo "Creating container..."
        docker run \
            -d --name $project-db \
            -p $port:5432 \
            -e POSTGRES_DB=$project \
            -e POSTGRES_USER=$username \
            -e POSTGRES_PASSWORD=$password \
            -v $project-db:/var/lib/postgresql/data \
            postgres:16
        ;;
      redis)
        echo "Creating a Redis container."

        read "project?Enter your project name: "
        read "port?Enter your external port number: "
        echo ""

        echo "Creating volume..."
        docker volume create ${project}-redis
        echo "Creating container..."
        docker run -d --name ${project}-redis -p ${port}:6379 -v ${project}-redis:/data redis:alpine
        ;;
      quit)
        echo "Exiting..."
        break
        ;;
      *)
        echo "Please answer with postgres, redis, or quit."
        ;;
    esac
  done
}
