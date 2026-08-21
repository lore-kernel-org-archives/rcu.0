Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C69357CEA;
	Fri, 21 Aug 2026 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313928; cv=none; b=pu+xkzLk8ahzpVI69YGyuiEcdpO0LIN1xfE7XGmwNWbRD3mBQ0DjPpv8dX4hi/lc8UKtCdijrdM+nRw6pA6/L7Am62txyj9kLIbp/O8ggEkuAMR7yZiJDT7yIHCcI+s1+zEnc1h0U4t7GGG4fUXIz3ZEvEAl0HcnO94YLTjlryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313928; c=relaxed/simple;
	bh=H8CGg8WVbpH3bG+JXHx7NyhsKsZflWMHxQbUa6as/Bw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=NT5vq3iKKEcqGZmu1EQZ8eOEmzliwwzYetvVrePCyRFNXgpKb3tcA/hPc8yau/uopsiAoyXocFJ9aVXVBbT1qI/zO8rwHwxQ2V4nYACAfLo66tSpd2fHZ1EkjcPuRzbgmBAf84NhJ0aQqzbuULsqnyWB7Xr5icQfdCB4pO1H4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nkiGc4V/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nkiGc4V/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7D4QYieqmty+LVJHaLmYlTIz8EYkao6XPkrKNytIrPg=; b=nkiGc4V/Qs7iEDzPr+rFLh3iZK
	J2Kvx9R+AzG9A1WOVOyvahDY6unBt1IDZDQk/Ic7uWghcdM1BqlsOlRBrnK0Sh1g4IqlQtwCb7zp3
	E5/QW+qnoDb1cvMWzEgb2XhT2aFxqqSDh8+CmJ9P56jdmHlOsP1APa/FqH/wccZDv7Wwr15T9gqKj
	HtwWKomXXA+OV/E3vygBlCmm7PhgxMCDXAM+JfwTVTnLdyKazuBCrZ2bVJ8Fu2XkXW+nihB453JP2
	0ednGawFDgYPt4klRJHELiwhtYdqAp5aF+cE1WkZHZyoJNjPrj1hUdHIP8uXsNngC6TBOB5q9crnz
	wSopVF4Q==;
Received: from [2001:8b0:10b:5:1f55:b76d:f266:856d] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNzi-0000000HOVA-182C;
	Fri, 21 Aug 2026 12:05:10 +0000
Message-ID: <05e5a29a95793651062dc5d165661b4d590f08ab.camel@infradead.org>
Subject: [PATCH v2] srcu: Add try_synchronize_srcu() for callers which can
 prove readers absent
From: David Woodhouse <dwmw2@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Kunwu Chan <kunwu.chan@linux.dev>, Kunwu Chan <kunwu.chan@gmail.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett
 <josh@joshtriplett.org>, Steven Rostedt	 <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Boqun Feng
 <boqun.feng@gmail.com>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes	 <joel@joelfernandes.org>, Uladzislau Rezki <urezki@gmail.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, rcu@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 21 Aug 2026 13:04:56 +0100
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-7YOb3W+OdXnl4efEoQ0u"
User-Agent: Evolution 3.60.3-0ubuntu1~ppa9~24.04 
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-7YOb3W+OdXnl4efEoQ0u
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For a dedicated srcu_struct whose read-side critical sections are
short, atomic, and usually absent =E2=80=94 such as one converted from a
spinning lock =E2=80=94 the common case at synchronize time is that there a=
re
no readers at all. Even synchronize_srcu_expedited() still costs the
caller an unconditional sleep and two trips through the SRCU workqueue
to discover that: tens of microseconds of machinery to wait for
nothing. And synchronize_srcu()'s auto-expedite heuristic explicitly
declines to expedite within exp_holdoff (25=C2=B5s) of the previous grace
period, which is exactly the regime a burst of back-to-back
invalidations puts such a domain in.

Provide try_synchronize_srcu(), which proves the no-readers case
inline and returns true without sleeping, without the workqueue, and
without advancing the grace-period sequence. A successful return
provides the caller the full happens-before guarantee of
synchronize_srcu(), but is not a grace-period completion for the
state and callback APIs: cookies from get_state_synchronize_srcu()
remain unfinished and queued callbacks are not invoked. If the proof
fails, it returns false and the caller falls back:

	if (!try_synchronize_srcu(ssp))
		synchronize_srcu_expedited(ssp);

For Tree SRCU the proof sums both epochs' unlock counters, executes a
full barrier, then sums both epochs' lock counters. Equality proves a
moment within this function at which no reader existed: a reader
entering between the sums inflates only the lock sum (spurious
fallback, safe), and a reader whose increment is unobserved has not
yet returned from srcu_read_lock() =E2=80=94 the barrier pairing with
__srcu_read_lock() guarantees such a reader sees every store the
caller made beforehand, so it is not a reader the caller is obliged
to wait for. Summing both epochs means no index flip is required, and
without a flip the counter-wrap concerns of
srcu_readers_active_idx_check() do not arise. Readers of the _fast()
flavors elide the read-side barrier this depends on; any sign of them
(in the unlock-side rdm mask, which is gathered unconditionally)
disqualifies the fast path.

For Tiny SRCU (!SMP) both nesting counts being zero already proves no
reader exists =E2=80=94 a mid-section reader could only be preempted or in =
an
interrupt, either of which leaves its count visibly elevated =E2=80=94 and
program order on the sole CPU provides all the required ordering.

The immediate motivation is a proposed conversion of KVM's
gfn_to_pfn_cache to use SRCU=C2=B9, where the mmu_notifier invalidation
path must drain readers of a cache (in the manner of a TLB shootdown)
before the primary MMU zaps the backing page. Those readers are short
non-sleeping fast paths, some in contexts which cannot sleep (hardirq
event channel delivery, the scheduler's sched-out hook); measurement
under a worst-case invalidation flood shows 98.8% of drains complete
inline in 4-16=C2=B5s where the expedited grace period took 32-128=C2=B5s, =
with
the wait dominated by workqueue round-trip latency, not by readers.

=C2=B9 https://lore.kernel.org/all/20260811132237.102400-1-dwmw2@infradead.=
org/

More potential use cases already exist in the tree with the same
no-readers-common-case profile: kvm->irq_srcu takes half a dozen
expedited grace periods in the irqfd and routing-update paths (bursts
of which, at VM boot, fall inside the exp_holdoff window), and mshv's
pt_irq_srcu is the same shape.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
v2 (all per Kunwu Chan's review):
 - Rebase onto rcu/dev (check_init_srcu_struct() is_atomic argument).
 - Drop the leading smp_mb(): the middle barrier already orders the
   caller's prior stores before the lock-counter reads, which is the
   only edge the store-buffering pairing needs; document the middle
   barrier's double duty (matching srcu_readers_active_idx_check(),
   which likewise has no barrier before its unlock reads).
 - Add the same-type-read-side RCU_LOCKDEP_WARN() as in
   synchronize_srcu(), to both Tree and Tiny variants.
 - Document that success is not a grace-period completion for the
   cookie/callback APIs.

Compile-tested for Tiny SRCU (tinyconfig); the Tree version has had
the KVM gfn_to_pfn_cache conversion soaking on it under an adversarial
invalidation flood (48h KASAN+lockdep clean, though of the v1 barrier
arrangement; the v2 change only removes a barrier proven redundant).
---
 include/linux/srcu.h  |  1 +
 kernel/rcu/srcutiny.c | 29 ++++++++++++++++
 kernel/rcu/srcutree.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 60100d8a2671..ee32c2583b30 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -105,6 +105,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head=
 *head,
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 void synchronize_srcu_atomic(struct srcu_struct *ssp);
+bool try_synchronize_srcu(struct srcu_struct *ssp);
=20
 #define SRCU_GET_STATE_COMPLETED 0x1
=20
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 32b37d63d58a..eb8beb365c1f 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -347,6 +347,35 @@ void srcu_barrier(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(srcu_barrier);
=20
+/**
+ * try_synchronize_srcu - inline grace period for a reader-free srcu_struc=
t
+ * @ssp: srcu_struct with which to synchronize.
+ *
+ * If @ssp provably has no readers in either epoch, provide the
+ * synchronize_srcu() guarantee to the caller immediately, without
+ * sleeping. Returns true on success; on failure the caller must fall
+ * back to synchronize_srcu().
+ *
+ * On !SMP a reader can only be mid-critical-section if it was
+ * preempted (or is running in an interrupt which preempted us), in
+ * which case its nesting count is visibly non-zero. Both counts being
+ * zero therefore proves that no reader exists, and any reader which
+ * begins after this function returns will, by program order on this
+ * sole CPU, observe every store the caller made before calling it.
+ */
+bool try_synchronize_srcu(struct srcu_struct *ssp)
+{
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
+			lock_is_held(&rcu_bh_lock_map) ||
+			lock_is_held(&rcu_lock_map) ||
+			lock_is_held(&rcu_sched_lock_map),
+			"Illegal try_synchronize_srcu() in same-type SRCU (or in RCU) read-side=
 critical section");
+
+	return !READ_ONCE(ssp->srcu_lock_nesting[0]) &&
+	       !READ_ONCE(ssp->srcu_lock_nesting[1]);
+}
+EXPORT_SYMBOL_GPL(try_synchronize_srcu);
+
 /*
  * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
  */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e44763e198e3..c3a2170d05db 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1714,6 +1714,87 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
=20
+/**
+ * try_synchronize_srcu - inline grace period for a reader-free srcu_struc=
t
+ * @ssp: srcu_struct with which to synchronize.
+ *
+ * If @ssp provably has no readers in either epoch, provide the
+ * synchronize_srcu() guarantee to the caller immediately: without
+ * sleeping, without a trip through the SRCU workqueue, and without
+ * advancing the grace-period sequence. Returns true on success; on
+ * failure the caller must fall back to synchronize_srcu() or
+ * synchronize_srcu_expedited().
+ *
+ * This serves dedicated srcu_struct structures whose read-side critical
+ * sections are short, atomic, and usually absent =E2=80=94 where even an
+ * expedited grace period costs two trips through the workqueue and an
+ * unconditional sleep of the caller, three orders of magnitude more
+ * than the check below.
+ *
+ * Only readers of the srcu_read_lock() and srcu_read_lock_nmisafe()
+ * flavors are compatible with this proof; if the _fast() flavors have
+ * ever been used on @ssp, this function always returns false.
+ *
+ * Note that a successful return provides the caller the full
+ * happens-before guarantee of synchronize_srcu(), but does NOT
+ * constitute a grace-period completion for the state and callback
+ * APIs: the grace-period sequence is not advanced, so cookies from
+ * get_state_synchronize_srcu() remain unfinished and queued callbacks
+ * are not invoked.
+ */
+bool try_synchronize_srcu(struct srcu_struct *ssp)
+{
+	unsigned long unlocks0, unlocks1;
+	unsigned long rdm0, rdm1;
+
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
+			 lock_is_held(&rcu_bh_lock_map) ||
+			 lock_is_held(&rcu_lock_map) ||
+			 lock_is_held(&rcu_sched_lock_map),
+			 "Illegal try_synchronize_srcu() in same-type SRCU (or in RCU) read-sid=
e critical section");
+
+	check_init_srcu_struct(ssp, false);
+
+	unlocks0 =3D srcu_readers_unlock_idx(ssp, 0, &rdm0);
+	unlocks1 =3D srcu_readers_unlock_idx(ssp, 1, &rdm1);
+
+	/*
+	 * Reader flavors which elide the read-side smp_mb() that the
+	 * pairings below depend on cannot be proven absent this way;
+	 * they need a real grace period.
+	 */
+	if ((rdm0 | rdm1) & SRCU_READ_FLAVOR_SLOWGP)
+		return false;
+
+	/*
+	 * As in srcu_readers_active_idx_check(), this barrier serves two
+	 * purposes. First, it ensures that a lock is always counted if
+	 * the corresponding unlock is counted, so that a reader racing
+	 * with these sums can only inflate the lock sum and force the
+	 * (safe) fallback. Second, it orders the caller's prior stores
+	 * before the lock-counter reads: pairing (store-buffering
+	 * pattern) with the smp_mb() in __srcu_read_lock(), any reader
+	 * whose lock increment is not observed by the sums below is
+	 * guaranteed to observe, within its critical section, every
+	 * store the caller made before calling this function.
+	 *
+	 * Summing both epochs means no index flip is needed: a stable
+	 * equality proves there was a moment in this function at which
+	 * no readers existed at all.
+	 */
+	smp_mb();
+
+	if (!srcu_readers_lock_idx(ssp, 0, false, unlocks0))
+		return false;
+	if (!srcu_readers_lock_idx(ssp, 1, false, unlocks1))
+		return false;
+
+	/* Order the caller's subsequent accesses after the proof. */
+	smp_mb();
+	return true;
+}
+EXPORT_SYMBOL_GPL(try_synchronize_srcu);
+
 /**
  * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
  * @ssp: srcu_struct to provide cookie for.
--=20
2.43.0


--=-7YOb3W+OdXnl4efEoQ0u
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
h0comoA+KaesvY0L99PBO0IAAAAAAAA=


--=-7YOb3W+OdXnl4efEoQ0u--
