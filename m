Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD3367B97;
	Sun, 20 Sep 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940254; cv=none; b=TqHBtyweEMnzBDksvhqNK5N+6SAAwq/8/68Nxay3LtLPLOW2nVBWruBBoB/pD3THLkRAbgUgVEm7K2JA+CQw/DL3UCkweUJPPSpTqfiAEy5ETOuo8UJ2q4XXc+up5hWf6JaPBR8mCqaEnaOP3OL0FbcvOnhBz4I7oBbn87JMuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940254; c=relaxed/simple;
	bh=kGZ4qoeRByhQjUsG/+/8AQggZcX5GquINXhGjbNwVio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyuyG5a4HJHr/jxF7dzHeNobKZbGT2QpKe0z4VXl4LebqNGJ05Mu85wdDKD2wlzKniXE2FkC2BEwaVds4mmB4Q2LU18WcRdl+hWThj7jSwEGbekXLS6c97rQiT7yrNscBbsxEB4sxoT36G+36jhxlUiXAW9//idAsTf/2CO+Gh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XLfL2Qkc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLfL2Qkc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=PCP+XmpTdCIagw/n69ORbTHLgBJ9slFq50pCKS0eX+8=; b=XLfL2QkcZmg05QyM80gwwfRFlS
	b9QSkbhgA6FCDhr619h7XYzpxsuoaeVqJpjYENToLQ9UZTT4hdA3uJYDQdMTRBegH4ocpmAkfH5jd
	9oo3HS15zyud+4IbcetWyezu07yVhXg7X1WdMRETmUTVzx8y8OY58jW2hAfSt4uYvGwagBt4aMvlV
	MMmu2dbQh0XVhTj7Kg9dyOtBmY4pARD9WGHk7UtJ1OPYcZBjqetlUwNmwQbZqyJuSjCzLfO4RYr6g
	BpfaFWDsSaFO2LX0Eg50Um3LhHVYL7rfJD91idIA4bO9GHNRpGd9zal+YwR2+8QM2+UZ12YpXvR3/
	a6TGjB9A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpt-21Xm;
	Sun, 20 Sep 2026 21:19:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcS-0yXK;
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
Subject: [PATCH 02/17] KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
Date: Sun, 20 Sep 2026 21:49:30 +0100
Message-ID: <20260920211920.928306-3-dwmw2@infradead.org>
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

From: Sean Christopherson <seanjc@google.com>

Move the marking of an event as pending in the target vCPU's vcpu_info
into a separate helper, __kvm_xen_set_evtchn_fast(), invoked after the
shared_info processing is complete and its RCU read-side critical
section has been exited. This makes both halves easier to read.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[dwmw2: rebased onto the RCU conversion of the GPC locking; the
 read_trylock() failure path in the original no longer exists. The
 caller's kvm->srcu section now extends across the helper call, since
 kvm_gpc_check() on the vcpu_info cache consults the memslot
 generation and the irqfd path enters holding only irq_srcu; in Sean's
 series that was covered by a guard(srcu) spanning the whole function,
 which this series does not carry.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c | 155 ++++++++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ea907f5fa5f8..1364fe8ee751 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1807,6 +1807,93 @@ static void kvm_xen_check_poller(struct kvm_vcpu *vcpu, int port)
 	}
 }
 
+/* Called with kvm->srcu held, as kvm_gpc_check() consults the memslots. */
+static void __kvm_xen_set_evtchn_fast(struct kvm_vcpu *vcpu, int port_word_bit)
+{
+	struct gfn_to_pfn_cache *gpc = &vcpu->arch.xen.vcpu_info_cache;
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(vcpu->kvm);
+	unsigned long vi_pending_sel_ofs;
+	bool inject_upcall = false;
+	bool kick_vcpu = false;
+	bool old;
+	int idx;
+
+	vi_pending_sel_ofs = has_64bit_shinfo ?
+		offsetof(struct vcpu_info, evtchn_pending_sel) :
+		offsetof(struct compat_vcpu_info, evtchn_pending_sel);
+
+	/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
+	idx = srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);
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
+	srcu_read_unlock_atomic(&vcpu->kvm->gpc_srcu, idx);
+
+	/*
+	 * Deliver the upcall or kick the vCPU only after dropping the GPC
+	 * read lock. Both paths end up in kvm_vcpu_kick(), and the MSI
+	 * delivery also walks the APIC map and takes APIC locks; none of
+	 * that wants to be nested inside the GPC read-side critical
+	 * section, which must be no longer than the accesses to gpc->khva
+	 * above. Invalidation waits for a grace period, so holding the
+	 * read lock across the kick would extend how long a memory
+	 * invalidation is blocked.
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
@@ -1821,10 +1908,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(kvm);
-	unsigned long *pending_bits, *mask_bits, vi_pending_sel_ofs;
+	unsigned long *pending_bits, *mask_bits;
 	struct kvm_vcpu *vcpu;
 	int port_word_bit;
-	bool kick_vcpu = false;
 	int vcpu_idx, idx, gpc_idx, rc;
 
 	vcpu_idx = READ_ONCE(xe->vcpu_idx);
@@ -1853,16 +1939,12 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
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
@@ -1878,64 +1960,23 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		rc = 0; /* It was already raised */
 	} else if (test_bit(xe->port, mask_bits)) {
 		rc = -ENOTCONN; /* Masked */
-		kvm_xen_check_poller(vcpu, xe->port);
 	} else {
-		bool old;
-
 		rc = 1; /* Delivered to the bitmap in shared_info. */
-		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		gpc = &vcpu->arch.xen.vcpu_info_cache;
-
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-			/*
-			 * Could not access the vcpu_info. Set the bit in-kernel
-			 * and prod the vCPU to deliver it for itself.
-			 */
-			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
-				kick_vcpu = true;
-			goto out_gpc_srcu;
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
 
  out_gpc_srcu:
 	srcu_read_unlock_atomic(&kvm->gpc_srcu, gpc_idx);
-	srcu_read_unlock(&kvm->srcu, idx);
 
-	if (kick_vcpu) {
-		kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-		kvm_vcpu_kick(vcpu);
-	}
+	/*
+	 * Both of these can kick the vCPU, so keep them outside the GPC
+	 * read-side critical section; invalidation waits for a grace period.
+	 */
+	if (rc == -ENOTCONN)
+		kvm_xen_check_poller(vcpu, xe->port);
+	else if (rc == 1)
+		__kvm_xen_set_evtchn_fast(vcpu, port_word_bit);
+
+	srcu_read_unlock(&kvm->srcu, idx);
 
 	return rc;
 }
-- 
2.55.0

