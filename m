Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54547CA6F;
	Sun, 20 Sep 2026 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940220; cv=none; b=Dd4YiZrANG/TMEHjrKWxfkloMTk7UewoW4MymOjwShxcOxJ39VCPQZvMDhD8YEzhcXCbcEumNmoxAf/3Nw85J9o2RJsMBRFtpg7fUGpyqElymvplEXVl+Kg3aMFgK4WViREncttOEpL/2lLMCJCdbfpSk0jzQ8ZlQhQ2997Egqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940220; c=relaxed/simple;
	bh=9cBclu09W+kLTQwOtfR7jq+xhXeKf0SNQfMh7tcxdX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLUBC/xK0sxnVOQu77MJjN81Z1fkard/sgdpCCcfnX9HCQTSITHLZ2RtXpMcrxUjHTzuEqaq5atKTi3cBV4MIp0flEQTGCofYkm9+Cc4BmRY5vA/pq7kcDOlQVZtL01W9pC9k8p+mBkwSoYNUgWaOzG0gdjv9Qb99//7TVbYPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MU5dMjyD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MU5dMjyD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ELdsClL82o7prlUot06Bhije8Y2pbzwZuFHJBbfF2d4=; b=MU5dMjyDqdkMk03ApEf1KfJ6gE
	uQ3Nlw7tZiS8QIvQZ+7Jx/Ox1O1k7EZ7ghYN6K//0EtEzLmIccWtme5rOwc4/QR04dLO6rx4DuyVU
	a0CkOM/Nfq7y/+GMhEpG7g/NxnlrsrRq1gPZb5hKl8dbUiXAHGop4PVkfrYnGxgtUD5SczcoRaEga
	BV1umD7Dcz4cLJau21Hb0MytCYhfV29icAEcIBeJ6ixB1q0cTiVqtWkB8kxKhWcoIjMcojJyKD7hK
	jW59FJfOLBbPK9X6naqFH2iZHHjaBsFe6kj/Kt+FeA3sbVu405qWO2dujOckZmgySdM+Z0UaV9Pyw
	0i4LZmng==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpy-3aqC;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcv-2bIP;
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
Subject: [PATCH 09/17] KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
Date: Sun, 20 Sep 2026 21:49:37 +0100
Message-ID: <20260920211920.928306-10-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

The physical addresses which nested page setup latches into hardware
control structures (vmcs02's APIC-access, virtual-APIC and posted
interrupt descriptor addresses) are derived from gPA→uHVA translations
which a memslot update can change. Software readers of the underlying
gfn_to_pfn_caches catch this lazily, via the memslot generation check
in kvm_gpc_check() at their next use — but the CPU's use of a latched
address from guest mode is continuous and checks nothing. A vCPU
running L2 across a memslot move would keep using the old translation
until something forced it to re-resolve; L0 exits which re-enter L2
without a nested VM-exit never re-run nested page setup.

(This is a staleness, not a lifetime, problem: freeing the underlying
page is the mmu_notifier's business and that path kicks pinned vCPUs
synchronously. The replaced kvm_host_map code had the same staleness
with no remedy at all.)

The alternative, checking each cache's memslot generation in the
VM-entry path after vcpu->mode is set, is strictly worse: the check
would run on every nested VM-entry forever, in a context which cannot
refresh (IRQs off), so its only possible action on a mismatch would be
to post KVM_REQ_GET_NESTED_STATE_PAGES and bail for the refresh to
happen outside. Posting that same request from the memslot update
itself — the single point where the generation actually changes, and
a slow path by definition — is the same mechanism minus the per-entry
cost. The request bit is also the artifact that survives racing with
a concurrent VM-entry: a bare kick landing before vcpu->mode is set
would be lost, and a vCPU which resolved its pages against the old
memslots but has not yet entered guest mode is invisible to any
is_guest_mode() filter, so the request is posted unconditionally to
every vCPU.

Accordingly, downgrade the WARN in svm_get_nested_state_pages(): a
spurious request outside guest mode is now expected, and a no-op.
(vmx_get_nested_state_pages already tolerates it.)

The memslot-move mode of the vmx_apic_update_test selftest exercises
this path.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/svm/nested.c |  7 ++++++-
 arch/x86/kvm/x86.c        | 26 ++++++++++++++++++++------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..acc423b13445 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2106,7 +2106,12 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
-	if (WARN_ON(!is_guest_mode(vcpu)))
+	/*
+	 * Memslot updates post this request to every vCPU (to make any
+	 * vCPU which has guest pages latched re-resolve them against the
+	 * new memslots), so it can arrive with nothing to do.
+	 */
+	if (!is_guest_mode(vcpu))
 		return true;
 
 	if (is_pae_paging(vcpu)) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 116932e13d59..07d1cfb051f5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10172,18 +10172,32 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
-	struct kvm_vcpu *vcpu;
-	unsigned long i;
-
 	/*
 	 * memslots->generation has been incremented.
 	 * mmio generation may have reached its maximum value.
 	 */
 	kvm_mmu_invalidate_mmio_sptes(kvm, gen);
 
-	/* Force re-initialization of steal_time cache */
-	kvm_for_each_vcpu(i, vcpu, kvm)
-		kvm_vcpu_kick(vcpu);
+	/*
+	 * Force re-initialization of the steal_time cache, and of any
+	 * nested-state pages whose physical addresses a vCPU has latched
+	 * in hardware control structures (e.g. vmcs02) from a
+	 * gfn_to_pfn_cache. Software readers of such caches catch the
+	 * generation bump lazily, via kvm_gpc_check() at their next use;
+	 * the CPU's use from guest mode is continuous and checks nothing,
+	 * so the vCPU must be told to re-resolve and re-latch before it
+	 * next enters the guest. The request is the artifact that
+	 * survives racing with a concurrent VM-entry (a bare kick landing
+	 * before vcpu->mode is set would be lost); its handler re-runs
+	 * nested page setup, whose gPA lookups then see the new
+	 * generation and refresh.
+	 *
+	 * The wake/kick this performs on every vCPU is also what forces
+	 * re-initialization of the steal_time cache: its check-at-use
+	 * sites likewise only see the new generation once the vCPU goes
+	 * around its run loop.
+	 */
+	kvm_make_all_cpus_request(kvm, KVM_REQ_GET_NESTED_STATE_PAGES);
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
-- 
2.55.0

