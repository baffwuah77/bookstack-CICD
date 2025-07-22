
---

    ### 2. `bookstack/Dockerfile`
    
    ```Dockerfile
    FROM linuxserver/bookstack
    
    ARG APP_URL
    ARG DB_HOST
    ARG DB_DATABASE
    ARG DB_USERNAME
    ARG DB_PASSWORD
    
    ENV APP_URL=$APP_URL \
        DB_HOST=$DB_HOST \
        DB_DATABASE=$DB_DATABASE \
        DB_USERNAME=$DB_USERNAME \
        DB_PASSWORD=$DB_PASSWORD
    