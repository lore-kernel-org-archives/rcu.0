Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1738E5EF
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046993; cv=pass; b=fgNPinqVEugPbOzVF4jBysijJtL4+c9oUVh8/bO6PqdIGi1DhRvsEIBGf/XCrcDAIqSu59rctaooAtN4S2axGVhQoH4mCwpX/52+RqvdONlCCp/6GEcIP1FWll2EG4OZPsDL245ym0GrYTe/kGualnolO5HzFrVGH18x46ZK9DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046993; c=relaxed/simple;
	bh=nxcBcIIu8q5gjVlpoqJK0T82KS5DXH91pbYJkPqLAyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6kL85MWPzlBR42lH+eRwDihvSK66T+giru22Z3mHx7wCJFsfEop7pydXvGqlPWcGTqWOKPi12USBeYF+4tL6Pf2oNRbYUOxT4FoYjJ9ESHFYsg8CLKbT+uXSiLrkzbmbgs2ENEpEjXnVPeqoUltkjcZgFqMfqesw8YQJtSlz2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OttL4iFp; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OttL4iFp"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so18285535e9.0
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2026 20:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790046989; cv=none;
        d=google.com; s=arc-20260327;
        b=ottRLG8jp6nWjoWCU1xSEl+hQqr4GU5zjddHcbm6Y/A3GpLdv0eCWBCVdFm3YsESnb
         pj5FaC4XzcqNHN/tDpOPxM82OMrwuUJvcpAoWZLyX1qsOzMMKb8QFh/GvYxqRKEIUQ3T
         R1reh/rGIwOvUIotgrBNcZRjXBJrsneRQ88Bwx7O19DahYOUINMesGMmfH0/J6vFMXI6
         M6Eg10QkGUFp7OYUeuesW/KVh7Q1SbucE6kxJ9rA94wGpcVK0m9Ow2Qeb0MQSwcNFXxa
         1ljHeQPeTo47rDwU863Y0k7mcYoNd56x8hTqLiI+gCVGWD3Kcgr/zcCxv3FKOgi3pE9d
         eHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        fh=tQUw2QGsnWcSB41+qeDM7B55+ndT5A49ska8U79KQGk=;
        b=Yg079UolhS7RPr9lucAwYV5gAE9BCY4JFowS7TDQ2udQHwwgdkTRFfLII5lHibpYye
         gqIHVMa27+bnOgV5d6otf2Jp0U8t2L/5lKLv/4RPPxECXUBS46VBUwfs1aX3yAqybqqf
         nU11g+nWXRyV8Z44xe873mpouaVAIP2vZ27HiW8YHVANaFBi0k/ATP+EmS9p6GfRzyQJ
         gSFD9PMucIW+vHKMhQNUdJTwcWKXIqR8C2N2asvW5tz0Aa4QNn4s2gTRZsW2xPERP5YN
         BTvzUgvV+xdrCKd7FLPsL9Te7Cfmt9CwODvIOUIp0gi1jN38wNbvgwDbMnSOusp7opkF
         MN5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046989; x=1790651789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=OttL4iFp1xOGLN3gQnlMB1tq0xJngLmH/krKaax6xy5z4RxYekCTxh9Pp5E7snJIS8
         ZobS1E0MjajLMNyvFy7990rcYKr++EK/BWqlFO10y85xevVnAspMQkzcxXzPTMmBUn16
         O0G3myRMed/g5rzaHBAU3uWu/wfB21Dcma6GjYJPOPLx7aR9vC0WtB94c3WyUTdrpnoa
         H4qtZJ+iHtgMcAK09zQLOy0AZ4jCix0Ts7e+HOLW6ZGtcTJ0I4WtsWreqCdP5gC4ZD2G
         UAIvrnTEZ2sjIyjTwWzRwKmDL02BxsXALzX3e57Rz67SZ57uoZZTMabSsbMu01Fj6Hhi
         yRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046989; x=1790651789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0hVWGyySlLly+28D7LGfZKDh0uXJmKT1sB0yr2I6gM=;
        b=kUeZ0N2cQvd2p1NG/nnnQHwF0yXkUUvIuXPr9Dxa/7Ew91yIH3tnbgn36hfrPAxEOE
         6VGaITiCd/ik15QIPns26klFkCGG88U2EOlJYobRH5a1hwRHJP9lHGQgo+diyTymyJ2B
         lSk+qIKfi0+QGYNkYV7m0PQq5JM9ifxKGbfnz1ckkwbtjjNkxGwsp/u2SyzdQ3oGt+qY
         pWysRV176zApLQDm2xEJ4eXkENzBY17RqcB5NWvX9MVKqEMLH3ilFoParuppBVRxJN+O
         FynMdhRuEZnRvgqv+GyrxrZlUtvmBmMihYcLQeIppR6sTDNXwj9gnjTZ9weckwYu0zG5
         ox1Q==
X-Forwarded-Encrypted: i=1; AKwUvBw6dBKK2vz7Df/ZKWVtSBwT3RALi6QUR8Z5o0YQALwH0VwEhcas5vqiI5UchMzB6z3YYBA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXdDcW7hJNBh8Ap90040qwCfUU034XPh7FT+jxaGp7DYZDyd2P
	PDU+MER2B9Ytnc/cbA2Q9++p+qPZug8TUxdx69iO9zMhcSZ78OGf4nHo/LipyfyG41xuRXKozaJ
	Kl8s36WUoWyBz/tCS79Da+TeZJo0IfVA=
X-Gm-Gg: AYBFou0GDFRoo5Jh6NJz6TEAZ0RkZpUPcmzamJHUx3uKETsiaQ5DRh/QeAICsHseiAB
	DJPuIRA4tOAQ57gK8FEKlruASTvGXwKKxYRqkQdt+gOuwlOsztiAW+xxboZkcttEZONJ9wGhrDX
	EkyLA8gCraW+dL9tfG/2susSzzIkKhrA7YHMCFDMrmL6hpywDxKo/VsqESxiIm4gyB8MGL5Iasw
	ELWOOkNH83aYUPkr6pDC+gByKHXgkoF0j4V6HWTVfwjRcE8wdgRGbMUldDsIZfqmwNElrMUtOfN
	zQOZfa9H+koGGBm/Xd4FuTOTKzUvmqMYYTINdzMswadEwF/ZmiFXpDGPxAkXhEYV10Mnl5pHIuI
	8a/r0Eh9RvCyWxQ==
X-Received: by 2002:a05:600c:46cc:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49fc566951dmr171043015e9.7.1790046989155; Mon, 21 Sep 2026
 20:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920211920.928306-1-dwmw2@infradead.org>
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 22 Sep 2026 11:16:17 +0800
X-Gm-Features: AcwNN1WrYNyWGp1bGXe-bJN9POYZPs3FjeCDYohf8fnVdXEdiDT26MiduZxqtjc
Message-ID: <CAN_Opa9YWJZxr=YEjnkS-Khm=83P-xqGVZ6tq2nVQzMNOiThbg@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Paul Durrant <paul@xen.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Zqiang <qiang.zhang@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Keir Fraser <keirf@google.com>, 
	David Matlack <dmatlack@google.com>, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks for the series. I noticed the testing results, but didn't see
a performance comparison for the SRCU change itself.

Do you happen to have any numbers comparing the GPC invalidation
latency with regular SRCU vs. `synchronize_srcu_atomic()`? If there
are also numbers with the reader-free fastpath, that would be useful
for understanding its impact as well.

No need to run anything specifically if you don't already have the
numbers.

Thanks,
Kunwu

On Mon, Sep 21, 2026 at 5:19=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> Now that Paul et al have so kindly provided atomic SRCU for us, it would
> be churlish not to use it.
>
> Based on the merge of kvm/next (d4b7fb647204) with Paul's dev.2026.09.17a=
=C2=B9
> as posted last week=C2=B2, this series:
>
>  =E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwlock which=
 was a
>    scaling and latency problem, and which PREEMPT_RT hated because it
>    turned the rwlock into a sleeping lock.
>
>  =E2=80=A2 Cleans up the intentional lack of dirty-tracking of Xen shinfo=
 and
>    vcpu_info pages (Sean).
>
>  =E2=80=A2 Converts steal-time / preempted status to use gfn_to_pfn_cache=
. (Carsten)
>
>  =E2=80=A2 Reinstates guest-mode pinning: replacing the old GUEST_USES_PF=
N mode,
>    letting nested state pages be cached and pinned while in guest context=
.
>
>  =E2=80=A2 nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for APIC =
access
>    and vAPIC pages. (Fred)
>
>  =E2=80=A2 nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissions p=
ages. This
>    cuts the vmcb12 transition cost measurably (selftest included).
>
>  =E2=80=A2 Returns -EAGAIN from cache lookups which race with memslot upd=
ates,
>    and re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot generation
>    bumps so pinned caches are revalidated lazily.
>
> Tested: rcutorture atomic-SRCU (srcud, reader_flavor=3D0x10) on three
> hosts; KVM selftests including new invalidation and transition tests;
> >1 week soak of VM lifecycle + invalidation reproducers on 128-way
> RT+KASAN+lockdep, 192-way RT and 192-way PREEMPT_DYNAMIC hosts. And
> booted an actual Xen guest in QEMU a few times...
>
> =C2=B9 https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.=
git dev.2026.09.17a
> =C2=B2 https://lore.kernel.org/rcu/20260919003521.3134552-1-paulmck@kerne=
l.org/
>
> There have been previous series which attempt to deal with various parts
> of GPC locking, and the steal time one has definitely been posted before
> a few times, but let's just call this v1:
> https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dshortlog;h=3Dref=
s/heads/gpc-srcu
>
> Carsten Stollmaier (1):
>       KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
>
> David Woodhouse (10):
>       KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
>       KVM: x86: Request the guest TLB flush from record_steal_time()
>       KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
>       KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid me=
mslot
>       KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
>       KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_pag=
e()
>       KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
>       KVM: nSVM: Cache L1's MSR permissions map pages
>       KVM: nSVM: Cache L1's IO permissions map pages
>       KVM: selftests: Add nested transition benchmark
>
> Fred Griffoul (3):
>       KVM: nVMX: Implement cache for L1 MSR bitmap
>       KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
>       KVM: selftests: Add nested VMX APIC cache invalidation test
>
> Sean Christopherson (3):
>       KVM: x86/xen: Extract delivery of event to vCPU into a separate hel=
per
>       KVM: x86/xen: Explicitly tag "shared info" page as never being dirt=
y tracked
>       KVM: x86/xen: Don't dirty track "vCPU info" page
>
>
>  arch/x86/include/asm/kvm_host.h                    |   2 +-
>  arch/x86/kvm/msrs.c                                |   7 +-
>  arch/x86/kvm/svm/nested.c                          | 112 +++-
>  arch/x86/kvm/svm/svm.h                             |  16 +
>  arch/x86/kvm/vmx/nested.c                          | 356 ++++++++++--
>  arch/x86/kvm/vmx/vmx.c                             |  11 +-
>  arch/x86/kvm/vmx/vmx.h                             |  16 +-
>  arch/x86/kvm/x86.c                                 | 181 ++++---
>  arch/x86/kvm/x86.h                                 |  33 ++
>  arch/x86/kvm/xen.c                                 | 279 +++++-----
>  include/linux/kvm_host.h                           |  86 ++-
>  include/linux/kvm_types.h                          |  52 +-
>  include/linux/srcu.h                               |   7 +
>  tools/testing/selftests/kvm/Makefile.kvm           |   2 +
>  .../selftests/kvm/x86/nested_transition_bench.c    | 204 +++++++
>  .../selftests/kvm/x86/vmx_apic_update_test.c       | 299 +++++++++++
>  virt/kvm/kvm_main.c                                |   9 +
>  virt/kvm/pfncache.c                                | 596 +++++++++++++++=
++----
>  18 files changed, 1876 insertions(+), 392 deletions(-)
