Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=zwqx1HHKjiQmp9Y4LUkENxr+NZ7WUMMojLTnyKiBNxVDkuC4n0YxXw7oui0GkJoBFhSe
	 IIvNatZVKeMOpqVcarTeLNpYvgYYycmL2UxkZ7RaX97r3uzENJgF6X48KFJ7Wc83dOsxd
	 2B60urUHP27U3eg6p9bB2L5E6LJ2QDXhrk30NRIQ0GPxF1++yceQmQevFs+6zBxgtpXyv
	 /ce2HW/IY4TEQDXp5RsAT7wRfUlT0pAPTxz6lhr7s8jVkQ49X4qz651UBA8WRj51owxhQ
	 mcWkO+g7XcqWWo5RGhKr3LfiK9DS2xiGxJi4h105t58FbzV/QyUjsuMVtC7a3jX7UPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=UgyLs6o4Orjp7r9TrZvgcRHUHKMCRka330m3aCKWdEQ=;
	b=V0O40xGlelVl2O7tBdXxrewmAAxbKCBJ1zqCBvG3gsjsVuNDuQKqcYqOIcei5rj9lc1O
	 kcEelcjwdVdxq5O0HSlrdd0NUZ1uTltVrNKPuXssGeMR/8tCNI4rhqMTPpA1pW10ztMCG
	 gh0VT+0zgi2bb5bW4U/LNM1fC+pgGKZcfVAwWLR4CA16suEFRl/Ed3PBXKvstTa/dbHEt
	 rk3GQKpNSagz3AFfch6c32iGYeewqz+GJwQ5UL93g5PdlclsCFvzuO4qvusxLtgNi0jVz
	 ydZes2V0CE/jzA72SvQlZpVP+DUhLmEM14uwqDTG+WXzeEkLUhmrK9AEiJv3Bp34rfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MujwxWKs;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB18606A336;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB18606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=MujwxWKs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=UgyLs6o4Orjp7r9TrZvgcRHUHKMCRka330m3aCKWdEQ=; b=MujwxWKsiDg/pCHAc4bLWCV5Cg
	7QHM7AcNwnwbTY80H3ZNP4o2CQ0jIkAmUbdvSl6Ml2XqU3IE947Ow+x5FsJreKPvBEoVdd80bfyXZ
	5ChIZKpFWO5KujoGUe5MEDIWV40DaDY6V2DcQgdyqeZLI2nvYqrz8JXEm3UoIH0f/5bE3wN0xnX3K
	q4IOiBPV/Uz0tLXn9farqxTLb/uh+AptumD61Zb5+UGWS+VhgK0IdvPJne/TV0O96Bmk9OAa6IOcl
	ijX97daC6NziEYUSVQsUA78budms2uHb2dLCScJ54mU5MllRA1mfJRrL29TqZtf92qGI637kp/mVc
	4oA/ephw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jA-0D4N;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDP-1ey4;
	Thu, 05 Nov 2026 02:01:04 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 08/20] KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
Date: Thu,  5 Nov 2026 02:00:50 +0000
Message-ID: <20261105020104.2507083-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105020104.2507083-1-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
domain (kvm->gpc_srcu) for the read side. Readers now run under
srcu_read_lock_atomic() alone: preemption disabled and non-blocking
enforced, which every GPC read-side section already satisfied as a
former rwlock critical section. It works in any context (including
hardirq and sched-out paths) and never fails or spins, eliminating
the read_trylock() contortions in the atomic paths, the double-lock
dance with the lockdep subclass hack in the runstate update, and the
PREEMPT_RT problems inherent to taking an rwlock in those contexts.
In particular, kvm_xen_set_evtchn_fast() is called from hardirq
context (timer callback, kvm_arch_set_irq_inatomic()), where taking
gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.

The mutators' reader drains use synchronize_srcu_atomic(), which
spins for the bounded readers instead of sleeping: no path waiting
out GPC readers ever schedules. That satisfies the OOM-reaper
non-blocking requirement in the invalidation walk, whose wait must
happen even on unblockable ranges — GPC readers never allocate, take
mmap_lock, or sleep, so waiting them out cannot deadlock against
reclaim. SRCU rather than plain RCU so that wait covers only this
VM's GPC readers, not a grace period across every pCPU in the
system; the read-side cost is a this_cpu_inc() and a barrier.

Without gpc->lock, the refresh can no longer rely on holding it to
make its final invalidation check and its publish atomic with
respect to the mmu_notifier walk, and can no longer treat "GPC_VALID
already clear" as "no readers remain". Three state bits in a single
atomic word replace it: GPC_BECOMING_VALID lets the walk veto an
in-flight refresh's pending publish (the publish is a cmpxchg which
fails if the bit was cleared, closing the window between the
refresh's last check and its publish); GPC_INVALIDATING records that
a grace period for the previously published mapping is still owed:
whoever clears GPC_VALID leaves the marker standing until their
grace-period wait completes, so that a later mutator — or a later
mmu_notifier walk, whose return is what lets the primary MMU free
the page — finding GPC_VALID already clear still performs a wait of
its own rather than trusting one it cannot see finish. The comments
in pfncache.c and kvm_types.h carry the full protocol.

As before, a refresh which resolves to the same uHVA in the same
memslot leaves the cache valid and undisturbed, skipping the grace
period: routine host memory management (page migration, NUMA
balancing, KSM) usually re-backs the same uHVA, and a grace period
in the reader's refresh path for each such event would add seconds
to a guest boot.

Not suitable for stable backport despite the Fixes tag (it depends
on the atomic SRCU reader flavour, new in this cycle); the tag
documents where the PREEMPT_RT sleeping-lock problem was introduced.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
Tested-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c        |  10 +-
 arch/x86/kvm/xen.c        | 146 ++++++------
 include/linux/kvm_host.h  |  26 ++-
 include/linux/kvm_types.h |  37 ++-
 include/linux/srcu.h      |   7 +
 virt/kvm/kvm_main.c       |   9 +
 virt/kvm/pfncache.c       | 481 ++++++++++++++++++++++++++++++--------
 7 files changed, 528 insertions(+), 188 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3c26c0eb9865..f5f3459ed4a5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1747,18 +1747,18 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 {
 	struct pvclock_vcpu_time_info *guest_hv_clock;
 	struct pvclock_vcpu_time_info hv_clock;
-	unsigned long flags;
+	int idx;
 
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-	read_lock_irqsave(&gpc->lock, flags);
+	idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
 			return;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	}
 
 	guest_hv_clock = (void *)(gpc->khva + offset);
@@ -1783,7 +1783,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	guest_hv_clock->version = ++hv_clock.version;
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e54988522b8b..13e287bc17bb 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -46,16 +46,17 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	u64 wall_nsec;
 	int ret = 0;
 	int idx = srcu_read_lock(&kvm->srcu);
+	int gpc_idx;
 
-	read_lock_irq(&gpc->lock);
+	gpc_idx = srcu_read_lock_atomic(&kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
-		read_unlock_irq(&gpc->lock);
+		srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 
 		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
 		if (ret)
 			goto out;
 
-		read_lock_irq(&gpc->lock);
+		gpc_idx = srcu_read_lock_atomic(&kvm->gpc_srcu);
 	}
 
 	/*
@@ -98,7 +99,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	smp_wmb();
 
 	wc->version = wc_version + 1;
-	read_unlock_irq(&gpc->lock);
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 
 out:
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -155,22 +156,21 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
 				 struct gfn_to_pfn_cache *gpc,
 				 unsigned int offset)
 {
-	unsigned long flags;
-	int r;
+	int idx, r;
 
-	read_lock_irqsave(&gpc->lock, flags);
+	idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock));
 		if (r)
 			return r;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	}
 
 	memcpy(hv_clock, gpc->khva + offset, sizeof(*hv_clock));
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 	/*
 	 * Sanity check TSC shift+multiplier to verify the guest's view of time
@@ -325,12 +325,12 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	struct gfn_to_pfn_cache *gpc2 = &vx->runstate2_cache;
 	size_t user_len, user_len1, user_len2;
 	struct vcpu_runstate_info rs;
-	unsigned long flags;
 	size_t times_ofs;
 	uint8_t *update_bit = NULL;
 	uint64_t entry_time;
 	uint64_t *rs_times;
 	int *rs_state;
+	int idx;
 
 	/*
 	 * The only difference between 32-bit and 64-bit versions of the
@@ -417,20 +417,12 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 
  retry:
 	/*
-	 * Attempt to obtain the GPC lock on *both* (if there are two)
-	 * gfn_to_pfn caches that cover the region.
+	 * Check *both* (if there are two) gfn_to_pfn caches that cover
+	 * the region, under a single SRCU read-side critical section.
 	 */
-	if (atomic) {
-		local_irq_save(flags);
-		if (!read_trylock(&gpc1->lock)) {
-			local_irq_restore(flags);
-			return;
-		}
-	} else {
-		read_lock_irqsave(&gpc1->lock, flags);
-	}
+	idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc1, user_len1)) {
-		read_unlock_irqrestore(&gpc1->lock, flags);
+		srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 
 		/* When invoked from kvm_sched_out() we cannot sleep */
 		if (atomic)
@@ -439,7 +431,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		if (kvm_gpc_refresh(gpc1, user_len1))
 			return;
 
-		read_lock_irqsave(&gpc1->lock, flags);
+		idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	}
 
 	if (likely(!user_len2)) {
@@ -459,24 +451,11 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	} else {
 		/*
 		 * The guest's runstate_info is split across two pages and we
-		 * need to hold and validate both GPCs simultaneously. We can
-		 * declare a lock ordering GPC1 > GPC2 because nothing else
-		 * takes them more than one at a time. Set a subclass on the
-		 * gpc1 lock to make lockdep shut up about it.
+		 * need to validate both GPCs simultaneously. They are both
+		 * covered by the single SRCU read-side critical section above.
 		 */
-		lock_set_subclass(&gpc1->lock.dep_map, 1, _THIS_IP_);
-		if (atomic) {
-			if (!read_trylock(&gpc2->lock)) {
-				read_unlock_irqrestore(&gpc1->lock, flags);
-				return;
-			}
-		} else {
-			read_lock(&gpc2->lock);
-		}
-
 		if (!kvm_gpc_check(gpc2, user_len2)) {
-			read_unlock(&gpc2->lock);
-			read_unlock_irqrestore(&gpc1->lock, flags);
+			srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 
 			/* When invoked from kvm_sched_out() we cannot sleep */
 			if (atomic)
@@ -575,13 +554,11 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		smp_wmb();
 	}
 
-	if (user_len2) {
+	if (user_len2)
 		kvm_gpc_mark_dirty_in_slot(gpc2);
-		read_unlock(&gpc2->lock);
-	}
 
 	kvm_gpc_mark_dirty_in_slot(gpc1);
-	read_unlock_irqrestore(&gpc1->lock, flags);
+	srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 }
 
 void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
@@ -656,7 +633,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
 	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
-	unsigned long flags;
+	int idx;
 
 	if (!evtchn_pending_sel)
 		return;
@@ -666,14 +643,14 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	 * does anyway. Page it in and retry the instruction. We're just a
 	 * little more honest about it.
 	 */
-	read_lock_irqsave(&gpc->lock, flags);
+	idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 
 		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info)))
 			return;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	}
 
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
@@ -706,7 +683,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
@@ -716,8 +693,8 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
-	unsigned long flags;
 	u8 rc = 0;
+	int idx;
 
 	/*
 	 * If the global upcall vector (HVMIRQ_callback_vector) is set and
@@ -742,9 +719,9 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	 */
 	guard(srcu)(&v->kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
+	idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 
 		/*
 		 * This function gets called from kvm_vcpu_block() after setting the
@@ -764,11 +741,11 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 			 */
 			return 0;
 		}
-		read_lock_irqsave(&gpc->lock, flags);
+		idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	}
 
 	rc = ((struct vcpu_info *)gpc->khva)->evtchn_upcall_pending;
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&v->kvm->gpc_srcu, idx);
 	return rc;
 }
 
@@ -803,6 +780,13 @@ int kvm_xen_hvm_set_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
 
 		mutex_lock(&kvm->arch.xen.xen_lock);
 
+		/*
+		 * The cache's own readers hold kvm->gpc_srcu, but activating
+		 * it resolves the gfn through kvm_memslots(), which is
+		 * protected by kvm->srcu. (Holding kvm->srcu across the
+		 * deactivation is also fine: its grace-period wait is on the
+		 * gpc_srcu domain, not this one.)
+		 */
 		idx = srcu_read_lock(&kvm->srcu);
 
 		if (data->type == KVM_XEN_ATTR_TYPE_SHARED_INFO) {
@@ -937,6 +921,14 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	int idx, r = -ENOENT;
 
 	mutex_lock(&vcpu->kvm->arch.xen.xen_lock);
+
+	/*
+	 * Activating the caches below resolves gfns through kvm_memslots(),
+	 * and the runstate cases read it via kvm_gpc_check(); both are
+	 * protected by kvm->srcu (the caches' readers hold kvm->gpc_srcu,
+	 * which does not cover the memslots, and whose grace-period waits
+	 * are safe to perform with kvm->srcu held).
+	 */
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 	switch (data->type) {
@@ -1532,14 +1524,13 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	unsigned long *pending_bits;
-	unsigned long flags;
 	bool ret = true;
-	int idx, i;
+	int idx, gpc_idx, i;
 
 	idx = srcu_read_lock(&kvm->srcu);
-	read_lock_irqsave(&gpc->lock, flags);
+	gpc_idx = srcu_read_lock_atomic(&kvm->gpc_srcu);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
+		goto out_gpc_srcu;
 
 	ret = false;
 	if (has_64bit_shinfo) {
@@ -1557,8 +1548,8 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
 		}
 	}
 
- out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+ out_gpc_srcu:
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	return ret;
@@ -1883,6 +1874,15 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+/*
+ * Called with kvm->srcu held, as kvm_gpc_check() consults the memslots.
+ *
+ * The caller passes its own has_64bit_shinfo snapshot, from which it also
+ * derived port_word_bit; re-reading the mode here could race with a
+ * concurrent mode flip and pair a 64-bit bit index with the compat
+ * evtchn_pending_sel offset (or vice versa), writing outside the intended
+ * field within the guest's vcpu_info.
+ */
 static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit,
 				      bool has_64bit_shinfo)
 {
@@ -1890,15 +1890,15 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit,
 	unsigned long vi_pending_sel_ofs;
 	bool inject_upcall = false;
 	bool kick_vcpu = false;
-	unsigned long flags;
 	bool old;
+	int idx;
 
 	vi_pending_sel_ofs = has_64bit_shinfo ?
 		offsetof(struct vcpu_info, evtchn_pending_sel) :
 		offsetof(struct compat_vcpu_info, evtchn_pending_sel);
 
 	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-	read_lock_irqsave(&gpc->lock, flags);
+	idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		/*
 		 * Could not access the vcpu_info. Set the bit in-kernel and
@@ -1940,14 +1940,17 @@ static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit,
 	}
 
 out_unlock:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 	/*
 	 * Deliver the upcall or kick the vCPU only after dropping the GPC
 	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
 	 * delivery also walks the APIC map and takes APIC locks; none of
-	 * that wants to be nested inside the GPC read lock, which a
-	 * concurrent invalidation may be waiting to take for write.
+	 * that wants to be nested inside the GPC read-side critical
+	 * section, which must be no longer than the accesses to gpc->khva
+	 * above. Invalidation waits for a grace period, so holding the
+	 * read lock across the kick would extend how long a memory
+	 * invalidation is blocked.
 	 */
 	if (!kick_vcpu)
 		return;
@@ -1982,9 +1985,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
 	unsigned long *pending_bits, *mask_bits;
 	struct kvm_vcpu *vcpu;
-	unsigned long flags;
 	int port_word_bit;
-	int vcpu_idx, idx, rc;
+	int vcpu_idx, idx, gpc_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
 	if (vcpu_idx >= 0)
@@ -2003,9 +2005,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
+	gpc_idx = srcu_read_lock_atomic(&kvm->gpc_srcu);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_unlock;
+		goto out_gpc_srcu;
 
 	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
@@ -2037,12 +2039,12 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 	}
 
- out_unlock:
-	read_unlock_irqrestore(&gpc->lock, flags);
+ out_gpc_srcu:
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 
 	/*
 	 * Both of these can kick the vCPU, so keep them outside the GPC
-	 * read lock; an invalidation may be waiting to take it for write.
+	 * read-side critical section; invalidation waits for a grace period.
 	 */
 	if (rc == -ENOTCONN)
 		kvm_xen_check_poller(vcpu, xe->port);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cadd0318400e..3ed0b8c9c102 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -798,6 +798,16 @@ struct kvm {
 	/* For management / invalidation of gfn_to_pfn_caches */
 	spinlock_t gpc_lock;
 	struct list_head gpc_list;
+	/*
+	 * Protects the contents of active gfn_to_pfn_caches. Readers hold it
+	 * across kvm_gpc_check() and any subsequent access to gpc->khva; the
+	 * invalidation and refresh paths clear GPC_VALID in gpc->state and
+	 * then wait for a grace period before mutating anything a reader
+	 * might be looking at.
+	 * A dedicated domain (rather than kvm->srcu) keeps those waits from
+	 * being lengthened by unrelated memslot readers.
+	 */
+	struct srcu_struct gpc_srcu;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -1520,12 +1530,9 @@ int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsign
  * @return:	   %true if the cache is still valid and the address matches.
  *		   %false if the cache is not valid.
  *
- * Callers outside IN_GUEST_MODE context should hold a read lock on @gpc->lock
- * while calling this function, and then continue to hold the lock until the
- * access is complete.
- *
- * Callers in IN_GUEST_MODE may do so without locking, although they should
- * still hold a read lock on kvm->scru for the memslot checks.
+ * Callers must hold a read lock on @gpc->kvm->gpc_srcu across this function
+ * and any subsequent access to the target page, and must hold a read lock on
+ * kvm->srcu for the memslot checks.
  */
 bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
 
@@ -1542,8 +1549,8 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  * This will attempt to refresh a gfn_to_pfn_cache. Note that a successful
  * return from this function does not mean the page can be immediately
  * accessed because it may have raced with an invalidation. Callers must
- * still lock and check the cache status, as this function does not return
- * with the lock still held to permit access.
+ * still check the cache status under a kvm->gpc_srcu read lock, via
+ * kvm_gpc_check(), before accessing the target page.
  */
 int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
 
@@ -1984,7 +1991,8 @@ static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 
 static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 {
-	lockdep_assert_held(&gpc->lock);
+	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&gpc->kvm->gpc_srcu),
+			 "kvm_gpc_mark_dirty_in_slot() without kvm->gpc_srcu read lock");
 
 	if (!gpc->memslot || gpc->never_dirty)
 		return;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index e850adc3f47e..22393f97266a 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -88,15 +88,48 @@ struct gfn_to_pfn_cache {
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
 	struct list_head list;
-	rwlock_t lock;
 	struct mutex refresh_lock;
 	void *khva;
 	kvm_pfn_t pfn;
 	bool active;
-	bool valid;
+	/*
+	 * GPC_VALID, GPC_BECOMING_VALID and GPC_INVALIDATING live in a
+	 * single atomic word so that a refresh can publish
+	 * (BECOMING_VALID => VALID) with a single conditional RMW, an
+	 * invalidation can veto that publish by clearing both of those bits
+	 * (setting INVALIDATING in the same operation if VALID was set, to
+	 * record that its grace period is still owed), and a mutator can
+	 * consume the whole state with one xchg to learn whether it must
+	 * wait for readers before touching anything they see. See the
+	 * comments in pfncache.c.
+	 *
+	 * 'active' deliberately stays separate: the invalidation and
+	 * mutation paths operate on the word without having to care about
+	 * racing with deactivation, which is ordered by refresh_lock
+	 * instead.
+	 */
+	atomic_t state;
 	bool never_dirty;
 };
 
+/* The cache is valid: pfn and khva may be used by readers. */
+#define GPC_VALID		0x1
+/*
+ * A refresh is in flight and intends to publish. Set before the uhva is
+ * resolved, so an invalidation of that uhva can veto the publish even
+ * though the cache is not yet valid.
+ */
+#define GPC_BECOMING_VALID	0x2
+/*
+ * GPC_VALID has been cleared but the grace period for readers of the
+ * previously published mapping has not yet completed. Nothing may mutate
+ * reader-visible fields (pfn, khva, uhva, gpa, memslot) until whoever
+ * next needs to do so has waited it out. Set by whichever party clears
+ * GPC_VALID; cleared after a synchronize_srcu() which began after the
+ * VALID clear.
+ */
+#define GPC_INVALIDATING	0x4
+
 #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
 /*
  * Memory caches are used to preallocate memory ahead of various MMU flows,
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650..f7a6bbcabc4e 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -706,6 +706,13 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 DECLARE_LOCK_GUARD_1_ATTRS(srcu, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
 #define class_srcu_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu, _T)
 
+DEFINE_LOCK_GUARD_1(srcu_atomic, struct srcu_struct,
+		    _T->idx = srcu_read_lock_atomic(_T->lock),
+		    srcu_read_unlock_atomic(_T->lock, _T->idx),
+		    int idx)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_atomic, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
+#define class_srcu_atomic_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_atomic, _T)
+
 DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    _T->scp = srcu_read_lock_fast(_T->lock),
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..a3b4ca1ae88d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1160,6 +1160,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_srcu;
 	if (init_srcu_struct(&kvm->irq_srcu))
 		goto out_err_no_irq_srcu;
+	if (init_srcu_struct_atomic(&kvm->gpc_srcu))
+		goto out_err_no_gpc_srcu;
 
 	r = kvm_init_irq_routing(kvm);
 	if (r)
@@ -1240,6 +1242,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
 out_err_no_irq_routing:
+	cleanup_srcu_struct(&kvm->gpc_srcu);
+out_err_no_gpc_srcu:
 	cleanup_srcu_struct(&kvm->irq_srcu);
 out_err_no_irq_srcu:
 	cleanup_srcu_struct(&kvm->srcu);
@@ -1316,6 +1320,11 @@ static void kvm_destroy_vm(struct kvm *kvm)
 		kvm_free_memslots(kvm, &kvm->__memslots[i][0]);
 		kvm_free_memslots(kvm, &kvm->__memslots[i][1]);
 	}
+	/*
+	 * All gfn_to_pfn_caches have been deactivated by kvm_arch_destroy_vm()
+	 * above, so there can be no readers or pending invalidations left.
+	 */
+	cleanup_srcu_struct(&kvm->gpc_srcu);
 	cleanup_srcu_struct(&kvm->irq_srcu);
 	srcu_barrier(&kvm->srcu);
 	cleanup_srcu_struct(&kvm->srcu);
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 17a30da00d40..1c98b7bdbf09 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -26,35 +26,149 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 				       unsigned long end)
 {
 	struct gfn_to_pfn_cache *gpc;
+	bool cleared = false;
 
 	spin_lock(&kvm->gpc_lock);
+
+	/*
+	 * Order the caller's earlier mn_active_invalidate_count increment
+	 * (and gpc_invalidate_seq bump, for range_end) before the state
+	 * reads below. This is a store->load ordering, which neither the
+	 * unlock/lock the increment travelled through (RCtso) nor the
+	 * acquire on the state read provides generically. It pairs with
+	 * smp_mb__after_atomic() in hva_to_pfn_retry(): whichever side's
+	 * full barrier executes second guarantees that either this walk
+	 * observes GPC_BECOMING_VALID and vetoes the pending publish, or
+	 * the refresh observes the elevated count / bumped seq and
+	 * retries — closing the store-buffering window in which each
+	 * side misses the other and a stale pfn gets published. (On x86
+	 * both sides' locked RMW operations already provide this; generic
+	 * code must not rely on that.)
+	 */
+	smp_mb__after_spinlock();
+
 	list_for_each_entry(gpc, &kvm->gpc_list, list) {
-		read_lock_irq(&gpc->lock);
+		/*
+		 * A cache covers only a single page, keyed by its uhva, so
+		 * there is no length to consider.
+		 *
+		 * The acquire pairs with the release-publish in
+		 * hva_to_pfn_retry() (for GPC_VALID) and with the
+		 * smp_mb__before_atomic() before the GPC_BECOMING_VALID
+		 * announce (for that bit): whichever is seen, the uhva read
+		 * below is guaranteed to see the value stored before it. A
+		 * stale uhva paired with a fresh state bit could otherwise
+		 * cause a cache whose new uhva is in the invalidated range
+		 * to be skipped.
+		 *
+		 * uhva is read once, with READ_ONCE(), and only after the
+		 * state (the acquire provides that ordering): it is written
+		 * (with WRITE_ONCE()) by __kvm_gpc_refresh() without holding
+		 * gpc_lock. Note the refresh only mutates uhva while the
+		 * state word is 0 — after its xchg, before its announce —
+		 * so this walk cannot observe a half-updated cache: if
+		 * either state bit is visible, the uhva is current.
+		 *
+		 * Keying on GPC_BECOMING_VALID as well as GPC_VALID means a
+		 * cache whose refresh is in flight is *not* skipped: its
+		 * uhva is already known at that point, and clearing the bit
+		 * vetoes the pending publish. Testing only GPC_VALID would
+		 * leave the window between the refresh's last invalidation
+		 * check and its publish unprotected. (For an invalidation
+		 * which begins before that check, this veto is belt and
+		 * braces: the mn_active_invalidate_count / gpc_invalidate_seq
+		 * check makes the refresh retry anyway. The window after
+		 * that check has only the veto.)
+		 *
+		 * Keying on GPC_INVALIDATING too means a cache whose
+		 * VALID-clearing party is still mid-grace-period is not
+		 * skipped either: see the comment at the 'cleared' update
+		 * below.
+		 */
+		unsigned long gpc_uhva;
+		int old, new;
 
-		/* Only a single page so no need to care about length */
-		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-		    gpc->uhva >= start && gpc->uhva < end) {
-			read_unlock_irq(&gpc->lock);
+		old = atomic_read_acquire(&gpc->state);
+		if (!(old & (GPC_VALID | GPC_BECOMING_VALID | GPC_INVALIDATING)))
+			continue;
 
+		gpc_uhva = READ_ONCE(gpc->uhva);
+		if (gpc_uhva >= start && gpc_uhva < end) {
 			/*
-			 * There is a small window here where the cache could
-			 * be modified, and invalidation would no longer be
-			 * necessary. Hence check again whether invalidation
-			 * is still necessary once the write lock has been
-			 * acquired.
+			 * Clear VALID and BECOMING_VALID; if VALID was set,
+			 * also set INVALIDATING so that anyone else who wants
+			 * to mutate reader-visible fields before our grace
+			 * period below completes knows to wait for one of
+			 * their own. (A cache which was merely becoming
+			 * valid has no readers: the veto alone suffices.)
+			 *
+			 * 'old' is seeded from the read above; if the state
+			 * changed since (e.g. the refresh published), the
+			 * cmpxchg fails, reloads it, and goes around.
 			 */
+			do {
+				new = old & ~(GPC_VALID | GPC_BECOMING_VALID);
+				if (old & GPC_VALID)
+					new |= GPC_INVALIDATING;
+			} while (!atomic_try_cmpxchg(&gpc->state, &old, new));
 
-			write_lock_irq(&gpc->lock);
-			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-			    gpc->uhva >= start && gpc->uhva < end)
-				gpc->valid = false;
-			write_unlock_irq(&gpc->lock);
-			continue;
+			/*
+			 * Wait below not only when this walk itself cleared
+			 * GPC_VALID, but also when GPC_INVALIDATING alone
+			 * was found: the party which cleared GPC_VALID (a
+			 * concurrent walk, or a refresh/deactivation mid
+			 * grace-period — they keep the marker up until their
+			 * wait completes) may still be inside its own
+			 * synchronize, with readers outstanding on the old
+			 * mapping. Those readers are covered by *its* grace
+			 * period, which this walk's caller does not wait
+			 * for; it must begin (and finish) one of its own
+			 * before the caller frees the page.
+			 */
+			if (old & (GPC_VALID | GPC_INVALIDATING))
+				cleared = true;
 		}
-
-		read_unlock_irq(&gpc->lock);
 	}
 	spin_unlock(&kvm->gpc_lock);
+
+	/*
+	 * Readers may still be using the old mapping, having sampled
+	 * GPC_VALID before it was cleared. Wait for them all to drain
+	 * before the caller proceeds to zap the page tables; like a TLB
+	 * shootdown, this guarantees no access via the stale mapping
+	 * once the invalidation completes.
+	 *
+	 * This wait is safe even on unblockable ranges (the OOM reaper):
+	 * the constraint there is not "no sleeping" but "no blocking on
+	 * anything which may itself depend on memory allocation to make
+	 * progress" (see the reasoning in commit 312364f3534c and its
+	 * discussion). A GPC read-side critical section has no such
+	 * dependency: readers never allocate, never take mmap_lock, and
+	 * never sleep.
+	 *
+	 * The atomic variant: this stalls progress of the primary MMU
+	 * operation which triggered the invalidation, and the readers being
+	 * drained are bounded, short, non-sleeping sections, so the wait
+	 * spins (preemption disabled) rather than sleeping — and never
+	 * queues a callback, so it depends on no allocation at all. That
+	 * satisfies even the strictest reading of the OOM-reaper
+	 * requirement; it is also the only wait primitive permitted on a
+	 * domain whose readers are the atomic flavor.
+	 */
+	if (cleared)
+		synchronize_srcu_atomic(&kvm->gpc_srcu);
+
+	/*
+	 * Note the GPC_INVALIDATING markers set above are deliberately NOT
+	 * cleared here: this walk dropped gpc_lock before waiting, so it
+	 * cannot tell whether the marker it would clear is still the one
+	 * it set (consider a republish-and-reinvalidate cycle completing
+	 * entirely within this synchronize_srcu()). Leaving it standing is
+	 * merely conservative: a later walk over the same uhva pays a
+	 * redundant grace period, and the next mutation of the cache (a
+	 * refresh or deactivation, which performs its own wait) retires
+	 * it. Readers ignore the bit.
+	 */
 }
 
 static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
@@ -74,14 +188,31 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
 
-	if (!gpc->active)
+	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&gpc->kvm->gpc_srcu),
+			 "kvm_gpc_check() without kvm->gpc_srcu read lock");
+
+	/*
+	 * Check valid *first*. The acquire pairs with the release-publish
+	 * in hva_to_pfn_retry(), so every field read below — and any use
+	 * of gpc->khva by the caller — is guaranteed to be from the
+	 * published generation, not a stale value reordered from before
+	 * the publish. The fields are then stable for the remainder of
+	 * the RCU read-side critical section, because every mutator
+	 * clears valid and waits a full grace period before changing
+	 * anything.
+	 */
+	if (!(atomic_read_acquire(&gpc->state) & GPC_VALID))
+		return false;
+
+	if (!READ_ONCE(gpc->active))
 		return false;
 
 	/*
 	 * If the page was cached from a memslot, make sure the memslots have
 	 * not been re-configured.
 	 */
-	if (!kvm_is_error_gpa(gpc->gpa) && gpc->generation != slots->generation)
+	if (!kvm_is_error_gpa(gpc->gpa) &&
+	    READ_ONCE(gpc->generation) != slots->generation)
 		return false;
 
 	if (kvm_is_error_hva(gpc->uhva))
@@ -90,9 +221,6 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
 		return false;
 
-	if (!gpc->valid)
-		return false;
-
 	return true;
 }
 
@@ -134,8 +262,8 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long gpc_s
 	 * is elevated.
 	 *
 	 * Note, it does not matter that mn_active_invalidate_count
-	 * is not protected by gpc->lock.  It is guaranteed to
-	 * be elevated before the mmu_notifier acquires gpc->lock, and
+	 * is not protected by any lock the refresher holds.  It is
+	 * guaranteed to be elevated before the mmu_notifier walk, and
 	 * isn't dropped until after gpc_invalidate_seq is updated.
 	 */
 	if (kvm->mn_active_invalidate_count)
@@ -156,10 +284,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 {
 	/* Note, the new page offset may be different than the old! */
 	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
+	void *old_khva_exact = gpc->khva;
+	kvm_pfn_t old_pfn = gpc->pfn;
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
 	unsigned long gpc_seq;
 	struct page *page;
+	int state;
 
 	struct kvm_follow_pfn kfp = {
 		.slot = gpc->memslot,
@@ -171,21 +302,42 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
 	lockdep_assert_held(&gpc->refresh_lock);
 
-	lockdep_assert_held_write(&gpc->lock);
-
-	/*
-	 * Invalidate the cache prior to dropping gpc->lock, the gpa=>uhva
-	 * assets have already been updated and so a concurrent check() from a
-	 * different task may not fail the gpa/uhva/generation checks.
-	 */
-	gpc->valid = false;
+	WARN_ON_ONCE(atomic_read(&gpc->state) & GPC_VALID);
 
 	do {
+		/*
+		 * Announce the intent to publish before the uhva is resolved
+		 * and before any lock is dropped. From here on an
+		 * invalidation of this uhva will clear the bit, and the
+		 * cmpxchg below will then fail and send us around again.
+		 * This is what makes the check-and-publish atomic with
+		 * respect to the mmu_notifier walk without holding a lock
+		 * across it.
+		 *
+		 * The barrier orders the caller's gpc->uhva store before the
+		 * bit becoming visible (atomic_or() alone is unordered, and
+		 * x86's lock-or being a full barrier must not be relied on
+		 * in generic code). It pairs with the atomic_read_acquire()
+		 * in gfn_to_pfn_cache_invalidate_start(): a walker which
+		 * observes the bit observes the uhva this refresh is
+		 * resolving, and so aims its veto correctly.
+		 */
+		smp_mb__before_atomic();
+		atomic_or(GPC_BECOMING_VALID, &gpc->state);
+
+		/*
+		 * Order the announce store before the gpc_invalidate_seq
+		 * and mn_active_invalidate_count reads which follow
+		 * (store->load; atomic_or() alone is unordered). Pairs
+		 * with smp_mb__after_spinlock() in
+		 * gfn_to_pfn_cache_invalidate_start(); see the comment
+		 * there for the store-buffering window this closes.
+		 */
+		smp_mb__after_atomic();
+
 		gpc_seq = gpc->kvm->gpc_invalidate_seq;
 		smp_rmb();
 
-		write_unlock_irq(&gpc->lock);
-
 		/*
 		 * If the previous iteration "failed" due to an mmu_notifier
 		 * event, release the pfn and unmap the kernel virtual address
@@ -213,9 +365,15 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		/*
 		 * Obtain a new kernel mapping if KVM itself will access the
 		 * pfn.  Note, kmap() and memremap() can both sleep, so this
-		 * too must be done outside of gpc->lock!
+		 * can sleep, which is fine: this path holds no spinning locks.
 		 */
-		if (new_pfn == gpc->pfn)
+		/*
+		 * Compare against the *published* pfn captured at entry, via
+		 * a local: gpc->pfn must not be consulted mid-loop. (A
+		 * previous iteration's vetoed publish attempt must not be
+		 * able to leak its doomed pfn into this comparison.)
+		 */
+		if (new_pfn == old_pfn)
 			new_khva = old_khva;
 		else
 			new_khva = gpc_map(new_pfn);
@@ -225,18 +383,39 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 			goto out_error;
 		}
 
-		write_lock_irq(&gpc->lock);
+		if (mmu_notifier_retry_cache(gpc->kvm, gpc_seq))
+			continue;
+
+		gpc->pfn = new_pfn;
+		gpc->khva = new_khva + offset_in_page(gpc->uhva);
 
 		/*
-		 * Other tasks must wait for _this_ refresh to complete before
-		 * attempting to refresh.
+		 * Publish: BECOMING_VALID => VALID, but only if the bit is
+		 * still set. If an invalidation of this uhva landed at any
+		 * point since it was set — including in the window after the
+		 * retry check just above — the bit is gone, the cmpxchg fails
+		 * and we go around again. The release ordering pairs with the
+		 * atomic_read_acquire() in kvm_gpc_check() so the pfn/khva
+		 * stores are visible before GPC_VALID is. (The stores must
+		 * precede the VALID publish; a reader which observes VALID
+		 * must observe the fields it covers.)
 		 */
-		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, gpc_seq));
+		state = GPC_BECOMING_VALID;
+		if (atomic_try_cmpxchg_release(&gpc->state, &state, GPC_VALID))
+			break;
 
-	gpc->valid = true;
-	gpc->pfn = new_pfn;
-	gpc->khva = new_khva + offset_in_page(gpc->uhva);
+		/*
+		 * Vetoed: an invalidation cleared GPC_BECOMING_VALID after
+		 * the retry check above. No reader ever saw the values just
+		 * stored (VALID was never set for them), but the loop's own
+		 * cleanup and aliasing logic must not see them either —
+		 * restore the published values. This runs under refresh_lock
+		 * with the cache unpublished, so it is single-writer plain
+		 * stores.
+		 */
+		gpc->pfn = old_pfn;
+		gpc->khva = old_khva_exact;
+	} while (1);
 
 	/*
 	 * Put the reference to the _new_ page.  The page is now tracked by the
@@ -248,8 +427,19 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	return 0;
 
 out_error:
-	write_lock_irq(&gpc->lock);
-
+	/*
+	 * Withdraw the announcement: no publish is coming. Leaving the bit
+	 * set would be harmless — an invalidation walk would merely veto a
+	 * publish which was never going to happen, and the next refresh or
+	 * deactivation starts by xchg'ing the whole state word to zero —
+	 * but clearing it here keeps the invariant that GPC_BECOMING_VALID
+	 * means a refresh is between announce and publish. Only VALID can
+	 * have been set here by anyone else, and only by our own publish
+	 * (which didn't happen), and INVALIDATING only by whoever clears
+	 * VALID; the sole concurrent writer is an invalidation walk also
+	 * clearing this bit, so a plain andnot cannot lose an update.
+	 */
+	atomic_andnot(GPC_BECOMING_VALID, &gpc->state);
 	return -EFAULT;
 }
 
@@ -259,7 +449,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
-	bool hva_change = false;
+	bool must_drain;
 	void *old_khva;
 	int ret;
 
@@ -269,13 +459,103 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 	lockdep_assert_held(&gpc->refresh_lock);
 
-	write_lock_irq(&gpc->lock);
+	if (!gpc->active)
+		return -EINVAL;
 
-	if (!gpc->active) {
-		ret = -EINVAL;
-		goto out_unlock;
+	/*
+	 * Resolve the target uHVA (and memslot, for a GPA-based cache) before
+	 * deciding whether anything needs to be invalidated at all.
+	 *
+	 * If the cache is still valid and this refresh resolves to exactly the
+	 * same uHVA, in the same memslot, for the same GPA, then nothing which
+	 * a reader can observe is changing: the gPA => uHVA translation is
+	 * unchanged, and GPC_VALID being set is precisely the assertion that
+	 * the second stage (uHVA => PFN, and the kernel mapping of it) is
+	 * still good. No mapping is retired, so there is nothing for a grace
+	 * period to wait for. At most the memslot generation needs updating,
+	 * which no reader consults except via kvm_gpc_check() itself.
+	 *
+	 * All of the following must hold to take this shortcut:
+	 *
+	 *  - GPC_VALID: the PFN and its kernel mapping are still good.
+	 *  - the resolved uHVA is unchanged. kvm_gpc_check() validates
+	 *    'offset + len <= PAGE_SIZE' from gpc->uhva/gpa on the reader's
+	 *    behalf, and the reader then accesses gpc->khva for 'len' bytes
+	 *    with no recheck; moving the offset under a live reader would let
+	 *    it run off the end of the page.
+	 *  - the memslot is unchanged. kvm_gpc_mark_dirty_in_slot() uses
+	 *    gpc->memslot, so replacing it under a reader could mark the wrong
+	 *    slot dirty and thus lose a dirty page for live migration.
+	 *  - the gPA is unchanged, as it provides the gfn for dirty tracking.
+	 */
+	if (atomic_read(&gpc->state) & GPC_VALID) {
+		struct kvm_memory_slot *new_slot = gpc->memslot;
+		unsigned long new_uhva = KVM_HVA_ERR_BAD;
+		u64 new_generation = gpc->generation;
+
+		if (kvm_is_error_gpa(gpa)) {
+			new_uhva = uhva;
+		} else {
+			struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
+			gfn_t gfn = gpa_to_gfn(gpa);
+
+			new_generation = slots->generation;
+			new_slot = __gfn_to_memslot(slots, gfn);
+			if (new_slot)
+				new_uhva = gfn_to_hva_memslot(new_slot, gfn) +
+					   offset_in_page(gpa);
+		}
+
+		if (!kvm_is_error_hva(new_uhva) && new_uhva == gpc->uhva &&
+		    new_slot == gpc->memslot && gpa == gpc->gpa) {
+			/*
+			 * Nothing to invalidate. A concurrent reader may be
+			 * using the cache right now and can safely continue
+			 * to do so; only the memslot generation, which is
+			 * read solely by kvm_gpc_check(), may need updating.
+			 */
+			if (new_generation != gpc->generation)
+				WRITE_ONCE(gpc->generation, new_generation);
+
+			return 0;
+		}
 	}
 
+	/*
+	 * Take the cache invalid and wait for all current readers to
+	 * drain before mutating anything they might be looking at. Once
+	 * the grace period has elapsed, this task (serialized by
+	 * refresh_lock) owns all the cache fields exclusively: readers
+	 * check valid (with an acquire load) inside their SRCU read-side
+	 * critical sections and back off. This mirrors what a TLB
+	 * shootdown does for the hardware page tables.
+	 *
+	 * The clear and the test are one operation on purpose, and the wait
+	 * triggers on GPC_INVALIDATING as well as GPC_VALID: an mmu_notifier
+	 * invalidation which cleared GPC_VALID a moment ago is not
+	 * necessarily finished — its grace period may still be running, with
+	 * readers which sampled GPC_VALID before the clear still
+	 * dereferencing gpc->khva. GPC_INVALIDATING is set by whoever clears
+	 * GPC_VALID precisely so that this path knows those readers may
+	 * exist. Our own grace-period wait below necessarily begins after
+	 * that clear, so waiting here covers them; only then may
+	 * reader-visible fields (uhva, gpa, memslot, and later pfn/khva) be
+	 * mutated or the old mapping torn down.
+	 *
+	 * The xchg leaves GPC_INVALIDATING *standing* (rather than clearing
+	 * the word outright) for the duration of the wait, for the same
+	 * reason it is tested: an mmu_notifier walk which arrives while
+	 * this grace period is still running must not read a zero state,
+	 * skip the cache, and let its caller free the page under readers
+	 * only this wait covers. The marker comes down only once the drain
+	 * is complete and the readers it advertised cannot exist.
+	 */
+	must_drain = atomic_xchg(&gpc->state, GPC_INVALIDATING) &
+		     (GPC_VALID | GPC_INVALIDATING);
+	if (must_drain)
+		synchronize_srcu_atomic(&gpc->kvm->gpc_srcu);
+	atomic_set(&gpc->state, 0);
+
 	old_pfn = gpc->pfn;
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
@@ -285,10 +565,14 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
 		gpc->gpa = INVALID_GPA;
 		gpc->memslot = NULL;
-		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
-
-		if (gpc->uhva != old_uhva)
-			hva_change = true;
+		/*
+		 * uhva stores are WRITE_ONCE(): the invalidation walks read
+		 * it without holding refresh_lock. This mutation window is
+		 * safe because the state word is 0 here (cleared by the
+		 * xchg above, announced again only in hva_to_pfn_retry()
+		 * after these stores), so no walk will match this cache.
+		 */
+		WRITE_ONCE(gpc->uhva, PAGE_ALIGN_DOWN(uhva));
 	} else {
 		struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
 
@@ -301,43 +585,31 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			gpc->gpa = gpa;
 			gpc->generation = slots->generation;
 			gpc->memslot = __gfn_to_memslot(slots, gfn);
-			gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
+			WRITE_ONCE(gpc->uhva, gfn_to_hva_memslot(gpc->memslot, gfn));
 
 			if (kvm_is_error_hva(gpc->uhva)) {
 				ret = -EFAULT;
 				goto out;
 			}
-
-			/*
-			 * Even if the GPA and/or the memslot generation changed, the
-			 * HVA may still be the same.
-			 */
-			if (gpc->uhva != old_uhva)
-				hva_change = true;
 		} else {
-			gpc->uhva = old_uhva;
+			WRITE_ONCE(gpc->uhva, old_uhva);
 		}
 	}
 
 	/* Note: the offset must be correct before calling hva_to_pfn_retry() */
-	gpc->uhva += page_offset;
+	WRITE_ONCE(gpc->uhva, gpc->uhva + page_offset);
 
 	/*
-	 * If the userspace HVA changed or the PFN was already invalid,
-	 * drop the lock and do the HVA to PFN lookup again.
+	 * Always redo the HVA to PFN lookup: an invalidation of our uhva
+	 * may have raced with (or followed) the valid-clearing above, in
+	 * which case the notifier walk skipped this cache (valid was
+	 * already false) and the old pfn may already be stale. The
+	 * gpc_invalidate_seq check in hva_to_pfn_retry() is what detects
+	 * that race, so the lookup path is the only safe way to publish.
+	 * If the mapping is in fact unchanged, hva_to_pfn_retry() reuses
+	 * the existing kernel mapping for the same pfn.
 	 */
-	if (!gpc->valid || hva_change) {
-		ret = hva_to_pfn_retry(gpc);
-	} else {
-		/*
-		 * If the HVA→PFN mapping was already valid, don't unmap it.
-		 * But do update gpc->khva because the offset within the page
-		 * may have changed.
-		 */
-		gpc->khva = old_khva + page_offset;
-		ret = 0;
-		goto out_unlock;
-	}
+	ret = hva_to_pfn_retry(gpc);
 
  out:
 	/*
@@ -346,17 +618,12 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	 * valid, leave it as is.
 	 */
 	if (ret) {
-		gpc->valid = false;
+		WARN_ON_ONCE(atomic_read(&gpc->state) & GPC_VALID);
 		gpc->pfn = KVM_PFN_ERR_FAULT;
 		gpc->khva = NULL;
 	}
 
-	/* Detect a pfn change before dropping the lock! */
 	unmap_old = (old_pfn != gpc->pfn);
-
-out_unlock:
-	write_unlock_irq(&gpc->lock);
-
 	if (unmap_old)
 		gpc_unmap(old_pfn, old_khva);
 
@@ -385,14 +652,14 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 		    bool never_dirty)
 {
-	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
 
 	gpc->kvm = kvm;
 	gpc->pfn = KVM_PFN_ERR_FAULT;
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
-	gpc->active = gpc->valid = false;
+	gpc->active = false;
+	atomic_set(&gpc->state, 0);
 	gpc->never_dirty = never_dirty;
 }
 
@@ -407,7 +674,7 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 	guard(mutex)(&gpc->refresh_lock);
 
 	if (!gpc->active) {
-		if (KVM_BUG_ON(gpc->valid, kvm))
+		if (KVM_BUG_ON(atomic_read(&gpc->state) & GPC_VALID, kvm))
 			return -EIO;
 
 		spin_lock(&kvm->gpc_lock);
@@ -417,11 +684,11 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 		/*
 		 * Activate the cache after adding it to the list, a concurrent
 		 * refresh must not establish a mapping until the cache is
-		 * reachable by mmu_notifier events.
+		 * reachable by mmu_notifier events. (Refreshes are serialized
+		 * by refresh_lock, which we hold; the store ordering matters
+		 * only against the notifier walk, which holds gpc_lock.)
 		 */
-		write_lock_irq(&gpc->lock);
-		gpc->active = true;
-		write_unlock_irq(&gpc->lock);
+		WRITE_ONCE(gpc->active, true);
 	}
 	return __kvm_gpc_refresh(gpc, gpa, uhva);
 }
@@ -456,13 +723,28 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 
 	if (gpc->active) {
 		/*
-		 * Deactivate the cache before removing it from the list, KVM
-		 * must stall mmu_notifier events until all users go away, i.e.
-		 * until gpc->lock is dropped and refresh is guaranteed to fail.
+		 * Mark the cache inactive and invalid, and wait for all
+		 * current readers to drain, before tearing down the mapping
+		 * they may have been using. Refreshes are excluded by
+		 * refresh_lock, which we hold.
+		 */
+		WRITE_ONCE(gpc->active, false);
+
+		/*
+		 * As in __kvm_gpc_refresh(): clear and test in one
+		 * operation, waiting on GPC_INVALIDATING as well as
+		 * GPC_VALID. An invalidation which cleared GPC_VALID first
+		 * may still be inside its own synchronize_srcu() with
+		 * readers outstanding — it left GPC_INVALIDATING set to say
+		 * so — and the unmap below must not run under those readers.
+		 * And, also as there, leave GPC_INVALIDATING standing until
+		 * the drain completes, so that an mmu_notifier walk arriving
+		 * mid-wait does not read a zero state and skip the cache.
 		 */
-		write_lock_irq(&gpc->lock);
-		gpc->active = false;
-		gpc->valid = false;
+		if (atomic_xchg(&gpc->state, GPC_INVALIDATING) &
+		    (GPC_VALID | GPC_INVALIDATING))
+			synchronize_srcu_atomic(&kvm->gpc_srcu);
+		atomic_set(&gpc->state, 0);
 
 		/*
 		 * Leave the GPA => uHVA cache intact, it's protected by the
@@ -475,7 +757,6 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 
 		old_pfn = gpc->pfn;
 		gpc->pfn = KVM_PFN_ERR_FAULT;
-		write_unlock_irq(&gpc->lock);
 
 		spin_lock(&kvm->gpc_lock);
 		list_del(&gpc->list);
-- 
2.43.0

