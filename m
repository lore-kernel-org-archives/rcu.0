Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=V7u3W/wzl+JPyaf/kLbnXqqpxyKJnaWOHIuS3ea3IFf7u3AdnE2tmUWsdzdf3A3p7sz2
	 HAYx/RLiqzRTdygiZQyF8cD0lvF08FCgP702HRjRzHARj5ClfDSI0SJIvG2IwMg2xstBC
	 oXg96HZ4Ti56Sktd5m/+Zl4xFTL251LRNb1IyFRrajigVp14FexZeAVKIBhv7eL47ERdr
	 jcoV3BXe+Wvgi0GTkD1YKRz33Tu/gafbpXr1AkvggSe7dg/QLxcGfyuH7y1pPDijmENTE
	 sDBLjPXuZ0Ug1uChjZmM0R3qLzkiBZlc0deugk5FfCHd8ly0IAxXjpPvr862+UkSUPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=mjNES8BIaoIyrAOmFi0HcJENXzorOo9BmJYMd+hdINg=;
	b=LE8lFB5sfWzIfTbvdFukdwJkoHUz7ugy2/iTItKQ8ZmKMAMSZuoKT5cwGT/F8kYuAOrw
	 DMGObcU3rhJJLqFQWdWl/WGcJV3g2wehKVUEHj/COHKrwvQ0qW5yh6fxx8+hKojaaGyfP
	 baxGLBIM49SEH/R6rnnZhunqbzpcOEqK7imznQ01Y/CCgBXIxSnwEU4EAUhEMkgRcDeaw
	 5Ku9RA1jwdNbPxnEJgMdByAwmfSEutbVFvfLgZGzWZBWNbXMTWZ+R2h1P6ckNcTGClMVJ
	 GpH6MnUbPz2swkk4Kh6T9FfxxkHW2meGDUo2eB6T7uhyTguOyxPVDQihopSVLlF2xuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y+4ZLfxu;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3A606A32F;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA3A606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y+4ZLfxu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=mjNES8BIaoIyrAOmFi0HcJENXzorOo9BmJYMd+hdINg=; b=Y+4ZLfxuIGwYr8Uuoj4oxXYUxI
	2oJ32ETKK9nkI2LUJkr/qCpbOZ6N38Q/VT7lXm9jthEy2qTdRxsGo0+jNuA5e9MjpQdyyECD1hwVr
	Mh/5PBP1h9o+Sj6hZwUGFghzge3H8qjmvMz+H5Rt9myJGs0Bv6pDIRmeeQtlqbyqTuj9thTui/dMH
	NThFTvPHocdsHhSKoxEdpkYXa8NQj22AuxzZHD9SQEVAdXYsW94n2mox8K0UQAcFMPZDmbeSWeUHN
	oUjKDK/22Pc+dB081JaC6QQZj0iiviUUz0Yo7zxM+akDVn1MDCyNA0MEj/gx0lO1++5nvqaR7xGVQ
	aEYmqtXA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jH-12gf;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDq-2wrs;
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
Subject: [PATCH v2 13/20] KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
Date: Thu,  5 Nov 2026 02:00:55 +0000
Message-ID: <20261105020104.2507083-14-dwmw2@infradead.org>
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

The physical addresses which nested page setup latches into hardware
control structures (vmcs02's APIC-access, virtual-APIC and posted
interrupt descriptor addresses) are derived from gPA→uHVA
translations which a memslot update can change. Software readers of
the underlying gfn_to_pfn_caches catch that lazily, via the memslot
generation check at their next use — but the CPU's use of a latched
address from guest mode is continuous and checks nothing. A vCPU
running L2 across a memslot move keeps using the old translation
until a nested VM-exit happens to re-run nested page setup. (A
staleness problem, not a lifetime one: freeing the page is the
mmu_notifier's business. The replaced kvm_host_map code had the same
staleness with no remedy at all.)

Post the request from the memslot update itself — the single point
where the generation changes, and a slow path by definition — rather
than checking generations in the VM-entry path forever. The request
is what survives racing with a concurrent VM-entry (a bare kick
landing before vcpu->mode is set would be lost), and a vCPU which
resolved its pages against the old memslots but has not yet entered
guest mode is invisible to any is_guest_mode() filter, so it is
posted unconditionally to every vCPU. TD vCPUs share vmx_nested_ops
but are not struct vcpu_vmx; the VMX handler bails for them up
front.

The posting site is kvm_arch_commit_memory_region(), once per
user-visible update with the final memslots in place — not
kvm_arch_memslots_updated(), which also runs when a DELETE or MOVE
installs its transient KVM_MEMSLOT_INVALID placeholder, where the
handler could only retry, and skipping FLAGS_ONLY updates, which
cannot change any translation. kvm_arch_memslots_updated() keeps a
bare kick for the steal_time cache's check-at-use sites.

The handlers distinguish the request's origin, extending VMX's
nested.resume_pending to nSVM. A resume into L2 from saved state
(KVM_SET_NESTED_STATE after migration, or RSM) re-derives PAE PDPTRs
and re-runs the MSRPM merge; a failure there is a userspace error
(or, in a narrow window, a concurrent memslot update's transient
KVM_MEMSLOT_INVALID placeholder), reported as KVM_EXIT_INTERNAL_ERROR
with the request re-posted and resume_pending kept, so a further
KVM_RUN bounces back out rather than entering L2 with the restore
work undone — and so a userspace which retries recovers once a
transient failure clears. A memslot-posted request re-latches the vmcs02 addresses on
VMX and is a no-op on SVM, which latches no L1-owned physical
address in hardware (the merged MSRPM and IOPM are kernel pages);
neither vendor re-derives PDPTRs for it, as those latch only at MOV
CR3 and VM-entry. The classification dies with the request: nested
VM-exit clears resume_pending on both vendors, so a request posted
after L1 re-enters L2 cannot inherit entry-time semantics.
Accordingly, downgrade the WARN in svm_get_nested_state_pages(): a
request with nothing to do is now expected.

The memslot-move mode of the vmx_apic_update_test selftest, added
later in this series, exercises this path.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/nested.c | 45 ++++++++++++++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h    | 12 +++++++++++
 arch/x86/kvm/vmx/nested.c | 12 +++++++++--
 arch/x86/kvm/x86.c        | 44 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..ab187abc11b5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1078,8 +1078,10 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 	if (ret)
 		return ret;
 
-	if (!from_vmrun)
+	if (!from_vmrun) {
+		svm->nested.resume_pending = true;
 		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	}
 
 	svm_set_gif(svm, true);
 
@@ -1340,6 +1342,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	kvm_warn_on_nested_run_pending(vcpu);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	svm->nested.resume_pending = false;
 
 	/* in case we halted in L2 */
 	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
@@ -1568,6 +1571,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 	}
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+	svm->nested.resume_pending = false;
 }
 
 static int nested_svm_exit_handled_msr(struct vcpu_svm *svm)
@@ -2113,6 +2117,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	if (kvm_vcpu_apicv_active(vcpu))
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 
+	svm->nested.resume_pending = true;
 	kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 out_free:
 	kfree(save);
@@ -2123,7 +2128,21 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
-	if (WARN_ON(!is_guest_mode(vcpu)))
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * Memslot updates post this request to every vCPU (to make any
+	 * vCPU which has guest pages latched in hardware re-resolve them
+	 * against the new memslots), so it can arrive with nothing to
+	 * do: outside guest mode, or (unlike VMX) even with L2
+	 * running, because SVM latches no L1-owned physical address in
+	 * hardware (the merged MSRPM and the IOPM are kernel pages).
+	 * The restore work below (PDPTR re-derivation, MSRPM merge)
+	 * runs only when the request came from a migration restore;
+	 * running it for a memslot update would re-latch a live L2's
+	 * PDPTRs at a moment the architecture does not allow.
+	 */
+	if (!is_guest_mode(vcpu) || !svm->nested.resume_pending)
 		return true;
 
 	if (is_pae_paging(vcpu)) {
@@ -2139,16 +2158,32 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
 		else if (!vcpu->arch.pdptrs_from_userspace &&
 			 CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
-			return false;
+			goto internal_error;
 	}
 
 	if (!nested_svm_merge_msrpm(vcpu))
-		return false;
+		goto internal_error;
 
 	if (kvm_hv_verify_vp_assist(vcpu))
-		return false;
+		goto internal_error;
 
+	/* Success consumes the resume classification. */
+	svm->nested.resume_pending = false;
 	return true;
+
+internal_error:
+	/*
+	 * Restored state names an unusable page. (In a narrow window, a
+	 * concurrent memslot update's KVM_MEMSLOT_INVALID placeholder
+	 * lands here too; a userspace which retries KVM_RUN recovers
+	 * once the update commits.) The caller fills in the
+	 * KVM_EXIT_INTERNAL_ERROR exit and re-posts the request; what is
+	 * SVM's to keep is resume_pending, still set, so that no
+	 * subsequent KVM_RUN can enter L2 with the restore work undone:
+	 * the vCPU bounces back here (and to userspace) until the
+	 * failure is resolved or the vCPU state is replaced.
+	 */
+	return false;
 }
 
 static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966dc8..1b8f3f2057d9 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -236,6 +236,18 @@ struct svm_nested_state {
 
 	bool initialized;
 
+	/*
+	 * The pending KVM_REQ_GET_NESTED_STATE_PAGES was posted by a
+	 * migration restore (KVM_SET_NESTED_STATE or RSM back into L2),
+	 * where PDPTRs must be re-derived and the MSRPM merge re-run
+	 * before re-entering L2, and a failure is a userspace error to
+	 * report. Unlike VMX, SVM latches no L1-owned physical address
+	 * in hardware (the merged MSRPM and the IOPM are kernel pages),
+	 * so a request posted by a memslot update finds nothing to
+	 * re-latch and the handler no-ops on !resume_pending.
+	 */
+	bool resume_pending;
+
 	/*
 	 * Indicates whether MSR bitmap for L2 needs to be rebuilt due to
 	 * changes in MSR bitmap for L1 or switching to a different L2. Note,
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 23f1fff97917..6c8004009bcd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3846,6 +3846,14 @@ static bool __vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 
 static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Memslot updates post this request to every vCPU, including TD
+	 * vCPUs, which are not struct vcpu_vmx and have no nested state
+	 * to re-resolve.
+	 */
+	if (is_td_vcpu(vcpu))
+		return true;
+
 	if (!__vmx_get_nested_state_pages(vcpu)) {
 		/*
 		 * The caller (vcpu_enter_guest) consumed
@@ -5501,8 +5509,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 
 	/*
 	 * The resume classification dies with the request: a stale
-	 * resume_pending would give the next request (e.g. posted by an
-	 * invalidation after L1 re-enters L2) entry-time semantics,
+	 * resume_pending would give the next request (e.g. posted by a
+	 * memslot update after L1 re-enters L2) entry-time semantics,
 	 * re-deriving PDPTRs mid-L2 and treating a transiently
 	 * unbackable page as a terminal error.
 	 */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 321f29789f9f..892c6f81d704 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10282,7 +10282,16 @@ void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 	 */
 	kvm_mmu_invalidate_mmio_sptes(kvm, gen);
 
-	/* Force re-initialization of steal_time cache */
+	/*
+	 * Force re-initialization of the steal_time cache: its
+	 * check-at-use sites only see the new generation once the vCPU
+	 * goes around its run loop. This runs on both memslot swaps of a
+	 * DELETE/MOVE; the re-resolution of latched nested-state pages
+	 * is posted from kvm_arch_commit_memory_region() instead, once
+	 * per update and only when the final memslots are in place, so
+	 * that its handler never chases an in-flight update's
+	 * KVM_MEMSLOT_INVALID placeholder.
+	 */
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_vcpu_kick(vcpu);
 }
@@ -10452,6 +10461,39 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	/*
+	 * Force re-resolution of any nested-state pages whose physical
+	 * addresses a vCPU has latched in hardware control structures
+	 * (e.g. vmcs02) from a gfn_to_pfn_cache. Software readers of
+	 * such caches catch the generation bump lazily, via
+	 * kvm_gpc_check() at their next use; the CPU's use from guest
+	 * mode is continuous and checks nothing, so the vCPU must be
+	 * told to re-resolve and re-latch before it next enters the
+	 * guest. The request is the artifact that survives racing with
+	 * a concurrent VM-entry (a bare kick landing before vcpu->mode
+	 * is set would be lost); its handler re-runs nested page setup,
+	 * whose gPA lookups then see the new generation and refresh.
+	 *
+	 * This is posted from commit, not from kvm_arch_memslots_updated(),
+	 * so it runs once per user-visible update with the final memslots
+	 * in place: a request serviced during a DELETE/MOVE's
+	 * invalidation phase would find the KVM_MEMSLOT_INVALID
+	 * placeholder and could only retry. A FLAGS_ONLY update (e.g. a
+	 * dirty-log toggle) cannot change any translation — base_gfn and
+	 * userspace_addr are immutable — so it posts nothing.
+	 *
+	 * The kick is deliberately fire-and-forget (no KVM_REQUEST_WAIT):
+	 * a vCPU still in L2 may keep using the old translation until it
+	 * services the request, which matches the staleness semantics the
+	 * replaced kvm_host_map code had, unboundedly. Lifetime is not at
+	 * stake — the underlying page is freed only via the mmu_notifier,
+	 * whose invalidation forces pinned vCPUs out of guest mode and
+	 * waits. Making the ioctl wait here would buy only a tighter
+	 * staleness bound, at a vCPU-roundtrip cost on every update.
+	 */
+	if (change != KVM_MR_FLAGS_ONLY)
+		kvm_make_all_cpus_request(kvm, KVM_REQ_GET_NESTED_STATE_PAGES);
+
 	if (change == KVM_MR_DELETE)
 		kvm_page_track_delete_slot(kvm, old);
 
-- 
2.43.0

