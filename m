Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2823FE37A;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939196; cv=none; b=TRHva1dvG01lLqq7VLwVS6kOQTEgner6YyMLWR3VzIMiyZS+gx10XHE7aXacU/mLx7WociAGF25jH45zNV3zhCwwu8mYMClBzalukeOaQtVI8tFO2tkgPqIB6zNO9iSx+OWhgGe6uzJaA9yjMNBcPcgp06KWX0IS+ThvU11/4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939196; c=relaxed/simple;
	bh=Y4CTwaklHR2OmcE3Rw07p2DrrOVA1opquovvp1Q3o2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3uQ1g8CLRZfbjNtaK770qC19x/Jv+whBIoN1jKV8Ih7r5IT9bnRF6deMiMCmWCkI6yxk5C4IKj++D+8XbgiGDGNix+eskE8zrNI8Z7DuK0kczPRaucLxhNyWkX5xlyrfXEOpkPmRiBeyrrx6aAUi58CxtpD1aVjHUalpqr0O74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rgon5A9/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rgon5A9/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pW9IlA+Hi5C3VN3JToaaVwIa/8p4sBq024z7jeQJVd0=; b=Rgon5A9/H7fnzbLiwxEa14p98s
	JdyfrOcCN4hLMMGGGgsRRLCZx5d9oC2I9D1Ovs7/ea/Y8zX/hua+xM0PjiSNaHv9ynenJNyc9oFfE
	oZcfF64MRU7U0au7dr8QRo3Z1fhKKivuXkyyDWGyhHtat7EGrOccXnvH2SewcyWh/k1HrA2UivrBg
	wF4lFl3qIevXl2mBKuolXoEElTtJRBaDxL0QV01icjNuKTu59Dh6m83Y/ApAErCte7SnOdZ72zC2w
	wVNRfyIuF2FxVSbRZEvyItjU/pub39+yaMv12ilG7cYRWy2mTCLauB8JWnfPrKogYp43NGQlJM9XQ
	0hKN1vKg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000BdxZ-49Tb;
	Sun, 20 Sep 2026 21:19:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tdJ-3oIn;
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
Subject: [PATCH 15/17] KVM: nSVM: Cache L1's MSR permissions map pages
Date: Sun, 20 Sep 2026 21:49:43 +0100
Message-ID: <20260920211920.928306-16-dwmw2@infradead.org>
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
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/svm/nested.c | 46 +++++++++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.h    |  7 ++++++
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a8ee0a03d9f7..07609e4802f9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -292,6 +292,34 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
  * is optimized in that it only merges the parts where KVM MSR permission bitmap
  * may contain zero bits.
  */
+/*
+ * Read from L1's MSR permissions map through the per-page caches.
+ * @offset is a byte offset into the (two-page) MSRPM; the read must not
+ * cross a page boundary. msrpm_base_pa was validated page-aligned and
+ * in-bounds by nested_svm_check_controls().
+ */
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
@@ -324,11 +352,9 @@ static bool nested_svm_merge_msrpm(struct kvm_vcpu *vcpu)
 	for (i = 0; i < nested_svm_nr_msrpm_merge_offsets; i++) {
 		const int p = nested_svm_msrpm_merge_offsets[i];
 		nsvm_msrpm_merge_t l1_val;
-		gpa_t gpa;
 
-		gpa = svm->nested.ctl.msrpm_base_pa + (p * sizeof(l1_val));
-
-		if (kvm_vcpu_read_guest(vcpu, gpa, &l1_val, sizeof(l1_val)))
+		if (nested_svm_read_l1_msrpm(svm, p * sizeof(l1_val),
+					     &l1_val, sizeof(l1_val)))
 			return false;
 
 		msrpm02[p] = msrpm01[p] | l1_val;
@@ -1488,6 +1514,7 @@ static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
 int svm_allocate_nested(struct vcpu_svm *svm)
 {
 	struct page *vmcb02_page;
+	int i;
 
 	if (svm->nested.initialized)
 		return 0;
@@ -1503,6 +1530,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 		goto err_free_vmcb02;
 
 	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
+		kvm_gpc_init(&svm->nested.msrpm12_cache[i], svm->vcpu.kvm);
 
 	svm->nested.initialized = true;
 	return 0;
@@ -1514,6 +1543,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 void svm_free_nested(struct vcpu_svm *svm)
 {
+	int i;
+
 	if (!svm->nested.initialized)
 		return;
 
@@ -1524,6 +1555,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	svm->nested.msrpm = NULL;
 
 	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
+		kvm_gpc_deactivate(&svm->nested.msrpm12_cache[i]);
 
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
@@ -1575,7 +1608,6 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 
 static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 {
-	gpa_t base = svm->nested.ctl.msrpm_base_pa;
 	int write, bit_nr;
 	u8 value, mask;
 	u32 msr;
@@ -1590,8 +1622,8 @@ static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
 	if (bit_nr < 0)
 		return NESTED_EXIT_DONE;
 
-	if (kvm_vcpu_read_guest(&svm->vcpu, base + bit_nr / BITS_PER_BYTE,
-				&value, sizeof(value)))
+	if (nested_svm_read_l1_msrpm(svm, bit_nr / BITS_PER_BYTE,
+				     &value, sizeof(value)))
 		return NESTED_EXIT_DONE;
 
 	mask = BIT(write) << (bit_nr & (BITS_PER_BYTE - 1));
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cd0755919062..ac2f9731bf5d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -221,6 +221,13 @@ struct svm_nested_state {
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
2.55.0

