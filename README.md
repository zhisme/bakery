## Description
Each order has a series of lines with each line containing the number of items followed by the product code. An example input:
10 VS5
14 MB11
13 CF

A successfully passing test(s) that demonstrates the following output: 
10 VS5 $17.98
2 x 5 $8.99 
14 MB11 $54.8
1 x 8 $24.95
3 x 2 $9.95 
13 CF $25.85
2 x 5 $9.95 
1 x 3 $5.95

## Setup
`bundle install`

## Running
`bin/run.rb path/to/test.txt`

or

```
bin/run.rb
pass your values
```

## Testing
`bundle exec rspec`
