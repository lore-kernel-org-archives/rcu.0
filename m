Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340389;
	b=vuEm6uUEEiXHR7TPDXjRo6ZduKgAoC7+pmQUQ4qgmPcKZP+vtV586RJ8M9u7tdgyL8xc
	 DcDn0Ee3/dh1kCUvcDhjREPFGjPE4eOx9WTqzIcMbbv31FB4DTNFCgVL2R1VSoSBm/7gX
	 aENoT7EuuEK7jCb/LL2DmISPGceFWAFYVzZ+WqmmoPlfE5pZZgIunuRH3bBM83LfXKQpB
	 bvq2GUR/hhhrpvoMckliGvGjJWP7SMKLDVxKMXjR/2iKdByWbB+YjrsGVUS/TWdWJLojE
	 5bDANcITQnwLZZwlOnTH5/E9cDJ8Q8snDCxvyweZH1oqQotCSdyNoBG9ywV+Wci3Yeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340389;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 X-SRS-Rewrite;
	bh=/sHQ+gV4qkZnhp7ksdS0Ur7zJFEvxSjCyZRdVAg485k=;
	b=kS0TLT9esWm4Wp6HKvHJSHrSZEWryDvqjnczLuyRUURCakQru/TdvvbYW6ftYp0SG2dT
	 A+2MADRlp54YAYIIyjDFajDFhJ7lbmNuiPszbltEKeR4jTPlr0x8T4kqyFK0WdIKv94qp
	 eyO8OFFUelZ+mE8Y9/iP4iEvwDLJrJxxkIBC6NunI/DU9DBtEweZOY7UIrg71o44U5CXs
	 Y+D7WqkEO6ABH2fyKGzdec5hNNkhnwvAyZ7Na0y5ui30l/f9kG2R7PTTMyj1z5a28DBlu
	 /p94Yh6g5FVhM4scIJxhh86J4yqI8/o254zl7E38n4fzDPQdxI3cb2lfHNURyoyIPZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KoSOTPOS;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8E606A326;
	Tue, 10 Nov 2026 19:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47D8E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KoSOTPOS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/sHQ+gV4qkZnhp7ksdS0Ur7zJFEvxSjCyZRdVAg485k=; b=KoSOTPOS1Y+kex+v4v+rMh5fJ1
	Ba3sDoQJK01HDhLInkKVSg5I3mg+CfC0KESTGWwpkdf9sCDDQg+ayJ09zP8Cwn0qHNgOoOtOxERW8
	/gaHu/PUrepIqwZRZdteB/DQfmWrsaHbGd47GL80IMdPEgRzOEvM6iH8oxvLgtSmWB4XRgFzJyMK0
	V+jRHgxO9J3/T/L9HOb/WY4kstIFhuUqrQYzNLmtOzngb47h9c4XDOJQsKAR087m46NXD2hfEtFoy
	Ptho2eGzzqwo7LBwFgHHiUS8TYlCbc/DMWonsLbxjN8DWAYXwX0zPnNLW82GUYtWCYLKDFVd3sPs6
	8bJq0hJA==;
Received: from [205.251.233.52] (helo=u09cd745991455d.ant.amazon.com)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQrtw-00000000oaS-2kCn;
	Tue, 10 Nov 2026 19:53:04 +0000
Message-ID: <cd458ee9a0c2405349cd2aaecb180f0b2e757aa3.camel@infradead.org>
Subject: Re: [PATCH v2 00/20] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rcu@vger.kernel.org, linux-rt-devel@lists.linux.dev, Paolo Bonzini	
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Paul
 Durrant	 <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred
 Griffoul	 <fgriffo@amazon.co.uk>, "Paul E . McKenney" <paulmck@kernel.org>,
 Kunwu Chan	 <kunwu.chan@linux.dev>, Kunwu Chan <kunwu.chan@gmail.com>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Date: Tue, 10 Nov 2026 11:52:59 -0800
In-Reply-To: <20261105020104.2507083-1-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
	boundary="=-AODIAK3RRiR3rrOaNi6N"
User-Agent: Evolution 3.62.0-0ubuntu1~ppa1~24.04 
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html


--=-AODIAK3RRiR3rrOaNi6N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-05 at 02:00 +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> Based on v7.4-rc1 (kvm/next doesn't have the atomic SRCU flavour yet),
> this series:
>=20
> =C2=A0=E2=80=A2 Converts the GPC to use atomic SRCU, ditching the rwlock =
which was a
> =C2=A0=C2=A0 scaling and latency problem, and which PREEMPT_RT hated beca=
use it
> =C2=A0=C2=A0 turned the rwlock into a sleeping lock=C2=B9.
>=20
> =C2=A0=E2=80=A2 Fixes the pre-existing bugs which torture-testing that co=
nversion
> =C2=A0=C2=A0 shook out: a guest-reachable dirty ring overflow from the hy=
percall
> =C2=A0=C2=A0 page write (128 pushes of the same gfn against 64 reserved e=
ntries,
> =C2=A0=C2=A0 without PML), and a lost TLB flush request in record_steal_t=
ime().
>=20
> =C2=A0=E2=80=A2 Adds KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE, for VMM=
s which
> =C2=A0=C2=A0 intercept the guest's MSR write and need to replay it from h=
ost
> =C2=A0=C2=A0 context=C2=B2.
>=20
> =C2=A0=E2=80=A2 Cleans up the intentional lack of dirty-tracking of Xen s=
hinfo and
> =C2=A0=C2=A0 vcpu_info pages (Sean).
>=20
> =C2=A0=E2=80=A2 Converts steal-time / preempted status to use gfn_to_pfn_=
cache.
> =C2=A0=C2=A0 (Carsten)
>=20

I love it when sashiko-bot finds things which my own local runs don't.
I'm still iterating on the latter part of the series; I think it
probably makes sense to merge the first half (patches 1-9 above), and
the nested parts (below) can come later.

Sean, what do you think?

> =C2=A0=E2=80=A2 Reinstates guest-mode pinning: replacing the old GUEST_US=
ES_PFN
> =C2=A0=C2=A0 mode, letting nested state pages be cached and pinned while =
in
> =C2=A0=C2=A0 guest context.
>=20
> =C2=A0=E2=80=A2 nVMX: Uses GPC for the L1 MSR bitmap, and guest mode for =
APIC
> =C2=A0=C2=A0 access and vAPIC pages. (Fred)
>=20
> =C2=A0=E2=80=A2 nSVM: Uses GPC for vmcb12 / MSR-permissions / IO-permissi=
ons pages.
> =C2=A0=C2=A0 This cuts the vmcb12 transition cost measurably (selftest in=
cluded).
>=20
> =C2=A0=E2=80=A2 Re-posts KVM_REQ_GET_NESTED_STATE_PAGES on memslot update=
s so the
> =C2=A0=C2=A0 pinned caches are revalidated lazily, riding out the transie=
nt
> =C2=A0=C2=A0 KVM_MEMSLOT_INVALID window of an in-flight update via the pe=
nding
> =C2=A0=C2=A0 request rather than ever entering L2 with a stale latched ad=
dress.
>=20
> I had briefly split out some of the preliminary fixes and cleanups
> into a separate series which didn't depend on atomic SRCU. But I've
> joined it all back together now that atomic SRCU is merged. And I've
> ditched half of those 'fixes' as a bad idea anyway=C2=B3.
>=20
>=20
> Tested: per-commit builds across the series; KVM selftests including
> the new invalidation, transition and race tests on 192-way AMD, and
> the applicable subset on Intel under PROVE_LOCKING + PROVE_RCU +
> DEBUG_ATOMIC_SLEEP (which catches the attribute-ioctl srcu fix on the
> very first xen_shinfo_test run when it's reverted; that config is now
> a standing part of the testing here). The new mmu_notifier race test
> asserts that every one of 5000 event channel deliveries into HVA-based
> caches survives continuous MADV_DONTNEED invalidation of the backing
> page, and soaks at 10/10.
>=20
> =C2=B9 https://syzkaller.appspot.com/bug?extid=3D208f7f3e5f59c11aeb90
> =C2=B2 https://lore.kernel.org/kvm/c855535b4262ecd41f67734d19e8f48a7f014c=
2a.camel@infradead.org/
> =C2=B3 https://lore.kernel.org/kvm/ac6b1891d6bdf3a855a5b840c462a6e7d464a1=
46.camel@infradead.org/
>=20
> v2: https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/g=
pc-srcu-v2
>=20
> =C2=A0=E2=80=A2 Absorb the fixes/cleanups which had been split out (and d=
rop the
> =C2=A0=C2=A0 delivery-retry half of them=C2=B3, plus the SCHEDOP_poll fix=
 which Sean
> =C2=A0=C2=A0 is picking up separately)
> =C2=A0=E2=80=A2 Fix the mmu_notifier walk to wait out a grace period stil=
l owed by
> =C2=A0=C2=A0 a concurrent mutator
> =C2=A0=E2=80=A2 Keep kvm->srcu in the Xen attribute ioctls for the memslo=
t lookups
> =C2=A0=E2=80=A2 Pair smp_mb__after_atomic()/__after_spinlock() for the pu=
blish/veto
> =C2=A0=C2=A0 store->load ordering
> =C2=A0=E2=80=A2 Nested: treat a refresh failure against a KVM_MEMSLOT_INV=
ALID
> =C2=A0=C2=A0 placeholder as transient; re-set vmcs02 controls after a laz=
y
> =C2=A0=C2=A0 degradation heals; initialize caches once at vCPU creation
> =C2=A0=E2=80=A2 New: dirty ring overflow fix, WRITE_HYPERCALL_PAGE attrib=
ute,
> =C2=A0=C2=A0 the two Xen race selftests
>=20
> v1: https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/g=
pc-srcu
> =C2=A0=C2=A0=C2=A0 https://lore.kernel.org/kvm/20260920211920.928306-1-dw=
mw2@infradead.org/
>=20
> Carsten Stollmaier (1):
> =C2=A0 KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
>=20
> David Woodhouse (13):
> =C2=A0 KVM: x86/xen: Fill the hypercall page with a single guest write
> =C2=A0 KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
> =C2=A0 KVM: x86: Request the guest TLB flush from record_steal_time()
> =C2=A0 KVM: selftests: Actually deactivate the HVA-based shared_info cach=
e in
> =C2=A0=C2=A0=C2=A0 xen_shinfo_test
> =C2=A0 KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
> =C2=A0 KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
> =C2=A0 KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
> =C2=A0 KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
> =C2=A0 KVM: nSVM: Cache L1's MSR permissions map pages
> =C2=A0 KVM: nSVM: Cache L1's IO permissions map pages
> =C2=A0 KVM: selftests: Add nested transition benchmark
> =C2=A0 KVM: selftests: Add Xen evtchn vs memslot-update race test
> =C2=A0 KVM: selftests: Add Xen evtchn vs mmu_notifier race test for HVA
> =C2=A0=C2=A0=C2=A0 caches
>=20
> Fred Griffoul (3):
> =C2=A0 KVM: nVMX: Implement cache for L1 MSR bitmap
> =C2=A0 KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
> =C2=A0 KVM: selftests: Add nested VMX APIC cache invalidation test
>=20
> Sean Christopherson (3):
> =C2=A0 KVM: x86/xen: Extract delivery of event to vCPU into a separate he=
lper
> =C2=A0 KVM: x86/xen: Explicitly tag "shared info" page as never being dir=
ty
> =C2=A0=C2=A0=C2=A0 tracked
> =C2=A0 KVM: x86/xen: Don't dirty track "vCPU info" page
>=20
> =C2=A0Documentation/virt/kvm/api.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 +-
> =C2=A0arch/x86/include/asm/kvm_host.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0arch/x86/include/uapi/asm/kvm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0arch/x86/kvm/msrs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> =C2=A0arch/x86/kvm/svm/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 174 ++++-
> =C2=A0arch/x86/kvm/svm/svm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +
> =C2=A0arch/x86/kvm/svm/svm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +
> =C2=A0arch/x86/kvm/vmx/nested.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 517 +++++++++++--
> =C2=A0arch/x86/kvm/vmx/nested.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0arch/x86/kvm/vmx/vmx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
> =C2=A0arch/x86/kvm/vmx/vmx.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 21 +-
> =C2=A0arch/x86/kvm/x86.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 209 ++++--
> =C2=A0arch/x86/kvm/x86.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 33 +
> =C2=A0arch/x86/kvm/xen.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 380 ++++++----
> =C2=A0include/linux/kvm_host.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 121 +++-
> =C2=A0include/linux/kvm_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 64 +-
> =C2=A0include/linux/srcu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +
> =C2=A0tools/testing/selftests/kvm/Makefile.kvm=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 +
> =C2=A0.../kvm/x86/nested_transition_bench.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 210 ++++++
> =C2=A0.../selftests/kvm/x86/vmx_apic_update_test.c=C2=A0 | 323 +++++++++
> =C2=A0.../kvm/x86/xen_evtchn_hva_notify_race_test.c | 188 +++++
> =C2=A0.../kvm/x86/xen_evtchn_memslot_race_test.c=C2=A0=C2=A0=C2=A0 | 232 =
++++++
> =C2=A0.../selftests/kvm/x86/xen_shinfo_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0.../selftests/kvm/x86/xen_vmcall_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 118 +++
> =C2=A0virt/kvm/kvm_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> =C2=A0virt/kvm/pfncache.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 677 +++++++++++++++---
> =C2=A026 files changed, 2962 insertions(+), 426 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/kvm/x86/nested_transitio=
n_bench.c
> =C2=A0create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_=
test.c
> =C2=A0create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_hva_n=
otify_race_test.c
> =C2=A0create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memsl=
ot_race_test.c
>=20
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

--=-AODIAK3RRiR3rrOaNi6N
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCE8Ew
ggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMwMDAwMDBaFw0zNDAz
MTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1xPQ+dgSxbIIrkaru6skAWJYaGFzmv
q4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XRmS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5Z
S64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1Cxy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTb
Z/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK
72a2GEpI8Wpl26G6I1/LMzz/98T+FqjTqxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZA
CcVdCtl4nAacFacmsiArZBfX7AQGL7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8W
mAESbUriIjyuTUf3fJ9oDNCurVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2cs
h2T79v7pC8aUtHBfwNrTR19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61a
CBevQGHNzrbZ3JAMneveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxI
GJiywe9qPhuJSDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtg
v6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMG
CCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURS
b290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdp
Q2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUA
A4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvCRS2pili3Hy67i8N4N5NU
vw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwEqOOwLLyH02ZQcsfq5p5LrOH9
0JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9YflujuNNvJztjBaHKYZsnNSg+J38o
jYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3x7Nel3A1bwAkalrDMspvTHvey6LfiBks
FIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVrYu8RMIIHAzCCBOugAwIBAgIQAzUotrsybJHx
HTjKOIVdIDANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQs
IEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTEwHhcNMjYwNzE4MDAwMDAwWhcNMjgwMTA0MjM1OTU5WjAeMRwwGgYDVQQDDBNkd213
MkBpbmZyYWRlYWQub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA2pYux73kdbYX
sWF8f1u6DJP91qcqaZetsyfPkZk0B+MmXmAEv0kVes5n15V2mbDThOnpoPFly0UugQO9JYqLfrtD
tKD5yL58fgrDB9Dw+LQikgrHafl6YSCds5AvUu/8hw2J6noKrcOLJpKlKn9Fl/4IB9Q3JIdLx5aa
EtTqMalIPqHFOlgrJ7s+aua8xbB8YQ9ahqYBXWRJNv3P/2b1DYtdrz1oqZPE3CcB8Pc6Gf2a1Tcm
6TAgtEx7Cf1BFcrsrMz7TWHmGQITieNb2r9UYWSc2Gp+GtYFNJCgT0JJXKUBIauPMKBLteYrL8Fo
ff/uY44dC/mDWjdCP/5x0qelPQjlBvWdHL5zvBTOj06rJ0m3HNI/hnIcDh0Qu2j9reb9rLVcdym6
bWmBM4uDEB8Zv9Ph0KTBFSy1IosyakuD1j1Os30EzjGfbi0EUXIvnOcYbTBAbM5UAzrxEHMhBvoX
Pvnx+OyvjJmc9tWxTX6AcSz+m40esbT17URBeZS18afgieiikm5TynlUYP1LciR3hSgGVzvGXnKO
02VDFR5itGWdRKZ2W5wIShNfWfhSa0D0K5UdIDt5Qc7sjzwK1Yb1sY5Tu0uA5mhIS82q1ov83uxB
sFkriNnhGv/M1NCDVLBiOMsHu73qUM+yKmgKLwF9Hfn9WI25glbAMI4S5r3hYzcCAwEAAaOCAfcw
ggHzMB8GA1UdIwQYMBaAFPebok7Tl8X0NA9DDoGFzpGTMq/5MB0GA1UdDgQWBBRcYhqbcGzn1jrT
JOZaB8O7qllDpzAwBgNVHREEKTAngRNkd213MkBpbmZyYWRlYWQub3JngRBkYXZpZEB3b29kaG91
LnNlMBQGA1UdIAQNMAswCQYHZ4EMAQUBAjAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMIGpBgNVHR8EgaEwgZ4wTaBLoEmGR2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsME2gS6BJ
hkdodHRwOi8vY3JsNC5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZT
SEEzODQyMDI0Q0ExLmNybDCBjQYIKwYBBQUHAQEEgYAwfjAkBggrBgEFBQcwAYYYaHR0cDovL29j
c3AuZGlnaWNlcnQuY29tMFYGCCsGAQUFBzAChkpodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20v
RGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0ExLmNydDANBgkqhkiG9w0B
AQsFAAOCAgEAocabrh1cPd5s3vY5rnlBVQSTc7zs2ZWs67dAIltR+05WELrYClVzzUhMs/LOJPlr
EUo45UDDomXq38DxFepaPd9+iNLjXfn33EX/IG44j04lU/oF/Rg9VeQILkYLbCZ/x9wOjNHZc4SN
ydY7Dhvf/sT5aBz88u7D5+azZJ7Qf1U57wYseCH1Mt0nDrtr5y19IJ8D9xJJ33RFL6vfpHZBBAQ8
+3RqkKNxLoV2aFvQhxdhjNLDqTv3LjUIdicwPraN7JkxEu7CV2Lka7eRqJgkWL7SK0YmBjGpRafs
+icP/ON5RCCKTTb6VlX8eTG2sJJfsFhvJNCCt6xexbWzWtIrfP7NvPBvwBB737AyEGBZkS5aNizT
McURJGTv9UKvBh1LF/+tNhYtLvPCN7oecGzhCHht9jcwSkygTo3Y6YlK3QgOu+ncmiBbfeuwlLZ1
LxbYvG6hgNqXv7u6YyADbYajAQJXJ2OQen39pm3Q/AQSyLYG+B8lDglWsM8tYXPlEdrYJcksGK6F
nqIX6Bumn43rBooLJdiZp4WmfWdL2pxe+LxRDjprmqu1WprixDxULSTOKJZoqTlugs6y3Bc+if+s
gHnBBtz9WQ6MtPHkh7zONDAFIKcBmv8OqPQCx0F3Wv3OEybwMpXx0OsKgK8wLldaX1pXcMuyDgTL
Sqs0AV0OHUgwggcDMIIE66ADAgECAhADNSi2uzJskfEdOMo4hV0gMA0GCSqGSIb3DQEBCwUAMGIx
CzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQg
QXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMTAeFw0yNjA3MTgwMDAwMDBa
Fw0yODAxMDQyMzU5NTlaMB4xHDAaBgNVBAMME2R3bXcyQGluZnJhZGVhZC5vcmcwggIiMA0GCSqG
SIb3DQEBAQUAA4ICDwAwggIKAoICAQDali7HveR1thexYXx/W7oMk/3Wpyppl62zJ8+RmTQH4yZe
YAS/SRV6zmfXlXaZsNOE6emg8WXLRS6BA70liot+u0O0oPnIvnx+CsMH0PD4tCKSCsdp+XphIJ2z
kC9S7/yHDYnqegqtw4smkqUqf0WX/ggH1Dckh0vHlpoS1OoxqUg+ocU6WCsnuz5q5rzFsHxhD1qG
pgFdZEk2/c//ZvUNi12vPWipk8TcJwHw9zoZ/ZrVNybpMCC0THsJ/UEVyuyszPtNYeYZAhOJ41va
v1RhZJzYan4a1gU0kKBPQklcpQEhq48woEu15isvwWh9/+5jjh0L+YNaN0I//nHSp6U9COUG9Z0c
vnO8FM6PTqsnSbcc0j+GchwOHRC7aP2t5v2stVx3KbptaYEzi4MQHxm/0+HQpMEVLLUiizJqS4PW
PU6zfQTOMZ9uLQRRci+c5xhtMEBszlQDOvEQcyEG+hc++fH47K+MmZz21bFNfoBxLP6bjR6xtPXt
REF5lLXxp+CJ6KKSblPKeVRg/UtyJHeFKAZXO8Zeco7TZUMVHmK0ZZ1EpnZbnAhKE19Z+FJrQPQr
lR0gO3lBzuyPPArVhvWxjlO7S4DmaEhLzarWi/ze7EGwWSuI2eEa/8zU0INUsGI4ywe7vepQz7Iq
aAovAX0d+f1YjbmCVsAwjhLmveFjNwIDAQABo4IB9zCCAfMwHwYDVR0jBBgwFoAU95uiTtOXxfQ0
D0MOgYXOkZMyr/kwHQYDVR0OBBYEFFxiGptwbOfWOtMk5loHw7uqWUOnMDAGA1UdEQQpMCeBE2R3
bXcyQGluZnJhZGVhZC5vcmeBEGRhdmlkQHdvb2Rob3Uuc2UwFAYDVR0gBA0wCzAJBgdngQwBBQEC
MA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwgakGA1UdHwSB
oTCBnjBNoEugSYZHaHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01J
TUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwTaBLoEmGR2h0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNv
bS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNBNDA5NlNIQTM4NDIwMjRDQTEuY3JsMIGNBggrBgEF
BQcBAQSBgDB+MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wVgYIKwYBBQUH
MAKGSmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRHMlNNSU1FUlNB
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
xemZTEtp3M2wZIVEHKFuOuMAAAAAAAA=


--=-AODIAK3RRiR3rrOaNi6N--
