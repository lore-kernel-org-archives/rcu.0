Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC333394490;
	Fri, 21 Aug 2026 11:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313231; cv=none; b=uJFIJFMQdiRCJpg3V8mR+yiyUAXUMxdAKgn45rG1iJqf75ObA+/0b71ik04jyeRREkju+W9adb6rd8UW/aTvt28vjxNgSf4LcGM6Q8NAP5jaOCmfRzX1bWXXaTWvMkGCSZyp3gwuSONlPGDklf6ZegBF1y6IQ+qa/WSNot1IzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313231; c=relaxed/simple;
	bh=Iy1cPbV20QoEpDx5ugY3Fc8vEGWCnfCd3DvradBUgwg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=rOwK8JVuUsG72T+l6pJTvKIpJnl8BPOEc7pyRLFB9UZN1E3r5aNNoSKnnrrEDulE4TJlbIqXpw9n3hmrYfTmSmGJZ7nz4TEef6B/4KFE9GWy4Kv4mlAcp95LO6tP7R7VloChTQPXkpWJ2KNl5lDN/PNRARpTWTjKz29F36yGnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=knzJfTEt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knzJfTEt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=XZ3gFnn0A5RbW71OmMNANd6FSjYvWKogaEgxxwHp5Bo=; b=knzJfTEta0umt4+eH5wqOo6WZJ
	dKDtijNdAFDePfe+Ge/S9gC1rq7xnmJjQ76ElS+Pq9HusrPyMZrDCCdQ48EKnQ8u+yV78cvOH5u9Q
	MglvlG4NAkZy7dEcWNns0qMGpAYH+5GdI0aDE9HAqMwQ+mXj8zeifrMoOJ5mBZ1K1a5B5YjS5c8p7
	ZK8j0jWZjfvKVUMOhyejoQbVuzZmxcdEqCsut3ZIphkcXrit8uERtI3bNj+IARZ9dPinmFoxY7HG6
	6zMd4rsyVbYvTSL0UrY6aiEJIElTqi8tIAPrbyh/ORR+mHWys/ZrSvljiY0j5tgwWGZR8pDxeoVxs
	KwRmCjGA==;
Received: from [2001:8b0:10b:5:1f55:b76d:f266:856d] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNoW-0000000HNED-0koJ;
	Fri, 21 Aug 2026 11:53:36 +0000
Message-ID: <d26ec36e92e8f5aa244e2a22de5d167d14b36597.camel@infradead.org>
Subject: Re: [PATCH] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
From: David Woodhouse <dwmw2@infradead.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, "Paul E. McKenney"
 <paulmck@kernel.org>,  Lai Jiangshan <jiangshanlai@gmail.com>, Josh
 Triplett <josh@joshtriplett.org>, Steven Rostedt	 <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  Boqun Feng
 <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes	 <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, rcu@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 21 Aug 2026 12:53:22 +0100
In-Reply-To: <20260821032210.792451-1-kunwu.chan@linux.dev>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-dz+qIfCEeiAqzpwLKE2J"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-dz+qIfCEeiAqzpwLKE2J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 11:22 +0800, Kunwu Chan wrote:
> If the common case is that there are no readers and the new fast path
> is intended to avoid the SRCU grace-period machinery, could you explain
> what property of SRCU is still required by the proposed users that
> prevents using ordinary RCU instead?

My original version did use RCU, but Sean asked me to switch to a
dedicated per-vm SRCU=C2=B9 because a system-wide grace period doesn't work
well on large KVM hosting systems.

=C2=B9 https://lore.kernel.org/all/anS8C4Cxqy6ehCo3@google.com/

> Could this use case instead be addressed by making exp_holdoff
> configurable per srcu_struct, or otherwise allowing a dedicated SRCU
> domain to use a more aggressive expedite policy?

That doesn't help much; the other concern is latency. And the mere act
of bouncing to the workqueue only to realise we can wake up again was
adding 100=C2=B5s or so every time for nothing. *Plus* once you schedule at
all, you start to see really high tail latencies of >20ms too =E2=80=94 whi=
ch
is why we've also started looking at synchronize_srcu_atomic() to
eliminate that completely. If we get *that*, then maybe I don't
personally care as much about try_synchronize_srcu(), although it might
be a useful extension to synchronize_srcu_expedited() =E2=80=94 this *would=
* be
the 'more aggressive expedite policy' of which you speak, for the case
where there are no readers.

> Could you also clarify why observing no readers during this
> check is sufficient for the reclamation/happens-before guarantee
> required by the proposed callers?

Both halves of the grace-period guarantee are provided when it returns
true. For any reader, either:

   =E2=80=A2 its lock increment was observed by the sums and its unlock was
     too =E2=80=94 the reader's final smp_mb() then orders its whole critic=
al
     section before the caller's subsequent accesses (that reader has
     completed), or

   =E2=80=A2 its lock increment was not observed =E2=80=94 in which case th=
e
     store-buffering pairing with the smp_mb() in __srcu_read_lock()
     guarantees that reader observes every store the caller made
     before calling: it is a "new" reader for the purposes of the
     grace period, exactly as if it had started after a real
     synchronize_srcu() returned, or

   =E2=80=A2 its lock increment was observed but its unlock was not =E2=80=
=94 the one
     case where the reader may still be running with no guarantee it
     saw anything. But that reader inflates the lock sum above the
     unlock sum, so this is precisely the case in which we return
     false and the caller takes the real grace period.

It's the same argument srcu_readers_active_idx_check() makes; the only
novelty is summing both epochs so no flip is needed.

> Since a successful try_synchronize_srcu() does not advance srcu_gp_seq,
> flip the SRCU index, or process callbacks, could we document more
> explicitly that a successful try provides the required
> reclamation/happens-before guarantee to the caller, but does not
> constitute an SRCU grace-period completion for the state/callback APIs?

Yes; done in v2.

> What ordering edge does the first smp_mb() establish that is not
> already provided by the middle and final barriers?

Er.... none? :)

We need the caller's prior stores ordered before the *lock*-counter
reads, but the middle barrier already does that for us. Dropped in v2,
and the comment on the middle barrier updated.

> Would it make sense to perform the same lockdep check in the try path?

Ack.

> When applying this to current rcu/dev, the patch also needs to account
> for the additional bool is_atomic argument to
> check_init_srcu_struct(). Please rebase accordingly.

Ooh, shiny, I hadn't spotted that the atomic thing had landed. Maybe I
should retract my 'if we get that' above... but let's see how it
survives.

I also have more than just this patch to rebase onto rcu/dev =E2=80=94 unli=
ke
some, I'm not just hacking RCU for the fun of it; I get my jollies
elsewhere :)

Btw, the current commit c68271c3f83a message says "no index flip, no
grace-period sequence update" but that isn't true of the implementation
any more, is it? In fact, it *always* does those things, and doesn't
take the try-path optimisation by counting both epochs, that I'm doing
here?

Thanks for the careful review.

--=-dz+qIfCEeiAqzpwLKE2J
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
NDA5NlNIQTM4NDIwMjRDQTEuY3J0MA0GCSqGSIb3DQEBCwUAA4ICAQChxpuuHVw93mze9jmueUFV
BJNzvOzZlazrt0AiW1H7TlYQutgKVXPNSEyz8s4k+WsRSjjlQMOiZerfwPEV6lo9336I0uNd+ffc
Rf8gbjiPTiVT+gX9GD1V5AguRgtsJn/H3A6M0dlzhI3J1jsOG9/+xPloHPzy7sPn5rNkntB/VTnv
Bix4IfUy3ScOu2vnLX0gnwP3EknfdEUvq9+kdkEEBDz7dGqQo3EuhXZoW9CHF2GM0sOpO/cuNQh2
JzA+to3smTES7sJXYuRrt5GomCRYvtIrRiYGMalFp+z6Jw/843lEIIpNNvpWVfx5Mbawkl+wWG8k
0IK3rF7FtbNa0it8/s288G/AEHvfsDIQYFmRLlo2LNMxxREkZO/1Qq8GHUsX/602Fi0u88I3uh5w
bOEIeG32NzBKTKBOjdjpiUrdCA676dyaIFt967CUtnUvFti8bqGA2pe/u7pjIANthqMBAlcnY5B6
ff2mbdD8BBLItgb4HyUOCVawzy1hc+UR2tglySwYroWeohfoG6afjesGigsl2JmnhaZ9Z0vanF74
vFEOOmuaq7VamuLEPFQtJM4olmipOW6CzrLcFz6J/6yAecEG3P1ZDoy08eSHvM40MAUgpwGa/w6o
9ALHQXda/c4TJvAylfHQ6wqArzAuV1pfWldwy7IOBMtKqzQBXQ4dSDGCBCAwggQcAgEBMHYwYjEL
MAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTowOAYDVQQDEzFEaWdpQ2VydCBB
c3N1cmVkIEcyIFNNSU1FIFJTQTQwOTYgU0hBMzg0IDIwMjQgQ0ExAhADNSi2uzJskfEdOMo4hV0g
MA0GCWCGSAFlAwQCAQUAoIIBezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNjA4MjExMTUzMjJaMC8GCSqGSIb3DQEJBDEiBCDvTj6wGxE2yazrai7KDr4QkRiz6H/e
DV0En/0S1DLJ9zCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
aUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBT
SEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAwgYcGCyqGSIb3DQEJEAILMXigdjBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFz
c3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAw
DQYJKoZIhvcNAQEBBQAEggIAXeR09+P9SR7TzQW5rNnZJm3KRNLeN85JacpMK+DModXfVkzTEMm0
xSF286NFHLKm/d2fuLdZu8iN+X2PyUEaPkVqj4IO3Vw44Y/ttgHTgeP9uvLmiHAenkeQoGqhd9IJ
l/0G4dfEcgONcwuM/xcqa4XDylBOev00KpX33NGJfAwa15UOvqIRgvT2RxrppKz/WeJ+0IMEooJX
H+PU56LfEbpK2CJPJrfUurI66f3qgCAQJl2u/0sdspOnPHJVFhIRDhvU4AwgW4cqPCKQrZN1Mpvg
0b6yRCSIhjzvm3/LuObcmhKWyb2ceF5jI63E/gmASiM9FXSt/dRzLX/Ng14Rf99HX0n30fFWZvWj
NVXAqoNF2Woj/YheqmBBxDx/8Ay+NvBbj2nrFcy7KYfdzP+tdzd7aTWfY67WKssOiZjlcLPONaEi
mE/8jOqQS5qa3zAI/x/T/iZf63BzRmH0yA8P+dzOWuja8bTfHPsCcfdTi/AYEaVCoT8Fnmn8Sda3
+PW4IxBOxTnFTSPZYQbHwVa6zsIjtT8bdjFJySC+OTSYvjq4TEWtcVmaxrmUWILj5NLesZrXPnPe
UXXgMGIQdmkeXbzVBGQpOtVOwb+AN+61oANhW1n0B3ZQzpnkC6Q6qg8ek2wt/c3KbH5TNoeszKq6
dGbX3XUKhwDmdtztRmyp6KMAAAAAAAA=


--=-dz+qIfCEeiAqzpwLKE2J--
