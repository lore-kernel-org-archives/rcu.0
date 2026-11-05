Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=nE9k4HbRRCK+2NkENcBFft5yCe6D1B6ihcxmryonjnW9CbKZeG322nwB1JFT9Iq5iS70
	 seKXFrsbCYgnrbqS249y22EVNSo0heVsiV5rcZtviaw/DT+/I9FjR41m2tiGLJxg7BV4k
	 tsAP+NOPZSLPc6CfmETdbx3NXMNJ265iaezxDv7DW0wY/V58cpWLMqkjvOrYRnqnSx+u5
	 Naz1Jlxl9ujlQYfGi24HuwM0AGDZWKV6L3V1v3CdJ2+ORXt/Qv0b5by5osM1qhDe3CQ2O
	 AxaWS8diq4xydNrKk6CieXP50LHOYaJsVQk5rcDahsdTccQHBhTnUCK+yQ2XaoyxYAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=lQpJFDqY1tDguWTzIC8id9i9AgdhlJblnx5mnpydVTA=;
	b=APvl0fvWH9KUj/axh4esBtPCb3WS5Xm9vpxCPRXmymt/anW48Wvt/kTU4vpMd9snQnKL
	 LBnz9+B/1qIubZZX8SiIaJBybwT7WvA93RkClp1fnjab0nIY2g3hzGVP/Ow8Y3avNrn/A
	 3fIDtLzHXVrzB6TzUFvvVcQI26fEDNCOV6IHzuGIEr1aGk75BnoasRA4wd46sFQ9W8gh0
	 C9aFe2GbimTURqL7JJzUq460DbTfHM3Jn9+qUPiZfsaOzFIpbXRWJw/wenCN50ighrYfE
	 oodCK2w+SQl/LtlogZXWZAcRahIqwYjuxh1Ohb891CqW7CvAqJBxvK5abLhvVMZsbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=e6kFedoC;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD77B606A326;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD77B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=e6kFedoC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lQpJFDqY1tDguWTzIC8id9i9AgdhlJblnx5mnpydVTA=; b=e6kFedoCnPOnMG/kv4EOQLJ86M
	X42CkCMN+MJaMEOmD0bS5rLDo9/rYUYoW//Oh4S5CSvw6WI35jOX4HtJXeJlSNs0/6ByKAcBtsOc2
	Ig6AI2MgKd7y3e7gV9GKkXgqjLSaE9dSHZNdHrSfzY9CrM22lwNYM3nxcKICSL8hi43rBfcIScjKn
	daA54Zu+hG9Qdi7NPI4uXI1DL6cLpNX9ZZ3/bpgS1FDjTOtfggn0wFicpw7YEuZnvCTKQWz0ad8T2
	7GkgBy8Ia2JHcFgUjSRShwosji2mOskOwzG4PlMXSxKr4D4uNcMtaLHcBSAsCPhL6P4VO2d8Phgr/
	omRGpp/A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j4-0EUg;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWD1-0Djs;
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
Subject: [PATCH v2 00/20] KVM: Use atomic SRCU for gfn-to-pfn cache, reinstate guest mode for x86 nesting
Date: Thu,  5 Nov 2026 02:00:42 +0000
Message-ID: <20261105020104.2507083-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Based on v7.4-rc1 (kvm/next doesn't have the atomic SRCU flavour yet),
this series:

 • Converts the GPC to use atomic SRCU, ditching the rwlock which was a
   scaling and latency problem, and which PREEMPT_RT hated because it
   turned the rwlock into a sleeping lock¹.

 • Fixes the pre-existing bugs which torture-testing that conversion
   shook out: a guest-reachable dirty ring overflow from the hypercall
   page write (128 pushes of the same gfn against 64 reserved entries,
   without PML), and a lost TLB flush request in record_steal_time().

 • Adds KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE, for VMMs which
   intercept the guest's MSR write and need to replay it from host
   context².

 • Cleans up the intentional lack of dirty-tracking of Xen shinfo and
   vcpu_info pages (Sean).

 • Converts steal-time / preempted status to use gfn_to_pfn_cache.
   (Carsten)

 • Reinstates guest-mode pinning: replacing the old GUEST_USES_PFN
   mode, letting nested state pages be cached and pinned while in
   guest context.

 • nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for APIC
   access and vAPIC pages. (Fred)

 • nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissions pages.
   This cuts the vmcb12 transition cost measurably (selftest included).

 • Re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates so the
   pinned caches are revalidated lazily, riding out the transient
   KVM_MEMSLOT_INVALID window of an in-flight update via the pending
   request rather than ever entering L2 with a stale latched address.

I had briefly split out some of the preliminary fixes and cleanups
into a separate series which didn't depend on atomic SRCU. But I've
joined it all back together now that atomic SRCU is merged. And I've
ditched half of those 'fixes' as a bad idea anyway³.


Tested: per-commit builds across the series; KVM selftests including
the new invalidation, transition and race tests on 192-way AMD, and
the applicable subset on Intel under PROVE_LOCKING + PROVE_RCU +
DEBUG_ATOMIC_SLEEP (which catches the attribute-ioctl srcu fix on the
very first xen_shinfo_test run when it's reverted; that config is now
a standing part of the testing here). The new mmu_notifier race test
asserts that every one of 5000 event channel deliveries into HVA-based
caches survives continuous MADV_DONTNEED invalidation of the backing
page, and soaks at 10/10.

¹ https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
² https://lore.kernel.org/kvm/c855535b4262ecd41f67734d19e8f48a7f014c2a.camel@infradead.org/
³ https://lore.kernel.org/kvm/ac6b1891d6bdf3a855a5b840c462a6e7d464a146.camel@infradead.org/

v2: https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/gpc-srcu-v2

 • Absorb the fixes/cleanups which had been split out (and drop the
   delivery-retry half of them³, plus the SCHEDOP_poll fix which Sean
   is picking up separately)
 • Fix the mmu_notifier walk to wait out a grace period still owed by
   a concurrent mutator
 • Keep kvm->srcu in the Xen attribute ioctls for the memslot lookups
 • Pair smp_mb__after_atomic()/__after_spinlock() for the publish/veto
   store->load ordering
 • Nested: treat a refresh failure against a KVM_MEMSLOT_INVALID
   placeholder as transient; re-set vmcs02 controls after a lazy
   degradation heals; initialize caches once at vCPU creation
 • New: dirty ring overflow fix, WRITE_HYPERCALL_PAGE attribute,
   the two Xen race selftests

v1: https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/gpc-srcu
    https://lore.kernel.org/kvm/20260920211920.928306-1-dwmw2@infradead.org/

Carsten Stollmaier (1):
  KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

David Woodhouse (13):
  KVM: x86/xen: Fill the hypercall page with a single guest write
  KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
  KVM: x86: Request the guest TLB flush from record_steal_time()
  KVM: selftests: Actually deactivate the HVA-based shared_info cache in
    xen_shinfo_test
  KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
  KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
  KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
  KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
  KVM: nSVM: Cache L1's MSR permissions map pages
  KVM: nSVM: Cache L1's IO permissions map pages
  KVM: selftests: Add nested transition benchmark
  KVM: selftests: Add Xen evtchn vs memslot-update race test
  KVM: selftests: Add Xen evtchn vs mmu_notifier race test for HVA
    caches

Fred Griffoul (3):
  KVM: nVMX: Implement cache for L1 MSR bitmap
  KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
  KVM: selftests: Add nested VMX APIC cache invalidation test

Sean Christopherson (3):
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty
    tracked
  KVM: x86/xen: Don't dirty track "vCPU info" page

 Documentation/virt/kvm/api.rst                |  27 +-
 arch/x86/include/asm/kvm_host.h               |   2 +-
 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/msrs.c                           |   7 +-
 arch/x86/kvm/svm/nested.c                     | 174 ++++-
 arch/x86/kvm/svm/svm.c                        |  17 +
 arch/x86/kvm/svm/svm.h                        |  29 +
 arch/x86/kvm/vmx/nested.c                     | 517 +++++++++++--
 arch/x86/kvm/vmx/nested.h                     |   1 +
 arch/x86/kvm/vmx/vmx.c                        |  13 +-
 arch/x86/kvm/vmx/vmx.h                        |  21 +-
 arch/x86/kvm/x86.c                            | 209 ++++--
 arch/x86/kvm/x86.h                            |  33 +
 arch/x86/kvm/xen.c                            | 380 ++++++----
 include/linux/kvm_host.h                      | 121 +++-
 include/linux/kvm_types.h                     |  64 +-
 include/linux/srcu.h                          |   7 +
 tools/testing/selftests/kvm/Makefile.kvm      |   4 +
 .../kvm/x86/nested_transition_bench.c         | 210 ++++++
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 323 +++++++++
 .../kvm/x86/xen_evtchn_hva_notify_race_test.c | 188 +++++
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 232 ++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |   2 +-
 .../selftests/kvm/x86/xen_vmcall_test.c       | 118 +++
 virt/kvm/kvm_main.c                           |   9 +
 virt/kvm/pfncache.c                           | 677 +++++++++++++++---
 26 files changed, 2962 insertions(+), 426 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_transition_bench.c
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

