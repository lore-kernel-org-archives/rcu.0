Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48C437861;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939193; cv=none; b=Lr1/LPNYgb04GBXrCIgHCPnqMbTWM2xiJ/38RFechJEhAx2oso7209PaFKHWhkSvq89gCXqTe5BhzTokZzoucoBfpkbyJW47M9mCD0vj7F+d0ZZK/2gu3RC6FxMM9xNQ2Fjb952NHVA4jMNlnBLDeaY7CFxCtPfc3ORTE6XAmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939193; c=relaxed/simple;
	bh=XKhvi4UH2xSbZ7BBwTl1ZkmCYwOrT4e2Xzu40qEQBb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eaGOSKjm6LOIQgHRvsiR0ORT1zT0v7wIwIR8IDecv28nBNAkGbLIV/C6UPofs6fqRQUj3wbxgjikQDcKes/xGNUbkSp1hFMYWBWQdr9fx82q+Dk1q5f60kmkW/H1B6aWXjJvhxs5+huVgwQvlCNh9HQHo/jr4qlSeZtOcept/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mK3nWt+G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mK3nWt+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=p6lGEGLPmF9kP0Wh0JZOmW/JgPAV6LOO3KbyW4Pq6pM=; b=mK3nWt+GZR0uNlYPT2FfTzKmZ7
	ncyuK2UDfv9H8BEO3uQS2nVqunZI4sKo/ud2f6dl+7B1QxPnHrK/iq55iL7AupPAMz+GkvEkiY2ib
	iv9NA3+qi5hXmRGHNSBolc54vkbwO7T+EEXGY8X2WDV26Pu0QLIIDeGcQUFBmorLbOflGBgnde1F3
	C+IbLTABuKcvsA2vY+rO7HrXYgSs42Cm4hOn+bEBjskJ+ud7+MYmwGxIxrY6Sab5X3nBz4T8uAf1i
	HGCxmNYilJOdIWJU8CzB9tpUFotTdKhYJT48HzR7H+EzLEt+vIXp21DwuhqD3lEZdVLYqbxVSh4PY
	e8KogbbA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000BdxX-48vZ;
	Sun, 20 Sep 2026 21:19:43 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003td3-31Sn;
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
Subject: [PATCH 11/17] KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
Date: Sun, 20 Sep 2026 21:49:39 +0100
Message-ID: <20260920211920.928306-12-dwmw2@infradead.org>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

Replace kvm_host_map usage with gfn_to_pfn_cache for the L1 pages whose
physical addresses are handed to the CPU in vmcs02 for direct use while
running L2: the APIC-access page, the virtual-APIC page, and the posted
interrupt descriptor. This eliminates the map/unmap (with unmanaged
memory: memremap/memunmap) cycle on every L2 VM-entry/exit.

The caches are initialized with kvm_gpc_init_for_vcpu(), naming
KVM_REQ_GET_NESTED_STATE_PAGES as the service request, and their pfns
are pinned for guest use (GPC_GUEST_USING) when written into vmcs02 by
nested_get_vmcs12_pages(). If an MMU notifier invalidation hits a
pinned cache, the pfncache core posts that request, forces the vCPU
out of guest mode, and waits for it to leave; the request handler
re-runs nested_get_vmcs12_pages(), whose refresh cannot complete until
the invalidation ends, and rewrites the vmcs02 fields before the next
entry. The pins are dropped at nested VM-exit (including the
vmentry_fail_vmexit path, which does not pass through
__nested_vmx_vmexit()) and the caches deactivated when VMX operation
ends.

Note that no validity check is added to the guest-entry path: the
request substitutes for it. The invariant is that a stale physical
address latched in vmcs02 always implies a pending request, which the
existing kvm_request_pending() check catches after vcpu->mode is set
to IN_GUEST_MODE. It is maintained from both directions:

 - Every path which consumes a pin (the notifier walk, or a
   refresh/deactivate from any context, including the owning vCPU
   refreshing its own cache from a host-side reader) posts the
   service request.

 - The request handler cannot lose it: vcpu_enter_guest() consumes
   the request bit before calling in, so ANY failure of
   vmx_get_nested_state_pages() — including early exits which touch
   no cache at all, such as a failed load_pdptrs() — re-posts the
   request before exiting to userspace. A persistently failing
   configuration bounces to userspace on every KVM_RUN rather than
   ever entering L2 with a stale address. (The old kvm_host_map code
   could tolerate losing this race because the map held a page
   reference; the pfncache deliberately holds none.)

This is what closes the historical KVM_GUEST_USES_PFN gaps¹: the kick
is guaranteed to be acted upon before re-entry, without polling cache
validity on every entry.

Host-side (khva) readers of the virtual-APIC and PI descriptor pages
do not need the pin, which exists only for the benefit of the
physical addresses latched in vmcs02.
vmx_complete_nested_posted_interrupt() runs in a sleepable context
and uses the SRCU-protected check/refresh protocol.
vmx_has_nested_events() is reachable from the kvm_vcpu_block() loop
under set_current_state(TASK_INTERRUPTIBLE), where a refresh (mutex,
GUP, synchronize_srcu) must not sleep: it instead uses a non-sleeping
try-lock and reports "event pending" when a cache has been
invalidated. The resulting bounce through vcpu_run services the
pending request in a sleepable context and re-evaluates events for
real; a spurious wakeup is safe, whereas returning false could miss
a wakeup (the service request is posted with KVM_REQUEST_NO_WAKEUP).
To keep an unbackable page from turning that conservative answer into
a wakeup livelock, a failed activation deactivates the cache rather
than leaving it active-but-invalid.

Dirty marking for these pages, which the CPU writes via the vmcs02
physical addresses and thus bypasses EPT-based dirty tracking, moves
from the unmap path to gfn-based marking from the vmcs12 fields on
every L2 exit (__vmx_handle_exit() already does this on every exit
from L2, so unmap-time marking was redundant); the one software
writer, __kvm_apic_update_irr() from
vmx_complete_nested_posted_interrupt(), marks at the write site.

¹ https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Failure to resolve a page distinguishes three cases. At entry time
(VMLAUNCH/VMRESUME, or resume from KVM_SET_NESTED_STATE, tracked in
nested.resume_pending) an unbackable page is a misconfiguration:
report KVM_EXIT_INTERNAL_ERROR as ever (vmx_apic_access_test asserts
this). On lazy revalidation — a pending KVM_REQ_GET_NESTED_STATE_PAGES
consumed while L2 runs — a slot mid-update (-EAGAIN from the
pfncache) re-posts the request and continues; the pending request
prevents VM entry, so the vCPU retries until the memslot update
completes. And a genuinely unbacked gfn on lazy revalidation means
userspace yanked the backing from under a running L2: clear
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES in vmcs02 instead of killing
the VM, so L2's accesses take ordinary EPT violations and are
handled as MMIO, exactly as a non-nested guest touching the same
unbacked gpa would be — and as upstream KVM (which never re-resolves)
effectively behaves. The control is recomputed from vmcs12 on the
next nested entry, and a later memslot update which re-backs the gfn
re-latches the page, so the degradation heals itself
(vmx_apic_update_test's move-memslot phase exercises this).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/vmx/nested.c | 345 +++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/vmx.c    |  11 +-
 arch/x86/kvm/vmx/vmx.h    |  14 +-
 3 files changed, 319 insertions(+), 51 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5fe7e5d1f72d..105ff6cbfe58 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -352,14 +352,107 @@ static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc, int idx)
 	srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
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
+		idx = nested_gpc_lock(gpc, gpa);
+		if (idx < 0)
+			return idx;
+
+		/*
+		 * The pin can fail only if an invalidation cleared the
+		 * valid bit after nested_gpc_lock() checked it; go back
+		 * around to refresh (which will not complete until the
+		 * invalidation is over) and try again.
+		 */
+		if (kvm_gpc_pin_for_guest(gpc))
+			break;
+
+		nested_gpc_unlock(gpc, idx);
+	} while (1);
+
+	*hpa = pfn_to_hpa(gpc->pfn);
+	nested_gpc_unlock(gpc, idx);
+	return 0;
+}
+
+/*
+ * Try to lock an already-configured cache for host-side (khva) access,
+ * without sleeping. Returns -ENOENT if the cache is not active (e.g.
+ * posted interrupts not configured for this L2), -EWOULDBLOCK if it is
+ * active but currently invalidated (only a sleeping refresh would make
+ * it usable). Does not pin; the mapping is stable only until
+ * nested_gpc_unlock().
+ */
+static int nested_gpc_try_lock_if_active(struct gfn_to_pfn_cache *gpc)
+{
+	int idx;
+
+	/*
+	 * Check for an inactive (or never-initialized: gpc->kvm is NULL
+	 * before VMXON) cache before dereferencing gpc->kvm. Deactivation
+	 * only happens on this vCPU (under vcpu->mutex), so the check
+	 * cannot race with the lock which follows it.
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
+	if (!kvm_gpc_check(gpc, PAGE_SIZE)) {
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
@@ -378,6 +471,7 @@ static void free_nested(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	vmx->nested.resume_pending = false;
 
 	vmx->nested.vmxon = false;
 	vmx->nested.smm.vmxon = false;
@@ -402,10 +496,13 @@ static void free_nested(struct kvm_vcpu *vcpu)
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
@@ -3475,11 +3572,11 @@ static bool nested_get_evmcs_page(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool lazy)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct kvm_host_map *map;
+	hpa_t hpa;
 
 	if (!vcpu->arch.pdptrs_from_userspace &&
 	    !nested_cpu_has_ept(vmcs12) && is_pae_paging(vcpu)) {
@@ -3494,26 +3591,74 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 
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
 			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			vcpu->run->internal.suberror =
 				KVM_INTERNAL_ERROR_EMULATION;
 			vcpu->run->internal.ndata = 0;
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
 
-		if (!kvm_vcpu_map(vcpu, gpa_to_gfn(vmcs12->virtual_apic_page_addr), map)) {
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
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
+
+		if (vapic_err == -EAGAIN)
+			goto retry;
+
+		if (!vapic_err) {
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
 			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
@@ -3536,14 +3681,13 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
 		} else {
 			/*
 			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
@@ -3551,7 +3695,10 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3561,9 +3708,27 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
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
@@ -3584,9 +3749,39 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
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
 
@@ -3715,7 +3910,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	prepare_vmcs02_early(vmx, &vmx->vmcs01, vmcs12);
 
 	if (from_vmentry) {
-		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
+		if (unlikely(!nested_get_vmcs12_pages(vcpu, false))) {
 			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 		}
@@ -3753,6 +3948,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		 * to nested_get_vmcs12_pages before the next VM-entry.  The MSRs
 		 * have already been set at vmentry time and should not be reset.
 		 */
+		vmx->nested.resume_pending = true;
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 	}
 
@@ -3809,6 +4005,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
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
 	if (!from_vmentry)
 		return NVMX_VMENTRY_VMEXIT;
 
@@ -4065,6 +4269,8 @@ static void vmcs12_save_pending_event(struct kvm_vcpu *vcpu,
 static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	int pi_idx, vapic_idx;
+	struct pi_desc *pi_desc;
 	int max_irr;
 	void *vapic_page;
 	u16 status;
@@ -4072,22 +4278,32 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (!vmx->nested.pi_pending)
 		return 0;
 
-	if (!vmx->nested.pi_desc)
+	pi_idx = nested_gpc_lock_if_active(&vmx->nested.pi_desc_cache);
+	if (pi_idx < 0)
 		goto mmio_needed;
 
+	pi_desc = nested_pi_desc(vmx);
 	vmx->nested.pi_pending = false;
 
-	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
+	if (!pi_test_and_clear_on(pi_desc)) {
+		nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 		return 0;
+	}
 
-	max_irr = pi_find_highest_vector(vmx->nested.pi_desc);
+	max_irr = pi_find_highest_vector(pi_desc);
 	if (max_irr > 0) {
-		vapic_page = vmx->nested.virtual_apic_map.hva;
-		if (!vapic_page)
+		vapic_idx = nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache);
+		if (vapic_idx < 0) {
+			nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 			goto mmio_needed;
+		}
+		vapic_page = vmx->nested.virtual_apic_cache.khva;
+
+		__kvm_apic_update_irr(pi_desc->pir, vapic_page, &max_irr);
+
+		kvm_gpc_mark_dirty_in_slot(&vmx->nested.virtual_apic_cache);
+		nested_gpc_unlock(&vmx->nested.virtual_apic_cache, vapic_idx);
 
-		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
-			vapic_page, &max_irr);
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
 			status &= ~0xff;
@@ -4096,8 +4312,8 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.virtual_apic_map);
-	kvm_vcpu_map_mark_dirty(vcpu, &vmx->nested.pi_desc_map);
+	kvm_gpc_mark_dirty_in_slot(&vmx->nested.pi_desc_cache);
+	nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 	return 0;
 
 mmio_needed:
@@ -4216,8 +4432,9 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
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
@@ -4236,20 +4453,48 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	    __vmx_interrupt_blocked(vcpu))
 		return false;
 
-	if (!vapic)
+	/*
+	 * This is called from non-sleeping contexts (notably the
+	 * kvm_vcpu_block() loop, under set_current_state()), so it must
+	 * not refresh an invalidated cache. Claim a pending event
+	 * instead: the bounce through vcpu_run services the pending
+	 * KVM_REQ_GET_NESTED_STATE_PAGES (posted by whatever invalidated
+	 * the cache) in a sleepable context, re-establishing the cache,
+	 * and re-evaluates events for real. A spurious wakeup is safe;
+	 * sleeping here is not, and returning false could miss a wakeup.
+	 */
+	idx = nested_gpc_try_lock_if_active(&vmx->nested.virtual_apic_cache);
+	if (idx == -EWOULDBLOCK)
+		return true;
+	if (idx < 0)
 		return false;
 
+	vapic = vmx->nested.virtual_apic_cache.khva;
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
+	nested_gpc_unlock(&vmx->nested.virtual_apic_cache, idx);
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
+		if (idx == -EWOULDBLOCK)
 			return true;
+		if (idx < 0)
+			return false;
+
+		pi_desc = nested_pi_desc(vmx);
+		if (pi_test_on(pi_desc)) {
+			max_irr = pi_find_highest_vector(pi_desc);
+			if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0)) {
+				nested_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
+				return true;
+			}
+		}
+
+		nested_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
 	}
 
 	return false;
@@ -5482,6 +5727,20 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 	/* KVM only ever reads the L1 MSR bitmap, so never mark it dirty. */
 	__kvm_gpc_init(&vmx->nested.msr_bitmap_cache, vcpu->kvm, true, NULL, 0);
 
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
+
 	/*
 	 * Clear last_vpid to ensure that the VPID is flushed on the first
 	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..25b0d114f2bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6467,11 +6467,14 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
 
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
index d5aa5aa83c95..f88e0031be4e 100644
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
 
@@ -148,11 +154,11 @@ struct nested_vmx {
 	 */
 	struct gfn_to_pfn_cache msr_bitmap_cache;
 
-	struct kvm_host_map apic_access_page_map;
-	struct kvm_host_map virtual_apic_map;
-	struct kvm_host_map pi_desc_map;
+	struct gfn_to_pfn_cache apic_access_page_cache;
+	struct gfn_to_pfn_cache virtual_apic_cache;
+	struct gfn_to_pfn_cache pi_desc_cache;
 
-	struct pi_desc *pi_desc;
+	u64 pi_desc_offset;
 	bool pi_pending;
 	u16 posted_intr_nv;
 
-- 
2.55.0

