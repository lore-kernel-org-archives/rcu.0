Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D03E44F9;
	Sun, 20 Sep 2026 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940158; cv=none; b=rMBmVyiXNubQ5B//zayVYJD3AyVoal5zfTxjgsNdWe7Ju2G2DUmzBdcPAUkuE1Xa8MtcNsBzGp7TmEllg9/Sbza/SNIafwgrEA5J+tjGJRhLjNC9BPW73gMcCCQ2X5GVKX/WK8sT3WjFvi62j1osZOysuAreOe/88COqO/2DRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940158; c=relaxed/simple;
	bh=tvqGI96/y5AnMPFlYj3CtgYHw88DXLx8Mwf27ngrY3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK4aEBfHdDVL5UsHi46B6tmth4IxZtH9UqAuUNSR9Jplspc0SS13sIZLy4+GO5BSEJAj/k1LFtzlY2FUm4YayWXQPruuzDXfHkV8+bKL9SsyOuu0EbaidfO8CEp6qZyUgalztT83nxhNi5X7ceK4fft0ACezAbaRAmSDoJORRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZL6U2+RS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZL6U2+RS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HzPCG1mzDh8DdrBIPa7Nweb/5zxIoHMov0yDcro/4Mo=; b=ZL6U2+RSxLT1536poMuTWbIUBq
	Qz4XcUqwGnvYGk7eNggz1o7E1JWeeZoMMy8abSHSxmDvHHupU8XskEosqnXUnsNLc8hmUVKPXd1zg
	GZstG8c9idf9UxR3E/P1VK/uRZBl6nxh+ZA9ZA4HN43LzM6RJU4mMnzCTbVIo3rGhHJ//uu7RfmLM
	3WOHxkA6KC7+47k1MTubwD7dO/ZqOWBemSa2jlom0JzhkYdWzd+5KDMaOiriaTbrkA22yyAwSQtX5
	QdxrCIyrx9W/vVhV8rgS3Higc6NOnOBUo7x4r9Xv90uBtAPt4DCRJstTQj0qCfmevyYn5153TP/sA
	YtAmIVww==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwV-0000000BLq4-0AVs;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tdB-3PFb;
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
Subject: [PATCH 13/17] KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_page()
Date: Sun, 20 Sep 2026 21:49:41 +0100
Message-ID: <20260920211920.928306-14-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Move the SRCU lock/activate/retry helpers for accessing a page of L1
guest memory through a gfn_to_pfn_cache from vmx/nested.c to x86.h, so
that nested SVM can use them too.

There is nothing nesting-specific about these helpers: they lock a
gfn_to_pfn_cache as a mapping of a given whole guest page, activating
or re-keying it as required. Name them kvm_gpc_lock_page() and
kvm_gpc_unlock() accordingly; they are candidates for hoisting into
the generic GPC API in kvm_host.h when a non-x86 user appears (the
Hyper-V VP assist and enlightened VMCS pages are likely candidates).

No functional change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/vmx/nested.c | 60 +++++++++------------------------------
 arch/x86/kvm/x86.h        | 33 +++++++++++++++++++++
 2 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 105ff6cbfe58..b9f12313c960 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -320,38 +320,6 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	kvm_reset_dirty_registers(vcpu);
 }
 
-/*
- * Map a single page of L1 guest memory at @gpa and enter an SRCU read-side
- * critical section protecting the mapping. Returns the SRCU index (>= 0) to
- * pass to nested_gpc_unlock(), or a negative error code. While locked, the
- * cache's khva and pfn are guaranteed to remain valid: an invalidation
- * cannot complete until the reader drains.
- */
-static int nested_gpc_lock(struct gfn_to_pfn_cache *gpc, gpa_t gpa)
-{
-	int idx, err;
-
-	if (!PAGE_ALIGNED(gpa))
-		return -EINVAL;
-retry:
-	idx = srcu_read_lock_atomic(&gpc->kvm->gpc_srcu);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE) || gpc->gpa != gpa) {
-		srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
-		err = kvm_gpc_activate(gpc, gpa, PAGE_SIZE);
-		if (err)
-			return err;
-
-		goto retry;
-	}
-
-	return idx;
-}
-
-static void nested_gpc_unlock(struct gfn_to_pfn_cache *gpc, int idx)
-{
-	srcu_read_unlock_atomic(&gpc->kvm->gpc_srcu, idx);
-}
-
 /*
  * Map a page of L1 memory, pin it for direct use by the guest (i.e. by
  * the CPU while running the L2 guest, via a physical address in vmcs02),
@@ -366,24 +334,24 @@ static int nested_gpc_hpa(struct gfn_to_pfn_cache *gpc, gpa_t gpa, hpa_t *hpa)
 	int idx;
 
 	do {
-		idx = nested_gpc_lock(gpc, gpa);
+		idx = kvm_gpc_lock_page(gpc, gpa);
 		if (idx < 0)
 			return idx;
 
 		/*
 		 * The pin can fail only if an invalidation cleared the
-		 * valid bit after nested_gpc_lock() checked it; go back
+		 * valid bit after kvm_gpc_lock_page() checked it; go back
 		 * around to refresh (which will not complete until the
 		 * invalidation is over) and try again.
 		 */
 		if (kvm_gpc_pin_for_guest(gpc))
 			break;
 
-		nested_gpc_unlock(gpc, idx);
+		kvm_gpc_unlock(gpc, idx);
 	} while (1);
 
 	*hpa = pfn_to_hpa(gpc->pfn);
-	nested_gpc_unlock(gpc, idx);
+	kvm_gpc_unlock(gpc, idx);
 	return 0;
 }
 
@@ -393,7 +361,7 @@ static int nested_gpc_hpa(struct gfn_to_pfn_cache *gpc, gpa_t gpa, hpa_t *hpa)
  * posted interrupts not configured for this L2), -EWOULDBLOCK if it is
  * active but currently invalidated (only a sleeping refresh would make
  * it usable). Does not pin; the mapping is stable only until
- * nested_gpc_unlock().
+ * kvm_gpc_unlock().
  */
 static int nested_gpc_try_lock_if_active(struct gfn_to_pfn_cache *gpc)
 {
@@ -890,7 +858,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	idx = nested_gpc_lock(&vmx->nested.msr_bitmap_cache, vmcs12->msr_bitmap);
+	idx = kvm_gpc_lock_page(&vmx->nested.msr_bitmap_cache, vmcs12->msr_bitmap);
 	if (idx < 0)
 		return false;
 
@@ -974,7 +942,7 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
 
-	nested_gpc_unlock(&vmx->nested.msr_bitmap_cache, idx);
+	kvm_gpc_unlock(&vmx->nested.msr_bitmap_cache, idx);
 
 	vmx->nested.force_msr_bitmap_recalc = false;
 
@@ -4286,7 +4254,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	vmx->nested.pi_pending = false;
 
 	if (!pi_test_and_clear_on(pi_desc)) {
-		nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
+		kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 		return 0;
 	}
 
@@ -4294,7 +4262,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	if (max_irr > 0) {
 		vapic_idx = nested_gpc_lock_if_active(&vmx->nested.virtual_apic_cache);
 		if (vapic_idx < 0) {
-			nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
+			kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 			goto mmio_needed;
 		}
 		vapic_page = vmx->nested.virtual_apic_cache.khva;
@@ -4302,7 +4270,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 		__kvm_apic_update_irr(pi_desc->pir, vapic_page, &max_irr);
 
 		kvm_gpc_mark_dirty_in_slot(&vmx->nested.virtual_apic_cache);
-		nested_gpc_unlock(&vmx->nested.virtual_apic_cache, vapic_idx);
+		kvm_gpc_unlock(&vmx->nested.virtual_apic_cache, vapic_idx);
 
 		status = vmcs_read16(GUEST_INTR_STATUS);
 		if ((u8)max_irr > ((u8)status & 0xff)) {
@@ -4313,7 +4281,7 @@ static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	}
 
 	kvm_gpc_mark_dirty_in_slot(&vmx->nested.pi_desc_cache);
-	nested_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
+	kvm_gpc_unlock(&vmx->nested.pi_desc_cache, pi_idx);
 	return 0;
 
 mmio_needed:
@@ -4472,7 +4440,7 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 	vapic = vmx->nested.virtual_apic_cache.khva;
 	vppr = *((u32 *)(vapic + APIC_PROCPRI));
 
-	nested_gpc_unlock(&vmx->nested.virtual_apic_cache, idx);
+	kvm_gpc_unlock(&vmx->nested.virtual_apic_cache, idx);
 
 	max_irr = vmx_get_rvi();
 	if ((max_irr & 0xf0) > (vppr & 0xf0))
@@ -4489,12 +4457,12 @@ static bool vmx_has_nested_events(struct kvm_vcpu *vcpu, bool for_injection)
 		if (pi_test_on(pi_desc)) {
 			max_irr = pi_find_highest_vector(pi_desc);
 			if (max_irr > 0 && (max_irr & 0xf0) > (vppr & 0xf0)) {
-				nested_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
+				kvm_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
 				return true;
 			}
 		}
 
-		nested_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
+		kvm_gpc_unlock(&vmx->nested.pi_desc_cache, idx);
 	}
 
 	return false;
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 0f5919b092e4..e3d9889a245d 100644
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
 
-- 
2.55.0

