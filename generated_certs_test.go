package certy

import (
	"crypto/x509"
	"testing"
)


func TestCertPool(t *testing.T) {
	if Certs == nil || len(Certs) == 0 {
		t.Fatalf("Generated certs are empty")
	}
	testPool := x509.NewCertPool()
	ok := testPool.AppendCertsFromPEM(Certs)
	if !ok {
		t.Fatalf("Unable to parse certs into cert pool.")
	}

	if len(testPool.Subjects()) == 0 {
		t.Fatalf("No certs added to pool from generated certs.")
	}
}
