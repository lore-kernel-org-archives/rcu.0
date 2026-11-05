Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=ju1EVJ3aFW0P6yVRj7yYKT3zeDWipaBS7dNiX2kv7Uq8E/3EBTRwEwtqcJXrkIqD0BR5
	 F2st1cP0/eCqbSwjStHJe4n39cJmAL81bSzVp+POv7VXITkym2HGgDvYP6fZn9Td6vHUU
	 05aQYmVZevqBzMEBQ4n6eLZARl5SqkKS3DqdgXivOAgPYoMINj3fmFer6qMGRwhC7w74z
	 Kb4cUMjwu8OllIrf8SgZCQ1DYCsZHdigjbKvnZnMmk5Xo2JCHm9FQ57ROgWJWUILN8lAg
	 lD/tbWZQ0hasWZMHK7nK9AtxOXc/ZnJRF78Udc0X1bxIIW95ldqSurY/nqw6xtQ0giw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=5NTMmASLeB2L/VhizvxNP+opz3b0eVIoDdUhideV8+0=;
	b=Ae9CB01L9lU7OBU5rEYrHRtWIaWoYGm0o/O6ozmkZsU3Kt/t2Fs0fOsdzpnvuyl9Gfd7
	 QyjK6HLWz16X+5r39WkgjiqwFT3ml1Zb/dMrJ4rcavSZu7CF8X1j92ECOJRDpNFFCI6j3
	 35abMwHoiu4ST4tpwoL/1TSORlti4xLc1MuWWngHbJYbm6RKgE+wf+3bQkReaqcQpA8vN
	 enfaFoEWMCpkyUA7YZaOS8korVa8e1xgLAe/ouvqeuEvxrVAoC2uardvQHck2N4O4ATgA
	 7mmVbxLE8r2M85a0G03qR735qpoemx6hVB6gH08T9aQwqhDKFu8uuCfN14rs9Bhurzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=glkXx2Rv;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB07606A33B;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB07606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=glkXx2Rv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=5NTMmASLeB2L/VhizvxNP+opz3b0eVIoDdUhideV8+0=; b=glkXx2Rv8ZK4f/LZtNxR3J2Mxl
	YyjCguWA4Nhxpxlw3694qYHDyRqXMo89aEmyefHMJoXGQdS3DE6WO+SCHKkX/5+8R4ZU9QI3uO6lg
	Bc02QgRdQ9b+Hsm45zALUwhiWau9ScCoUlV3d7gmgBGDmV6aR1eUfNpg71igNIyaTP25IcXej+0MK
	Wc78I4Rc5o65fa31dEE4UBocG8I9ruE3Iiu0b/G3AJJcTME0UVfmx6oFmHSH6Pa+Y0aWmCC7HhXWC
	A8/bynSWpLWVV9hLLY4R1nymJVupSFlvvjWbhzjWgIxF6J9Hru59YtQbwCNl+hHB2eEbwxLiuqrG5
	9RApx1oQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j6-09Cw;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDA-0wz8;
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
Subject: [PATCH v2 03/20] KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
Date: Thu,  5 Nov 2026 02:00:45 +0000
Message-ID: <20261105020104.2507083-4-dwmw2@infradead.org>
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

From: Sean Christopherson <seanjc@google.com>

Move the marking of an event as pending in the target vCPU's vcpu_info
into a separate helper, __kvm_xen_set_evtchn_fast(), invoked after the
shared_info processing is complete and the shared_info cache's read
lock has been dropped. This makes both halves easier to read.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[dwmw2: rebased onto the -EAGAIN series, and reworded. Sean's series
 first converted the GPC locks to read_trylock(), which this series
 does not carry, so the helper takes the plain read lock and the
 original's trylock failure path does not apply. The caller's
 kvm->srcu section extends across the helper call, since
 kvm_gpc_check() on the vcpu_info cache consults the memslot
 generation and the irqfd path enters holding only irq_srcu; in
 Sean's series that was covered by a guard(srcu) spanning the whole
 function. The original said "no functional change intended", but
 here the lock scopes do change: kvm_xen_check_poller() and the
 upcall vector injection now run outside the GPC read locks (and
 with interrupts restored), deliberately, so that the vCPU kick and
 the APIC map walk are not nested inside them.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 158 ++++++++++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 61 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 2718da1320e0..4517eeb24909 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1884,6 +1884,89 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit,
+				      bool has_64bit_shinfo)
+{
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	unsigned long vi_pending_sel_ofs;
+	bool inject_upcall = false;
+	bool kick_vcpu = false;
+	unsigned long flags;
+	bool old;
+
+	vi_pending_sel_ofs = has_64bit_shinfo ?
+		offsetof(struct vcpu_info, evtchn_pending_sel) :
+		offsetof(struct compat_vcpu_info, evtchn_pending_sel);
+
+	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
+	read_lock_irqsave(&gpc->lock, flags);
+	if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		/*
+		 * Could not access the vcpu_info. Set the bit in-kernel and
+		 * prod the vCPU to deliver it for itself. Note that an MSI is
+		 * *not* an acceptable substitute here even if the vCPU has an
+		 * upcall vector: the pending bit only exists in
+		 * evtchn_pending_sel so far, and the vCPU has to be forced
+		 * out of the guest so that kvm_xen_inject_pending_events()
+		 * can refresh the cache and propagate it to the guest.
+		 */
+		if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+			kick_vcpu = true;
+		goto out_unlock;
+	}
+	inject_upcall = true;
+
+	/*
+	 * Explicitly use a 32-bit btsl instead of test_and_set_bit(), which
+	 * would use btsq on x86-64. The vcpu_info is guest-controlled and only
+	 * required to be 32-bit aligned, so a 64-bit access could generate a
+	 * split-lock #AC.
+	 *
+	 * Note, this does not apply to the test_and_set_bit() on pending_bits
+	 * in the caller: that is in the per-VM shared_info, which is page
+	 * aligned, so the access is guaranteed to be 64-bit aligned.
+	 */
+	old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
+			       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
+			       c, "Ir", port_word_bit);
+	if (!old) {
+		struct vcpu_info *vi = gpc->khva;
+
+		/* No need for compat handling */
+		BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
+			     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
+
+		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
+		kick_vcpu = true;
+	}
+
+out_unlock:
+	read_unlock_irqrestore(&gpc->lock, flags);
+
+	/*
+	 * Deliver the upcall or kick the vCPU only after dropping the GPC
+	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
+	 * delivery also walks the APIC map and takes APIC locks; none of
+	 * that wants to be nested inside the GPC read lock, which a
+	 * concurrent invalidation may be waiting to take for write.
+	 */
+	if (!kick_vcpu)
+		return;
+
+	/*
+	 * For the per-vCPU lapic vector, deliver it as MSI — but only if the
+	 * vcpu_info was actually updated above. If it wasn't, the vCPU must
+	 * be kicked instead (see above).
+	 */
+	if (inject_upcall && vcpu->arch.xen.upcall_vector) {
+		kvm_xen_inject_vcpu_vector(vcpu);
+		return;
+	}
+
+	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+	kvm_vcpu_kick(vcpu);
+}
+
 /*
  * The return value from this function is propagated to kvm_set_irq() API,
  * so it returns:
@@ -1898,11 +1981,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
+	unsigned long *pending_bits, *mask_bits;
 	struct kvm_vcpu *vcpu;
 	unsigned long flags;
 	int port_word_bit;
-	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
@@ -1924,23 +2006,19 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	read_lock_irqsave(&gpc->lock, flags);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
+		goto out_unlock;
 
 	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 64;
-
-		vi_pending_sel_ofs = offsetof(struct vcpu_info, evtchn_pending_sel);
 	} else {
 		struct compat_shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 		mask_bits = (unsigned long *)&shinfo->evtchn_mask;
 		port_word_bit = xe->port / 32;
 
-		vi_pending_sel_ofs = offsetof(struct compat_vcpu_info, evtchn_pending_sel);
-
 		/* test_and_set_bit() needs 64-bit alignment, but that's OK */
 		BUILD_BUG_ON(offsetof(struct compat_shared_info, evtchn_pending) & 7);
 	}
@@ -1956,66 +2034,24 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 0; /* It was already raised */
 	} else if (test_bit(xe->port, mask_bits)) {
 		rc = -ENOTCONN; /* Masked */
-		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
-		bool old;
-
 		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_rcu;
-		}
-
-		/*
-		 * Explicitly use a 32-bit btsl instead of test_and_set_bit(),
-		 * which would use btsq on x86-64. The vcpu_info is guest-
-		 * controlled and only required to be 32-bit aligned, so a
-		 * 64-bit access could generate a split-lock #AC.
-		 *
-		 * Note, this does not apply to the test_and_set_bit() on
-		 * pending_bits above: that is in the per-VM shared_info, which
-		 * is page aligned, so the access is guaranteed to be 64-bit
-		 * aligned.
-		 */
-		old = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl",
-				       *(u32 *)(gpc->khva + vi_pending_sel_ofs),
-				       c, "Ir", port_word_bit);
-		if (!old) {
-			struct vcpu_info *vi = gpc->khva;
-
-			/* No need for compat handling */
-			BUILD_BUG_ON(offsetof(struct vcpu_info, evtchn_upcall_pending) !=
-				     offsetof(struct compat_vcpu_info, evtchn_upcall_pending));
-
-			WRITE_ONCE(vi->evtchn_upcall_pending, 1);
-			kick_vcpu = true;
-		}
-
-		/* For the per-vCPU lapic vector, deliver it as MSI. */
-		if (kick_vcpu && vcpu->arch.xen.upcall_vector) {
-			kvm_xen_inject_vcpu_vector(vcpu);
-			kick_vcpu = false;
-		}
 	}
 
- out_rcu:
+ out_unlock:
 	read_unlock_irqrestore(&gpc->lock, flags);
-	srcu_read_unlock(&kvm->srcu, idx);
 
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	/*
+	 * Both of these can kick the vCPU, so keep them outside the GPC
+	 * read lock; an invalidation may be waiting to take it for write.
+	 */
+	if (rc == -ENOTCONN)
+		kvm_xen_check_poller(vcpu, xe->port);
+	else if (rc == 1)
+		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit,
+					  has_64bit_shinfo);
+
+	srcu_read_unlock(&kvm->srcu, idx);
 
 	return rc;
 }
-- 
2.43.0

