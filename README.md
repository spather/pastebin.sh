# pastebin.sh
Shell script to create a paste on pastebin.com

The implementation assumes your pastebin dev key and password are stored in the MacOS keychain. To set that up:

1. Log into pastebin and visit https://pastebin.com/doc_api#1 to get your unique developer key.

2. Save your developer key and password (the one you use to log into pastebin.com) in the keychain:

```
security add-generic-password -a {pastebin username} -s pastebin-api-devkey -w {pastebin api dev key}
security add-generic-password -a {pastebin username} -s pastebin -w {pastebin password}
```
