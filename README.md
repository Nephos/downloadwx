# downloadwx

Multi-File download via web api.

## Installation

```
make
```

### Requirements

- crystal ``v0.23``
- wget


## Usage

```
./downloadwx --port 3000 --listen 127.0.0.1
```

### Inside a docker

If you are using docker-compose:
```sh
docker-compose build && docker-compose up
```

Else, you can do:
```sh
docker build -t downloadwx . && docker run downloadwx
```

### API HTTP

- ``GET /``: list all downloads
- ``GET /add/:base64``: start a download
- ``POST /add``: start a download with the param ``url``
- ``GET /pause/:id``: pause a download
- ``GET /resume/:id``: resume a download

## Development

### TODO

- handle download by segment
- use only curl
- handle speed limitations and priorities (see TC)

## Contributing

1. Fork it ( https://github.com/Nephos/downloadwx/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Nephos](https://github.com/Nephos) Arthur Poulet - creator, maintainer
