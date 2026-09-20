Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715BD4766A8;
	Sun, 20 Sep 2026 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940170; cv=none; b=RCNOKvEWkbAMSz8q+7lvWeBzjJuCLASF5jZFbakTeQ6ANQRz9WeBUsdjaF6Ab6zlFvr3OePuVf1XN9xTuQcgT83ztm5CXsppEHHg40k0tcxZm14LrKN/BQQKZFW70Ydn6JlYrpSgcfa6pbxlQg5uGCTs0dAfJhvROuArxj1Wydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940170; c=relaxed/simple;
	bh=5TkRQFBf1wsCYl+8lB06JENVKL0r7aN40tEkJvYxW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qm27sWMxDqpGzS6XVt/ktPAiAV3e6qCdCo23G9PP8XZ810pLJ4ijhi/Dvjp1SOpQlFmzdqXbvVuqAKi1YpPvfipnAGZF5Tvoifhp1PyvKsesFryrxK39TeAJqYsXMHNkSgNHkTMGFjYHjOU0qkx/+b8+hCRrAO8wZU9TMkTByJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YJ8buXWM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YJ8buXWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4V+Q7xBg2WLqkZ+WGPzpCFKVps1K9DYH9Q5Ag+pAVxU=; b=YJ8buXWMw08v1qizTGeglAH7Sb
	q86Tyyw0anIGPZbeYDIiRuiD2Gir+M0cHOW5PjPRfrQqG41/o5LpSkxEiPR0UiuNh7c0jjIPksI26
	qS/7GZgNlScK6aHGN6sRKLkYEdioWdH/kCCdWrQ9Fn+iRBN37COHRPaJRnP+uvOCFRqexJ1eFcdUY
	bTZxD9HAlmndA5IfWRNU3kNaweKtSgRipD0Wcw/H6Zb5USs8VJsQTMOztopNx17nWEvHNvHYQ12iF
	NDE/SZ3+nIsdNeD/nVSh7j3PYKiHcEftGeZX0iw8bkgqfaKF+3OyGdU8WvcETl+W8QD1c2iBJZgKn
	H8GfFWoQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwV-0000000BLq9-0MSa;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tdF-3aOr;
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
Subject: [PATCH 14/17] KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
Date: Sun, 20 Sep 2026 21:49:42 +0100
Message-ID: <20260920211920.928306-15-dwmw2@infradead.org>
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

Replace the transient map/unmap of the vmcb12 page on every nested
VMRUN (control/save copy-in) and nested VM-exit (state copy-back) with
a gfn_to_pfn_cache keyed on vmcb12_gpa. With unmanaged guest memory
the transient map is a memremap/memunmap cycle on every L1<->L2
transition; the cache persists the kernel mapping for as long as the
gPA and its translation are unchanged.

No pinning is needed, unlike the nVMX APIC pages: SVM never hands an
L1-owned physical address to the CPU in vmcb02 (the merged MSRPM and
the IOPM are kernel-owned pages), so the vmcb12 page is only ever
accessed by KVM itself, under the SRCU read lock, with the usual
check/refresh protocol.

Dirty marking moves from unconditional-at-unmap to the actual write
paths: the SVM_EXIT_ERR reflection in the VMRUN consistency-check
failure path, and the copy-back at nested VM-exit.

The SMM enter/leave and VMLOAD/VMSAVE emulation paths keep the
transient map: they are cold, and VMLOAD/VMSAVE takes an arbitrary
gPA from RAX which would thrash a single-slot cache.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/svm/nested.c | 26 +++++++++++++++++++-------
 arch/x86/kvm/svm/svm.h    |  3 +++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index acc423b13445..a8ee0a03d9f7 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1088,12 +1088,13 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
 	int r = 0;
+	int idx;
 
-	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(vmcb12_gpa));
-	if (m.ret)
+	idx = kvm_gpc_lock_page(&svm->nested.vmcb12_cache, vmcb12_gpa);
+	if (idx < 0)
 		return -EFAULT;
 
-	vmcb12 = m.map.hva;
+	vmcb12 = svm->nested.vmcb12_cache.khva;
 	nested_copy_vmcb_control_to_cache(svm, &vmcb12->control);
 	nested_copy_vmcb_save_to_cache(svm, &vmcb12->save);
 
@@ -1104,9 +1105,11 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 		vmcb12->control.event_inj = 0;
 		vmcb12->control.event_inj_err = 0;
 		svm_set_gif(svm, false);
+		kvm_gpc_mark_dirty_in_slot(&svm->nested.vmcb12_cache);
 		r = -EINVAL;
 	}
 
+	kvm_gpc_unlock(&svm->nested.vmcb12_cache, idx);
 	return r;
 }
 
@@ -1251,12 +1254,14 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	struct vmcb *vmcb12;
+	int idx;
 
-	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(svm->nested.vmcb12_gpa));
-	if (m.ret)
-		return m.ret;
+	idx = kvm_gpc_lock_page(&svm->nested.vmcb12_cache,
+				  svm->nested.vmcb12_gpa);
+	if (idx < 0)
+		return idx;
 
-	vmcb12 = m.map.hva;
+	vmcb12 = svm->nested.vmcb12_cache.khva;
 
 	vmcb12->save.es     = vmcb02->save.es;
 	vmcb12->save.cs     = vmcb02->save.cs;
@@ -1311,6 +1316,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 				       vmcb12->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
+	kvm_gpc_mark_dirty_in_slot(&svm->nested.vmcb12_cache);
+	kvm_gpc_unlock(&svm->nested.vmcb12_cache, idx);
+
 	return 0;
 }
 
@@ -1494,6 +1502,8 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	if (!svm->nested.msrpm)
 		goto err_free_vmcb02;
 
+	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
+
 	svm->nested.initialized = true;
 	return 0;
 
@@ -1513,6 +1523,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	svm_vcpu_free_msrpm(svm->nested.msrpm);
 	svm->nested.msrpm = NULL;
 
+	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
+
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..cd0755919062 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -218,6 +218,9 @@ struct svm_nested_state {
 	u64 last_vmcb12_gpa;
 	u64 last_bus_lock_rip;
 
+	/* Cached mapping of the vmcb12 page, keyed on vmcb12_gpa */
+	struct gfn_to_pfn_cache vmcb12_cache;
+
 	/*
 	 * The MSR permissions map used for vmcb02, which is the merge result
 	 * of vmcb01 and vmcb12
-- 
2.55.0

