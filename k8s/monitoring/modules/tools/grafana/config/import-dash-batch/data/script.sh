for file in *-datasource.json ; do
    if [ -e "$file" ] ; then
        echo "importing $file" &&
        curl --silent --fail --show-error \
        --request POST http://admin:admin@grafana/api/datasources \
        --header "Content-Type: application/json" \
        --header "Accept: application/json" \
        --data-binary "@$file" ;
        echo "" ;
    fi
done ;
for file in *-dashboard.json ; do
    if [ -e "$file" ] ; then
        echo "importing $file" &&
        curl --silent --fail --show-error \
        --request POST http://admin:admin@grafana/api/dashboards/import \
        --header "Content-Type: application/json" \
        --header "Accept: application/json" \
        --data-binary "@$file" ;
        echo "" ;
    fi
done ;