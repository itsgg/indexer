# README

Simple indexer

# Dependencies

    brew install redis

Start background jobs

    QUEUE=* rake resque:work

## Test API requests

### Kick start a indexing job

    curl -X POST -H "Content-type: application/vnd.api+json" http://localhost:3000/urls -d '{"data": {"attributes": {"href":"http://akshi.com"}, "type": "urls"} }'

### Query the indexing of a particular url

    curl -H "Content-type: application/vnd.api+json" http://localhost:3000/urls?filter[href]=http://akshi.com -g
