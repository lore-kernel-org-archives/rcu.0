Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=MLcAUoq4evCwdaQTobRXy+I3v5HJSqAE1TJ7+No0SGn60+MLd3x5/NV+ZjojRwk5hfVt
	 b3azyYugzCvdmOPkt5Kk4BD5vz/gAWIfZfHouQUoY6zR/1jY+dInQPXZC7dR+nfe/K7yy
	 95UWSe4iXPUhz/C2j0GMbnUgXi86OYPe+YUGFgW7qWw0AC/jVbJf4HeGdhUUc9wuHVvPf
	 4spQ3eI4a2XGbdwrX7uWy1NgwLZ4FZ6kmIyBjY8gFonuB9/we0O88hrPFNTCWwXqsbOsE
	 0EfPgBwoa939Ji4Lrg0dyalHU6N5Y7PsaZZH4xQ0pTG+oodCiN7D2ziPPgnpo0TbifA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=cS36VXsZObmcF5KZcGY9YdwDsYCRTEkKDtw4SlNBJeo=;
	b=UCNgVze4k22cl0iQWTi/CMDXVDmWBkw7W/NK/7t01aY5op7YVvfLjr5bVj8ZYmstjc1B
	 bGcnXvZP9U7uy3uOwIxi/QKV+2FL7nGgqR0pihSyDN/RJLRlbGx6SPUkY0IUhc/P3jwBn
	 XHxAss0KT0GhUxZidgPtCFuWvBo1h9RF3u46XyPO3WSrXPaU0dMBJ+6+tl0q/gnV11y/X
	 u10kN+yqeay1MPrDm/hQwGlvBlTxNk+EkrDgA+Nor1FSQGi5J+Wl7vwFXOl1GRMtIgIwc
	 DMD4NTmk+pRakgeDi3CEUkDf+6/W9bmzkIX0Ylw8d30Nql2ue40B2LPX15vMyZ5ZKmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZJgZKNV0;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8A606A339;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB8A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZJgZKNV0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=cS36VXsZObmcF5KZcGY9YdwDsYCRTEkKDtw4SlNBJeo=; b=ZJgZKNV0eN8AdXxFvUuk90tiD8
	vE1BPAG6D/aNhtTw2m3t/hRNH5aPI3/7NCLRhexAECEu009aXZwg18CNDrXNj2axRztLy5ZIexufa
	59g/7PUKYEZYh3i/SXuHx77nZl0yiK1EcW3/4rWV5W0rj0JF7IBDA61WmwRm7rvGHnz3dBiBD50q+
	q6N18WSHGIv1OUplmLQGr+pNckiHWs4CHpJ0Cqvj+JRfZkjwUpTTiFlZvPciTCJYp4c9SkEhanV08
	zy6YuGEJUt0d5wBDGHv1fpIbuQQsXN2kOEAEAssSBDI8cZI0txnS0LPmdKuYBaRqvjazi+eMSGZPw
	o+qTyGRA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jC-0E92;
	Thu, 05 Nov 2026 02:01:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDV-1xzt;
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
Subject: [PATCH v2 10/20] KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
Date: Thu,  5 Nov 2026 02:00:52 +0000
Message-ID: <20261105020104.2507083-11-dwmw2@infradead.org>
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

Reinstate support for caches whose pfn a vCPU uses directly from guest
mode (stuffed into hardware control structures such as vmcs02 fields),
addressing the reasons the original KVM_GUEST_USES_PFN was removed as
incomplete/broken¹²:

 - The kick now comes with a guarantee. The original
   KVM_REQ_OUTSIDE_GUEST_MODE kick did "absolutely nothing to
   guarantee KVM refreshes the cache before re-entering the guest"¹.
   Now, a vCPU pins with a cmpxchg which succeeds only while
   GPC_VALID holds, the invalidation walk reads the pin in the same
   atomic word it uses to veto in-flight publishes, and re-pinning
   requires a refresh which cannot complete until
   invalidate_range_end(): a forced-out vCPU cannot re-enter with
   the stale mapping.

 - The service request is per-cache, given at init³
   (kvm_gpc_init_for_vcpu()), so e.g. nVMX can request
   KVM_REQ_GET_NESTED_STATE_PAGES rather than KVM guessing what a
   kicked vCPU must do before re-entering.

 - No special-casing of non-blockable invalidations. The original
   stripped KVM_REQUEST_WAIT for the OOM reaper, assuming a reaped
   task's vCPUs are stopped; that is false for process_mrelease()
   and opened the very use-after-free the kick exists to prevent⁴.
   The wait is unconditionally safe: kvm_make_vcpus_request_mask()
   spin-waits for IPI acks with preemption disabled, never sleeping.

 - Pin lifecycle has single-writer discipline: only the pinning vCPU
   sets or clears its pin, except that a mutator's xchg of the state
   word may consume it, inheriting the kick-and-wait duty. A stale
   pin costs at most a spurious request bit.

No users yet; the nVMX conversion⁵ builds on this.

¹ https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com
² https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com
³ https://lore.kernel.org/all/agJnqh7ACEkB-ftx@google.com
⁴ per Jann Horn's analysis in ²
⁵ https://lore.kernel.org/all/20260102142429.896101-1-griffoul@gmail.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c        |   4 +-
 include/linux/kvm_host.h  |  64 +++++++++++++-
 include/linux/kvm_types.h |  28 ++++--
 virt/kvm/pfncache.c       | 181 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 259 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 13e287bc17bb..132f0c379537 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2465,7 +2465,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true, NULL, 0);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
@@ -2486,7 +2486,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true, NULL, 0);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3ed0b8c9c102..008012d74d58 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1474,19 +1474,79 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @kvm:	   pointer to kvm instance.
  * @never_dirty:   the cache never needs to mark its page dirty in its memslot.
+ * @vcpu:	   the vCPU which may pin this cache's pfn for direct use from
+ *		   guest mode, or NULL for a cache which is never pinned.
+ * @vcpu_req:	   service request posted to @vcpu when a pinned cache is
+ *		   invalidated; must be non-zero when @vcpu is given (request
+ *		   0 is a real request, so it cannot mean "none"). Most
+ *		   callers want the kvm_gpc_init_for_vcpu() wrapper.
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
  * the caller before init).  Most callers want the kvm_gpc_init() wrapper.
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
+ * refresh and retry, or bail. Also returns false, permanently, for a
+ * cache initialized without a vCPU: a retry loop must not treat pin
+ * failure as transient unless the cache was initialized with
+ * kvm_gpc_init_for_vcpu().
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
index 1c98b7bdbf09..5cb30525e577 100644
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
@@ -127,10 +129,60 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 			 */
 			if (old & (GPC_VALID | GPC_INVALIDATING))
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
+	 * KVM_REQ_OUTSIDE_GUEST_MODE carries KVM_REQUEST_WAIT, so this
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
@@ -224,6 +276,107 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
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
+	/*
+	 * Fail closed on a cache initialized without a vCPU: proceeding
+	 * would arm the gpc->vcpu->vcpu_idx dereference in the
+	 * invalidation walk, crashing inside the mmu_notifier rather
+	 * than in the misusing caller.
+	 */
+	if (WARN_ON_ONCE(!gpc->vcpu))
+		return false;
+	WARN_ON_ONCE(kvm_get_running_vcpu() != gpc->vcpu);
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
@@ -449,7 +602,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	bool unmap_old = false;
 	unsigned long old_uhva;
 	kvm_pfn_t old_pfn;
-	bool must_drain;
+	int old_state;
 	void *old_khva;
 	int ret;
 
@@ -550,9 +703,9 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 	 * only this wait covers. The marker comes down only once the drain
 	 * is complete and the readers it advertised cannot exist.
 	 */
-	must_drain = atomic_xchg(&gpc->state, GPC_INVALIDATING) &
-		     (GPC_VALID | GPC_INVALIDATING);
-	if (must_drain)
+	old_state = atomic_xchg(&gpc->state, GPC_INVALIDATING);
+	gpc_kick_pinned_vcpu(gpc, old_state);
+	if (old_state & (GPC_VALID | GPC_INVALIDATING))
 		synchronize_srcu_atomic(&gpc->kvm->gpc_srcu);
 	atomic_set(&gpc->state, 0);
 
@@ -650,7 +803,7 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 }
 
 void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
-		    bool never_dirty)
+		    bool never_dirty, struct kvm_vcpu *vcpu, u32 vcpu_req)
 {
 	mutex_init(&gpc->refresh_lock);
 
@@ -661,6 +814,18 @@ void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
 	gpc->active = false;
 	atomic_set(&gpc->state, 0);
 	gpc->never_dirty = never_dirty;
+
+	/*
+	 * A vCPU-owned cache must come with a service request for the
+	 * invalidation walk to post; request 0 is a real request
+	 * (KVM_REQ_TLB_FLUSH on x86), so a missing one cannot be allowed
+	 * to alias it. Refuse the vcpu rather than arm that footgun —
+	 * the pin API then fails closed on !gpc->vcpu.
+	 */
+	if (WARN_ON_ONCE(vcpu && !vcpu_req))
+		vcpu = NULL;
+	gpc->vcpu = vcpu;
+	gpc->vcpu_req = vcpu_req;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
@@ -718,6 +883,7 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 	struct kvm *kvm = gpc->kvm;
 	kvm_pfn_t old_pfn;
 	void *old_khva;
+	int old_state;
 
 	guard(mutex)(&gpc->refresh_lock);
 
@@ -741,8 +907,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
 		 * the drain completes, so that an mmu_notifier walk arriving
 		 * mid-wait does not read a zero state and skip the cache.
 		 */
-		if (atomic_xchg(&gpc->state, GPC_INVALIDATING) &
-		    (GPC_VALID | GPC_INVALIDATING))
+		old_state = atomic_xchg(&gpc->state, GPC_INVALIDATING);
+		gpc_kick_pinned_vcpu(gpc, old_state);
+		if (old_state & (GPC_VALID | GPC_INVALIDATING))
 			synchronize_srcu_atomic(&kvm->gpc_srcu);
 		atomic_set(&gpc->state, 0);
 
-- 
2.43.0

