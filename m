Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC13321AA;
	Tue, 11 Aug 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438201; cv=none; b=MEXEVKgQeQoXq4/mTF9Vz0oJS9N32pjDqfsbbfjz0+x6HuvqVKJe3kgM2OKvEbHWrR50pp+rymTQdrjwPBQtLenIk5eB5ULj9YmgyyQoU8IG8Pdsx3le8iH50sBY0X6mNFKI4ALSgOXFTUpabwnBNZLSHI0LhzFlKXOemrEesa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438201; c=relaxed/simple;
	bh=P0UWCuYOa1EGGDMa2d147EdaSvn6kWcMAiO5CbqBt/k=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=BgDFGikAE0V2QaiiP5aK06G+dgA7AThPb0c/zIPUBvl4BfvrwZ0RcFD1FpFGtDx66bdsDlEbUuYPX1QfbDikyEqDoRRLbYcXVcgYW+I5/G0KUP9HeVVDfdEqfmRd7rZVepTPXks1wPQ1NrdxODpm+4dzyZarm8yxe2IX1AGBrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VlDpHMxl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VlDpHMxl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=1DFJ1+Yc2fe403LOy/A7nU0aiqv+MDiyugPAjBOLLdc=; b=VlDpHMxlBlu1DjgL9FHAcZoDih
	1HvSqJQaVYSs75Lr5OKNVUSkZE862zZNMSwtF+jxRGoIy9aWRLcR5r0eOg8cNWajGSRXoEyUm9tc5
	NvHvI3xbytArR2e7obubjfexWQ/21GvjxC1QxovkA75992t4E/fRL2FKn1VOuQrUf8n9ski6oLpwg
	zciRw7ha/6H0up5hcofeHfO70qvD6yEeRKo6k45rGMfNPOH2ZFeqUkZy3LGiKyVNMEUEVDiSSGW1L
	1MT/ZUTNTC2OGX6LeSbYm1rUYdLlPPetqsiiw83mWU7CklOu22M3YapbYKjxuC1Gk4PIFGnsYu8Lr
	FuKqHlLA==;
Received: from [2001:8b0:10b:5:e09:5b1f:c111:693d] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wti4U-0000000EwG6-2YyA;
	Tue, 11 Aug 2026 08:42:54 +0000
Message-ID: <6eed3fe3461e9690b486ca98fa7563f60d3940ff.camel@infradead.org>
Subject: [PATCH] srcu: Keep a spare node array so srcu_gp_end() need not
 block in reclaim
From: David Woodhouse <dwmw2@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett	
 <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng
 <boqun.feng@gmail.com>, Neeraj Upadhyay	 <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joel@joelfernandes.org>,  Uladzislau Rezki	 <urezki@gmail.com>,
 Sean Christopherson <seanjc@kernel.org>, Paolo Bonzini	
 <pbonzini@redhat.com>, rcu@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 11 Aug 2026 09:42:20 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-2Td9HET66dXaRJWW8010"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-2Td9HET66dXaRJWW8010
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

The one-time transition of an srcu_struct to SRCU_SIZE_BIG allocates
the srcu_node tree with GFP_KERNEL from srcu_gp_end(), which runs on
the same workqueue that processes grace periods for every srcu_struct
in the system =E2=80=94 including those awaited from OOM/reclaim contexts s=
uch
as the OOM reaper via an mmu_notifier. If the allocation blocks in
reclaim, it can be waiting on the very OOM reaper whose grace period
is queued behind it: a deadlock.

The size of the array depends only on rcu_num_nodes, fixed once
rcu_init_geometry() has run, so one preallocated spare fits every
srcu_struct. Have srcu_gp_end() allocate with GFP_NOWAIT, falling back
to the spare, which is replenished from system_wq where blocking is
harmless. If both fail, nothing is lost: the srcu_struct simply
remains un-upgraded =E2=80=94 fully functional, just contended =E2=80=94 an=
d the
upgrade is retried on a later grace period.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
Based on the discussion at=20
https://lore.kernel.org/all/4a8c82b27972f9dda156aede0fb352d58fa66db7.camel@=
infradead.org/

 kernel/rcu/srcutree.c | 85 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7..2601566c254a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -123,6 +123,72 @@ static inline bool srcu_invl_snp_seq(unsigned long s)
 	return s =3D=3D SRCU_SNP_INIT_SEQ;
 }
=20
+/*
+ * A standing spare srcu_node array. The size of the allocation depends
+ * only on rcu_num_nodes, which is fixed once rcu_init_geometry() has run,
+ * so one preallocated array fits every srcu_struct in the system.
+ *
+ * This exists because srcu_gp_end() may need to allocate the array when
+ * a size transition is triggered by contention, and srcu_gp_end() runs
+ * on the same workqueue for every srcu_struct =E2=80=94 including grace p=
eriods
+ * awaited from OOM/reclaim contexts (e.g. the OOM reaper via an
+ * mmu_notifier). Blocking there in GFP_KERNEL reclaim can deadlock: the
+ * reclaim may be waiting on the very OOM reaper whose grace period is
+ * queued behind this allocation.
+ *
+ * The allocation is therefore attempted with the caller's own flags
+ * (GFP_NOWAIT on the grace-period path), and the spare is raided only
+ * when that fails =E2=80=94 i.e. under the memory pressure the spare exis=
ts
+ * for. The spare is replenished from a clean context on system_wq.
+ * Nothing on the grace-period path ever blocks in reclaim.
+ */
+static struct srcu_node *srcu_spare_nodes;
+
+static void srcu_spare_replenish_wq(struct work_struct *work)
+{
+	struct srcu_node *spare, *expect =3D NULL;
+
+	if (READ_ONCE(srcu_spare_nodes))
+		return;		/* Already refilled. */
+
+	spare =3D kzalloc_objs(*spare, rcu_num_nodes, GFP_KERNEL);
+	if (!spare)
+		return;
+	if (!try_cmpxchg(&srcu_spare_nodes, &expect, spare))
+		kfree(spare);	/* Someone else refilled it first. */
+}
+static DECLARE_WORK(srcu_spare_replenish_work, srcu_spare_replenish_wq);
+
+static struct srcu_node *srcu_alloc_nodes(gfp_t gfp_flags)
+{
+	struct srcu_node *node;
+
+	/*
+	 * Try the caller's own flags first, raiding the spare only if that
+	 * fails. For init_srcu_struct() the flags are GFP_KERNEL in the
+	 * caller's own task, where blocking is permitted: such a caller
+	 * only ever reaches the spare under genuine OOM, rather than
+	 * consuming it on any transient pressure. From srcu_gp_end() the
+	 * flags are GFP_NOWAIT, so nothing on the grace-period workqueue
+	 * ever blocks in reclaim, and the spare is the fallback it exists
+	 * to provide. If the spare is also gone (already raided, not yet
+	 * replenished), fail: srcu_gp_end() retries the size transition
+	 * on a later grace period.
+	 */
+	node =3D kzalloc_objs(*node, rcu_num_nodes, gfp_flags);
+	if (node)
+		return node;
+
+	/*
+	 * Kick the replenisher whether or not the raid succeeds: the
+	 * replenisher does not retry a failed allocation itself, so this
+	 * is what retries the refill on each pressure event.
+	 */
+	node =3D xchg(&srcu_spare_nodes, NULL);
+	schedule_work(&srcu_spare_replenish_work);
+	return node;
+}
+
 /*
  * Allocated and initialize SRCU combining tree.  Returns @true if
  * allocation succeeded and @false otherwise.
@@ -139,8 +205,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *=
ssp, gfp_t gfp_flags)
=20
 	/* Initialize geometry if it has not already been initialized. */
 	rcu_init_geometry();
-	ssp->srcu_sup->node =3D kzalloc_objs(*ssp->srcu_sup->node, rcu_num_nodes,
-					   gfp_flags);
+	ssp->srcu_sup->node =3D srcu_alloc_nodes(gfp_flags);
 	if (!ssp->srcu_sup->node)
 		return false;
=20
@@ -1004,7 +1069,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* Transition to big if needed. */
 	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
 		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
+			init_srcu_struct_nodes(ssp, GFP_NOWAIT);
 		else
 			smp_store_release(&sup->srcu_size_state, ss_state + 1);
 	}
@@ -2111,6 +2176,20 @@ void __init srcu_init(void)
 		}
 	}
=20
+	/*
+	 * Prime the spare node array if lazy (contention-triggered) size
+	 * transitions are possible, so that srcu_gp_end() never needs to
+	 * allocate. Early-boot GFP_KERNEL is implicitly non-blocking
+	 * (gfp_allowed_mask strips __GFP_RECLAIM until much later), and
+	 * failure here is harmless: the GFP_NOWAIT fallback and replenish
+	 * worker remain.
+	 */
+	if (SRCU_SIZING_IS_CONTEND() || SRCU_SIZING_IS_TORTURE()) {
+		rcu_init_geometry();
+		srcu_spare_nodes =3D kzalloc_objs(*srcu_spare_nodes,
+						rcu_num_nodes, GFP_KERNEL);
+	}
+
 	/*
 	 * Once that is set, call_srcu() can follow the normal path and
 	 * queue delayed work. This must follow RCU workqueues creation
--=20
2.43.0


--=-2Td9HET66dXaRJWW8010
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
4G1jDHVH34kcb/lDn59HP/oAAAAAAAA=


--=-2Td9HET66dXaRJWW8010--
