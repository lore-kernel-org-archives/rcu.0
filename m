Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A273477E2E;
	Sun, 20 Sep 2026 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940204; cv=none; b=dJ3QulRmuk0t6Bzt0gzTOvQr2ktebDB5MlgJQmh0U+H/dqJScihWZdnZEvCbckEEeQjdRE2cV9n08fQavLb1/IIJWlgcu2Pftn80D2A7vDsikARBWfGTCFvugSmVzHSFRN4lWHGEsrsrqZKwP+e0sRFm7OQjHB6vhTHuRiWSQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940204; c=relaxed/simple;
	bh=Y1hEo7Fzg54gJX1x5pwywpcmpRMSRxvXJKAaFauuVfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExQWW0vadKaYOr9vxfM7s4imKsvhwbryRbmKFAhMRGAQ+dBYuvbUadcVri/dFZMskDIr5fUyTflOZ4TpS9S0rsZbGeJPTF1vnxqDvbio9hqtOTgYdI316PyTcPxtoAR7SCDb5/I9foc1S4u09iS8Ch/zt0NUyH2PgH6F33VZWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XojgNXlA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XojgNXlA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bsRWcGNoTyxaN19qncyog0rLVfUddJf56eFKHsq62hs=; b=XojgNXlAXiD/oILOCpCFaz3oA4
	MsO6vqxXBu8g7IBf/cQwTw95/mAFgCCIldMb09vVmxcXPNrJ0L1NXQXFG/rBUWjOXU1bQhFIan/bv
	cCzP3W7dSQ+r4ygNKEb2kswTd4uTNFQ4iDArogcxgkqf6S497Dz/C7YZ9pEhP+X6g3ES1dl7tChDG
	qr4QyR10GWpU3b9T4GsMDdG6DvtnKP44OBExpNbQ8W8pBt+oZMykK5dwicXxLN8BTNrYw03WdwKdc
	tRijtFgCvkZedNLPC2HOpm7rl8zaQdA1LPa9qKHGjx7EjOReWJYBBDt3Nv7YRdkEtx6TVO/zIMsww
	nU//WOXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLq0-3miz;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcz-2o3p;
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 10/17] KVM: nVMX: Implement cache for L1 MSR bitmap
Date: Sun, 20 Sep 2026 21:49:38 +0100
Message-ID: <20260920211920.928306-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
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

The cache is initialized when entering VMX operation and deactivated
when VMX operation ends. Readers run under kvm->gpc_srcu, following
the check/activate/retry pattern; KVM only ever reads the L1 bitmap,
so the cache is marked never-dirty.

This exports the core pfncache API to kvm-intel.ko, which is its
first modular user.

[dwmw2: Port from the rwlock-protected pfncache to the SRCU reader
        protocol, mark the cache never-dirty, rebase over the
        kvm_vcpu_map_local_readonly CLASS() conversion.]

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/vmx/nested.c | 47 +++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.h    |  2 ++
 virt/kvm/pfncache.c       |  5 +++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..5fe7e5d1f72d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -320,6 +320,38 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	kvm_reset_dirty_registers(vcpu);
 }
 
+/*
+ * Map a single page of L1 guest memory at @gpa and enter an SRCU read-side
+ * critical section protecting the mapping. Returns the SRCU index (>= 0) to
+ * pass to nested_gpc_unlock(), or a negative error code. While locked, the
+ * cache's khva and pfn are guaranteed to remain valid: an invalidation
+ * cannot complete until the reader drains.
+ */
+static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
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
+static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc, int idx)
+{
+	srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
+}
+
 static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -370,6 +402,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
 
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	nested_put_vmcs12_pages(vcpu);
 
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
@@ -734,7 +768,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	int msr;
+	int msr, idx;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
 
@@ -759,11 +793,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
-	if (m.ret)
+	idx = nested_gpc_lock(&vmx->nested.msr_bitmap_cache, vmcs12->msr_bitmap);
+	if (idx < 0)
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)m.map.hva;
+	msr_bitmap_l1 = (unsigned long *)vmx->nested.msr_bitmap_cache.khva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -843,6 +877,8 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
 
+	nested_gpc_unlock(&vmx->nested.msr_bitmap_cache, idx);
+
 	vmx->nested.force_msr_bitmap_recalc = false;
 
 	return true;
@@ -5443,6 +5479,9 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vpid02 = allocate_vpid();
 
+	/* KVM only ever reads the L1 MSR bitmap, so never mark it dirty. */
+	__kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm, true, NULL, 0);
+
 	/*
 	 * Clear last_vpid to ensure that the VPID is flushed on the first
 	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..d5aa5aa83c95 100644
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
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 29397ac02668..c634058a73bf 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -241,6 +241,7 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	return true;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_check);
 
 /*
  * A mutator's xchg of the state word to zero may have consumed a live
@@ -758,6 +759,7 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_refresh);
 
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req)
@@ -774,6 +776,7 @@ void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->vcpu = vcpu;
 	gpc->vcpu_req = vcpu_req;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_gpc_init);
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
 			      unsigned long len)
@@ -816,6 +819,7 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
 
 	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_activate);
 
 int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
 {
@@ -875,3 +879,4 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		gpc_unmap(old_pfn, old_khva);
 	}
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_deactivate);
-- 
2.55.0

