# Certy
A super, super simple certificate library that simply rips certificates from
mkcert.org

## Why would I want this?
If you don't know you probably don't want it.  

The main motivation for this is if you're building ultra small containers with
only go binaries and you don't want to install and copy over certs during the
docker build.

## How do I use it?
That's up to you, dawg!  
But, here's some obligatory boilerplate:
``` go
import (
    "crypto/x509"
    "net/http"

    "github.com/daihasso/certy"
)

func main() {
    pool := x509.NewCertPool()
    ok := pool.AppendCertsFromPEM(certy.Certs)
    if !ok {
        panic("You lied, these certs don't work at all!")
    }
    customHTTPClient := &http.Client{
        Transport: &http.Transport{
            TLSClientConfig: &tls.Config{RootCAs: pool},
        },
    }

    // ... Do cool stuff with certs here

    return
}
```

### That's cool, but I like, want these certs __everywhere__
That's probably dangerous man... But you do you:
``` go
import (
    "crypto/x509"
    "net/http"

    "github.com/daihasso/certy"
)

func init() {
    pool := x509.NewCertPool()
    ok := pool.AppendCertsFromPEM(certy.Certs)
    if !ok {
        panic("You lied, these certs don't work at all!")
    }
    defaultTransport := http.DefaultTransport.(*http.Transport)
    defaultTLSConfig := defaultTransport.TLSClientConfig

    if defaultTLSConfig == nil {
        defaultTransport.TLSClientConfig = &tls.Config{RootCAs: certPool}
    } else {
        existingPool := defaultTLSConfig.RootCAs
        if existingPool != nil {
            // Decide how to combine them.
        }

        defaultTLSConfig.RootCAs = certPool
    }
}
```

