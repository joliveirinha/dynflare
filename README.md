# dynflare

![latest 1.0](https://img.shields.io/badge/latest-1.0-green.svg?style=flat)
[![Build Status](https://travis-ci.org/joliveirinha/dynflare.svg?branch=master)](https://travis-ci.org/joliveirinha/dynflare)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

`dynflare` is a docker application for continously updating the IP of a Cloudflare record to the public IP of the host running the docker container.

It is an ideal replacement of other dynamic IP services without requiring you to validate your dynamic ip service subscription every couple of weeks.

### Usage

```
docker run -d \
-e CF_API_EMAIL=LOGIN@EXAMPLE.COM \
-e CF_RECORD_ID=CLOUDFLARE_RECORD_IDENTIFIER \
-e CF_ZONE_NAME=CLOUDFLARE_ZONE \
-e CF_API_KEY=CF_API_KEY \
-e INTERVAL=60 \
joliveirinha/dynflare:latest
```

The `INTERVAL` variable specifies the amount of time spent between updates to cloudflare. 

If you don't know your Cloudflare DNS Record Identifier you can find it by executing the following:

```
docker run -it --entrypoint=flarectl \
-e CF_API_KEY=API_KEY \
-e CF_API_EMAIL=LOGIN@EXAMPLE.COM \
joliveirinha/dynflare:latest \
dns list example.com --name record.example.com
```

