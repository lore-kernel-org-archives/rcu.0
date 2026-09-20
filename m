Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1013E4C66;
	Sun, 20 Sep 2026 21:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940187; cv=none; b=hxDHHOQTO+iXLzob8gv8S86lL5L6sMBsRnwBKJ5VQr6lgcH+8ul2t6Cn0ONCV4gEwxbA8yjQZdyJXq+nSpezc38XfNK5NRosnnEPRD2kXqJ70iSkZ0hwdx5hlnyDIsU93f3w4lS0b9y7/fZx99lBKHbtIm2krBc5dFObwT4ZDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940187; c=relaxed/simple;
	bh=YEKc3KrrpzXNpHGoHDiDFhyeTmmfIwwffuJ6Afu5laM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7hCu/OJWyvXCiHBHJDIdpVtXdbWY7R/+KYyHwN/DOVP9YNXP1WsYMivkjSfbj3qOEULntVHby8fhesljcDy/rW3VQLKtJsaqPejV4NL7kfg6xIlyS18IA1Sx+PniAVOVQCJY5aHyNyDGgFI0VDrd/+5X6XLWT1+iE8iEnv81mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ns+kCvf9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ns+kCvf9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=irbaFFZajVxC5/Wt9TrvGpRjKURVSE2MRN0j3OZs2wQ=; b=Ns+kCvf97JV//OtP9/8ZXcpKe4
	xVEq42LT1UCEqe9smkNOh3J7H8F6Q5IN+yKXyuJjUNk4IB9h2z9kvl60yQwKQnyhnGRCVkga7d3+t
	cWLpETytD+uBV8xxD5HZHqjWP2Qi9JfOlvH/ceTvrS8dQpPH5PVDkWHF6+WUTBGrMY/4dceTgG+rc
	NTqwM/DO+z2A332cGlpofS561ReBN95f085qEr5kxxS9o7E3JGx7x6oEhj3dDNudBGeHH1G2yAJz1
	9TohaIErVj9EnGd5SPmMDvEWlfzW8nOAPy4ROSSFzL4nnvS3urjw27GCa8ofCLRvZPyefEy+eOAi6
	74oo2jEw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpv-2tu6;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcj-1sBU;
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
	Carsten Stollmaier <stollmc@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 06/17] KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
Date: Sun, 20 Sep 2026 21:49:34 +0100
Message-ID: <20260920211920.928306-7-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Carsten Stollmaier <stollmc@amazon.com>

This largely reverts commit 7e2175ebd695 ("KVM: x86: Fix recording of
guest steal time / preempted status"), which dropped the use of the
gfn_to_pfn_cache because it was not integrated with the MMU notifiers
at the time. That shortcoming has long since been addressed, making
the GPC work correctly for this use case.

Aside from cleaning up the last open-coded assembler access to user
addresses and associated explicit asm exception fixups, moving back
to the now-functional GPC also resolves an issue with contention on
the mmap_lock with userfaultfd. The contention issue is as follows:

On vcpu_run, before entering the guest, the update of the steal time
information causes a page-fault if the page is not present. In our
scenario, this gets handled by do_user_addr_fault() and successively
handle_userfault() because the region is registered to that.

Since handle_userfault() uses TASK_INTERRUPTIBLE, it is interruptible
by signals. But do_user_addr_fault() then busy-retries if the pending
signal is non-fatal, which leads to heavy contention of the mmap_lock.

By restoring the use of GPC for accessing the guest steal time, the
contention is avoided and refreshing the GPC happens when the vCPU is
next scheduled.

Since the gfn_to_pfn_cache gives a kernel mapping rather than a
userspace HVA, accesses are now plain C instead of unsafe_put_user()
et al. Use READ_ONCE()/WRITE_ONCE() to prevent the compiler from
reordering or tearing the accesses, and add an smp_wmb() before the
final version increment to ensure the data writes are ordered before
the seqcount update — the old unsafe_put_user() inline assembly acted
as an implicit compiler barrier.

In kvm_steal_time_set_preempted(), which is called from the scheduler
path via kvm_sched_out(), just take the RCU read lock and bail if the
cache is not currently valid. The cache cannot be refreshed from that
context, but setting the preempted flag is best-effort anyway — the
old HVA-based code used copy_to_user_nofault(), which could equally
silently fail — and kvm_arch_vcpu_load() unconditionally raises
KVM_REQ_STEAL_UPDATE, so record_steal_time() will refresh the cache
from task context before the vCPU next enters the guest.

[dwmw2: Port to RCU-protected GPC. The original was written against a
        gpc->lock rwlock and needed a read_trylock() dance to be safe
        from the scheduler path on PREEMPT_RT; rcu_read_lock() is
        unconditionally safe there, so all of that goes away.]

Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/msrs.c             |   7 +-
 arch/x86/kvm/x86.c              | 119 +++++++++++++++-----------------
 3 files changed, 62 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3af7395c2430..97828eecc93e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -874,7 +874,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache cache;
+		struct gfn_to_pfn_cache cache;
 	} st;
 
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..3dd848c3f190 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1717,8 +1717,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		vcpu->arch.st.msr_val = data;
 
-		if (!(data & KVM_MSR_ENABLED))
+		if (!(data & KVM_MSR_ENABLED)) {
+			kvm_gpc_deactivate(&vcpu->arch.st.cache);
 			break;
+		}
+
+		kvm_gpc_activate(&vcpu->arch.st.cache, data & ~KVM_MSR_ENABLED,
+				 sizeof(struct kvm_steal_time));
 
 		kvm_make_request(KVM_REQ_STEAL_UPDATE, vcpu);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3db1855aba79..116932e13d59 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2047,12 +2047,11 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
 static void record_steal_time(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 	u64 steal;
 	u32 version;
+	int idx;
 
 	if (kvm_xen_msr_enabled(vcpu->kvm)) {
 		kvm_xen_runstate_set_running(vcpu);
@@ -2065,42 +2064,27 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
+	/* We rely on the fact that it fits in a single page. */
+	BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
 
-	if (unlikely(slots->generation != ghc->generation ||
-		     gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
-		/* We rely on the fact that it fits in a single page. */
-		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
+	idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
+	while (!kvm_gpc_check(gpc, sizeof(*st))) {
+		srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 
-		if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st)) ||
-		    kvm_is_error_hva(ghc->hva) || !ghc->memslot)
+		if (kvm_gpc_refresh(gpc, sizeof(*st)))
 			return;
+
+		idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
 	}
 
-	st = (struct kvm_steal_time __user *)ghc->hva;
+	st = gpc->khva;
+
 	/*
 	 * Doing a TLB flush here, on the guest's behalf, can avoid
 	 * expensive IPIs.
 	 */
 	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
-		u8 st_preempted = 0;
-		int err = -EFAULT;
-
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		asm volatile("1: xchgb %0, %2\n"
-			     "xor %1, %1\n"
-			     "2:\n"
-			     _ASM_EXTABLE_UA(1b, 2b)
-			     : "+q" (st_preempted),
-			       "+&r" (err),
-			       "+m" (st->preempted));
-		if (err)
-			goto out;
-
-		user_access_end();
+		u8 st_preempted = xchg(&st->preempted, 0);
 
 		vcpu->arch.st.preempted = 0;
 
@@ -2122,39 +2106,33 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 		 */
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
 			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
-
-		if (!user_access_begin(st, sizeof(*st)))
-			goto dirty;
 	} else {
-		if (!user_access_begin(st, sizeof(*st)))
-			return;
-
-		unsafe_put_user(0, &st->preempted, out);
+		WRITE_ONCE(st->preempted, 0);
 		vcpu->arch.st.preempted = 0;
 	}
 
-	unsafe_get_user(version, &st->version, out);
+	version = READ_ONCE(st->version);
 	if (version & 1)
 		version += 1;  /* first time write, random junk */
 
 	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	WRITE_ONCE(st->version, version);
 
 	smp_wmb();
 
-	unsafe_get_user(steal, &st->steal, out);
+	steal = READ_ONCE(st->steal);
 	steal += current->sched_info.run_delay -
 		vcpu->arch.st.last_steal;
 	vcpu->arch.st.last_steal = current->sched_info.run_delay;
-	unsafe_put_user(steal, &st->steal, out);
+	WRITE_ONCE(st->steal, steal);
+
+	smp_wmb();
 
 	version += 1;
-	unsafe_put_user(version, &st->version, out);
+	WRITE_ONCE(st->version, version);
 
- out:
-	user_access_end();
- dirty:
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+	kvm_gpc_mark_dirty_in_slot(gpc);
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
 }
 
 static inline bool kvm_can_mwait_in_guest(void)
@@ -2628,11 +2606,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 {
-	struct gfn_to_hva_cache *ghc = &vcpu->arch.st.cache;
-	struct kvm_steal_time __user *st;
-	struct kvm_memslots *slots;
-	static const u8 preempted = KVM_VCPU_PREEMPTED;
-	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.st.cache;
+	struct kvm_steal_time *st;
 
 	/*
 	 * The vCPU can be marked preempted if and only if the VM-Exit was on
@@ -2657,20 +2632,31 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
 	if (unlikely(current->mm != vcpu->kvm->mm))
 		return;
 
-	slots = kvm_memslots(vcpu->kvm);
-
-	if (unlikely(slots->generation != ghc->generation ||
-		     gpa != ghc->gpa ||
-		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))
-		return;
-
-	st = (struct kvm_steal_time __user *)ghc->hva;
-	BUILD_BUG_ON(sizeof(st->preempted) != sizeof(preempted));
-
-	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)))
+	/*
+	 * This is called from the scheduler path (via kvm_sched_out), so
+	 * the cache cannot be refreshed here.  Setting 'preempted' is
+	 * best-effort anyway; the old HVA-based code used
+	 * copy_to_user_nofault(), which could also silently fail.  If the
+	 * cache is invalid, it will be refreshed from task context by
+	 * record_steal_time() before the vCPU next enters the guest, since
+	 * kvm_arch_vcpu_load() unconditionally raises KVM_REQ_STEAL_UPDATE.
+	 */
+	guard(srcu_atomic)(&vcpu->kvm->gpc_srcu);
+	if (kvm_gpc_check(gpc, sizeof(*st))) {
+		st = gpc->khva;
+		WRITE_ONCE(st->preempted, KVM_VCPU_PREEMPTED);
 		vcpu->arch.st.preempted = KVM_VCPU_PREEMPTED;
 
-	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
+		kvm_gpc_mark_dirty_in_slot(gpc);
+	}
+}
+
+static void kvm_steal_time_reset(struct kvm_vcpu *vcpu)
+{
+	kvm_gpc_deactivate(&vcpu->arch.st.cache);
+	vcpu->arch.st.preempted = 0;
+	vcpu->arch.st.msr_val = 0;
+	vcpu->arch.st.last_steal = 0;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -9368,6 +9354,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
 
+	kvm_gpc_init(&vcpu->arch.st.cache, vcpu->kvm);
+
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	else
@@ -9475,6 +9463,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_mmu_unload(vcpu);
 
+	kvm_steal_time_reset(vcpu);
+
 	kvmclock_reset(vcpu);
 
 	for_each_possible_cpu(cpu)
@@ -9595,7 +9585,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val = 0;
 	vcpu->arch.apf.msr_int_val = 0;
-	vcpu->arch.st.msr_val = 0;
+
+	kvm_steal_time_reset(vcpu);
 
 	kvmclock_reset(vcpu);
 
-- 
2.55.0

