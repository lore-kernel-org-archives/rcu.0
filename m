Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844079;
	b=oLs6MuR/2OxNsjWjwpJNGFrRhN4X0DQpwJAs/AWrQ7NktV05u6KCFIgLRMxydholwN00
	 m/qkHR7oMuVx8FacUzsUuXYya9FUeE5NSoulKGBBS+5BU2ePvDQjhxpd3+OuHlPhDGMKb
	 695Ap3FePjL1DjxldzksAk29tU8060/5VNx9qQe0EmUIopBHWE8dsuZFDPctAL+Xr65Lk
	 oxSk9fVH1P9VmZnlFo9Q/sDJF2OPaBXe0bmGUGSoyNIuRmF4iE9/g+X+7EOWUG7kPNWca
	 TE2DK6lGiMH8cAKjN3a7+pbYvZ2PdWnn+rlb2UzOfwl/XViEPEib6ysqM7QIdnEg3pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=lq/Kk5OeAuXHYB6wOIZIFiKrOrr7XjZr/0fAEOHzrvs=;
	b=iIU0FPazy7C8f9eLs2YWZ/DI3kcKRuzxrKYET1OaaNXaVgJ3c5/d26oA8ws5dXC2HWDU
	 boCwCR/SBLai97ox2n9Fp0Vbtxs58O89h23pYRl9YA60IN9tcgG7rRTB/AIS0ixGq0hur
	 1ySaurl2AfsKOU1SdFLtbCidvU5etNKOqG12XOJGDOr77l6+MTQarGo510T5Yyp2dJQ2B
	 YzgvkBvC4WYHZeMuE6Wu53qTi1IKDmwJJkq5WcIN0RkoSnT/9/0p/6qzSu+EsfWuCkT3N
	 6lVY+LEPF2pBuYS0673GJUlARCwrz9gTmkf1RSxXhUzdMYoOiKYS2bvi6VoORhNM1QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=O89uQik+;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8B2606EE98;
	Thu,  5 Nov 2026 02:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8B2606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=O89uQik+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=lq/Kk5OeAuXHYB6wOIZIFiKrOrr7XjZr/0fAEOHzrvs=; b=O89uQik+whhvPMgG8J+xQHJBrN
	9XpIKGBPlO7HfZuA1emoSdJmLmCKTL39GTpJ59I8rMQSVOEDwpLFGVwSLaUkF1nZkXeCY+/s+SfcW
	D2QFsFLR+6LAD+gEtcQzbAMjvp6xoPnXiqsdewFEIYWfoaWUr0ITVsH+yF47RTHzPvvn6ZvPjBDI3
	TxJR5RIKorPu3jPB34BspRwIf3472huijbKnEFeHHcHZj4w5Z1IvOa1hpU8ox8i8v6W/FIab07JjH
	ZPEVSyYSv03NTP8b9cZthlBIWMCkCAb1gcT93PNJEzlDBgBZrhZufqINdBP+r9/jtogu/TQdHzq8j
	S1PAWfDg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-00000002ROO-25Pd;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDm-2Fyj;
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
Subject: [PATCH v2 12/20] KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
Date: Thu,  5 Nov 2026 02:00:54 +0000
Message-ID: <20261105020104.2507083-13-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Fred Griffoul <fgriffo@amazon.co.uk>

Replace kvm_host_map usage with gfn_to_pfn_cache for the L1 pages whose
physical addresses are handed to the CPU in vmcs02 for direct use while
running L2: the APIC-access page, the virtual-APIC page, and the posted
interrupt descriptor. This eliminates the map/unmap (with unmanaged
memory: memremap/memunmap) cycle on every L2 VM-entry/exit.

The caches are initialized once at vCPU creation with
kvm_gpc_init_for_vcpu(), naming KVM_REQ_GET_NESTED_STATE_PAGES as the
service request, and pinned when written into vmcs02 by
nested_get_vmcs12_pages(). An invalidation of a pinned cache posts
that request, forces the vCPU out of guest mode and waits; the
handler re-runs nested_get_vmcs12_pages(). Pins are dropped at
nested VM-exit (including the vmentry_fail_vmexit path, which does
not pass through __nested_vmx_vmexit()).

No validity check is added to the guest-entry path: a stale physical
address latched in vmcs02 always implies a pending request. Every
path which consumes a pin posts the request, and the handler cannot
lose it: any failure of vmx_get_nested_state_pages() re-posts it
before exiting to userspace, so a persistently failing configuration
bounces to userspace rather than ever entering L2 stale. This closes
the historical KVM_GUEST_USES_PFN gaps¹ without polling cache
validity on every entry.

Resolution failure distinguishes three cases. A slot mid-update (the
pfncache reports -EFAULT; finding the KVM_MEMSLOT_INVALID placeholder
still installed identifies the failure as transient) re-posts the
request and continues, retrying until the update commits or reverts.
At entry time (VMLAUNCH/VMRESUME, or resume from
KVM_SET_NESTED_STATE, tracked in nested.resume_pending — which dies
with the request at nested VM-exit, lest a later lazy request
inherit entry-time semantics) a genuinely unbackable page is a
misconfiguration: KVM_EXIT_INTERNAL_ERROR, as ever. On lazy
revalidation it means userspace yanked the backing from under a
running L2: for the APIC-access page and the posted interrupt
descriptor, clear the corresponding vmcs02 control instead of
killing the VM, so L2's accesses become ordinary EPT violations
handled as MMIO; the successful re-resolution path sets the control
back, so a later update re-backing the gfn heals the degradation
without waiting for a nested VM-entry. The virtual-APIC page allows
no such degradation (the TPR shadow is live, and the entry-time
INVALID_GPA fallback would deliver a VMfailValid to an L1 whose
VMLAUNCH retired long ago), and an unbacked gfn cannot be an error
either: a routine DELETE-then-recreate reshuffle has a committed gap
in which the gfn is genuinely absent, and the lazy revalidation runs
inside that gap precisely because the DELETE's commit posted the
request. So a vAPIC loss while L2 runs is ridden out like the
in-flight window: the pending request keeps L2 un-enterable until a
later update re-backs the gfn, and a userspace which never does
leaves its vCPU retrying in KVM_RUN, as for RET_PF_RETRY. The PAE
PDPTR reload runs only at
entry-time resolution: PDPTRs latch at MOV CR3 and VM-entry, so a
lazy revalidation must not re-derive them.

Host-side (khva) readers do not need the pin.
vmx_complete_nested_posted_interrupt() resolves both caches before
entering either one's atomic read section, and
vmx_has_nested_events(), which runs under set_current_state() in the
block loop where a refresh must not sleep, uses a non-sleeping
try-lock and reports "event pending" for an unusable cache, posting
KVM_REQ_GET_NESTED_STATE_PAGES itself (a bare memslot-generation
bump fails the check without anything else posting it): the bounce
through vcpu_run re-establishes the cache and re-evaluates for real,
and a failed activation deactivates the cache so an unbackable page
cannot livelock that conservative answer. The try-lock takes
kvm->srcu across its memslot-generation check; callers in the
vcpu_block() loop run with the vCPU's srcu lock dropped.

Dirty marking moves from the unmap path to gfn-based marking on
every L2 exit (__vmx_handle_exit() already did that, making
unmap-time marking redundant); the one software writer,
__kvm_apic_update_irr(), marks at the write site.

¹ https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx/nested.c | 483 ++++++++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.c    |  11 +-
 arch/x86/kvm/vmx/vmx.h    |  21 +-
 3 files changed, 458 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bb0baa79c28c..23f1fff97917 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -320,14 +320,140 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	kvm_reset_dirty_registers(vcpu);
 }
 
+/*
+ * Map a page of L1 memory, pin it for direct use by the guest (i.e. by
+ * the CPU while running the L2 guest, via a physical address in vmcs02),
+ * and return the host physical address to write into vmcs02. The pin
+ * guarantees that if the mapping is invalidated, this vCPU is forced out
+ * of guest mode and KVM_REQ_GET_NESTED_STATE_PAGES is posted so that the
+ * address is re-established (or the vCPU exits to userspace) before the
+ * next entry to guest mode.
+ */
+static int nested_gpc_hpa(struct gfn_to_pfn_cache *gpc, gpa_t gpa, hpa_t *hpa)
+{
+	int idx;
+
+	do {
+		idx = kvm_gpc_lock_page(gpc, gpa);
+		if (idx == -EFAULT) {
+			struct kvm_memory_slot *slot;
+
+			/*
+			 * An unbackable gfn and a memslot mid-update (a
+			 * DELETE or MOVE keeps a KVM_MEMSLOT_INVALID
+			 * placeholder installed until it commits) both fail
+			 * uHVA resolution with -EFAULT. Distinguish them:
+			 * finding the placeholder in the active memslots
+			 * (kvm->srcu is held by every caller) means the
+			 * failure is transient, and the callers' -EAGAIN
+			 * handling — re-post the request, don't enter L2 —
+			 * is what must ride it out; only a truly absent
+			 * slot means the page is unbacked.
+			 */
+			slot = gfn_to_memslot(gpc->kvm, gpa_to_gfn(gpa));
+			if (slot && (slot->flags & KVM_MEMSLOT_INVALID))
+				return -EAGAIN;
+		}
+		if (idx < 0)
+			return idx;
+
+		/*
+		 * The pin can fail only if an invalidation cleared the
+		 * valid bit after kvm_gpc_lock_page() checked it; go back
+		 * around to refresh (which will not complete until the
+		 * invalidation is over) and try again.
+		 */
+		if (kvm_gpc_pin_for_guest(gpc))
+			break;
+
+		kvm_gpc_unlock(gpc, idx);
+	} while (1);
+
+	*hpa = pfn_to_hpa(gpc->pfn);
+	kvm_gpc_unlock(gpc, idx);
+	return 0;
+}
+
+/*
+ * Try to lock an already-configured cache for host-side (khva) access,
+ * without sleeping. Returns -ENOENT if the cache is not active (e.g.
+ * posted interrupts not configured for this L2), -EWOULDBLOCK if it is
+ * active but currently invalidated (only a sleeping refresh would make
+ * it usable). Does not pin; the mapping is stable only until
+ * kvm_gpc_unlock().
+ */
+static int nested_gpc_try_lock_if_active(struct gfn_to_pfn_cache *gpc)
+{
+	int idx, srcu_idx;
+	bool usable;
+
+	/*
+	 * The caches are initialized at vCPU creation, so gpc->kvm is
+	 * always valid; !active covers a cache never activated (or since
+	 * deactivated) for this L2. Deactivation only happens on this
+	 * vCPU (under vcpu->mutex), so the check cannot race with the
+	 * lock which follows it.
+	 */
+	if (!gpc->active)
+		return -ENOENT;
+
+	idx = srcu_read_lock_atomic(&gpc->kvm->gpc_srcu);
+	if (!gpc->active) {
+		srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
+		return -ENOENT;
+	}
+
+	/*
+	 * kvm_gpc_check() consults kvm_memslots() (for the generation of
+	 * a GPA-based cache), which is protected by kvm->srcu — and not
+	 * every caller holds that: kvm_arch_vcpu_runnable() runs from the
+	 * vcpu_block() loop with the vCPU's srcu lock deliberately
+	 * dropped. Take it across the check; the khva the caller then
+	 * reads is protected by gpc_srcu, not kvm->srcu.
+	 */
+	srcu_idx = srcu_read_lock(&gpc->kvm->srcu);
+	usable = kvm_gpc_check(gpc, PAGE_SIZE);
+	srcu_read_unlock(&gpc->kvm->srcu, srcu_idx);
+
+	if (!usable) {
+		srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
+		return -EWOULDBLOCK;
+	}
+
+	return idx;
+}
+
+/*
+ * As above, but refresh the cache if it has been invalidated. May sleep;
+ * callers must be in a sleepable context (in particular, NOT under
+ * set_current_state() in a block loop, and not in a VM-exit fastpath).
+ */
+static int nested_gpc_lock_if_active(struct gfn_to_pfn_cache *gpc)
+{
+	int idx, err;
+
+	while ((idx = nested_gpc_try_lock_if_active(gpc)) == -EWOULDBLOCK) {
+		err = kvm_gpc_refresh(gpc, PAGE_SIZE);
+		if (err)
+			return err;
+	}
+
+	return idx;
+}
+
+static struct pi_desc *nested_pi_desc(struct vcpu_vmx *vmx)
+{
+	return (struct pi_desc *)((u8 *)vmx->nested.pi_desc_cache.khva +
+				  vmx->nested.pi_desc_offset);
+}
+
 static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map);
-	vmx->nested.pi_desc = NULL;
+	kvm_gpc_unpin_for_guest(&vmx->nested.apic_access_page_cache);
+	kvm_gpc_unpin_for_guest(&vmx->nested.virtual_apic_cache);
+	kvm_gpc_unpin_for_guest(&vmx->nested.pi_desc_cache);
 }
 
 /*
@@ -346,6 +472,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	vmx->nested.resume_pending = false;
 
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
@@ -370,10 +497,13 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	kfree(vmx->nested.cached_shadow_vmcs12);
 	vmx->nested.cached_shadow_vmcs12 = NULL;
 
-	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
-
 	nested_put_vmcs12_pages(vcpu);
 
+	kvm_gpc_deactivate(&vmx->nested.pi_desc_cache);
+	kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
+	kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
+	kvm_gpc_deactivate(&vmx->nested.msr_bitmap_cache);
+
 	kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
 	nested_release_evmcs(vcpu);
@@ -408,6 +538,20 @@ void nested_vmx_init_caches(struct kvm_vcpu *vcpu)
 	 * (which also means never marking it dirty).
 	 */
 	__kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm, false, true, NULL, 0);
+
+	/*
+	 * The pfns of these three caches are handed to the CPU in vmcs02
+	 * fields, for direct use while running the L2 guest. Pinning them
+	 * for guest use makes an invalidation force this vCPU out of
+	 * guest mode and post KVM_REQ_GET_NESTED_STATE_PAGES, whose
+	 * handler re-establishes them before the next entry.
+	 */
+	kvm_gpc_init_for_vcpu(&vmx->nested.apic_access_page_cache, vcpu,
+			      KVM_REQ_GET_NESTED_STATE_PAGES);
+	kvm_gpc_init_for_vcpu(&vmx->nested.virtual_apic_cache, vcpu,
+			      KVM_REQ_GET_NESTED_STATE_PAGES);
+	kvm_gpc_init_for_vcpu(&vmx->nested.pi_desc_cache, vcpu,
+			      KVM_REQ_GET_NESTED_STATE_PAGES);
 }
 
 #define EPTP_PA_MASK   GENMASK_ULL(51, 12)
@@ -3467,41 +3611,117 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool lazy)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_host_map *map;
+	hpa_t hpa;
 
-	if (!vcpu->arch.pdptrs_from_userspace &&
+	if (!lazy && !vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
 		/*
 		 * Reload the guest's PDPTRs since after a migration
 		 * the guest CR3 might be restored prior to setting the nested
-		 * state which can lead to a load of wrong PDPTRs.
+		 * state which can lead to a load of wrong PDPTRs. Only at
+		 * entry-time resolution: PDPTRs latch at MOV CR3 and
+		 * VM-entry, so a lazy revalidation (a memslot update while
+		 * L2 runs) must not re-derive them at a moment the
+		 * architecture does not allow.
 		 */
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
+		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3))) {
+			/*
+			 * Report the unusable PDPT rather than return to
+			 * userspace with a stale exit_reason.
+			 */
+			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			vcpu->run->internal.suberror =
+				KVM_INTERNAL_ERROR_EMULATION;
+			vcpu->run->internal.ndata = 0;
 			return false;
+		}
 	}
 
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
-		map = &vmx->nested.apic_access_page_map;
-
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->apic_access_addr), map)) {
-			vmcs_write64(APIC_ACCESS_ADDR, pfn_to_hpa(map->pfn));
-		} else {
+		int err = nested_gpc_hpa(&vmx->nested.apic_access_page_cache,
+					 vmcs12->apic_access_addr, &hpa);
+		if (!err) {
+			vmcs_write64(APIC_ACCESS_ADDR, hpa);
+			/*
+			 * Undo any earlier lazy degradation: once the page
+			 * is backed again the vmcs02 control must match
+			 * vmcs12, and prepare_vmcs02_early() only runs at
+			 * nested VM-entry, which a vCPU parked in L2 may
+			 * not reach for a long time.
+			 */
+			secondary_exec_controls_setbit(vmx,
+				SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES);
+		} else if (err == -EAGAIN) {
+			kvm_gpc_unpin_for_guest(&vmx->nested.apic_access_page_cache);
+			kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
+			goto retry;
+		} else if (!lazy) {
+			/*
+			 * Entry-time resolution (VMLAUNCH/VMRESUME, or resume
+			 * from KVM_SET_NESTED_STATE): an unbackable
+			 * APIC-access page is a misconfiguration to report,
+			 * not a transient to ride out.
+			 */
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
+			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+			vcpu->run->internal.suberror =
+				KVM_INTERNAL_ERROR_EMULATION;
+			vcpu->run->internal.ndata = 0;
+			kvm_gpc_unpin_for_guest(&vmx->nested.apic_access_page_cache);
+			kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
 			return false;
+		} else {
+			/*
+			 * Lazy revalidation (a memslot update or invalidation
+			 * while L2 runs) found the gfn unbacked: userspace
+			 * yanked the backing from under a running L2. Turn
+			 * off the APIC-access match for vmcs02 instead of
+			 * killing the VM; L2's accesses to the page then take
+			 * ordinary EPT violations on an unbacked gfn and are
+			 * handled (or reported) as MMIO, exactly as a
+			 * non-nested guest touching the same gpa would be.
+			 * prepare_vmcs02_early() recomputes the control from
+			 * vmcs12 on the next nested entry, and a later
+			 * memslot update which re-backs the gfn re-posts the
+			 * request and re-latches the page, so the
+			 * degradation heals itself.
+			 */
+			kvm_gpc_unpin_for_guest(&vmx->nested.apic_access_page_cache);
+			kvm_gpc_deactivate(&vmx->nested.apic_access_page_cache);
+			secondary_exec_controls_clearbit(vmx,
+				SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES);
 		}
 	}
 
 	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
-		map = &vmx->nested.virtual_apic_map;
+		int vapic_err = nested_gpc_hpa(&vmx->nested.virtual_apic_cache,
+					       vmcs12->virtual_apic_page_addr, &hpa);
+
+		/*
+		 * On failure, deactivate the cache: an active-but-invalid
+		 * cache would read as "might have an event" to the
+		 * non-sleeping check in vmx_has_nested_events(), causing
+		 * spurious wakeups for as long as the page remains
+		 * unbackable.
+		 */
+		if (vapic_err) {
+			kvm_gpc_unpin_for_guest(&vmx->nested.virtual_apic_cache);
+			kvm_gpc_deactivate(&vmx->nested.virtual_apic_cache);
+		}
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map)) {
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
+		if (vapic_err == -EAGAIN)
+			goto retry;
+
+		if (!vapic_err) {
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
+			/* As for the APIC-access page: undo a lazy degrade. */
+			exec_controls_setbit(vmx, CPU_BASED_TPR_SHADOW);
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
 			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
@@ -3514,6 +3734,27 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			 * only possibility we have.
 			 */
 			exec_controls_clearbit(vmx, CPU_BASED_TPR_SHADOW);
+		} else if (lazy) {
+			/*
+			 * Unlike the two sibling pages, a vAPIC loss cannot
+			 * be degraded around: the TPR shadow is live. Nor is
+			 * the entry-time INVALID_GPA fallback usable here —
+			 * the resulting hardware VM-entry failure would be
+			 * delivered as VMfailValid to an L1 whose VMLAUNCH
+			 * retired long ago, rewinding L2. Nor can an unbacked
+			 * gfn be reported as an error: a routine userspace
+			 * DELETE-then-recreate reshuffle has a committed gap
+			 * in which the gfn is genuinely absent, and this
+			 * revalidation runs inside it precisely because the
+			 * DELETE's commit posted the request. Ride it out
+			 * exactly like the in-flight window: keep the
+			 * request pending so L2 cannot be entered, and let
+			 * the recreate (whose commit posts again) supply the
+			 * page. A userspace which never re-backs the gfn
+			 * leaves the vCPU retrying in KVM_RUN indefinitely —
+			 * as for RET_PF_RETRY, that is its own doing.
+			 */
+			goto retry;
 		} else {
 			/*
 			 * Write an illegal value to VIRTUAL_APIC_PAGE_ADDR to
@@ -3524,14 +3765,15 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		map = &vmx->nested.pi_desc_map;
-
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr), map)) {
-			vmx->nested.pi_desc =
-				(struct pi_desc *)(((void *)map->hva) +
-				offset_in_page(vmcs12->posted_intr_desc_addr));
+		int pi_err = nested_gpc_hpa(&vmx->nested.pi_desc_cache,
+					    vmcs12->posted_intr_desc_addr & PAGE_MASK, &hpa);
+		if (!pi_err) {
+			vmx->nested.pi_desc_offset =
+				offset_in_page(vmcs12->posted_intr_desc_addr);
 			vmcs_write64(POSTED_INTR_DESC_ADDR,
-				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_addr));
+				     hpa + offset_in_page(vmcs12->posted_intr_desc_addr));
+			/* As for the APIC-access page: undo a lazy degrade. */
+			pin_controls_setbit(vmx, PIN_BASED_POSTED_INTR);
 		} else {
 			/*
 			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
@@ -3539,7 +3781,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc = NULL;
+			kvm_gpc_unpin_for_guest(&vmx->nested.pi_desc_cache);
+			kvm_gpc_deactivate(&vmx->nested.pi_desc_cache);
+			if (pi_err == -EAGAIN)
+				goto retry;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
@@ -3549,9 +3794,27 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		exec_controls_clearbit(vmx, CPU_BASED_USE_MSR_BITMAPS);
 
 	return true;
+
+retry:
+	/*
+	 * The gfn's memslot is being moved or deleted: present but
+	 * flagged invalid, so the lookup failure is transient and the
+	 * gfn must not (yet) be treated as unbacked. Re-post the
+	 * request and report success: the pending request prevents
+	 * any VM entry (vcpu_enter_guest() bails and reprocesses
+	 * requests), so L2 cannot run with the partially-updated
+	 * vmcs02, and the vCPU retries here until the memslot update
+	 * completes or reverts. This mirrors RET_PF_RETRY for
+	 * ordinary guest faults on an invalid slot; as there, a
+	 * userspace which never completes the update leaves the vCPU
+	 * retrying indefinitely, with signals and request processing
+	 * still serviced.
+	 */
+	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	return true;
 }
 
-static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
+static bool __vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_HYPERV
 	/*
@@ -3567,9 +3830,39 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	}
 #endif
 
-	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
+	if (is_guest_mode(vcpu) &&
+	    !nested_get_vmcs12_pages(vcpu, !to_vmx(vcpu)->nested.resume_pending))
 		return false;
 
+	/*
+	 * Success consumes the resume classification (a -EAGAIN retry
+	 * "succeeds" too: the resume did all it could against a memslot
+	 * mid-update, and the re-posted request's consumption is a fresh
+	 * revalidation like any other).
+	 */
+	to_vmx(vcpu)->nested.resume_pending = false;
+	return true;
+}
+
+static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
+{
+	if (!__vmx_get_nested_state_pages(vcpu)) {
+		/*
+		 * The caller (vcpu_enter_guest) consumed
+		 * KVM_REQ_GET_NESTED_STATE_PAGES before calling in, and a
+		 * failure here may leave a previously latched — and, after
+		 * an invalidation, stale and unreferenced — physical
+		 * address in vmcs02. Re-post the request so that no path
+		 * can re-enter L2 without retrying this function: the
+		 * invariant is that a stale latched address always implies
+		 * a pending request. If the failure persists, the vCPU
+		 * bounces to userspace on every KVM_RUN rather than ever
+		 * entering L2, which is the invariant doing its job.
+		 */
+		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+		return false;
+	}
+
 	return true;
 }
 
@@ -3698,7 +3991,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	prepare_vmcs02_early(vmx, &vmx->vmcs01, vmcs12);
 
 	if (from_vmentry) {
-		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
+		if (unlikely(!nested_get_vmcs12_pages(vcpu, false))) {
 			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 		}
@@ -3736,6 +4029,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		 * to nested_get_vmcs12_pages before the next VM-entry.  The MSRs
 		 * have already been set at vmentry time and should not be reset.
 		 */
+		vmx->nested.resume_pending = true;
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 	}
 
@@ -3792,13 +4086,19 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
+	/*
+	 * Release any guest-mode pins taken by nested_get_vmcs12_pages()
+	 * during this failed entry: this path returns to L1 without going
+	 * through __nested_vmx_vmexit(), which is where they are normally
+	 * dropped. (Idempotent if a later vmexit drops them again.)
+	 */
+	nested_put_vmcs12_pages(vcpu);
+
 	if (!from_vmentry) {
 		nested_ept_uninit_mmu_context(vcpu);
 		return NVMX_VMENTRY_VMEXIT;
 	}
 
-	nested_put_vmcs12_pages(vcpu);
-
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))
@@ -4054,6 +4354,8 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int pi_idx, vapic_idx;
+	struct pi_desc *pi_desc;
 	int max_irr;
 	void *vapic_page;
 	u16 status;
@@ -4061,22 +4363,58 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.pi_pending)
 		return 0;
 
-	if (!vmx->nested.pi_desc)
+	/*
+	 * Resolve both caches before touching the descriptor: taking one
+	 * cache's lock inside the other's would sleep in refresh (and
+	 * wait a grace period on the gpc_srcu domain this task already
+	 * reads) with preemption disabled. The vAPIC lock may go unused
+	 * (no pending vector), and its absence only matters once a
+	 * vector is found, so a failure is remembered, not acted on.
+	 */
+retry:
+	vapic_idx = nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache);
+
+	pi_idx = nested_gpc_try_lock_if_active(&vmx->nested.pi_desc_cache);
+	if (pi_idx == -EWOULDBLOCK) {
+		if (vapic_idx >= 0)
+			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
+				       vapic_idx);
+		if (kvm_gpc_refresh(&vmx->nested.pi_desc_cache, PAGE_SIZE))
+			goto mmio_needed;
+		goto retry;
+	}
+	if (pi_idx < 0) {
+		if (vapic_idx >= 0)
+			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
+				       vapic_idx);
 		goto mmio_needed;
+	}
 
+	pi_desc = nested_pi_desc(vmx);
 	vmx->nested.pi_pending = false;
 
-	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
+	if (!pi_test_and_clear_on(pi_desc)) {
+		kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
+		if (vapic_idx >= 0)
+			kvm_gpc_unlock(&vmx->nested.virtual_apic_cache,
+				       vapic_idx);
 		return 0;
+	}
 
-	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	max_irr = pi_find_highest_vector(pi_desc);
 	if (max_irr > 0) {
-		vapic_page = vmx->nested.virtual_apic_map.hva;
-		if (!vapic_page)
+		if (vapic_idx < 0) {
+			/* The ON bit is already cleared: mark the write. */
+			kvm_gpc_mark_dirty_in_slot(&vmx->nested.pi_desc_cache);
+			kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 			goto mmio_needed;
+		}
+		vapic_page = vmx->nested.virtual_apic_cache.khva;
+
+		__kvm_apic_update_irr(pi_desc->pir, vapic_page, &max_irr);
+
+		kvm_gpc_mark_dirty_in_slot(&vmx->nested.virtual_apic_cache);
 
-		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
-			vapic_page, &max_irr);
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
 			status &= ~0xff;
@@ -4085,8 +4423,10 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.pi_desc_map);
+	if (vapic_idx >= 0)
+		kvm_gpc_unlock(&vmx->nested.virtual_apic_cache, vapic_idx);
+	kvm_gpc_mark_dirty_in_slot(&vmx->nested.pi_desc_cache);
+	kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 	return 0;
 
 mmio_needed:
@@ -4205,8 +4545,9 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	void *vapic = vmx->nested.virtual_apic_map.hva;
-	int max_irr, vppr;
+	int max_irr, vppr, idx;
+	struct pi_desc *pi_desc;
+	void *vapic;
 
 	if (nested_vmx_preemption_timer_pending(vcpu) ||
 	    vmx->nested.mtf_pending)
@@ -4225,20 +4566,57 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	    __vmx_interrupt_blocked(vcpu))
 		return false;
 
-	if (!vapic)
+	/*
+	 * This is called from non-sleeping contexts (notably the
+	 * kvm_vcpu_block() loop, under set_current_state()), so it must
+	 * not refresh an unusable cache. Claim a pending event instead,
+	 * and post KVM_REQ_GET_NESTED_STATE_PAGES: the bounce through
+	 * vcpu_run services the request in a sleepable context,
+	 * re-establishing the cache, and re-evaluates events for real.
+	 * The request must be posted here rather than assumed pending —
+	 * an invalidation posts one, but a cache can also fail the check
+	 * on a bare memslot-generation bump (e.g. a dirty-logging toggle,
+	 * KVM_MR_FLAGS_ONLY), where nothing else does, and without it
+	 * the woken vCPU would re-enter, HLT, and spin back here. A
+	 * spurious wakeup is safe; sleeping here is not, and returning
+	 * false could miss a wakeup.
+	 */
+	idx = nested_gpc_try_lock_if_active(&vmx->nested.virtual_apic_cache);
+	if (idx == -EWOULDBLOCK) {
+		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+		return true;
+	}
+	if (idx < 0)
 		return false;
 
+	vapic = vmx->nested.virtual_apic_cache.khva;
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	kvm_gpc_unlock(&vmx->nested.virtual_apic_cache, idx);
+
 	max_irr = vmx_get_rvi();
 	if ((max_irr & 0xf0) > (vppr & 0xf0))
 		return true;
 
-	if (vmx->nested.pi_pending && vmx->nested.pi_desc &&
-	    pi_test_on(vmx->nested.pi_desc)) {
-		max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
-		if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0))
+	if (vmx->nested.pi_pending) {
+		idx = nested_gpc_try_lock_if_active(&vmx->nested.pi_desc_cache);
+		if (idx == -EWOULDBLOCK) {
+			kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 			return true;
+		}
+		if (idx < 0)
+			return false;
+
+		pi_desc = nested_pi_desc(vmx);
+		if (pi_test_on(pi_desc)) {
+			max_irr = pi_find_highest_vector(pi_desc);
+			if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0)) {
+				kvm_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
+				return true;
+			}
+		}
+
+		kvm_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
 	}
 
 	return false;
@@ -5121,6 +5499,15 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 #endif
 	}
 
+	/*
+	 * The resume classification dies with the request: a stale
+	 * resume_pending would give the next request (e.g. posted by an
+	 * invalidation after L1 re-enters L2) entry-time semantics,
+	 * re-deriving PDPTRs mid-L2 and treating a transiently
+	 * unbackable page as a terminal error.
+	 */
+	vmx->nested.resume_pending = false;
+
 	/* Service pending TLB flush requests for L2 before switching to L1. */
 	kvm_service_local_tlb_flush_requests(vcpu);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 590095bcb665..bb766380276e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6428,11 +6428,14 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 
 static void nested_vmx_mark_all_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.apic_access_page_map);
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.pi_desc_map);
+	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES))
+		kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(vmcs12->apic_access_addr));
+	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW))
+		kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr));
+	if (nested_cpu_has_posted_intr(vmcs12))
+		kvm_vcpu_mark_page_dirty(vcpu, gpa_to_gfn(vmcs12->posted_intr_desc_addr));
 }
 
 static void vmx_dump_sel(char *name, uint32_t sel)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index c6827368c84a..7d8bced38ca0 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -73,6 +73,12 @@ struct pt_desc {
 struct nested_vmx {
 	/* Has the level1 guest done vmxon? */
 	bool vmxon;
+	/*
+	 * The pending KVM_REQ_GET_NESTED_STATE_PAGES was posted by
+	 * KVM_SET_NESTED_STATE: an unbackable page is then a userspace
+	 * error to report, not a transient state to ride out.
+	 */
+	bool resume_pending;
 	gpa_t vmxon_ptr;
 	bool pml_full;
 
@@ -146,13 +152,18 @@ struct nested_vmx {
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
-	struct gfn_to_pfn_cache msr_bitmap_cache;
+	struct gfn_to_pfn_cache apic_access_page_cache;
+	struct gfn_to_pfn_cache virtual_apic_cache;
+	struct gfn_to_pfn_cache pi_desc_cache;
 
-	struct kvm_host_map apic_access_page_map;
-	struct kvm_host_map virtual_apic_map;
-	struct kvm_host_map pi_desc_map;
+	/*
+	 * L1's MSR bitmap, read by KVM when merging into the bitmap the
+	 * CPU actually uses (vmcs02 points at the merged copy). Never
+	 * pinned, never written through.
+	 */
+	struct gfn_to_pfn_cache msr_bitmap_cache;
 
-	struct pi_desc *pi_desc;
+	u64 pi_desc_offset;
 	bool pi_pending;
 	u16 posted_intr_nv;
 
-- 
2.43.0

