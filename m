Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=O3tLJPt4lAg3qbJDwctoQ3Py9Su/r/E+lwsUEVJ75T43YeiANWfGr9YtPo983id603rd
	 8/LGsyppiQy42lbj6z0+g0m8PtU2o+Q0OWt59MMc4xYfy16hvvohmbjWW39joruswlb72
	 Cxd7oQSW58D+BXJqNdTuOg1Z6gCd+D3cLzv9BwB6QvHRt1jBFRe1aQGdl/ToDSduQGg7k
	 pgZeIv0bKBw5zfIMcrPneRbKN8bR/6qMDJ1NslVtsL9tE5vyvOGTqPwDI3hyoyP/vCsA4
	 ocVksfhlJc/NPDOkBojusIIpkQa1MDa67DUH1vyi5g5Tk80PYW73lKaCYbhMM9Qdatw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=8OScpE0FBH4jzhyM8NQfWUyjdAAqoPLioveXmLb2kcA=;
	b=t2OCp+pzaAfXLmX3Jdpbsi4KnDvYIXREho3Y2fAnAi54XOeEuU6tH0vlJnGg4z1RqN3X
	 Pv6Mxh4wHWiXbMATWoZaoG5myIAxuALPWCJpsRQFp9+n819RImQHCO1Yp9HldcnlnuXVA
	 oPbX7nni+zAHtiInAmAHqohKq2ebZyakgSg9EOIYV+qq18o5jfDKRppz+o1vmperjWcoG
	 QOCvf0eGz0lTj2ya+W8hEh6QWUvgTdmt+KHgrWXXJZiBgp3trwzJYSFGLsGyERm6jk4xj
	 p8auZNSRLaQgAKkMCPrwHENmuoepE1L1/nsin1in1nYcalQtig4k/XYMP0LiieVhIIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pdGLH5Os;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAA606A334;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAAA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=pdGLH5Os
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=8OScpE0FBH4jzhyM8NQfWUyjdAAqoPLioveXmLb2kcA=; b=pdGLH5OsdZr8EtyKIJmt5IQH7C
	HMAP0xrE9eMwFFAslFyxq52n7DdB0E65EfRvLuAPgDE7AZ8V99ljYb9ygdzUze1U92MQb4DIn00Fv
	g57J0EjspdfGGvZ60oGWTIqEdK3IyrKcZYyW2JxPfpSypMIFtEScrsZSZR8TP+x0m4WmrcCR28c4H
	YUkVVN8HM2jBMYF88K73U/GDjdav1dpqrYqwDWnmf7vR1bKcvq0ZYNa80JBshkz1OCf3UTMLgMtOR
	kEawzuAu3mHxoEKInA6AfDPTLvlJkAtx8R+afzLFvkmHO4PZxJ+fKY3cIBhEngveKkcfDNHUY2KIs
	B2jIzEeg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jB-0EFY;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDS-1oI4;
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
Subject: [PATCH v2 09/20] KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
Date: Thu,  5 Nov 2026 02:00:51 +0000
Message-ID: <20261105020104.2507083-10-dwmw2@infradead.org>
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
et al. READ_ONCE()/WRITE_ONCE() and an smp_wmb() before the final
version increment replace the ordering the old inline assembly
provided implicitly.

kvm_steal_time_set_preempted(), called from the scheduler path, just
takes the atomic SRCU read lock (unconditionally safe there) and
bails if the cache is not currently valid: setting the preempted
flag is best-effort anyway — the old code used
copy_to_user_nofault(), which could equally silently fail — and
kvm_arch_vcpu_load() raises KVM_REQ_STEAL_UPDATE, so the cache is
refreshed from task context before the vCPU next enters the guest.

MSR disable (kvm_steal_time_reset()) leaves last_steal alone: it is
the baseline against the vCPU task's monotonic run_delay, and zeroing
it would dump the task's lifetime run_delay into the guest's steal
counter when the MSR is next enabled (e.g. after INIT-SIPI or kexec).

[dwmw2: Port to the SRCU-protected GPC. The original was written
        against a gpc->lock rwlock and needed a read_trylock() dance
        to be safe from the scheduler path on PREEMPT_RT; the atomic
        SRCU read lock is unconditionally safe there, so all of that
        goes away.]

Signed-off-by: Carsten Stollmaier <stollmc@amazon.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/msrs.c             |   7 +-
 arch/x86/kvm/x86.c              | 140 ++++++++++++++++----------------
 3 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ee4b127004d..4b0c18c77771 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -872,7 +872,7 @@ struct kvm_vcpu_arch {
 		u8 preempted;
 		u64 msr_val;
 		u64 last_steal;
-		struct gfn_to_hva_cache cache;
+		struct gfn_to_pfn_cache cache;
 	} st;
 
 	u64 l1_tsc_offset;
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..23407f8c441d 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1728,8 +1728,13 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
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
index f5f3459ed4a5..321f29789f9f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2058,12 +2058,11 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_service_local_tlb_flush_requests);
 
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
@@ -2076,55 +2075,41 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
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
 
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
 		/*
-		 * Request the flush instead of performing it inline. With
-		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule
-		 * (via mmu_sync_children()), so it could not be called while
-		 * the user access above was open. Requesting is just a bit
-		 * set on the running vCPU, and the request is serviced
-		 * before the vCPU enters the guest; nothing requires the
-		 * flush to have completed any earlier than that.
+		 * Request the flush instead of performing it inline. This
+		 * runs inside an atomic gpc_srcu read-side section, with
+		 * preemption disabled, and with shadow paging
+		 * kvm_vcpu_flush_tlb_guest() can reschedule (via
+		 * mmu_sync_children()). Requesting is just a bit set on the
+		 * running vCPU, and the request is serviced before the vCPU
+		 * enters the guest; nothing requires the flush to have
+		 * completed any earlier than that.
 		 *
 		 * Note the xchg above must remain as-is: it atomically
 		 * consumes any KVM_VCPU_FLUSH_TLB the guest set, as required
@@ -2133,39 +2118,33 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
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
@@ -2640,11 +2619,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
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
@@ -2669,20 +2645,37 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
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
+	/*
+	 * Leave last_steal alone: it is the baseline against the vCPU
+	 * task's cumulative sched_info.run_delay, which is never reset.
+	 * Zeroing it here would cause the first record_steal_time() after
+	 * a vCPU reset (INIT-SIPI, kexec) to account the task's entire
+	 * lifetime run_delay as steal time in one jump.
+	 */
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -9460,6 +9453,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.pv_time, vcpu->kvm);
 
+	kvm_gpc_init(&vcpu->arch.st.cache, vcpu->kvm);
+
 	if (!irqchip_in_kernel(vcpu->kvm) || kvm_vcpu_is_reset_bsp(vcpu))
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
 	else
@@ -9569,6 +9564,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_clear_async_pf_completion_queue(vcpu);
 	kvm_mmu_unload(vcpu);
 
+	kvm_steal_time_reset(vcpu);
+
 	kvmclock_reset(vcpu);
 
 	for_each_possible_cpu(cpu)
@@ -9689,7 +9686,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	vcpu->arch.apf.msr_en_val = 0;
 	vcpu->arch.apf.msr_int_val = 0;
-	vcpu->arch.st.msr_val = 0;
+
+	kvm_steal_time_reset(vcpu);
 
 	kvmclock_reset(vcpu);
 
-- 
2.43.0

