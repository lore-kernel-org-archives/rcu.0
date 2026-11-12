Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794448438;
	b=jZDUkeQ1QL3N3O2BKSPY76QpUNOxMuP6WTSp2YkHfjGpyPfKofL8IiToVe9vtKUhPgAy
	 /afjHEoj6afKNuw9eRB8L3pERXSDdBuNFJyJQjKvVaRvfn+xLHrZe4xHeBm7NP1TTv6nK
	 wXqkA+/fqtdOmOew8CznEp1lOy6Uz96UsjP5o++QNZ5vk4g8CYxuVhv63UJNPlZ75fdn6
	 elVbEfQcb0tCNotaBZrRK5gT95mdBPqEoQ81ZxMwEOtp2OXxHa7Uk+hvGOHVL1b1iJCO3
	 xG6FMnx9yMHUAfVuRoC6fOniVkX1+V5Dg84Om5+m/00gdoIDASpqingKEqhqKYEAmhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794448438;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=Qs+dUUmGwoCW9p8QsDKZPJUx5Tg8JM0cwaUKiiVMTwc=;
	b=m8FBm/Mw7MVtYcJcjKFLkOiGchqCHIripqHl/DVCJaCZSPl2672oHvtC+1sFOdWmMr3N
	 pXLwkTbG6cPkdpEOBaoo0Tjnln9/5mwj4DSg44eLNQNpSA9ep10e8QU4IuKjC3uZPkeRE
	 LcjV93BQKIBqiNjsSSqtFitw2Ucnap3gHYD4SVO3AcQSMU+73Sg1YCRZ8vYUY0cH2jJj5
	 4B69wOsn3MB4xsR44lXc8zQ0OhzHXgRq4ZPCMtCsAF3acL8ldjW/xalI9w2wH/+3lzdhB
	 7zabSvc8SbJPmV5zigzuLP6QYEUK6NqGMMOasvHieVSSUVHzhS2esMw8WgTSU2Q+ZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CAXAoGNb;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A0606A321;
	Thu, 12 Nov 2026 01:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE5A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CAXAoGNb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qs+dUUmGwoCW9p8QsDKZPJUx5Tg8JM0cwaUKiiVMTwc=; b=CAXAoGNbs6Q5k+GLstzvpM7w8D
	otGxRVP4zpvL1wVAkPR/kbFQPNp6cIOsB0Zm2amt4dbR8b3WPA/fEkS3HgPNtBcNuAVxFirzEbfQP
	6gryriryJoV0LxFueijpia2xXdfMRIoG1SrtDeVpjsxkx7qbwqEj8YmemVaIKJrEiUCehkEfw6w9j
	lG+65dB/SsvlVgeKbr7Iligd8YT3WTF47lD7A/+Oh3jzR2YGQjINajjYTnEsYOwnEOl6BuqQ+FRPt
	DpnALdvSipBYJJHlCspsQyiYNqJ06HkEOTMR0hAZb66XL4uJUcZ7zGiWWXTAW1Ufsrrp3jGsOguun
	19paRzcg==;
Received: from [205.251.233.108] (helo=freeip.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRK0d-00000001OIO-2q6r;
	Thu, 12 Nov 2026 01:53:52 +0000
Message-ID: <f4e56be61d46472ab1484900ba13bfc6e51a16b6.camel@infradead.org>
Subject: Re: [PATCH v2 0/7] srcu: NMI-safe atomic SRCU readers, and their
 irqsave forms
From: David Woodhouse <dwmw2@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E . McKenney"
	 <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
  Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett	 <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki	 <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Lai Jiangshan	 <jiangshanlai@gmail.com>, Zqiang
 <qiang.zhang@linux.dev>, Davidlohr Bueso	 <dave@stgolabs.net>, Kunwu Chan
 <kunwu.chan@gmail.com>, Puranjay Mohan	 <puranjay@kernel.org>,
 rcu@vger.kernel.org
Date: Wed, 11 Nov 2026 18:53:47 -0700
In-Reply-To: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
References: <20261111145949.70845-1-mathieu.desnoyers@efficios.com>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-bpSJx5pYageWojTnVvvl"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-bpSJx5pYageWojTnVvvl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-11 at 09:59 -0500, Mathieu Desnoyers wrote:
> Hi Paul,
>=20
> This series adapts atomic SRCU to the needs of RCU pseudo-transactions
> [1], as we discussed [2].=C2=A0 Their readers resolve a proxy within a sh=
ort
> section, in any context, NMI included.=C2=A0 A writer waits for these
> sections without sleeping, from task, softirq or hardirq context.
> Atomic SRCU fits, with one fix, one rule made explicit and two
> additions:
>=20
> - Patch 1 fixes Tiny synchronize_srcu_atomic().=C2=A0 With
> =C2=A0 CONFIG_PREEMPTION=3Dy, it called synchronize_rcu(), which ends an =
RCU
> =C2=A0 grace period on Tiny RCU.=C2=A0 That is wrong when the caller is i=
n an
> =C2=A0 interrupt handler or within rcu_read_lock().
> - Patch 2 is about calling synchronize_srcu_atomic() from an interrupt
> =C2=A0 handler.=C2=A0 All calls on that srcu_struct, task context include=
d, must
> =C2=A0 then disable interrupts around it.=C2=A0 Otherwise, the interrupt =
handler
> =C2=A0 may spin forever on the CPU of a waiter it interrupted.=C2=A0 Patc=
h 2
> =C2=A0 documents this rule, and warns when it is broken.
> - Patch 3 makes the atomic readers NMI-safe.=C2=A0 They use the counter
> =C2=A0 increments of __srcu_read_lock_nmisafe(), which keep the full barr=
iers
> =C2=A0 that synchronize_srcu_atomic() pairs with.
> - Patch 4 adds srcu_read_lock_atomic_irqsave() and
> =C2=A0 srcu_read_unlock_atomic_irqrestore().=C2=A0 They disable interrupt=
s instead
> =C2=A0 of preemption, for a domain whose writers wait with interrupts
> =C2=A0 disabled.
> - Patch 5 makes rcutorture run readers from NMI, for the NMI-safe reader
> =C2=A0 flavors.
> - Patch 6 makes rcutorture alternate the atomic readers of each CPU with
> =C2=A0 irqsave readers, with a new atomic_irqsave parameter.=C2=A0 It als=
o adds an
> =C2=A0 SRCU-P run of this mode to torture.sh.
> - Patch 7 makes rcutorture check what patch 1 fixes.
>=20
> Patch 2 does not make synchronize_srcu_atomic() disable interrupts
> itself.=C2=A0 A reader that disables only preemption may wait for an IPI =
to
> the waiter's CPU, and that IPI would never run.=C2=A0 Only the caller kno=
ws
> that its readers disable interrupts.
>=20
> On architectures without NMI-safe this_cpu_inc(), every atomic reader
> now pays an atomic increment at lock and at unlock.=C2=A0 The update side=
 is
> unchanged.=C2=A0 On architectures with NMI-safe this_cpu_inc(), such as x=
86,
> the readers use the same counter increments as before.=C2=A0 David agreed=
 to
> the change, as long as synchronize_srcu_atomic() stays within the 4-16us
> it was designed for [3].

Tested-by: David Woodhouse <dwmw@amazon.co.uk>

I gave it a spin on the 192-way Granite Rapids box I've been using for
the KVM gfn-to-pfn-cache conversion to atomic SRCU.

All my torture tests pass, including the mmu_notifier race test which
does a full invalidate/refresh cycle for every one of 5000 event
channel deliveries. That works out at over 1.2 million calls to
synchronize_srcu_atomic() per run, of which 99.4% are below 8=C2=B5s:

                with series          without
    [4, 8)=C2=B5s     99.388%             99.458%
    [8, 16)       0.583%             0.508%
    [16, 32)      0.026%             0.032%
    > 32=C2=B5s        0.003%             0.002%
    worst        128-256=C2=B5s bucket    512=C2=B5s-1ms bucket
    (n)          1235551             1126320

So it's basically identical to the same measurement without your
series, which is fairly much as we expected.

Also, rcutorture with reader_flavor=3D0x10 ran clean for five minutes,
for whatever that's worth on a config where NEED_SRCU_NMI_SAFE is off.

--=-bpSJx5pYageWojTnVvvl
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
qPNVOz4XnwHb3wAbaA+4LWsAAAAAAAA=


--=-bpSJx5pYageWojTnVvvl--
