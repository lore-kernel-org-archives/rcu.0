Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794422353;
	b=LtiWXAbvPS5qFprX/upsdWtjrADVT8Tki0k6/SXW3XmX4ySuUEkiaCsfNDOYekS4FW5q
	 K9UVIbuyaoyBIbVH5/AdhnKPh9WCjv0rUPAHBSNWWxWh/Zzi83IH3f96ZMzL8bMkzadTm
	 Z+r4NPmVjlVQjhuIuPDYThHE+QX+t1/WggIlD3q9aqJX3TP0n+CmaCmzS4bWtr73BdwQw
	 qGIHxGEm3v7eUFHQ7kMFdA4zjG/rxoFfJEUw235OqVI1PMnkXTYK5rCy4Y6fG6fwe7AcQ
	 SPZWU/QIvyppAlSxVFtGnt4GSL3RWToAiqPrHpEDm1cm0GHSNWd6+yoZkBTTAqHxseA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794422353;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=XdhkBvS5zmHB65fsM5ZMcRexeBc9oDJYjv/DtwuPZYU=;
	b=eGo9PL7xnVmp/8mhu89LqFF1fIvBuKR33NNXjqBgh+txBvBV71oKcEZftv02Ql10NNZJ
	 lJtYURQ/ih5jrikhXnnkp5SMridEuHhBlOTCTFpJAQDUG42uVi1RTmsIszEIVy/5NMkxw
	 PJcrfFXP9/Tmco0DFIecI36X9mB6WeQvr/Ia+azUzRorpNNNImLoKJvZ97YsSIoVsAExp
	 slcgl5pCLyfiMIDgJUq6tjQ6573KUnfCIpLFdn2uU4SskryBCS/GNZbggtXxXkMt5yo1m
	 tzv3qu/nhKmwmYgkTfP2fZSg7LV4MVRH0fXL2FCmDoQmVpG+rheeF+vMSQ/U/Bp0GsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FX7AWonH;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A2606A31C;
	Wed, 11 Nov 2026 18:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE2A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FX7AWonH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XdhkBvS5zmHB65fsM5ZMcRexeBc9oDJYjv/DtwuPZYU=; b=FX7AWonHO7YcWRtOb7F0n2tmFT
	Dhe1nUL/vYiD7acJnaD0uFpngwc9sKXRyWquN8CEqwAaL5tkq0NiDlvbKIGA7Whc52gKaeIzQFUNC
	JMgOn+a/+HBfYF198YbgepRe45vVfyNm0ZDv9Q/k9nZ3ahOeQiU/jsFDFD2PFqUEVrV8i/uo+ZvzO
	mFifZ5/IVZV+yEuQvH8AERJnebX94Gn0jmFm6PROV4VfkmMhc3iziAFGxOHTLiyULA0jwl66QPLNx
	g94ioE5mrpYA7CSlSoMsDbcwV6PGh5U+2Zsl4Falm7OxcPOhFhddDwYrECij0MEmqV9pHl+1hJv1W
	43/bxeRg==;
Received: from [205.251.233.51] (helo=edge-lb-102.e-maa3.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRDDx-0000000CjUc-1Zkg;
	Wed, 11 Nov 2026 18:39:09 +0000
Message-ID: <07358e4fcd606c8dece26dff21443bd61087f0c9.camel@infradead.org>
Subject: Re: [PATCH v2 00/20] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, Paul
 Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred
 Griffoul <fgriffo@amazon.co.uk>,  "Paul E . McKenney"	
 <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, Kunwu Chan	
 <kunwu.chan@gmail.com>,
 syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Date: Wed, 11 Nov 2026 10:38:58 -0800
In-Reply-To: <avN7PfMdfZcYl7Gt@seanjc-mac.roam.internal>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
	 <cd458ee9a0c2405349cd2aaecb180f0b2e757aa3.camel@infradead.org>
	 <avN7PfMdfZcYl7Gt@seanjc-mac.roam.internal>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-JaKGOdCQjdQsbp5BR5F7"
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


--=-JaKGOdCQjdQsbp5BR5F7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-11-10 at 12:14 -0800, Sean Christopherson wrote:
> On Tue, Nov 10, 2026, David Woodhouse wrote:
> > On Thu, 2026-11-05 at 02:00 +0000, David Woodhouse wrote:
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >=20
> > > Based on v7.4-rc1 (kvm/next doesn't have the atomic SRCU flavour yet)=
,
> > > this series:
> > >=20
> > > =C2=A0=E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwl=
ock which was a
> > > =C2=A0=C2=A0 scaling and latency problem, and which PREEMPT_RT hated =
because it
> > > =C2=A0=C2=A0 turned the rwlock into a sleeping lock=C2=B9.
> > >=20
> > > =C2=A0=E2=80=A2 Fixes the pre-existing bugs which torture-testing tha=
t conversion
> > > =C2=A0=C2=A0 shook out: a guest-reachable dirty ring overflow from th=
e hypercall
> > > =C2=A0=C2=A0 page write (128 pushes of the same gfn against 64 reserv=
ed entries,
> > > =C2=A0=C2=A0 without PML), and a lost TLB flush request in record_ste=
al_time().
> > >=20
> > > =C2=A0=E2=80=A2 Adds KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE, for=
 VMMs which
> > > =C2=A0=C2=A0 intercept the guest's MSR write and need to replay it fr=
om host
> > > =C2=A0=C2=A0 context=C2=B2.
> > >=20
> > > =C2=A0=E2=80=A2 Cleans up the intentional lack of dirty-tracking of X=
en shinfo and
> > > =C2=A0=C2=A0 vcpu_info pages (Sean).
> > >=20
> > > =C2=A0=E2=80=A2 Converts steal-time / preempted status to use gfn_to_=
pfn_cache.
> > > =C2=A0=C2=A0 (Carsten)
> > >=20
> >=20
> > I love it when sashiko-bot finds things which my own local runs don't.
> > I'm still iterating on the latter part of the series; I think it
> > probably makes sense to merge the first half (patches 1-9 above), and
> > the nested parts (below) can come later.
> >=20
> > Sean, what do you think?
>=20
> Ya, I'm definitely in favor of that.=C2=A0 Even if Sashiko didn't find an=
ything, I
> think I'd want to grab the GUEST_USES_PFN stuff separately.

Cool. Then I'll focus on kvmclock and VSM stuff for now, and come back
to the GPC-nesting fun later. The basic GPC SRCU patches 1-9 in my tree
are still identical to what was posted in this thread, and what I've
been torture-testing all along:

https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/gpc-src=
u-v2-part1

Carsten Stollmaier (1):
      KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

David Woodhouse (5):
      KVM: x86/xen: Fill the hypercall page with a single guest write
      KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
      KVM: x86: Request the guest TLB flush from record_steal_time()
      KVM: selftests: Actually deactivate the HVA-based shared_info cache i=
n xen_shinfo_test
      KVM: pfncache: Use atomic SRCU for readers instead of a rwlock

Sean Christopherson (3):
      KVM: x86/xen: Extract delivery of event to vCPU into a separate helpe=
r
      KVM: x86/xen: Explicitly tag "shared info" page as never being dirty =
tracked
      KVM: x86/xen: Don't dirty track "vCPU info" page


 Documentation/virt/kvm/api.rst                    |  27 +-
 arch/x86/include/asm/kvm_host.h                   |   2 +-
 arch/x86/include/uapi/asm/kvm.h                   |   3 +
 arch/x86/kvm/msrs.c                               |   7 +-
 arch/x86/kvm/x86.c                                | 165 ++++----
 arch/x86/kvm/xen.c                                | 380 ++++++++++-------
 include/linux/kvm_host.h                          |  41 +-
 include/linux/kvm_types.h                         |  38 +-
 include/linux/srcu.h                              |   7 +
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c |   2 +-
 tools/testing/selftests/kvm/x86/xen_vmcall_test.c | 118 ++++++
 virt/kvm/kvm_main.c                               |   9 +
 virt/kvm/pfncache.c                               | 485 +++++++++++++++++-=
----
 13 files changed, 944 insertions(+), 340 deletions(-)




--=-JaKGOdCQjdQsbp5BR5F7
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
BTEPFw0yNjExMTExODM4NThaMC8GCSqGSIb3DQEJBDEiBCCDNbgN9mLBoF2fuehsdR4h62oXEDYZ
yfLRpX2jafYTgjCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
aUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBT
SEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAwgYcGCyqGSIb3DQEJEAILMXigdjBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFz
c3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAw
DQYJKoZIhvcNAQEBBQAEggIAzFpW+Mv1IoRrKm5wpN9SdaxwoRhdBn0EZMifXqXiJF32NJz9969e
WLGQfw8bEEzXfwO/IHgPoXzFpcclM28vMPjvEyracEriR2RpYm1iSALj0l9+bDvUjVHFoF0ca8uZ
VA48vX1AQ64IXsyNeFNMfiWVgUbwLPc3QAG8127a8b6NNbpANMFVppvDsJQ2JGHQSCbVqdYGdhw0
OScA3+Ex/KQ0475gFxZSrNvemZIFz7e36yQyofyqBRtLlCiKsGlEuWu8FocLzsOVl9Ou3THqqmZQ
rmAevgRXIbF/Ua+8OWXBAghjSbMqgQaBgRGyzanRSQgQSPeo9AhEJOYg1vc4rnssfOoEYt3dXaoL
TVnoRxTjl8cUhX1Q/pGhzWElvdx+7Sel2VmLPdRQsUp13RRDFOSVCSzIjhq6iq6XwnKGNmQcoaIW
6dfts4hbhqtG4YhXKbTMkRLbouOUfwMb8p9ZwIoTiLiy//xCN1jc/Wi5vz2hOQCn3whKzHGZlunM
iuo/ZrSZzow7DBidGX5hYhrT7QmSTQXf3EUjoWED2Tkyuc6wrOMYc70fnkH2CuMzEv+iMvRY0szE
qbeUo6MzY1P5lN4qJ6MoTi3zKTyfgOT9tnF2h/o+zkVT3vISYueCAuyhm8LaW56hEHHmuFAf7BIo
XeBbjVN3VsXFDE1IHk2eVX0AAAAAAAA=


--=-JaKGOdCQjdQsbp5BR5F7--
