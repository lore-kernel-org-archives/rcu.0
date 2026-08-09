Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557313C1D5B;
	Sun,  9 Aug 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786269608; cv=none; b=Yaq/d9oDgxccyABC4nBvSCP4e86A9N+gxBvTOs0rljI9rAo5cPYX2cWfUAdzuXcJXns/TSCS9GcF+816E2Hvvgu6GuTP80+PjtPIflhG8qFWPfAAv82l9vLn9ExmQgOZYtQ+/58TqKHwePTeJhrAeJRc6AtDqPA7FKNYKw3n3FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786269608; c=relaxed/simple;
	bh=0thQ9MJOMVfePm8SoiN3tQuR2kH9tQtHWQAunN/tTd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=oPuS/aqCmNy9gc4lrbOkU6Z8/EJ2sK3BbtvqHBYxdTcBmCe1MyUMAXmUjwXAUMH1XeafgxRO2ZJBiVKF84nGJKFjm/HhMw1tqBfI7OaZjjj3I1AUA0LCdRNbXh+ap7wKSvAaTOvonriJ7f7zYY9U5LqwrF3UOObWE1p5t54gO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e7REWrCx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e7REWrCx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:References;
	bh=bE7X5rWA3AiT5JC+SzetgFSyISEB5qQKKnvgvLTWPKA=; b=e7REWrCxMlks5esEc9rhMHrJOc
	qgSCIs1wyyd1NYqyXXa8bYk/pcLhI84RPwBK+cD5Hr4t1otT/hQCAAIxkhpkdZVikfazr/K+SZocX
	O26aArklxREIfIyxhAH+P9mIoNA/z90kdoiopoS1FmhxIrQIxixNrII4eOoOMkpUu7XyMsWp7NG9H
	WMfjaE8g54Y8c4SEvwogG8m7Hy6kpBygDpQ9/pk5/ZvcAo6mek4YTz6GTc7GTJw/GbkQng8AR8hNb
	3AsNFEzEa7TCMabkeQitAZ8HnjTqew1Sy/17GEEYuuVLyYzMq5ag99z7mtu40KxTEaZzHwfA++uSI
	iSnn7uCQ==;
Received: from 54-240-197-234.amazon.com ([54.240.197.234] helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0K1-00000008mxs-0vmq;
	Sun, 09 Aug 2026 10:00:01 +0000
Message-ID: <d0fdf8aa4faa4e349cdc0e051b6e211cddd566b0.camel@infradead.org>
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
From: David Woodhouse <dwmw2@infradead.org>
To: paulmck@kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>, 
	kvm@vger.kernel.org, rcu@vger.kernel.org
Date: Sun, 09 Aug 2026 10:59:59 +0100
In-Reply-To: <0d483855-4d2f-4502-858c-c88077aa0b94@paulmck-laptop>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-zfyFSbc7cbbWHvQJ9Fme"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-zfyFSbc7cbbWHvQJ9Fme
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-08-08 at 10:58 -0700, Paul E. McKenney wrote:
> By the way, good point on all the SRCU instances sharing a common
> set of workqueues.  More ways to deadlock!  But I don't see having
> per-srcu_struct sets of dedicated kthreads.  ;-)

Indeed. Although I did briefly go down the rabbit hole of whether a
*reader* sleeping in an allocation could compose into the same kind of
cycle.

Conclusion: only if something on the reclaim path synchronizes the
*same* srcu_struct that the reader holds =E2=80=94 cross-domain it's only
latency, since the GP state machine polls and requeues rather than
capturing a worker. Which becomes a design rule for GPC usage:
never allocate under srcu_read_lock(&kvm->gpc_srcu), because our
invalidator *is* on the reaper path. But that's OK because allocating
inside the existing GPC rwlock is already verboten.

> True, but shouldn't we take as much pressure off of the spare as we can
> so that it will be there for us when we really need it.
[...]
> Why not do a "GFP_NOWAIT | __GFP_NOWARN" attempt before raiding
> srcu_spare_nodes?  Wouldn't that increase the probability that there
> would be an srcu_node array available when someone really needed it?

Makes sense. Done that way below: the GFP_NOWAIT attempt comes first,
so in the common no-pressure case the spare is never touched and is
guaranteed present under the memory pressure it exists for. That also
makes the replenish latency mostly moot =E2=80=94 it only matters after an
allocation has already failed under pressure, and nothing ever waits on
it.

> Mightn't !try_cmpxchg() be a better fit here?  You are using the returned
> pointer as a boolean anyway.  (One could also argue for xchg(), but why
> unnecessarily write to that poor cache line?)

Also done, plus a check of srcu_spare_nodes before the kzalloc as you
suggested =E2=80=94 the collision is indeed low-probability, but the check =
is
free.

> And the across-SRCU shared-workqueue deadlock that you pointed out is
> avoided because the only way that gfp_flags is set to GFP_KERNEL is when
> the caller is supplying its own task, correct?

Right. After this patch the only GFP_KERNEL caller of
init_srcu_struct_nodes() is init_srcu_struct() in the caller's own
task, where blocking is permitted. srcu_gp_end() passes GFP_NOWAIT, so
nothing on the grace-period workqueue can ever block in reclaim.

In the meantime, testing found some issues in my original conversion of
the GPC code to RCU =E2=80=94 dropping gpc->lock broke the atomicity of the
final invalidation check against the publish, and the teardown paths
could skip the grace period when an invalidation had already cleared
the valid flag =E2=80=94 re-breaking the syzbot thing I only just fixed, bu=
t
for which thankfully I had a repro case right there ready to catch it
:)

Both reworked: the valid/becoming-valid state now lives in a single
atomic word, so the publish is a cmpxchg which an invalidation can
veto. (My old needs_invalidation flag back again!). That's now ~30
hours into a 48-hour KASAN+lockdep soak with no complaints, and syzbot
is chewing on it too.

Tree with all of that plus this SRCU preallocation patch on top:

https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Drefs/=
heads/xen-rcu-srcu-prealloc

Patch below. Still only compile-tested =E2=80=94 my metal test hosts are
over the big_cpu_lim threshold, so the lazy transition path this
changes never executes there; testing it properly wants a small guest
or big_cpu_lim=3D tweaking, which is on the list. But also it's a PITA to
actually *trigger* the OOM reaper path anyway, and I've not actually
managed it without hacking the kernel to introduce delays.

From: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] srcu: Keep a spare node array so srcu_gp_end() need not bl=
ock
 in reclaim

The one-time transition of an srcu_struct from SRCU_SIZE_SMALL to
SRCU_SIZE_BIG allocates the srcu_node combining tree with GFP_KERNEL
from srcu_gp_end(). That runs on the same workqueue which processes
grace periods for every srcu_struct in the system =E2=80=94 including grace
periods awaited from OOM/reclaim contexts such as the OOM reaper
calling synchronize_srcu() via an mmu_notifier. If the allocation
blocks in direct reclaim, it can be waiting on the very OOM reaper
whose grace period is queued behind it: a deadlock.

The allocation is literally one size fits all: it depends only on
rcu_num_nodes, which is fixed once rcu_init_geometry() has run. So
keep a single preallocated spare array, primed in srcu_init() when
lazy (contention-triggered) sizing is in effect.

Allocation tries GFP_NOWAIT first, which in the common no-pressure
case succeeds and leaves the spare untouched, so that it is still
there when there really is pressure. Only when that fails is the
spare consumed (with xchg(), so double-consumption is impossible),
and the consumer kicks a replenish worker on system_wq =E2=80=94 a clean
context where GFP_KERNEL is safe and nothing waits on the result.
The final fallback uses the caller's own flags: GFP_KERNEL only ever
from init_srcu_struct() in the caller's own task, where blocking is
permitted; srcu_gp_end() passes GFP_NOWAIT, preserving the guarantee
that the grace-period workqueue never blocks in reclaim.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 kernel/rcu/srcutree.c | 84 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7c2f7cc131f7..23911fa71c64 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -123,6 +123,71 @@ static inline bool srcu_invl_snp_seq(unsigned long s)
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
+ * The allocation therefore tries GFP_NOWAIT first =E2=80=94 which in the =
common
+ * no-pressure case succeeds and leaves the spare untouched =E2=80=94 and =
raids
+ * the spare only when that fails, i.e. under the memory pressure the
+ * spare exists for. The spare is replenished from a clean context on
+ * system_wq. Nothing on the grace-period path ever blocks in reclaim.
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
+	 * Try a non-blocking allocation first, leaving the spare untouched
+	 * in the common no-pressure case so that it is still there when
+	 * there really is pressure.
+	 */
+	node =3D kzalloc_objs(*node, rcu_num_nodes, GFP_NOWAIT | __GFP_NOWARN);
+	if (node)
+		return node;
+
+	node =3D xchg(&srcu_spare_nodes, NULL);
+	if (node) {
+		schedule_work(&srcu_spare_replenish_work);
+		return node;
+	}
+
+	/*
+	 * Spare already taken and not yet replenished. Fall back to the
+	 * caller's own flags: for init_srcu_struct() this is GFP_KERNEL in
+	 * the caller's own task, where blocking is permitted; from
+	 * srcu_gp_end() it is GFP_NOWAIT again, preserving the guarantee
+	 * that the grace-period workqueue never blocks in reclaim.
+	 */
+	return kzalloc_objs(*node, rcu_num_nodes, gfp_flags);
+}
+
 /*
  * Allocated and initialize SRCU combining tree.  Returns @true if
  * allocation succeeded and @false otherwise.
@@ -139,8 +204,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *=
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
@@ -1004,7 +1068,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* Transition to big if needed. */
 	if (ss_state !=3D SRCU_SIZE_SMALL && ss_state !=3D SRCU_SIZE_BIG) {
 		if (ss_state =3D=3D SRCU_SIZE_ALLOC)
-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
+			init_srcu_struct_nodes(ssp, GFP_NOWAIT | __GFP_NOWARN);
 		else
 			smp_store_release(&sup->srcu_size_state, ss_state + 1);
 	}
@@ -2111,6 +2175,20 @@ void __init srcu_init(void)
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


--=-zfyFSbc7cbbWHvQJ9Fme
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
BTEPFw0yNjA4MDkwOTU5NTlaMC8GCSqGSIb3DQEJBDEiBCBiNPcSL4i+7FQeX7eKEH2OBYBWxOt8
cl5uSTPMSiX/xDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGln
aUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBT
SEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAwgYcGCyqGSIb3DQEJEAILMXigdjBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFz
c3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTECEAM1KLa7MmyR8R04yjiFXSAw
DQYJKoZIhvcNAQEBBQAEggIALW7bNTBORoE6O12BB2xy4Rtchbf0ufCkBqqQf7mtTf8I0/R7F8qR
KYKp8LmTqO0cV3xFoDS6ZFV7MblNThcicfJ1gLZjXMvMOWrjy4YqRfqLXUOBkuxQibrvS09IUFyW
YfvOCPBYs9yFkiDc4PeulYAjxxu/052qPJrmzZI/Lo1Fz+MS66FUZtsMvQ2OUbC4J01Hf9nDRbJ4
XFQyfQR7ocx9goVMJNlpmfqlVMFA5oUNRUlOU5s+9gMtYSas74d4trAaAF/xrepcWIdFvZdT4Ln0
03qweodHbV0bIYEzxm8dFPFx7Dn7rrZd5T6xwqk1krQS3TogrL6E19zG0ZFpkNxvmDOv97DmRBIJ
u0LEptwLlTW8X35U/iAlwbRptuFXm99pTO4zsm2yxB32tmFrHTFmXyOQ7/Yk1oUCyBo1td50avXQ
yUvYVB4fLZD0WSvwN9TmtCidfbsv04/bf7iz5q+ErjUnkIlWQmLxIDx/hkFRMK41UBCYkeYQIA5R
wHvLlAqzqahQFwfh9cFNZ4XZTCo2nuwRovUJnpif7NGuOOmJW6r90QcDZUTpm8UztRQ3OrvUhAbe
RGnahF3H0MJR560RznfbiU8hJ1P0n7xrdQixMq9O3tVq2Xxht+c8fxID+GpITiGo2orPXDc637EV
qAG6GjHmeWeK+aVCnec2fyAAAAAAAAA=


--=-zfyFSbc7cbbWHvQJ9Fme--
