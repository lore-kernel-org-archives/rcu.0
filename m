Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=BnE4h1c7z1FCznGQPXdOSRFhW8LoMXpoKuCZzONIkvOXutCWlPAMwtpxcHFhC0zLHEG0
	 1P7fBXC7WFJNR1Ud0fZnbLcCru/R5qb+SVZb7FIfr99VuYcX3NOKuAlyh6Bu0PYs/8zfb
	 mkYaXk1JAR/rSzJnKOrrDN1ydiKGNSIDPSJeJtUFz864nu2BVmsIg5XWpCrDhgmO5TanE
	 4YNd4iRTGUrj8GsAiGyltF95TfiSZIAq9+V05j+8E4fEFl7/X484g4FFOYbUgWf+I5foY
	 mWe2UJY77qc0kjDJHMuGR6v0rrd+r67qF7y1+Jo4kUHAlQ8HtavRqApmWwUbrqzBCPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=SyJB48g5d3dD51rFyA0ineUHrgUKJTcQUMy2B9WJ/Ig=;
	b=2NkmevKPQNdZmNsZIXQqLTT0wtaPirmw7GX+u0OdRAfAmyFHZZCF5uplzIAKvXdiOxk3
	 RFO2uc9q/Mal3HA4Nn6AL3LBHQoom0ogjOx7xntgO5yMq/7seBEJ7k8MXiHClUyOdAg1Q
	 da2F0YfQdXYELapapD0aWlBlQMdBd+Zpcms8VDhwxCYaGGYtMteZKnv+tRn6kI57PeF/b
	 4MwH2qnYpDo6s57zOBHxTpmHo0IZsUOcGwKLobL9eJoxPKJc3A7wCfpRd5FkTevjllfmD
	 mv0CQoGruJgtB+eCm2PkHeACcXz0HiiXwBsTtRFEPRNdAEuTvBVT5FUc8F0o0DLcBdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=q+UEGOur;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99B606A32D;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA99B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=q+UEGOur
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=SyJB48g5d3dD51rFyA0ineUHrgUKJTcQUMy2B9WJ/Ig=; b=q+UEGOuravXo/K331KrtFCNxgR
	yGeICDKLCUqm4pZ4e7wxbFkTioNil0ej75YKEOWaR7o9JGSUiKSSw/uYJ02Gh5tf/sf59LLkzrdps
	CS/0Kv3SBSE0zvu+omRqtwUiUha7fHrVv7SEDHCUPXIZfPbBJ9VAuR+kyNlpy/4E5IDZnPH33qCeq
	rHOfz42T/bP9iPF9QLjw2Jf2Qnwp9m9G/EQs2ehl9LfbKvrOhe5kMmH2BhaIkcqVaSoF1U94dHX2/
	/bs/rlx/iWVWaPr1zB18CDFWK6LSCVM1jXhL26m8ATaMahHBHzYDmnwigehz2o0/5577bD6jj1vHW
	SBbQIFaA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jJ-1XPR;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDy-3aRK;
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
Subject: [PATCH v2 15/20] KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
Date: Thu,  5 Nov 2026 02:00:57 +0000
Message-ID: <20261105020104.2507083-16-dwmw2@infradead.org>
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

Replace the transient map/unmap of the vmcb12 page on every nested
VMRUN (control/save copy-in) and nested VM-exit (state copy-back) with
a gfn_to_pfn_cache keyed on vmcb12_gpa. With unmanaged guest memory
the transient map is a memremap/memunmap cycle on every L1<->L2
transition; the cache persists the kernel mapping for as long as the
gPA and its translation are unchanged. An L1 which multiplexes
several L2s on one vCPU re-keys the cache on each switch, paying a
refresh; the common single-L2 case pays nothing.

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
svm_leave_smm() now validates the vmcb12 GPA it reads from SMRAM, as
VMRUN does for RAX; the copy-back through the cache would otherwise
fail on an unaligned address at the eventual nested VM-exit. The
refused RSM still ends in TRIPLE_FAULT, but at the corrupt-SMRAM
instruction itself, before any L2 state is committed, as for the
other SMRAM consistency checks here.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/nested.c | 27 ++++++++++++++++++++-------
 arch/x86/kvm/svm/svm.c    | 15 +++++++++++++++
 arch/x86/kvm/svm/svm.h    |  3 +++
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ab187abc11b5..32854c8b2bbc 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1098,12 +1098,13 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
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
 
@@ -1114,9 +1115,11 @@ static int nested_svm_copy_vmcb12_to_cache(struct kvm_vcpu *vcpu, u64 vmcb12_gpa
 		vmcb12->control.event_inj = 0;
 		vmcb12->control.event_inj_err = 0;
 		svm_set_gif(svm, false);
+		kvm_gpc_mark_dirty_in_slot(&svm->nested.vmcb12_cache);
 		r = -EINVAL;
 	}
 
+	kvm_gpc_unlock(&svm->nested.vmcb12_cache, idx);
 	return r;
 }
 
@@ -1261,12 +1264,14 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
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
@@ -1321,6 +1326,9 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 				       vmcb12->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
+	kvm_gpc_mark_dirty_in_slot(&svm->nested.vmcb12_cache);
+	kvm_gpc_unlock(&svm->nested.vmcb12_cache, idx);
+
 	return 0;
 }
 
@@ -1506,6 +1514,9 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 		goto err_free_vmcb02;
 
 	svm->nested.vmcb02.cpu = -1;
+
+	kvm_gpc_init(&svm->nested.vmcb12_cache, svm->vcpu.kvm);
+
 	svm->nested.initialized = true;
 	return 0;
 
@@ -1525,6 +1536,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	svm_vcpu_free_msrpm(svm->nested.msrpm);
 	svm->nested.msrpm = NULL;
 
+	kvm_gpc_deactivate(&svm->nested.vmcb12_cache);
+
 	__free_page(virt_to_page(svm->nested.vmcb02.ptr));
 	svm->nested.vmcb02.ptr = NULL;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44..b78727cca9b1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5206,6 +5206,21 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (!(smram64->efer & EFER_SVME))
 		return 1;
 
+	/*
+	 * The vmcb12 GPA read back from SMRAM feeds the vmcb12 cache at
+	 * the eventual nested VM-exit, whose copy-back would fail on an
+	 * unaligned or illegal address. Refusing the RSM here ends in
+	 * TRIPLE_FAULT just the same (em_rsm() shoots a refused RSM),
+	 * but it fails before any L2 state has been committed, at the
+	 * instruction whose SMRAM contents are corrupt, matching how
+	 * this function already treats other inconsistent SMRAM state —
+	 * rather than at an unrelated nested VM-exit later. VMRUN
+	 * (#GP) and KVM_SET_NESTED_STATE (-EINVAL) police the same
+	 * field on their own entry points.
+	 */
+	if (!page_address_valid(vcpu, smram64->svm_guest_vmcb_gpa))
+		return 1;
+
 	CLASS(kvm_vcpu_map_local, m)(vcpu, gpa_to_gfn(smram64->svm_guest_vmcb_gpa));
 	if (m.ret)
 		return 1;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 1b8f3f2057d9..fe964a961305 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -219,6 +219,9 @@ struct svm_nested_state {
 	u64 last_vmcb12_gpa;
 	u64 last_bus_lock_rip;
 
+	/* Cached mapping of the vmcb12 page, keyed on vmcb12_gpa */
+	struct gfn_to_pfn_cache vmcb12_cache;
+
 	/*
 	 * The MSR permissions map used for vmcb02, which is the merge result
 	 * of vmcb01 and vmcb12
-- 
2.43.0

