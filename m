Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B294772AC;
	Sun, 20 Sep 2026 21:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940245; cv=none; b=iYsyQyOZ7rA4aAuBZz1q6WporLkzwAmbZjPNW+v5uyxMtlvl52aitGMzXwTIkdlqYj5yQqhA3c5re6AjAC/LKNssQ2adh4tu46BikTFuF3pu1Czo1wnPwpeJaPOBoF7fK/U/iAHg9JLG/SIgKlmg1ysJO4wO4VUmhrakTg2En7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940245; c=relaxed/simple;
	bh=el9WAUIJ63lwtLCW11K89rMt7bxmO//ekmd05po6ey8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz8dfZbNksOQzAJnG4blF6/fjIWd0KiNhxl+VS725poszuQVLcawb61D0q60iVy5xAB0OGybIsRzO4fhhvkvIedw5Mp5l0/NBlxDdkx3BJmujbqfmXEzm+a9yN6zaZav4czq+sCtktxUBxIil4qC3JRbBqTReZrcFeGcEaSuep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YdQWIXc9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YdQWIXc9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=62Ih9ymwIJU5b1gyiXDeF0z+bk/RYv/UkPhSOWe66p8=; b=YdQWIXc9GqjIpfJzMVBbxjBbVX
	1iaQQrDQ1NygOicYQ7ANlDfQ/d4JCRg+BH5XiWtnn/uH5vRFzDgg7ZU9Hkvhg7jCUq5hZ6hFz2gAE
	7zEuuZo+zzmKT924LLC8W4GOKFhBi1bnYKLl0KEEn/qFia4QFm/VTX/EGvK2Gv7+zV+BQ7ImO8Os3
	/YZSNt8kJq0NcDXGsm2X15fhMWFv7xTgTVm/viP8ei9Ij6NeT4GVYdsKq1DbYAK8kn0L63CD6p8Nx
	DHS7D99DFKtNFXiAez2405D4vOpSA+UA9W+X1rtqsb7W4fBIPOIy38VaEqR2iDVBq1SNi7scOwEVq
	ykutoQeQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpw-37jE;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcn-2Afy;
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
Subject: [PATCH 07/17] KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
Date: Sun, 20 Sep 2026 21:49:35 +0100
Message-ID: <20260920211920.928306-8-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Reinstate support for caches whose pfn a vCPU uses directly from guest
mode (stuffed into hardware control structures such as vmcs02 fields),
addressing the reasons the original KVM_GUEST_USES_PFN was removed as
incomplete/broken¹²:

 - The kick now comes with a guarantee. The original
   KVM_REQ_OUTSIDE_GUEST_MODE kick did "absolutely nothing to
   guarantee KVM refreshes the cache before re-entering the guest"¹.
   Now, a vCPU pins with a cmpxchg which succeeds only while GPC_VALID
   holds; the invalidation walk reads the pin in the same atomic word
   it already reads to veto in-flight publishes, so no pin can slip
   between its check and the zap; and re-pinning requires GPC_VALID,
   which requires a refresh, which cannot complete until
   invalidate_range_end(). The vCPU is forced out (with WAIT) and
   physically cannot re-enter with the stale mapping.

 - The service request is per-cache, given at init³
   (kvm_gpc_init_for_vcpu()), so e.g. nVMX can request
   KVM_REQ_GET_NESTED_STATE_PAGES for vmcs12 pages rather than KVM
   guessing. The force-out (KVM_REQ_OUTSIDE_GUEST_MODE, which carries
   KVM_REQUEST_WAIT) is common; the per-cache request says what the
   vCPU must do before re-entering.

 - No special-casing of non-blockable invalidations. The original
   stripped KVM_REQUEST_WAIT for the OOM reaper on the assumption that
   a reaped task's vCPUs are already stopped; that assumption is false
   for process_mrelease(), which requires only SIGNAL_GROUP_EXIT, and
   the strip opened the very use-after-free window the kick exists to
   prevent⁴. The wait is unconditionally safe:
   kvm_make_vcpus_request_mask() runs with preemption disabled and
   spin-waits for IPI acks; it never sleeps.

 - Pin lifecycle has single-writer discipline. Only the pinning vCPU
   sets its pin (cmpxchg-while-VALID) and only that vCPU clears it (on
   unpin or request service, before re-pinning) — except that a
   mutator's xchg of the whole state word to zero may consume a live
   pin, in which case it inherits the kick-and-wait duty before
   mutating anything the guest may be using. A stale pin left by a
   kicked vCPU costs at most a spurious request bit: the force-out
   only IPIs and waits for targets actually in guest mode.

No users yet; the nVMX conversion⁵ builds on this.

¹ https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com
² https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com
³ https://lore.kernel.org/all/agJnqh7ACEkB-ftx@google.com
⁴ per Jann Horn's analysis in ²
⁵ https://lore.kernel.org/all/20260102142429.896101-1-griffoul@gmail.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c        |   4 +-
 include/linux/kvm_host.h  |  55 ++++++++++++-
 include/linux/kvm_types.h |  28 +++++--
 virt/kvm/pfncache.c       | 168 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 235 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 16b76379dcec..b6643b889320 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2388,7 +2388,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true, NULL, 0);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
@@ -2409,7 +2409,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true, NULL, 0);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b2dbbd6b104..0ee1479b135b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1475,13 +1475,64 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
  * the caller before init).
  */
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		    bool never_dirty);
+		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req);
 
 static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 {
-	__kvm_gpc_init(gpc, kvm, false);
+	__kvm_gpc_init(gpc, kvm, false, NULL, 0);
 }
 
+/**
+ * kvm_gpc_init_for_vcpu - initialize a cache whose pfn a vCPU may pin for
+ *                         direct use from guest mode.
+ *
+ * @gpc:  struct gfn_to_pfn_cache object.
+ * @vcpu: the vCPU which will pin and directly access this cache.
+ * @req:  service request to post to @vcpu when the cache is invalidated
+ *        while pinned. The invalidation separately forces @vcpu out of
+ *        guest mode (KVM_REQ_OUTSIDE_GUEST_MODE, with WAIT) and does not
+ *        complete until it has left; @req says what the vCPU must then do
+ *        before re-entering. Its handler must re-establish the mapping
+ *        (via a refresh, which cannot complete until the invalidation
+ *        ends) and re-pin before the pfn may be used from guest mode
+ *        again, or exit to userspace.
+ */
+static inline void kvm_gpc_init_for_vcpu(struct gfn_to_pfn_cache *gpc,
+					 struct kvm_vcpu *vcpu, u32 req)
+{
+	__kvm_gpc_init(gpc, vcpu->kvm, false, vcpu, req);
+}
+
+/**
+ * kvm_gpc_pin_for_guest - pin a valid cache's pfn for use from guest mode.
+ *
+ * @gpc: struct gfn_to_pfn_cache object (initialized with
+ *       kvm_gpc_init_for_vcpu()).
+ *
+ * Marks the cache as being used directly by the vCPU in guest mode, so
+ * that an invalidation will kick the vCPU (with the request given at init
+ * time) and wait for it to be out of guest mode before completing.
+ * Succeeds only while the cache is valid: on success the pfn is
+ * guaranteed to remain mapped and unreclaimed until the pin is released
+ * or the vCPU is kicked. Must be called by @gpc->vcpu itself.
+ *
+ * Returns false if the cache is not currently valid; the caller must
+ * refresh and retry, or bail.
+ */
+bool kvm_gpc_pin_for_guest(struct gfn_to_pfn_cache *gpc);
+
+/**
+ * kvm_gpc_unpin_for_guest - release a guest-mode pin.
+ *
+ * @gpc: struct gfn_to_pfn_cache object.
+ *
+ * Must be called by @gpc->vcpu itself, after it has left guest mode (or
+ * before entering it), when the pfn is no longer stuffed into any
+ * hardware control structure. Idempotent: a pin already consumed by a
+ * mutator's teardown is harmless to release again.
+ */
+void kvm_gpc_unpin_for_guest(struct gfn_to_pfn_cache *gpc);
+
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
  *                    physical address.
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 22393f97266a..bdee01f22a2d 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -87,21 +87,34 @@ struct gfn_to_pfn_cache {
 	unsigned long uhva;
 	struct kvm_memory_slot *memslot;
 	struct kvm *kvm;
+	/*
+	 * A cache initialized with kvm_gpc_init_for_vcpu() may be pinned for
+	 * direct use from guest mode (its pfn stuffed into hardware control
+	 * structures such as vmcs02 fields) by setting GPC_GUEST_USING while
+	 * GPC_VALID holds. When such a cache is invalidated, @vcpu is kicked
+	 * out of guest mode with @vcpu_req, whose handler must re-pin (via a
+	 * refresh which cannot complete until the invalidation ends) or exit.
+	 */
+	struct kvm_vcpu *vcpu;
+	u32 vcpu_req;
 	struct list_head list;
 	struct mutex refresh_lock;
 	void *khva;
 	kvm_pfn_t pfn;
 	bool active;
 	/*
-	 * GPC_VALID, GPC_BECOMING_VALID and GPC_INVALIDATING live in a
-	 * single atomic word so that a refresh can publish
-	 * (BECOMING_VALID => VALID) with a single conditional RMW, an
+	 * GPC_VALID, GPC_BECOMING_VALID, GPC_INVALIDATING and
+	 * GPC_GUEST_USING live in a single atomic word so that a refresh can
+	 * publish (BECOMING_VALID => VALID) with a single conditional RMW, an
 	 * invalidation can veto that publish by clearing both of those bits
 	 * (setting INVALIDATING in the same operation if VALID was set, to
-	 * record that its grace period is still owed), and a mutator can
-	 * consume the whole state with one xchg to learn whether it must
-	 * wait for readers before touching anything they see. See the
-	 * comments in pfncache.c.
+	 * record that its grace period is still owed) and observe in the same
+	 * read whether a vCPU has the pfn pinned for guest-mode use
+	 * (GUEST_USING, set by the vCPU with a cmpxchg only while VALID
+	 * holds, cleared only by that vCPU or by a mutator's xchg), and a
+	 * mutator can consume the whole state with one xchg to learn whether
+	 * it must wait for readers and/or kick the pinning vCPU before
+	 * touching anything they see. See the comments in pfncache.c.
 	 *
 	 * 'active' deliberately stays separate: the invalidation and
 	 * mutation paths operate on the word without having to care about
@@ -129,6 +142,7 @@ struct gfn_to_pfn_cache {
  * VALID clear.
  */
 #define GPC_INVALIDATING	0x4
+#define GPC_GUEST_USING		0x8
 
 #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
 /*
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 2fe50dfa3fc1..e15d9a475fed 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -25,7 +25,9 @@
 void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 				       unsigned long end)
 {
+	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
 	struct gfn_to_pfn_cache *gpc;
+	bool evict_vcpus = false;
 	bool cleared = false;
 
 	spin_lock(&kvm->gpc_lock);
@@ -91,10 +93,60 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 
 			if (old & GPC_VALID)
 				cleared = true;
+
+			/*
+			 * If a vCPU has the pfn pinned for direct use from
+			 * guest mode, it must be forced out of guest mode
+			 * before the invalidation may complete. The pin bit
+			 * was set with a cmpxchg only while GPC_VALID held,
+			 * so this same read of 'old' cannot miss it. It is
+			 * NOT cleared here: only the vCPU itself (on request
+			 * service, before re-pinning) or a mutator's xchg
+			 * (which inherits the kick duty) may clear it. A
+			 * stale pin costs at most a spurious request bit:
+			 * kvm_make_vcpus_request_mask() only IPIs and waits
+			 * for targets actually in guest mode.
+			 */
+			if (old & GPC_GUEST_USING) {
+				if (!evict_vcpus) {
+					evict_vcpus = true;
+					bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
+				}
+				__set_bit(gpc->vcpu->vcpu_idx, vcpu_bitmap);
+				/*
+				 * Set this cache's own service request (what
+				 * the vCPU must do before re-entering); the
+				 * force-out below is common to all of them.
+				 */
+				__kvm_make_request(gpc->vcpu_req, gpc->vcpu);
+			}
 		}
 	}
 	spin_unlock(&kvm->gpc_lock);
 
+	/*
+	 * Force pinned vCPUs out of guest mode before waiting for the
+	 * kernel readers below and before the caller zaps the page tables.
+	 * The request includes KVM_REQUEST_WAIT (enforced at init), so this
+	 * does not return until the vCPUs have left guest mode; they cannot
+	 * re-enter with the stale mapping, because re-pinning requires
+	 * GPC_VALID, which requires a refresh, which cannot complete until
+	 * invalidate_range_end().
+	 *
+	 * This is safe on unblockable (OOM reaper) ranges too, with no
+	 * special-casing: kvm_make_vcpus_request_mask() runs with
+	 * preemption disabled and spin-waits for IPI acks; it never sleeps.
+	 * Do not be tempted to skip the wait for !blockable ranges on the
+	 * assumption that a reaped task's vCPUs are already stopped: that
+	 * is false for process_mrelease(), which only requires
+	 * SIGNAL_GROUP_EXIT, and a vCPU still in guest mode after this
+	 * walk returns is exactly the use-after-free this kick exists to
+	 * prevent.
+	 */
+	if (evict_vcpus)
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_OUTSIDE_GUEST_MODE,
+					    vcpu_bitmap);
+
 	/*
 	 * Readers may still be using the old mapping, having sampled
 	 * GPC_VALID before it was cleared. Wait for them all to drain
@@ -122,7 +174,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 	 * so the grace period never blocks in reclaim either.)
 	 */
 	if (cleared)
-		synchronize_srcu_expedited(&kvm->gpc_srcu);
+		synchronize_srcu_atomic(&kvm->gpc_srcu);
 
 	/*
 	 * Note the GPC_INVALIDATING markers set above are deliberately NOT
@@ -190,6 +242,100 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return true;
 }
 
+/*
+ * A mutator's xchg of the state word to zero may have consumed a live
+ * GPC_GUEST_USING pin. Clearing that bit obliges the clearer to do what
+ * the invalidation walk would have done: post the cache's service
+ * request and force the vCPU out of guest mode, waiting until it has
+ * left, before mutating or tearing down what the guest may be using.
+ *
+ * The service request is posted unconditionally: consuming a pin means
+ * whatever physical address the vCPU had latched (e.g. into a hardware
+ * control structure) is stale, and only the request handler makes that
+ * good. That holds even when the pinning vCPU is the caller itself —
+ * a vCPU refreshing its own pinned cache may re-map at a different pfn,
+ * and without the request nothing would rewrite the stale address
+ * before the next guest entry. Only the waited force-out is skipped in
+ * that case: a vCPU running a refresh is by definition not in guest
+ * mode. (The vCPU's own unpin is the one silent path, in
+ * kvm_gpc_unpin_for_guest(), because unpinning asserts the address is
+ * no longer latched anywhere.)
+ */
+static void gpc_kick_pinned_vcpu(struct gfn_to_pfn_cache *gpc, int old_state)
+{
+	DECLARE_BITMAP(vcpu_bitmap, KVM_MAX_VCPUS);
+
+	if (!(old_state & GPC_GUEST_USING))
+		return;
+	if (WARN_ON_ONCE(!gpc->vcpu))
+		return;
+
+	__kvm_make_request(gpc->vcpu_req, gpc->vcpu);
+
+	if (kvm_get_running_vcpu() == gpc->vcpu)
+		return;
+
+	/*
+	 * As in the invalidation walk: force the vCPU out of guest mode and
+	 * wait until it has left (KVM_REQ_OUTSIDE_GUEST_MODE carries
+	 * KVM_REQUEST_WAIT). A plain kvm_vcpu_kick() would not wait.
+	 */
+	bitmap_zero(vcpu_bitmap, KVM_MAX_VCPUS);
+	__set_bit(gpc->vcpu->vcpu_idx, vcpu_bitmap);
+	kvm_make_vcpus_request_mask(gpc->kvm, KVM_REQ_OUTSIDE_GUEST_MODE,
+				    vcpu_bitmap);
+}
+
+bool kvm_gpc_pin_for_guest(struct gfn_to_pfn_cache *gpc)
+{
+	int old, new;
+
+	WARN_ON_ONCE(!gpc->vcpu);
+	WARN_ON_ONCE(gpc->vcpu && kvm_get_running_vcpu() != gpc->vcpu);
+
+	/*
+	 * Set GPC_GUEST_USING only while GPC_VALID holds: the pin then
+	 * cannot race with an invalidation, because the invalidation walk
+	 * reads the whole state word in one atomic operation — either it
+	 * sees VALID (and this pin, if set) and kicks; or the publish which
+	 * set VALID has not happened and the walk's veto of
+	 * GPC_BECOMING_VALID prevents it. The acquire pairs with the
+	 * release-publish so the pinned pfn/khva are the published ones.
+	 */
+	old = atomic_read_acquire(&gpc->state);
+	do {
+		if (!(old & GPC_VALID))
+			return false;
+		new = old | GPC_GUEST_USING;
+	} while (!atomic_try_cmpxchg(&gpc->state, &old, new));
+
+	return true;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_pin_for_guest);
+
+void kvm_gpc_unpin_for_guest(struct gfn_to_pfn_cache *gpc)
+{
+	/*
+	 * Only the pinning vCPU itself may unpin — except on teardown
+	 * paths (vCPU destruction), which run with no running-vCPU
+	 * context but with the vCPU necessarily out of guest mode.
+	 */
+	WARN_ON_ONCE(gpc->vcpu && kvm_get_running_vcpu() &&
+		     kvm_get_running_vcpu() != gpc->vcpu);
+
+	/*
+	 * The vCPU's last access to the pfn must be visible before the pin
+	 * is seen clear by an invalidator deciding it need not kick
+	 * (atomic_andnot() alone is unordered). In practice the VM-exit
+	 * which preceded this call already serialized the guest's accesses,
+	 * but the API should not depend on its callers' exit paths. A pin
+	 * already consumed by a mutator's xchg makes this a harmless no-op.
+	 */
+	smp_mb__before_atomic();
+	atomic_andnot(GPC_GUEST_USING, &gpc->state);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gpc_unpin_for_guest);
+
 static void *gpc_map(kvm_pfn_t pfn)
 {
 	if (pfn_valid(pfn))
@@ -405,7 +551,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
-	bool must_drain;
+	int old_state;
 	void *old_khva;
 	int ret;
 
@@ -498,10 +644,10 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	 * reader-visible fields (uhva, gpa, memslot, and later pfn/khva) be
 	 * mutated or the old mapping torn down.
 	 */
-	must_drain = atomic_xchg(&gpc->state, 0) &
-		     (GPC_VALID | GPC_INVALIDATING);
-	if (must_drain)
-		synchronize_srcu_expedited(&gpc->kvm->gpc_srcu);
+	old_state = atomic_xchg(&gpc->state, 0);
+	gpc_kick_pinned_vcpu(gpc, old_state);
+	if (old_state & (GPC_VALID | GPC_INVALIDATING))
+		synchronize_srcu_atomic(&gpc->kvm->gpc_srcu);
 
 	old_pfn = gpc->pfn;
 	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
@@ -599,7 +745,7 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 }
 
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		    bool never_dirty)
+		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req)
 {
 	mutex_init(&gpc->refresh_lock);
 
@@ -610,6 +756,8 @@ void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->active = false;
 	atomic_set(&gpc->state, 0);
 	gpc->never_dirty = never_dirty;
+	gpc->vcpu = vcpu;
+	gpc->vcpu_req = vcpu_req;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
@@ -667,6 +815,7 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 	struct kvm *kvm = gpc->kvm;
 	kvm_pfn_t old_pfn;
 	void *old_khva;
+	int old_state;
 
 	guard(mutex)(&gpc->refresh_lock);
 
@@ -687,8 +836,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		 * readers outstanding — it left GPC_INVALIDATING set to say
 		 * so — and the unmap below must not run under those readers.
 		 */
-		if (atomic_xchg(&gpc->state, 0) &
-		    (GPC_VALID | GPC_INVALIDATING))
+		old_state = atomic_xchg(&gpc->state, 0);
+		gpc_kick_pinned_vcpu(gpc, old_state);
+		if (old_state & (GPC_VALID | GPC_INVALIDATING))
 			synchronize_srcu_atomic(&kvm->gpc_srcu);
 
 		/*
-- 
2.55.0

