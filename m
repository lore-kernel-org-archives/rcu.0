Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2763CC7CD;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939193; cv=none; b=nBeWQ3TbkinrO82MzkmBXcCQIiwdgbMxW3PtIxlTx3/GdzgYRkhpD/hcxC6kbvBcOcYFMSwkhcLHIE4BAUSlf04RHSILMCg8ipio1hY5kJkNg+iaMo2bQJJdIExsMN5CuNzA2LO7m5Vc8LPLxmRAObnhTX7vbSU6uAB0TNW7mRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939193; c=relaxed/simple;
	bh=ig4/AR3dlJ8hgwY/mdh2xBudVl0tzrFDfw5s8DmL+04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UwWLTotour2zUEvXRv7zb3e+gi9mKtMCu+/YWm3UMn8SerGE/FSJdzDl6KKE+pGJlU0zqj5Q+0iMzYQAQ+1NEy2Wi3ETVk7hGh9/J/n25mo/9H2jqF3ritMXLIGDs4K1ZDCZPoSLEN5P2l/jR3riGyAo5e+PSVFr3/cm+Ur39qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z3zEo/fY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3zEo/fY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CuBtQj2YvVayz9J+VBI+JR/WeiiCX+miEFDODENeHxQ=; b=Z3zEo/fYWgpDxrtmNVolENUpvD
	azePLPQ8llVckNBb2G1Ojdbc05D8AgpugQxfU8sBaiwsUzCvgBm6QIU5dyq6L64zS+7/wmA+pH8iB
	u4FIGNAGU0uVBD5C2Fs6LN181Owbb3DAhtDZXuiMUvSIIw2ZwFnjAyAsrTK4dANydPetmdMgDu92Y
	PxA+DTQNBUbzI2yJEBQChIOsRgA1hMuRkn5rDvZlxALJKsMgP6coX1slao824NQZrGjtDKrM8Wa6u
	dWYmxFzTE5NzxRc9iMJC8RjHgXgHiUxAV9VOw+Yp2UkScA5o1NkH2o3CzgBYSSpYYUOpongnTAKbm
	ByFfeNSg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000BdxT-49Dx;
	Sun, 20 Sep 2026 21:19:42 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcM-09Zd;
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
	nh-open-source@amazon.com
Subject: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache, reinstate guest mode for x86 nesting
Date: Sun, 20 Sep 2026 21:49:28 +0100
Message-ID: <20260920211920.928306-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Now that Paul et al have so kindly provided atomic SRCU for us, it would
be churlish not to use it.

Based on the merge of kvm/next (d4b7fb647204) with Paul's dev.2026.09.17a¹
as posted last week², this series:

 • Converts the GPC to use atomic SRCU, ditching the rwlock which was a
   scaling and latency problem, and which PREEMPT_RT hated because it
   turned the rwlock into a sleeping lock.

 • Cleans up the intentional lack of dirty-tracking of Xen shinfo and
   vcpu_info pages (Sean).

 • Converts steal-time / preempted status to use gfn_to_pfn_cache. (Carsten)
  
 • Reinstates guest-mode pinning: replacing the old GUEST_USES_PFN mode,
   letting nested state pages be cached and pinned while in guest context.
  
 • nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for APIC access
   and vAPIC pages. (Fred)

 • nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissions pages. This
   cuts the vmcb12 transition cost measurably (selftest included).

 • Returns -EAGAIN from cache lookups which race with memslot updates,
   and re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot generation
   bumps so pinned caches are revalidated lazily.

Tested: rcutorture atomic-SRCU (srcud, reader_flavor=0x10) on three
hosts; KVM selftests including new invalidation and transition tests;
>1 week soak of VM lifecycle + invalidation reproducers on 128-way
RT+KASAN+lockdep, 192-way RT and 192-way PREEMPT_DYNAMIC hosts. And
booted an actual Xen guest in QEMU a few times...

¹ https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2026.09.17a
² https://lore.kernel.org/rcu/20260919003521.3134552-1-paulmck@kernel.org/

There have been previous series which attempt to deal with various parts
of GPC locking, and the steal time one has definitely been posted before
a few times, but let's just call this v1:
https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu

Carsten Stollmaier (1):
      KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

David Woodhouse (10):
      KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
      KVM: x86: Request the guest TLB flush from record_steal_time()
      KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
      KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
      KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
      KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_page()
      KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
      KVM: nSVM: Cache L1's MSR permissions map pages
      KVM: nSVM: Cache L1's IO permissions map pages
      KVM: selftests: Add nested transition benchmark

Fred Griffoul (3):
      KVM: nVMX: Implement cache for L1 MSR bitmap
      KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
      KVM: selftests: Add nested VMX APIC cache invalidation test

Sean Christopherson (3):
      KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
      KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
      KVM: x86/xen: Don't dirty track "vCPU info" page


 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kvm/msrs.c                                |   7 +-
 arch/x86/kvm/svm/nested.c                          | 112 +++-
 arch/x86/kvm/svm/svm.h                             |  16 +
 arch/x86/kvm/vmx/nested.c                          | 356 ++++++++++--
 arch/x86/kvm/vmx/vmx.c                             |  11 +-
 arch/x86/kvm/vmx/vmx.h                             |  16 +-
 arch/x86/kvm/x86.c                                 | 181 ++++---
 arch/x86/kvm/x86.h                                 |  33 ++
 arch/x86/kvm/xen.c                                 | 279 +++++-----
 include/linux/kvm_host.h                           |  86 ++-
 include/linux/kvm_types.h                          |  52 +-
 include/linux/srcu.h                               |   7 +
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../selftests/kvm/x86/nested_transition_bench.c    | 204 +++++++
 .../selftests/kvm/x86/vmx_apic_update_test.c       | 299 +++++++++++
 virt/kvm/kvm_main.c                                |   9 +
 virt/kvm/pfncache.c                                | 596 +++++++++++++++++----
 18 files changed, 1876 insertions(+), 392 deletions(-)
