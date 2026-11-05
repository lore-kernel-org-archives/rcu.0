Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844079;
	b=y8ElK9gPtWJmvTj+MsbhO9l738ikOpUTBySGMoKkT+8X5RatNY4G7V9JaTxZSwzOoS+n
	 gBUxTB6QvIaunUcGarVktcihag2UdaMqR/gZutBpQAR+g7m/oZUV+5uRfIdVeDFXiTsoe
	 172oadm8Av5/kYVJbokcxyoet6qdT3rQ7ZVQFacX0zZXEwJ6lYSCsTihTqTQTzHrj3A+m
	 COpIzd8tAPm9NH/ASJ5Deh1pngat5r77AvMXiPBiNrsVrhenVYlsvuB2iivOGfUoAhap7
	 NSR8Q0glhAZqXU0pZ42Psp1kVplEyi+W3lD/sbNIJj4bkea9cAkOxel3YwA/0drA6rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=HHbMXrntQTOJ5IPdESBOGZVApcYK5UI5lu9oMqvobYE=;
	b=XuZbXpuUTXvPaiCY86dXynbJdTRqSr/Wyh01zFaVjrynEXt5gybKPfsO+NL9eLY+wnrt
	 r/lMFqOhwkDgzuNpOSpU30nMnnecbGWOvEtrwbkY8X+dOnA2rHOXm+qwEPfnoOLyuFMN8
	 ReFdnusBOXfj0I1NXfLlTIehxyOegcUnMX1r0Q/LD+jDICaKSFZNHjp5F11ZUMjo0JZgP
	 VruAjkJumwhYhyhY1i8ZHmebDKJU1enkA4rrc0IK0n92L7d76k/GkpiU+4UtvQuc081N2
	 1+ugoYmMw4g4jvHV7Sq2U0wV0PRysBkjrU0186NS2ngSf3DLDpwaJxbQeh6Bab3XkJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ae+tqrD0;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC99606EEA6;
	Thu,  5 Nov 2026 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC99606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Ae+tqrD0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=HHbMXrntQTOJ5IPdESBOGZVApcYK5UI5lu9oMqvobYE=; b=Ae+tqrD0A5cIWp9q1MmrdrlOhm
	x0DHa/HcBOUb8qpxiTZNQGso0gaFp60cS1T4G+k/gU+stshu3i38AotQfBfdAfTVoIaZt0GKHNtOv
	1xIrt0/A/Qf433sSC8WDNBQT5CQu86Qs6LujeOtqo2kml1k9vlrsI1Rg8cJ4epb3o0SVHtLo10tDb
	Bka/PNm22PqSLTkTcgJD7DwCbNWBvP1QbHQqVFnV/PQuKz76uTOKf+3XHGmyNLeMcSPI5oWqY05ar
	DAuaXhf8/SNlQ9InzAkjGLZ4o4PRxsduxy4SN91W/GhAxZ7O3Ywe6d3KPGYt9qFII5v9FQYyj21e0
	vIZZreKg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmo-00000002ROR-265C;
	Thu, 05 Nov 2026 02:01:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWE6-3u0A;
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
Subject: [PATCH v2 17/20] KVM: nSVM: Cache L1's IO permissions map pages
Date: Thu,  5 Nov 2026 02:00:59 +0000
Message-ID: <20261105020104.2507083-18-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

The per-intercept IOPM check on every trapped L2 IO instruction reads
L1's IO permissions map with kvm_vcpu_read_guest() — a
memremap/memunmap cycle per access with unmanaged guest memory. Cache
the three IOPM pages in gfn_to_pfn_caches keyed on iopm_base_pa, as
for the MSR permissions map.

Unlike the MSRPM accesses, an IOPM read is not naturally aligned: a
two-byte read for a port range straddling a page boundary (e.g. ports
0x7ff8-0x7fff at bytes 0xfff-0x1000) spans two pages, so read byte by
byte, each from its own page's cache.

Failure semantics are preserved: an unreadable IOPM reflects the
intercept to L1 (NESTED_EXIT_DONE).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/nested.c | 71 +++++++++++++++++++++++++++++----------
 arch/x86/kvm/svm/svm.c    |  2 ++
 arch/x86/kvm/svm/svm.h    |  7 ++++
 3 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4e22cd7a38e1..a682b7446c3e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1519,10 +1519,36 @@ static void nested_svm_triple_fault(struct kvm_vcpu *vcpu)
 	nested_svm_simple_vmexit(to_svm(vcpu), SVM_EXIT_SHUTDOWN);
 }
 
+/*
+ * Initialize the nested gfn_to_pfn_caches, once per vCPU. Unlike the
+ * allocations in svm_allocate_nested(), the caches persist across
+ * EFER.SVME toggles: svm_free_nested() only deactivates them, and
+ * reuse goes through kvm_gpc_activate() without re-init.
+ */
+void svm_init_nested_caches(struct vcpu_svm *svm)
+{
+	int i;
+
+	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
+
+	/*
+	 * KVM only ever reads the MSR and IO permissions maps, which L1 may
+	 * keep in memory that its VMM maps read-only: map the caches
+	 * read-only (which also means never marking them dirty), matching
+	 * the read semantics of the kvm_vcpu_read_guest() calls they
+	 * replace.
+	 */
+	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
+		__kvm_gpc_init(&svm->nested.msrpm12_cache[i], svm->vcpu.kvm,
+			       false, true, NULL, 0);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.iopm12_cache); i++)
+		__kvm_gpc_init(&svm->nested.iopm12_cache[i], svm->vcpu.kvm,
+			       false, true, NULL, 0);
+}
+
 int svm_allocate_nested(struct vcpu_svm *svm)
 {
 	struct page *vmcb02_page;
-	int i;
 
 	if (svm->nested.initialized)
 		return 0;
@@ -1539,18 +1565,6 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 
 	svm->nested.vmcb02.cpu = -1;
 
-	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
-
-	/*
-	 * KVM only ever reads the MSR permissions map, which L1 may keep in
-	 * memory that its VMM maps read-only: map the cache read-only
-	 * (which also means never marking it dirty), matching the read
-	 * semantics of the kvm_vcpu_read_guest() calls it replaces.
-	 */
-	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
-		__kvm_gpc_init(&svm->nested.msrpm12_cache[i], svm->vcpu.kvm,
-			       false, true, NULL, 0);
-
 	svm->nested.initialized = true;
 	return 0;
 
@@ -1575,6 +1589,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
 	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
 		kvm_gpc_deactivate(&svm->nested.msrpm12_cache[i]);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.iopm12_cache); i++)
+		kvm_gpc_deactivate(&svm->nested.iopm12_cache[i]);
 
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
@@ -1654,7 +1670,7 @@ static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
 	unsigned port, size, iopm_len;
 	u16 val, mask;
 	u8 start_bit;
-	u64 gpa;
+	int i;
 
 	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_IOIO_PROT)))
 		return NESTED_EXIT_HOST;
@@ -1662,14 +1678,35 @@ static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
 	port = svm->vmcb->control.exit_info_1 >> 16;
 	size = (svm->vmcb->control.exit_info_1 & SVM_IOIO_SIZE_MASK) >>
 		SVM_IOIO_SIZE_SHIFT;
-	gpa  = svm->nested.ctl.iopm_base_pa + (port / 8);
 	start_bit = port % 8;
 	iopm_len = (start_bit + size > 8) ? 2 : 1;
 	mask = (0xf >> (4 - size)) << start_bit;
 	val = 0;
 
-	if (kvm_vcpu_read_guest(&svm->vcpu, gpa, &val, iopm_len))
-		return NESTED_EXIT_DONE;
+	/*
+	 * Read byte by byte: a two-byte read at the end of a page (e.g.
+	 * ports 0x7ff8-0x7fff spanning bytes 0xfff-0x1000) crosses into
+	 * the next page of the IOPM, i.e. the next cache.
+	 */
+	for (i = 0; i < iopm_len; i++) {
+		unsigned long offset = port / 8 + i;
+		struct gfn_to_pfn_cache *gpc;
+		gpa_t gpa;
+		int idx;
+
+		if (WARN_ON_ONCE(offset >= IOPM_SIZE))
+			return NESTED_EXIT_DONE;
+
+		gpc = &svm->nested.iopm12_cache[offset >> PAGE_SHIFT];
+		gpa = svm->nested.ctl.iopm_base_pa + (offset & PAGE_MASK);
+
+		idx = kvm_gpc_lock_page(gpc, gpa);
+		if (idx < 0)
+			return NESTED_EXIT_DONE;
+
+		val |= *(u8 *)(gpc->khva + offset_in_page(offset)) << (i * 8);
+		kvm_gpc_unlock(gpc, idx);
+	}
 
 	return (val & mask) ? NESTED_EXIT_DONE : NESTED_EXIT_HOST;
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b78727cca9b1..f601e0650c36 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1382,6 +1382,8 @@ static int svm_vcpu_create(struct kvm_vcpu *vcpu)
 	svm->vmcb01.pa = __sme_set(page_to_pfn(vmcb01_page) << PAGE_SHIFT);
 	svm_switch_vmcb(svm, &svm->vmcb01);
 
+	svm_init_nested_caches(svm);
+
 	svm->guest_state_loaded = false;
 
 	return 0;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8a5dff5a9ee3..256eefb27a83 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -229,6 +229,12 @@ struct svm_nested_state {
 	 */
 	struct gfn_to_pfn_cache msrpm12_cache[MSRPM_SIZE / PAGE_SIZE];
 
+	/*
+	 * Cached mappings of the three pages of L1's IO permissions map,
+	 * keyed on ctl.iopm_base_pa, for the per-intercept checks.
+	 */
+	struct gfn_to_pfn_cache iopm12_cache[IOPM_SIZE / PAGE_SIZE];
+
 	/*
 	 * The MSR permissions map used for vmcb02, which is the merge result
 	 * of vmcb01 and vmcb12
@@ -904,6 +910,7 @@ int __init nested_svm_init_msrpm_merge_offsets(void);
 
 int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb_gpa, bool from_vmrun);
 void svm_leave_nested(struct kvm_vcpu *vcpu);
+void svm_init_nested_caches(struct vcpu_svm *svm);
 void svm_free_nested(struct vcpu_svm *svm);
 int svm_allocate_nested(struct vcpu_svm *svm);
 int nested_svm_vmrun(struct kvm_vcpu *vcpu);
-- 
2.43.0

