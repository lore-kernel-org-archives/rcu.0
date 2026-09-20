Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B31B3D5657;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939195; cv=none; b=VBlJsUp6pSbjaeUQ1+ORE2r3jSCwaUbq1Fz2LrXM7/D9ckcBRA7USvRhQmEpPJOXDi9J7huan9dZL1ciQLv2YhGE90Ddh5RffPUnm33oN0Z+IEAQOwe0AwDBY71+adKD86mOHCJA+KUCgfGnUekIf9qeVa/KtPaUI1rXzHOHogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939195; c=relaxed/simple;
	bh=8a9yaFCZ1phH1ADNQ3eJFWmfVMoo4hglym05z6fkJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgyMeiTDAWi3jvd8rygQ5yR4pdAA5RaAPdXcIOyp0QcrF690o/pYRHC7PhoCmfELzVC2FDhlUxHUDzki0s5c9AzfuNl2s1sD6tamA1Eg4dfEo9m61QuQykQ0OP7AAqaxK7XtwI64eWobEkDz6iWgXvz0LWTxXy0bUgVFpaP7lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ovUkAIiY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ovUkAIiY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=nmDCZIQtvAljsPRGM/byezdxbY6oJbhclu7Tywf5i+U=; b=ovUkAIiY5uwV7JBnrXwUqjrJ+x
	lSD7IaXIsy3mGfUve32BvmCEZUViSvrwQO32BFPtBBseKricq8cY+J33RZV6jTin4IEYjHfjszKds
	xIu7+L2FCOE7emHpPOzSh9BJ4YzVzWZs2NwM5o7ii1XmQ+BIaqBwW0kFG7RRk3FOUoYA5eHQenb9v
	eTfmJz4fRJDoY9oHQoSW1mymPd1ybr52Shp+YsPj8RJtoT/W4RsZO1nYAMgj0nOt1NPKVpHP5MDGK
	eErBXEuhY4G8lvQl0dJUyq4Kh5NGjlsU5j4niAVJ5IRdJx8btIJu8L+Lc/LfbQq3vb16jHnuc9nAN
	nwoKkjDg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000BdxU-49rX;
	Sun, 20 Sep 2026 21:19:44 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcP-0aOD;
	Sun, 20 Sep 2026 22:19:22 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Keir Fraser <keirf@google.com>,
	David Matlack <dmatlack@google.com>,
	nh-open-source@amazon.com,
	David Woodhouse <dwmw@amazon.co.uk>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Subject: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
Date: Sun, 20 Sep 2026 21:49:29 +0100
Message-ID: <20260920211920.928306-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
domain (kvm->gpc_srcu) for the read side. Readers now run under
srcu_read_lock_atomic() alone — preemption disabled and non-blocking
enforced, which every GPC read-side section already satisfied as a
former rwlock critical section. It works in any context
(including hardirq and sched-out paths) and never fails or spins,
eliminating the
read_trylock() contortions in the atomic paths, the double-lock dance
with the lockdep subclass hack in the runstate update, and the
PREEMPT_RT problems inherent to taking an rwlock in those contexts.
In particular, kvm_xen_set_evtchn_fast() is called from hardirq
context (timer callback, kvm_arch_set_irq_inatomic()), where taking
gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.

The mutators' reader drains use synchronize_srcu_atomic(), which
spins for the bounded readers instead of sleeping: no path waiting
out GPC readers ever schedules, satisfying even the strictest
reading of the OOM-reaper non-blocking requirement in the
invalidation walk. The srcu_struct is initialized with
init_srcu_struct_atomic() so the domain is declared atomic up front
rather than latched at the first reader.

SRCU rather than plain RCU because the write side must wait for
readers: with a per-VM srcu_struct, that wait covers only this VM's
GPC readers, not a grace period across every pCPU in the system —
which matters on large hosts running many small guests, where a
vCPU's refresh must not stall on unrelated load. The read-side cost
is a this_cpu_inc() and a barrier.

The invariant is that a cache's fields (pfn, khva, uhva, gpa, memslot)
are only
ever mutated after clearing GPC_VALID and waiting for a full grace
period, so any reader which observed GPC_VALID (with an acquire load,
paired with the release store publishing the fields) has stable values
for its entire SRCU read-side critical section — including writes
through khva, which are guaranteed to land before the backing page can
be unmapped, exactly as with a TLB shootdown.

The mmu_notifier invalidation path clears GPC_VALID on any overlapping
cache and then does synchronize_srcu_expedited() before returning, so the
primary MMU cannot proceed to zap the page tables until all readers of
the stale mapping have drained. This wait happens even on unblockable
(OOM reaper) ranges: the actual constraint on those is not "no
sleeping" but "no blocking on anything which may itself depend on
memory allocation to make progress", and GPC readers never allocate,
never take mmap_lock, and never sleep. (The one allocation in the
SRCU grace-period machinery itself, on the one-time transition of an
srcu_struct to its node tree, is addressed separately.) The previous
patch removed the over-broad non_block_start() debug annotation which
would have splatted on any voluntary schedule regardless.

Dropping gpc->lock means the refresh can no longer rely on holding it
to make its final invalidation check and its publish atomic with
respect to the mmu_notifier walk, and can no longer treat "GPC_VALID
is already clear" as "no readers remain". Three state bits therefore
live in a single atomic word:

 - GPC_BECOMING_VALID is set before the uHVA is resolved and before
   any lock is dropped. The invalidation walk keys on it as well as on
   GPC_VALID, so a cache whose refresh is in flight is *not* skipped:
   its uHVA is already known, and clearing the bit vetoes the pending
   publish. The announce is ordered after the uHVA store with
   smp_mb__before_atomic() (atomic_or() alone is unordered), pairing
   with the walk's acquire load of the state word: a walker which
   observes the bit observes the uHVA the refresh is resolving, so the
   veto is aimed at the right cache. The walk reads uhva with
   READ_ONCE() (and the refresh writes it with WRITE_ONCE()); the
   refresh only mutates uhva while the state word is zero, so a walker
   which sees either bit sees a current value.

 - The publish is a cmpxchg from GPC_BECOMING_VALID to GPC_VALID. If
   an invalidation of this uHVA landed at any point since the bit was
   set — including in the window after the last retry check — the bit
   is gone, the cmpxchg fails, and the refresh goes around again.
   Without this, an invalidation which starts and completes entirely
   within that window is missed by both mechanisms: the walk skips the
   cache because it is not valid (and so does not even wait for a
   grace period), and the refresh never re-checks. On a vetoed
   publish the speculatively stored pfn/khva are restored to the
   previously published values, and the retry loop's own bookkeeping
   (the mapping-reuse comparison and the unmap of a failed attempt)
   works exclusively from locals: cache fields never carry a doomed
   attempt's mapping, which the loop could otherwise free while the
   cache still referenced it.

 - GPC_INVALIDATING is set in the same atomic operation that clears
   GPC_VALID, and means "a grace period for the previously published
   mapping is owed and not known to be complete". A refresh or
   deactivation entering while the invalidator's synchronize_srcu()
   is still in flight would otherwise find GPC_VALID already clear,
   skip its own wait, and mutate reader-visible fields under readers
   which sampled GPC_VALID before the clear. The mutators consume the
   state word with atomic_xchg() and wait whenever either bit was
   set; their wait necessarily begins after the clear which set the
   marker, so it covers every reader the original clearer is still
   waiting for. The invalidator deliberately never clears the marker:
   with overlapping invalidate/republish cycles, an earlier
   invalidation completing its wait cannot know that a later one is
   not still draining the same cache.

As with the rwlock version, a refresh which resolves to the same uHVA,
in the same memslot, for the same gPA does not need to invalidate the
cache at all: the gPA => uHVA translation has not changed, and
GPC_VALID already asserts that the uHVA => PFN mapping is good. Such a
refresh updates only the memslot generation and returns, leaving
concurrent readers undisturbed and skipping the grace period entirely.
This matters because the mmu_notifier invalidates caches on any host
memory management activity (page migration, NUMA balancing, KSM), and
the affected pages usually come straight back at the same uHVA; making
each of those cost a full grace period in the reader's refresh path
would add seconds to a guest boot.

Refreshes are serialized by the existing refresh_lock mutex, and the
gpc_invalidate_seq mechanism continues to catch invalidations which
race with the (lockless) HVA->PFN lookup.

Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
Tested-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/x86.c        |  10 +-
 arch/x86/kvm/xen.c        | 111 ++++------
 include/linux/kvm_host.h  |  25 ++-
 include/linux/kvm_types.h |  37 +++-
 include/linux/srcu.h      |   7 +
 virt/kvm/kvm_main.c       |   9 +
 virt/kvm/pfncache.c       | 424 +++++++++++++++++++++++++++++---------
 7 files changed, 439 insertions(+), 184 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..ccca707d768f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1719,18 +1719,18 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
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
@@ -1755,7 +1755,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	guest_hv_clock->version = ++hv_clock.version;
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..ea907f5fa5f8 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -45,16 +45,17 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
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
@@ -97,7 +98,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	smp_wmb();
 
 	wc->version = wc_version + 1;
-	read_unlock_irq(&gpc->lock);
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 
 out:
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -154,22 +155,21 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
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
@@ -324,12 +324,12 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
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
@@ -416,20 +416,12 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 
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
@@ -438,7 +430,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		if (kvm_gpc_refresh(gpc1, user_len1))
 			return;
 
-		read_lock_irqsave(&gpc1->lock, flags);
+		idx = srcu_read_lock_atomic(&v->kvm->gpc_srcu);
 	}
 
 	if (likely(!user_len2)) {
@@ -458,24 +450,11 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
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
@@ -574,13 +553,11 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
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
@@ -655,7 +632,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
 	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
-	unsigned long flags;
+	int idx;
 
 	if (!evtchn_pending_sel)
 		return;
@@ -665,14 +642,14 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
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
 	}
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
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
 
@@ -1480,14 +1457,13 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
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
@@ -1505,8 +1481,8 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
 		}
 	}
 
- out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+ out_gpc_srcu:
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	return ret;
@@ -1847,10 +1823,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
 	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
 	struct kvm_vcpu *vcpu;
-	unsigned long flags;
 	int port_word_bit;
 	bool kick_vcpu = false;
-	int vcpu_idx, idx, rc;
+	int vcpu_idx, idx, gpc_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
 	if (vcpu_idx >= 0)
@@ -1869,9 +1844,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
+	gpc_idx = srcu_read_lock_atomic(&kvm->gpc_srcu);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
+		goto out_gpc_srcu;
 
 	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
@@ -1909,10 +1884,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
 		gpc = &vcpu->arch.xen.vcpu_info_cache;
 
-		read_lock_irqsave(&gpc->lock, flags);
 		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
@@ -1920,7 +1893,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 			 */
 			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
 				kick_vcpu = true;
-			goto out_rcu;
+			goto out_gpc_srcu;
 		}
 
 		/*
@@ -1955,8 +1928,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		}
 	}
 
- out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+ out_gpc_srcu:
+	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3dd04605f2e5..9da947eb08ed 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -806,6 +806,15 @@ struct kvm {
 	/* For management / invalidation of gfn_to_pfn_caches */
 	spinlock_t gpc_lock;
 	struct list_head gpc_list;
+	/*
+	 * Protects the contents of active gfn_to_pfn_caches. Readers hold it
+	 * across kvm_gpc_check() and any subsequent access to gpc->khva; the
+	 * invalidation and refresh paths clear gpc->valid and then wait for a
+	 * grace period before mutating anything a reader might be looking at.
+	 * A dedicated domain (rather than kvm->srcu) keeps those waits from
+	 * being lengthened by unrelated memslot readers.
+	 */
+	struct srcu_struct gpc_srcu;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -1510,12 +1519,9 @@ int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsign
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
 
@@ -1532,8 +1538,8 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len);
  * This will attempt to refresh a gfn_to_pfn_cache. Note that a successful
  * return from this function does not mean the page can be immediately
  * accessed because it may have raced with an invalidation. Callers must
- * still lock and check the cache status, as this function does not return
- * with the lock still held to permit access.
+ * still check the cache status under a kvm->gpc_srcu read lock, via
+ * kvm_gpc_check(), before accessing the target page.
  */
 int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len);
 
@@ -1974,7 +1980,8 @@ static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 
 static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 {
-	lockdep_assert_held(&gpc->lock);
+	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&gpc->kvm->gpc_srcu),
+			 "kvm_gpc_mark_dirty_in_slot() without kvm->gpc_srcu read lock");
 
 	if (!gpc->memslot)
 		return;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..31f3eb0dd2aa 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -88,14 +88,47 @@ struct gfn_to_pfn_cache {
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
index 108d42c5c1d6..bf0c21969726 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1152,6 +1152,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		goto out_err_no_srcu;
 	if (init_srcu_struct(&kvm->irq_srcu))
 		goto out_err_no_irq_srcu;
+	if (init_srcu_struct_atomic(&kvm->gpc_srcu))
+		goto out_err_no_gpc_srcu;
 
 	r = kvm_init_irq_routing(kvm);
 	if (r)
@@ -1232,6 +1234,8 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
 		kfree(kvm_get_bus_for_destruction(kvm, i));
 	kvm_free_irq_routing(kvm);
 out_err_no_irq_routing:
+	cleanup_srcu_struct(&kvm->gpc_srcu);
+out_err_no_gpc_srcu:
 	cleanup_srcu_struct(&kvm->irq_srcu);
 out_err_no_irq_srcu:
 	cleanup_srcu_struct(&kvm->srcu);
@@ -1308,6 +1312,11 @@ static void kvm_destroy_vm(struct kvm *kvm)
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
index 3659686b97c2..067da05a87ac 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -26,35 +26,115 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 				       unsigned long end)
 {
 	struct gfn_to_pfn_cache *gpc;
+	bool cleared = false;
 
 	spin_lock(&kvm->gpc_lock);
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
+		 */
+		unsigned long gpc_uhva;
+		int old, new;
 
-		/* Only a single page so no need to care about length */
-		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-		    gpc->uhva >= start && gpc->uhva < end) {
-			read_unlock_irq(&gpc->lock);
+		old = atomic_read_acquire(&gpc->state);
+		if (!(old & (GPC_VALID | GPC_BECOMING_VALID)))
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
-
-			write_lock_irq(&gpc->lock);
-			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
-			    gpc->uhva >= start && gpc->uhva < end)
-				gpc->valid = false;
-			write_unlock_irq(&gpc->lock);
-			continue;
+			do {
+				new = old & ~(GPC_VALID | GPC_BECOMING_VALID);
+				if (old & GPC_VALID)
+					new |= GPC_INVALIDATING;
+			} while (!atomic_try_cmpxchg(&gpc->state, &old, new));
+
+			if (old & GPC_VALID)
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
+	 * The expedited variant: this stalls progress of the primary MMU
+	 * operation which triggered the invalidation, and the readers being
+	 * drained are bounded, short, non-sleeping sections. Expedited SRCU
+	 * does not IPI; it only polls the (per-VM) domain more aggressively.
+	 *
+	 * (The one allocation in the SRCU grace-period machinery itself —
+	 * the srcu_node tree on the one-time upgrade of a contended
+	 * srcu_struct — is dealt with separately, by having srcu_gp_end()
+	 * allocate with GFP_NOWAIT and fall back to a preallocated spare,
+	 * so the grace period never blocks in reclaim either.)
+	 */
+	if (cleared)
+		synchronize_srcu_expedited(&kvm->gpc_srcu);
+
+	/*
+	 * Note the GPC_INVALIDATING markers set above are deliberately NOT
+	 * cleared here. Clearing them safely requires knowing that no
+	 * *other* invalidation's grace period is still covering the same
+	 * cache (consider a republish-and-reinvalidate cycle completing
+	 * entirely within this synchronize_srcu()). Only a party which is
+	 * about to mutate the cache — and which therefore performs its own
+	 * wait, necessarily beginning after the VALID clear which set the
+	 * marker — can meaningfully clear it. Readers ignore the bit; if no
+	 * mutation ever follows, it sits there harmlessly.
+	 */
 }
 
 static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
@@ -74,6 +154,22 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 {
 	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
 
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
 	if (!gpc->active)
 		return false;
 
@@ -81,7 +177,8 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	 * If the page was cached from a memslot, make sure the memslots have
 	 * not been re-configured.
 	 */
-	if (!kvm_is_error_gpa(gpc->gpa) && gpc->generation != slots->generation)
+	if (!kvm_is_error_gpa(gpc->gpa) &&
+	    READ_ONCE(gpc->generation) != slots->generation)
 		return false;
 
 	if (kvm_is_error_hva(gpc->uhva))
@@ -90,9 +187,6 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	if (!kvm_gpc_is_valid_len(gpc->gpa, gpc->uhva, len))
 		return false;
 
-	if (!gpc->valid)
-		return false;
-
 	return true;
 }
 
@@ -134,8 +228,8 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long gpc_s
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
@@ -156,10 +250,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
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
@@ -171,21 +268,32 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 
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
 		gpc_seq = gpc->kvm->gpc_invalidate_seq;
 		smp_rmb();
 
-		write_unlock_irq(&gpc->lock);
-
 		/*
 		 * If the previous iteration "failed" due to an mmu_notifier
 		 * event, release the pfn and unmap the kernel virtual address
@@ -213,9 +321,15 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
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
@@ -225,18 +339,39 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
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
@@ -248,8 +383,19 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
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
 
@@ -259,7 +405,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
-	bool hva_change = false;
+	bool must_drain;
 	void *old_khva;
 	int ret;
 
@@ -269,13 +415,94 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
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
+	 */
+	must_drain = atomic_xchg(&gpc->state, 0) &
+		     (GPC_VALID | GPC_INVALIDATING);
+	if (must_drain)
+		synchronize_srcu_expedited(&gpc->kvm->gpc_srcu);
+
 	old_pfn = gpc->pfn;
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
@@ -285,10 +512,14 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 
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
 
@@ -301,43 +532,33 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			gpc->gpa = gpa;
 			gpc->generation = slots->generation;
 			gpc->memslot = __gfn_to_memslot(slots, gfn);
-			gpc->uhva = gfn_to_hva_memslot(gpc->memslot, gfn);
+			WRITE_ONCE(gpc->uhva, gfn_to_hva_memslot(gpc->memslot, gfn));
 
 			if (kvm_is_error_hva(gpc->uhva)) {
 				ret = -EFAULT;
 				goto out;
 			}
 
-			/*
-			 * Even if the GPA and/or the memslot generation changed, the
-			 * HVA may still be the same.
-			 */
-			if (gpc->uhva != old_uhva)
-				hva_change = true;
+
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
@@ -346,17 +567,12 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
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
 
@@ -384,14 +600,14 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
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
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
@@ -405,7 +621,7 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
 	guard(mutex)(&gpc->refresh_lock);
 
 	if (!gpc->active) {
-		if (KVM_BUG_ON(gpc->valid, kvm))
+		if (KVM_BUG_ON(atomic_read(&gpc->state) & GPC_VALID, kvm))
 			return -EIO;
 
 		spin_lock(&kvm->gpc_lock);
@@ -415,11 +631,11 @@ static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned
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
@@ -454,13 +670,24 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 
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
 		 */
-		write_lock_irq(&gpc->lock);
-		gpc->active = false;
-		gpc->valid = false;
+		if (atomic_xchg(&gpc->state, 0) &
+		    (GPC_VALID | GPC_INVALIDATING))
+			synchronize_srcu_atomic(&kvm->gpc_srcu);
 
 		/*
 		 * Leave the GPA => uHVA cache intact, it's protected by the
@@ -473,7 +700,6 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 
 		old_pfn = gpc->pfn;
 		gpc->pfn = KVM_PFN_ERR_FAULT;
-		write_unlock_irq(&gpc->lock);
 
 		spin_lock(&kvm->gpc_lock);
 		list_del(&gpc->list);
-- 
2.55.0

