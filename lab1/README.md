Project
---
Chat on Ruby using sockets that support multiple users

Requirements
---
- Ruby >= 2.6.3
  - Download from https://www.ruby-lang.org/
  - Instalation guide: https://www.ruby-lang.org/en/documentation/installation/

How to start it?
---
This chat uses enviroment variables that you can set into your terminal configuraton file or inline.
For more information on how to set enviroment variables read: [How To Set Environment Variables by Dominik Kundel on Twilio Blog](https://www.twilio.com/blog/2017/01/how-to-set-environment-variables.html)

Environment Variables
----
- **CPORT**: Refeers to the port where the server gonna listen
- **CSIP**: Refeers to the server IP address

Server
-----
- With Environment Variables created on the system
  ``` sh
  $ ruby server.rb
  ```
- Enviroment Variables inline
  ``` sh
  $ CPORT=3030 ruby server.rb
  ```

Client
----
- With Environment Variables created on the system
  ``` sh
  $ ruby client.rb
  ```
- Enviroment Variables inline
  ``` sh
  $ CSIP=127.0.0.1 CPORT=3030 ruby client.rb
  ```

Copyright
---
Based on post: [TCP chat app with ruby by Sushant Bajracharya](https://dev.to/sushant12/tcp-chat-app-with-ruby-i88)