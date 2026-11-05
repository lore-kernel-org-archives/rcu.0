Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844078;
	b=JcD33Nu3MBPakFti0NY7njx3TjcDG1EkbqkgqXhKPk1g42mXM+IJ7iEe1SMbfvfzCuyG
	 fz9Nztpqn3rdWXYMZ7cPJkVKPrTo5Fu+DXWUe3ajWdCnOl29wyrnKEjF9TY++x+vW8Njc
	 ngk2bha3w/S/mACIWoxUJbiGY2VHZNJQ8YGo6mvIThFEKWNcAXzkDQ6vclHFNQqSESj9+
	 n+ti0qcj92/t1mRBlXhSfMCtMn+nKs1qcJgiBY1afn+Qb+PMy8V84/ktn02HoA753NlzT
	 9yVT4/jkRnDB88hSa31fMCD/I5xsJFLsqALt2yaOfeJElaeweMEnzcz2J3NMErEWNgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844078;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=tlil6pgzu2xPgb8UCS8ovNT3btJoY4ercWr+hPOutBs=;
	b=qZbSLHLMjiqHJEX7SbNB08ReGbBuPhkhGsu/JW/PHUoUusOR+1M8F9mQVrNV8WGiQcgl
	 jR89/3cWp5D1Qid5aPOp/d8K9trh7eTybjm3E7adMPQUlau0hAawkkKslHDeXudFfUq6n
	 dVLDRX/D60pyEVcCiehG9o+7zulG6LAzj+/5GIIRXAcehrr8FCaHaXc7+z6Gc/5hyWb84
	 TGkXP43N4xjUWM93QAb3AfEIqTv3hHYL4ANZ/Tlw65Q1pHUM2/zlHhtLiUIXvwhhFYqny
	 HkVDmFPOqigfl2lLefrNNLDAvJwDj8frvVbGKs003vPvFnWl273oghGIF/i7cA2wbqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QoSxerRj;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE41606EEA8;
	Thu,  5 Nov 2026 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE41606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QoSxerRj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tlil6pgzu2xPgb8UCS8ovNT3btJoY4ercWr+hPOutBs=; b=QoSxerRjbEEU1udbAgchHwSKwt
	FomsXBiFW5t2aoAJeE2TdtAtOcC/DfRns6DbNX+NeVxphZThpnL6hmODqQGX9WMeJCtAltXLLNc6q
	/Xmjfrm3jclX4VMiKz5h5Xd7iCCTuoiF8RaeVu7Wu+oOKh8MTz//nHfywsXys6nOPUMXWPyYSG224
	mpqmZoMFefEcchf3fpLDG+I+XIo+E+uO9M2ZzViyLclSlYGtG8K8cxV1vKb0gL0lWcbB2xmO0HWJK
	8O4DICb+DKJXqpYvviVwOAkCGP2Ip3oO08aOZfhgaG0n3rE7/fqNbZ++6UNMr4H7tZYtQ75opwIn4
	iPmkqnKA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmo-00000002ROQ-265G;
	Thu, 05 Nov 2026 02:01:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWE2-3lIT;
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
Subject: [PATCH v2 16/20] KVM: nSVM: Cache L1's MSR permissions map pages
Date: Thu,  5 Nov 2026 02:00:58 +0000
Message-ID: <20261105020104.2507083-17-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Reads of L1's MSRPM go through kvm_vcpu_read_guest() on two paths:
the vmcb02 MSRPM merge on nested VMRUN (~10 reads per entry), and the
per-intercept check on every trapped L2 MSR access. With unmanaged
guest memory each read is a memremap/memunmap cycle.

Cache the two pages of L1's MSRPM in a pair of gfn_to_pfn_caches,
keyed on msrpm_base_pa (re-keying automatically when L1 switches to
a different L2 with a different bitmap). Reads preserve the existing
failure semantics: an unreadable bitmap means NESTED_EXIT_DONE
(reflect to L1) on the intercept path and a failed VMRUN on the merge
path.

An 8-byte merge read is naturally aligned and a one-byte intercept
read cannot cross a page, so each access hits exactly one cached page;
a WARN in the accessor enforces that invariant.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/nested.c | 57 ++++++++++++++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.h    |  7 +++++
 2 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 32854c8b2bbc..4e22cd7a38e1 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -288,10 +288,35 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 }
 
 /*
- * Merge L0's (KVM) and L1's (Nested VMCB) MSR permission bitmaps. The function
- * is optimized in that it only merges the parts where KVM MSR permission bitmap
- * may contain zero bits.
+ * Read from L1's MSR permissions map through the per-page caches.
+ * @offset is a byte offset into the (two-page) MSRPM; the read must not
+ * cross a page boundary. msrpm_base_pa is page-aligned by construction:
+ * __nested_copy_vmcb_control_to_cache() masks it with PAGE_MASK (hardware
+ * ignores bits 11:0), and nested_vmcb_check_controls() bounds-checks it
+ * via nested_svm_check_bitmap_pa().
  */
+static int nested_svm_read_l1_msrpm(struct vcpu_svm *svm, unsigned long offset,
+				    void *val, unsigned int len)
+{
+	gpa_t base = svm->nested.ctl.msrpm_base_pa;
+	struct gfn_to_pfn_cache *gpc;
+	int idx;
+
+	if (WARN_ON_ONCE(offset >= MSRPM_SIZE ||
+			 offset_in_page(offset) + len > PAGE_SIZE))
+		return -EINVAL;
+
+	gpc = &svm->nested.msrpm12_cache[offset >> PAGE_SHIFT];
+
+	idx = kvm_gpc_lock_page(gpc, base + (offset & PAGE_MASK));
+	if (idx < 0)
+		return idx;
+
+	memcpy(val, gpc->khva + offset_in_page(offset), len);
+	kvm_gpc_unlock(gpc, idx);
+	return 0;
+}
+
 static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -324,11 +349,9 @@ static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 	for (i = 0; i < nested_svm_nr_msrpm_merge_offsets; i++) {
 		const int p = nested_svm_msrpm_merge_offsets[i];
 		nsvm_msrpm_merge_t l1_val;
-		gpa_t gpa;
-
-		gpa = svm->nested.ctl.msrpm_base_pa + (p * sizeof(l1_val));
 
-		if (kvm_vcpu_read_guest(vcpu, gpa, &l1_val, sizeof(l1_val)))
+		if (nested_svm_read_l1_msrpm(svm, p * sizeof(l1_val),
+					     &l1_val, sizeof(l1_val)))
 			return false;
 
 		msrpm02[p] = msrpm01[p] | l1_val;
@@ -1499,6 +1522,7 @@ static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
 int svm_allocate_nested(struct vcpu_svm *svm)
 {
 	struct page *vmcb02_page;
+	int i;
 
 	if (svm->nested.initialized)
 		return 0;
@@ -1517,6 +1541,16 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
 
+	/*
+	 * KVM only ever reads the MSR permissions map, which L1 may keep in
+	 * memory that its VMM maps read-only: map the cache read-only
+	 * (which also means never marking it dirty), matching the read
+	 * semantics of the kvm_vcpu_read_guest() calls it replaces.
+	 */
+	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
+		__kvm_gpc_init(&svm->nested.msrpm12_cache[i], svm->vcpu.kvm,
+			       false, true, NULL, 0);
+
 	svm->nested.initialized = true;
 	return 0;
 
@@ -1527,6 +1561,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 void svm_free_nested(struct vcpu_svm *svm)
 {
+	int i;
+
 	if (!svm->nested.initialized)
 		return;
 
@@ -1537,6 +1573,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	svm->nested.msrpm = NULL;
 
 	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
+		kvm_gpc_deactivate(&svm->nested.msrpm12_cache[i]);
 
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
@@ -1589,7 +1627,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 {
-	gpa_t base = svm->nested.ctl.msrpm_base_pa;
 	int write, bit_nr;
 	u8 value, mask;
 	u32 msr;
@@ -1604,8 +1641,8 @@ static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 	if (bit_nr < 0)
 		return NESTED_EXIT_DONE;
 
-	if (kvm_vcpu_read_guest(&svm->vcpu, base + bit_nr / BITS_PER_BYTE,
-				&value, sizeof(value)))
+	if (nested_svm_read_l1_msrpm(svm, bit_nr / BITS_PER_BYTE,
+				     &value, sizeof(value)))
 		return NESTED_EXIT_DONE;
 
 	mask = BIT(write) << (bit_nr & (BITS_PER_BYTE - 1));
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fe964a961305..8a5dff5a9ee3 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -222,6 +222,13 @@ struct svm_nested_state {
 	/* Cached mapping of the vmcb12 page, keyed on vmcb12_gpa */
 	struct gfn_to_pfn_cache vmcb12_cache;
 
+	/*
+	 * Cached mappings of the two pages of L1's MSR permissions map,
+	 * keyed on ctl.msrpm_base_pa, for the vmcb02 merge and the
+	 * per-intercept checks.
+	 */
+	struct gfn_to_pfn_cache msrpm12_cache[MSRPM_SIZE / PAGE_SIZE];
+
 	/*
 	 * The MSR permissions map used for vmcb02, which is the merge result
 	 * of vmcb01 and vmcb12
-- 
2.43.0

