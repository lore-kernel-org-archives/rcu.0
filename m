Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F401433BD9;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939193; cv=none; b=R7614dGAS7R4eWafPK91QoydfU1mViuI04oyLWd7yP/RAaPaPrJXXe41yjD1mFwZn8zoDCVjNxf35ZJ1wvB0f9Q3qQKOO5x0t0dyVRiSskOpLbcUq0PR/FkqMYEWROSMtPdmMcjagOhunK+nVmRfhZZGINHYwBAVk0OESEKNevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939193; c=relaxed/simple;
	bh=o/w5wAcUND6U7WBcEjVsBsMDJTjoOCOT0m/LdHTFb1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPnzYvbxh/HUi9ik753e0AwL6blSnpEY1azhCJy9phedPTW/66QutdBn0zJN3KBoeqYfhKK2o69x2l+cBKg5mz0B3HI2RyuAXsP3CD58aU0AFbl9BZbSru43zZilR4JLI1ZUOjJlpRj+onlCeqHJcxoY/UG+dMHSKbUskce/U4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tho3eLo9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tho3eLo9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=QZBlRcM4+jxGH5hRNiXjivWIKeFX8QVY3HuhApq4Apk=; b=Tho3eLo9itXVMLSdwr+S7PPxrI
	8T5afDra7Uixfbe1jGeaXIYRCWOklY7zJVTVpaw+hiv4X8uOL/G08CK7hO+SQln/LVaOuX9P4dDm2
	ipI24Z+gEw+9fcry/JEIita9EOsMkjbLaSLSuTYZUvNmJ5OSmyrDWTRmNuLZePTYvAHuuuo5cV57h
	wLXFJJtoUM26spN5M64yqdXLjsdojMD4ghF/MRYtg1syiWtBOFMPQWCmRRbeLmNwFVrBtiJ9HoIHl
	RiIiZ/kX2PKJupwXNPYFVHD02dstFDk3cfXuKjGS3beQAAVj2AhofTeVsqdduRm4A36CBX6P+VOpZ
	pXOPlA4g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000Bdxa-49fR;
	Sun, 20 Sep 2026 21:19:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tdN-42Cs;
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
Subject: [PATCH 16/17] KVM: nSVM: Cache L1's IO permissions map pages
Date: Sun, 20 Sep 2026 21:49:44 +0100
Message-ID: <20260920211920.928306-17-dwmw2@infradead.org>
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
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/svm/nested.c | 33 +++++++++++++++++++++++++++++----
 arch/x86/kvm/svm/svm.h    |  6 ++++++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07609e4802f9..0fa3183a509c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1532,6 +1532,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
 	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
 		kvm_gpc_init(&svm->nested.msrpm12_cache[i], svm->vcpu.kvm);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.iopm12_cache); i++)
+		kvm_gpc_init(&svm->nested.iopm12_cache[i], svm->vcpu.kvm);
 
 	svm->nested.initialized = true;
 	return 0;
@@ -1557,6 +1559,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
 	for (i = 0; i < ARRAY_SIZE(svm->nested.msrpm12_cache); i++)
 		kvm_gpc_deactivate(&svm->nested.msrpm12_cache[i]);
+	for (i = 0; i < ARRAY_SIZE(svm->nested.iopm12_cache); i++)
+		kvm_gpc_deactivate(&svm->nested.iopm12_cache[i]);
 
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
@@ -1635,7 +1639,7 @@ static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
 	unsigned port, size, iopm_len;
 	u16 val, mask;
 	u8 start_bit;
-	u64 gpa;
+	int i;
 
 	if (!(vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_IOIO_PROT)))
 		return NESTED_EXIT_HOST;
@@ -1643,14 +1647,35 @@ static int nested_svm_intercept_ioio(struct vcpu_svm *svm)
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
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ac2f9731bf5d..8ccd5a2d942e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -228,6 +228,12 @@ struct svm_nested_state {
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
-- 
2.55.0

