# README

Simple indexer

# Dependencies

    brew install redis

Start background jobs

    QUEUE=* rake resque:work

## Run unit tests

    rake test

## Test API requests

### Kick start a indexing job

Start indexing of https://akshi.com

    curl -X POST -H "Content-type: application/vnd.api+json" "http://localhost:3000/urls" -d '{"data": {"attributes": {"href":"https://akshi.com"}, "type": "urls"} }'

### Query the indexing of a particular url

Search all indexing of https://akshi.com

    curl -H "Content-type: application/vnd.api+json" "http://localhost:3000/urls?filter[href]=https://akshi.com" -g

Search all indexing of https://akshi.com including headings and links

    curl -H "Content-type: application/vnd.api+json" "http://localhost:3000/urls?filter[href]=https://akshi.com&include=contents,links" -g
