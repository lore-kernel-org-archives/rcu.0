Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=a+Fg0TBnMzyJUC1/Xleui5t+Lusgbq8geRrFY6/sYu8n+bDxHLFKPS/Hy+sBDYcfivcz
	 eMeE0o/+CbrpAvjNcTls84eo7OXKAC3bvsOmbWZ8cwfBiVh06gJJLS36EVWFmb+cHI4Cg
	 9qvNAMTEwDWgLBjcIGXuuNnhCtOMfYwY/qfJocN/j/HVGSpGODbYnwu8DHvBa2pl2lG4Q
	 C/1WeMKjQ0CP2wt6i236nCmRsUc0IlVDkfW0cVhqvsxWMHyEqYrXYLpST3wNvvegoRj+a
	 rLF/y+VDWxCVG0XbMpsmbrBXt65DuJshsgyxExlYlLUIZzV8LJVCEDRed1TqdP/Ye/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=YL+lBqDUJNOy/hv9jUl5JyMaYSXCWE0E46LaudV422w=;
	b=M/PRonBBF6hK198TSEnqaZySW2DmfLRMCOLqLjqDwtL5DeDB+nMoAbLHYNPmJ/hyqH16
	 lAiKL5TJ87FuKN2IxACtCvwRMvtrmy/Pb0qDSqMXw0QVUlbK42aMvkclUXF44Z2tqLGUa
	 j4IsPlJMg36wxMTyxxqsidw++3z8Omq/e2N12SbSxxrGO5/9kFrD6XvoI075sC2/9sjGF
	 WySuKoWsQxbqkVBzKaLf8RPtUmFStDgqfXOgJDdt3B6ktbUJaN915DsPR6GMEANCeiEA0
	 3aNhRqhx1aDQL5y1KeeeXOBNCAEaRMT/VSL9FW5lgCdTmkvgZjszS4dDKReHqg1s1iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LHX+gf4e;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCCD606A33A;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCCD606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LHX+gf4e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YL+lBqDUJNOy/hv9jUl5JyMaYSXCWE0E46LaudV422w=; b=LHX+gf4esAQAwNNl+6sG/OPhfw
	R0AS7Ypu1vuUXonqAi82K6sEU8nEQTohPmpglaMnfgujKbxMYtiZDwfnMc5RgxzYx9BXYeQiDAMZm
	KWqJ0hLZCM7yO6mVf4/S1eBxkDQN8JLP9eLte98q8UKOmgmNqgFKAG4DyeC8mQi2hq/bNhNak04yX
	xCAuPMY17KxtGBhqDlsyhA+eE5+JvKMghaoZ74/3CkRfTebGLS1uC/q109pOeaVTFbL2433a9qPFZ
	ICHIJMOOlMylejLTkfMikIFaOfAmdTYrWZYSCrWJc+nbP5tagApWfND7A6iCHsnUn6i7xhsLhDESJ
	6Ebd5+9w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jD-0EW9;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDi-25oS;
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
Subject: [PATCH v2 11/20] KVM: nVMX: Implement cache for L1 MSR bitmap
Date: Thu,  5 Nov 2026 02:00:53 +0000
Message-ID: <20261105020104.2507083-12-dwmw2@infradead.org>
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
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Fred Griffoul <fgriffo@amazon.co.uk>

Introduce a gfn_to_pfn_cache to optimize L1 MSR bitmap access by
replacing map/unmap operations. This optimization reduces overhead
during L2 VM-entry where nested_vmx_prepare_msr_bitmap() merges L1's
MSR intercepts with L0's requirements.

The current implementation maps and unmaps the page on every bitmap
merge, which is a significant performance impact with unmanaged guest
memory (where the map is a memremap/memunmap cycle).

The cache is initialized once at vCPU creation and deactivated when
VMX operation ends; re-entering VMX operation reactivates it through
the normal check/activate path. Readers run under kvm->gpc_srcu,
following the check/activate/retry pattern; KVM only ever reads the
L1 bitmap, so the cache is mapped read-only (which L1 may
legitimately demand for its bitmap) and never marked dirty.

This exports the core pfncache API to kvm-intel.ko, which is its
first modular user.

[dwmw2: Port from the rwlock-protected pfncache to the SRCU reader
        protocol, rebase over the kvm_vcpu_map_local_readonly CLASS()
        conversion, introduce the lock/unlock helpers in x86.h as
        kvm_gpc_lock_page()/kvm_gpc_unlock() for later nSVM use, map
        the cache read-only, init at vCPU creation.]

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260920215613.1CC0C1F000FF@smtp.kernel.org
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 30 +++++++++++++++++++++++++----
 arch/x86/kvm/vmx/nested.h |  1 +
 arch/x86/kvm/vmx/vmx.c    |  2 ++
 arch/x86/kvm/vmx/vmx.h    |  2 ++
 arch/x86/kvm/x86.h        | 33 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/xen.c        |  4 ++--
 include/linux/kvm_host.h  | 40 +++++++++++++++++++++++++++------------
 include/linux/kvm_types.h | 12 ++++++++++++
 virt/kvm/pfncache.c       | 37 +++++++++++++++++++++++++++++++-----
 9 files changed, 138 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 516ba03bf608..bb0baa79c28c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -370,6 +370,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
 
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	nested_put_vmcs12_pages(vcpu);
 
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
@@ -390,6 +392,24 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	vcpu_put(vcpu);
 }
 
+/*
+ * Initialize the nested gfn_to_pfn_caches, once per vCPU. Unlike the
+ * allocations in enter_vmx_operation(), the caches persist across
+ * VMXOFF/VMXON cycles: free_nested() only deactivates them, and reuse
+ * goes through kvm_gpc_activate() without re-init.
+ */
+void nested_vmx_init_caches(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	/*
+	 * KVM only ever reads the L1 MSR bitmap, which L1 may keep in
+	 * memory that its VMM maps read-only: map the cache read-only
+	 * (which also means never marking it dirty).
+	 */
+	__kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm, false, true, NULL, 0);
+}
+
 #define EPTP_PA_MASK   GENMASK_ULL(51, 12)
 
 static bool nested_ept_root_matches(hpa_t root_hpa, u64 root_eptp, u64 eptp)
@@ -734,7 +754,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	int msr;
+	int msr, idx;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
 
@@ -759,11 +779,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
-	if (m.ret)
+	idx = kvm_gpc_lock_page(&vmx->nested.msr_bitmap_cache, vmcs12->msr_bitmap);
+	if (idx < 0)
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)m.map.hva;
+	msr_bitmap_l1 = (unsigned long *)vmx->nested.msr_bitmap_cache.khva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -843,6 +863,8 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
 
+	kvm_gpc_unlock(&vmx->nested.msr_bitmap_cache, idx);
+
 	vmx->nested.force_msr_bitmap_recalc = false;
 
 	return true;
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index c6de848bd9ce..e27299b9f30b 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -24,6 +24,7 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *));
 void nested_vmx_set_vmcs_shadowing_bitmap(void);
 int nested_vmx_check_restored_vmcs12(struct kvm_vcpu *vcpu);
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
+void nested_vmx_init_caches(struct kvm_vcpu *vcpu);
 enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 						     bool from_vmentry);
 bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f684c..590095bcb665 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7613,6 +7613,8 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 		WRITE_ONCE(to_kvm_vmx(vcpu->kvm)->pid_table[vcpu->vcpu_id],
 			   __pa(&vmx->vt.pi_desc) | PID_TABLE_ENTRY_VALID);
 
+	nested_vmx_init_caches(vcpu);
+
 	return 0;
 
 free_vmcs:
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 74cd50f29fa4..c6827368c84a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -146,6 +146,8 @@ struct nested_vmx {
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
+	struct gfn_to_pfn_cache msr_bitmap_cache;
+
 	struct kvm_host_map apic_access_page_map;
 	struct kvm_host_map virtual_apic_map;
 	struct kvm_host_map pi_desc_map;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 436e2fb1396c..c48f3aeb4d64 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -14,6 +14,39 @@
 
 #define KVM_MAX_MCE_BANKS 32
 
+/*
+ * Map a single page of L1 guest memory at @gpa into a gfn_to_pfn_cache
+ * and enter an SRCU read-side critical section protecting the mapping.
+ * Returns the SRCU index (>= 0) to pass to kvm_gpc_unlock(), or a
+ * negative error code. While locked, the cache's khva and pfn are
+ * guaranteed to remain valid: an invalidation cannot complete until the
+ * reader drains.
+ */
+static inline int kvm_gpc_lock_page(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
+{
+	int idx, err;
+
+	if (!PAGE_ALIGNED(gpa))
+		return -EINVAL;
+retry:
+	idx = srcu_read_lock_atomic(&gpc->kvm->gpc_srcu);
+	if (!kvm_gpc_check(gpc, PAGE_SIZE) || gpc->gpa != gpa) {
+		srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
+		err = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
+		if (err)
+			return err;
+
+		goto retry;
+	}
+
+	return idx;
+}
+
+static inline void kvm_gpc_unlock(struct gfn_to_pfn_cache *gpc, int idx)
+{
+	srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
+}
+
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
 void kvm_x86_vendor_exit(void);
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 132f0c379537..ecfeeea57c66 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2465,7 +2465,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true, NULL, 0);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true, false, NULL, 0);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
@@ -2486,7 +2486,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true, NULL, 0);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true, false, NULL, 0);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 008012d74d58..c604b7bb0b4c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1471,26 +1471,35 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 /**
  * __kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
- * @gpc:	   struct gfn_to_pfn_cache object.
- * @kvm:	   pointer to kvm instance.
- * @never_dirty:   the cache never needs to mark its page dirty in its memslot.
- * @vcpu:	   the vCPU which may pin this cache's pfn for direct use from
- *		   guest mode, or NULL for a cache which is never pinned.
- * @vcpu_req:	   service request posted to @vcpu when a pinned cache is
- *		   invalidated; must be non-zero when @vcpu is given (request
- *		   0 is a real request, so it cannot mean "none"). Most
- *		   callers want the kvm_gpc_init_for_vcpu() wrapper.
+ * @gpc:	 struct gfn_to_pfn_cache object.
+ * @kvm:	 pointer to kvm instance.
+ * @never_dirty: KVM never marks the cached page dirty in its memslot;
+ *		 userspace must assume the page is always dirty (as for
+ *		 the Xen shared_info page, written on every event channel
+ *		 delivery). kvm_gpc_mark_dirty_in_slot() becomes a no-op.
+ * @readonly:	 map without FOLL_WRITE; KVM must never write through
+ *		 @gpc->khva. For guest pages KVM only reads, which the
+ *		 guest may place in memory its VMM maps read-only.
+ *		 Implies @never_dirty.
+ * @vcpu:	 the vCPU which may pin this cache's pfn for direct use
+ *		 from guest mode, or NULL. Callers use the
+ *		 kvm_gpc_init() / kvm_gpc_init_for_vcpu() wrappers
+ *		 rather than passing this directly.
+ * @vcpu_req:	 service request posted to @vcpu when the cache is
+ *		 invalidated while pinned; required (non-zero) when
+ *		 @vcpu is given.
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).  Most callers want the kvm_gpc_init() wrapper.
  */
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req);
+		    bool never_dirty, bool readonly,
+		    struct kvm_vcpu *vcpu, u32 vcpu_req);
 
 static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 {
-	__kvm_gpc_init(gpc, kvm, false, NULL, 0);
+	__kvm_gpc_init(gpc, kvm, false, false, NULL, 0);
 }
 
 /**
@@ -1511,7 +1520,7 @@ static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 static inline void kvm_gpc_init_for_vcpu(struct gfn_to_pfn_cache *gpc,
 					 struct kvm_vcpu *vcpu, u32 req)
 {
-	__kvm_gpc_init(gpc, vcpu->kvm, false, vcpu, req);
+	__kvm_gpc_init(gpc, vcpu->kvm, false, false, vcpu, req);
 }
 
 /**
@@ -2054,6 +2063,13 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&gpc->kvm->gpc_srcu),
 			 "kvm_gpc_mark_dirty_in_slot() without kvm->gpc_srcu read lock");
 
+	/*
+	 * Nobody may write through (and hence dirty) a read-only cache:
+	 * its mapping was created without FOLL_WRITE and may lack write
+	 * permission entirely.
+	 */
+	WARN_ON_ONCE(gpc->readonly);
+
 	if (!gpc->memslot || gpc->never_dirty)
 		return;
 
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index bdee01f22a2d..193dd5b64c2a 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -122,7 +122,19 @@ struct gfn_to_pfn_cache {
 	 * instead.
 	 */
 	atomic_t state;
+	/*
+	 * KVM never marks the cached page dirty in its memslot; userspace
+	 * must assume the page is always dirty (as for the Xen shared_info
+	 * page, written on every event channel delivery).
+	 */
 	bool never_dirty;
+	/*
+	 * The cache is mapped without FOLL_WRITE and KVM must never write
+	 * through khva: for guest pages KVM only reads (e.g. the L1 MSR
+	 * bitmap), which the guest may legitimately place in memory its VMM
+	 * maps read-only. Implies never_dirty (there is nothing to mark).
+	 */
+	bool readonly;
 };
 
 /* The cache is valid: pfn and khva may be used by readers. */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 5cb30525e577..42adfdccd6fe 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -223,6 +223,20 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 	 */
 }
 
+/*
+ * As gfn_to_hva_memslot(), but tolerate a KVM_MEM_READONLY slot for a
+ * cache which promises never to write through its mapping.
+ */
+static unsigned long gpc_gfn_to_hva_memslot(struct gfn_to_pfn_cache *gpc,
+					    struct kvm_memory_slot *slot,
+					    gfn_t gfn)
+{
+	if (gpc->readonly)
+		return gfn_to_hva_memslot_prot(slot, gfn, NULL);
+
+	return gfn_to_hva_memslot(slot, gfn);
+}
+
 static bool kvm_gpc_is_valid_len(gpa_t gpa, unsigned long uhva,
 				 unsigned long len)
 {
@@ -275,6 +289,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	return true;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_check);
 
 /*
  * A mutator's xchg of the state word to zero may have consumed a live
@@ -448,7 +463,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	struct kvm_follow_pfn kfp = {
 		.slot = gpc->memslot,
 		.gfn = gpa_to_gfn(gpc->gpa),
-		.flags = FOLL_WRITE,
+		.flags = gpc->readonly ? 0 : FOLL_WRITE,
 		.hva = gpc->uhva,
 		.refcounted_page = &page,
 	};
@@ -655,7 +670,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			new_generation = slots->generation;
 			new_slot = __gfn_to_memslot(slots, gfn);
 			if (new_slot)
-				new_uhva = gfn_to_hva_memslot(new_slot, gfn) +
+				new_uhva = gpc_gfn_to_hva_memslot(gpc, new_slot, gfn) +
 					   offset_in_page(gpa);
 		}
 
@@ -738,7 +753,8 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			gpc->gpa = gpa;
 			gpc->generation = slots->generation;
 			gpc->memslot = __gfn_to_memslot(slots, gfn);
-			WRITE_ONCE(gpc->uhva, gfn_to_hva_memslot(gpc->memslot, gfn));
+			WRITE_ONCE(gpc->uhva,
+				   gpc_gfn_to_hva_memslot(gpc, gpc->memslot, gfn));
 
 			if (kvm_is_error_hva(gpc->uhva)) {
 				ret = -EFAULT;
@@ -801,9 +817,11 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_refresh);
 
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req)
+		    bool never_dirty, bool readonly,
+		    struct kvm_vcpu *vcpu, u32 vcpu_req)
 {
 	mutex_init(&gpc->refresh_lock);
 
@@ -813,7 +831,13 @@ void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->uhva = KVM_HVA_ERR_BAD;
 	gpc->active = false;
 	atomic_set(&gpc->state, 0);
-	gpc->never_dirty = never_dirty;
+	/*
+	 * A read-only cache maps without FOLL_WRITE, so writing through
+	 * gpc->khva would hit a mapping which may lack write permission;
+	 * there is never anything to mark dirty.
+	 */
+	gpc->never_dirty = never_dirty || readonly;
+	gpc->readonly = readonly;
 
 	/*
 	 * A vCPU-owned cache must come with a service request for the
@@ -827,6 +851,7 @@ void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->vcpu = vcpu;
 	gpc->vcpu_req = vcpu_req;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_gpc_init);
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			      unsigned long len)
@@ -869,6 +894,7 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 
 	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_activate);
 
 int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
 {
@@ -932,3 +958,4 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		gpc_unmap(old_pfn, old_khva);
 	}
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_deactivate);
-- 
2.43.0

