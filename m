Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F113F39F1;
	Thu,  8 Oct 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445186; cv=none; b=QAlLLa9tPtbtEBNUtJdYy9zxGfv2iMx4qGZxztFlVbHFv+cHKLwio7JN4jktOFIjZ9fb6Y8UW6JJY66YPN5Ka9HH/PM9j9s/Erk6waOOUnmJH1pDJdba0d6CLbMpWUMvikjl6rOBGaE73OfKwOkGC2I+wlGIxOCi5ruQSb/IbmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445186; c=relaxed/simple;
	bh=6RX6Ha7kPUB8sNNvAOXfr063+YJKjjSX+xZ9Um78OdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DSq885RnzbuJhz3AxLiyqSCSQ19e3Ww1FdHEWp9nuj+SIkRfETGHVJEl1gYTtvzXDXatYsEWxGRRAfKKK+1JL6VSbgjOmmTxhuRPEDJ+teZp6msdirZRHGLh+9s42LECmSxOYXhflPg3hTawyktog/mHQNneeQoIF4gbIC+7aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=an44Yfvi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="an44Yfvi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6RX6Ha7kPUB8sNNvAOXfr063+YJKjjSX+xZ9Um78OdM=; b=an44YfvitkN5cyUoOwRZXuumhZ
	bsFMV914kG3YkVh8XNRWh7bqQ/mO1fC2v/aVO3G6iRHmWASY6yyAG13PbGtTstmBlXMKcu9cII4Fq
	mVUVx1/dVb4XlLEomaQpET6nVoCbmC28YLnOaZkTCei9MAWZezkKZWrEKUGGsOMRZaa8nT+xv8w4t
	YzuXgD/h6AEy8xWK8FOBn7dvFWL7MGKz3HqNeNHH2O+DXjNY71RO2MvNBPnC1ujoi9pPhL2PijVKO
	ocVKD1cFnzWwvSfJ8rhJuhoXGTF3AY9r7x47Ij+gcpdTmdhFYBIhgI2WZ6R40TUK4iNsiwh+0QMoQ
	vZNHhsAg==;
Received: from [54.239.6.186] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEiix-00000006Fqw-150A;
	Thu, 08 Oct 2026 07:39:31 +0000
Message-ID: <729dfdb236e4daaf2438b74d4d921993a156ec34.camel@infradead.org>
Subject: Re: [PATCH v2 04/21] srcutree: Add an atomic Tree SRCU
From: David Woodhouse <dwmw2@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Date: Thu, 08 Oct 2026 09:39:29 +0200
In-Reply-To: <20261007205924.1983367-4-paulmck@kernel.org>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
	 <20261007205924.1983367-4-paulmck@kernel.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-tfV42uwklNgo3QEc1dqS"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-tfV42uwklNgo3QEc1dqS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-07 at 13:59 -0700, Paul E. McKenney wrote:
> Some dedicated srcu_struct users have read-side critical sections
> which are short, never sleep, and never block on anything which may
> itself depend on memory allocation =E2=80=94 because they were, until
> recently, spinlock or rwlock critical sections. For such a domain the
> update side can safely wait for readers by spinning, from contexts
> where sleeping is undesirable or the grace-period machinery's
> latency (workqueue scheduling, jiffy-paced retries) dominates the
> actual reader drain time.
>=20
> But that is only safe if every reader keeps the promise. Make the
> promise explicit and machine-checkable:
>=20
> =C2=A0- srcu_read_lock_atomic() / srcu_read_unlock_atomic() enter the
> =C2=A0=C2=A0 usual (smp_mb-based) read-side critical section with preempt=
ion
> =C2=A0=C2=A0 disabled and (except in hardirq, where it is redundant)
> =C2=A0=C2=A0 non_block_start() armed, recording SRCU_READ_FLAVOR_ATOMIC i=
n the
> =C2=A0=C2=A0 per-CPU reader flavor. Disabling preemption enforces the
> =C2=A0=C2=A0 no-sleeping promise on every configuration and bounds the se=
ction,
> =C2=A0=C2=A0 so it is always running on some CPU; non_block_start() exten=
ds the
> =C2=A0=C2=A0 enforcement to even potentially-sleeping calls on paths whic=
h
> =C2=A0=C2=A0 happen not to block. The existing reader-flavor consistency =
checks
> =C2=A0=C2=A0 complain about any mixing with other flavors.
>=20
> =C2=A0- synchronize_srcu_atomic() waits for all pre-existing readers by
> =C2=A0=C2=A0 repeating the try_synchronize_srcu() both-epoch counter proo=
f with
> =C2=A0=C2=A0 cpu_relax() until it succeeds: no sleeping, no index flip, n=
o
> =C2=A0=C2=A0 grace-period sequence update, and therefore no interaction w=
ith
> =C2=A0=C2=A0 concurrent call_srcu(), synchronize_srcu() or srcu_barrier()=
. It
> =C2=A0=C2=A0 always provides the full grace-period guarantee: if the doma=
in
> =C2=A0=C2=A0 turns out to have had readers of any other flavor =E2=80=94 =
a caller bug,
> =C2=A0=C2=A0 since such a reader may be asleep and spinning on it would b=
e
> =C2=A0=C2=A0 unbounded =E2=80=94 it complains and falls back to a real (s=
leeping) grace
> =C2=A0=C2=A0 period internally, that being the only correct wait for a
> =C2=A0=C2=A0 possibly-sleeping reader. The flavor mask is rechecked on ev=
ery
> =C2=A0=C2=A0 iteration so a first non-atomic reader appearing mid-spin ta=
kes
> =C2=A0=C2=A0 the same path.
>=20
> The immediate motivation is the proposed conversion of KVM's
> gfn_to_pfn_cache to SRCU=C2=B9, whose mmu_notifier invalidation path drai=
ns
> readers before the primary MMU zaps a page. With the readers declared
> atomic, that drain becomes spin-only: no sleeping at all in the
> notifier, bounded by the longest reader section, satisfying even the
> strictest reading of the OOM-reaper non-blocking requirement without
> needing to touch the non_block_start() annotation=C2=B2.
>=20
> This commit also adds atomic-SRCU-specific initializers:
> init_srcu_struct_atomic(), DEFINE_SRCU_ATOMIC(), and
> DEFINE_STATIC_SRCU_ATOMIC().
>=20
> This commit implements only Tree SRCU.=C2=A0 Tiny SRCU will follow.
>=20
> =C2=B9 https://lore.kernel.org/all/20260811132237.102400-1-dwmw2@infradea=
d.org/
> =C2=B2 https://lore.kernel.org/all/20260812134934.GC662699@ziepe.ca/
>=20
> [ paulmck: Apply Kunwu Chan feedback. ]
>=20
> Co-developed-by: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> Assisted-by: Claude:claude-mythos-5
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Thank you for seeing this concept through to completion.

If it isn't already too late (i.e. if it hasn't already made it to a
tree where changing commit-ids is painful), please could you change my
attribution to use the dwmw@amazon.co.uk email address for both Co-
developed-by: and Signed-off-by: tags? I'm fairly sure you made up that
Signed-off-by: with the infradead address, which is naughty of you :)

I tell people you should only ever cut-and-paste SoB lines, because
that way the magic is intact. So here are the two you need for patches
4 and 5 of this series:

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks.

--=-tfV42uwklNgo3QEc1dqS
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
gIK3cH3Mwf2VE3B0j/fHSlsAAAAAAAA=


--=-tfV42uwklNgo3QEc1dqS--
