Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98147F775;
	Thu,  6 Aug 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053788; cv=none; b=BvQ3PfWPobHUrCZcn90nDMe5JLC682norkpUgUzrOtuGvTjWsseXkOi0OVrs1lYWoMkl/vXO4bOXPq37y0ZqcgT4S8zyP4W9EfN7FzjWalnE3VzCCIMnQVwOLwqGXwupdBPvRwnHLk1iU3Xt7pR8AsIrw5j4m9fk2PJuxS1XqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053788; c=relaxed/simple;
	bh=qMDIlJr1e0ixn1fw/FwSjcSGy/ZQO65RjbZkAUo8SYs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hDYdVkt7PdlvTAXCiTGMa08YNR6nqm6+QhVXU2mhKM/cMig+uHv9OhAbrL2k88VUTFEtpbh/xlyVMyNdKv/RRBLs4q7RpdlT5d1R+Du2VSulUIHSj00XDUKBMfynbARCLCGvZqYlu0t+IcMwfvwIiXjuqlaRpH/wNJQQxf9CqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XQUzQ8OW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQUzQ8OW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CXwZ9ZErHq0hyR4L2/6BQUEAEmSFDMIkY4wTMow8yZA=; b=XQUzQ8OWK756PN/XmLn94/M79z
	54D3+N6uVKe+HWyMjrV3w8MOsJUCm614NoYcLScKslMJ5L89Czf6XYIROwPbln3ItABQ0TkszjPyO
	YQuf0Opv7dMb1a4bVx1fzxFRvzw0HuH6LoYnPKZVEzw9ygrJPJYqZ4dV5ysOX76BS/piRBN7PYqSd
	caAWcA5P1OfRPhFF6x5lJD7eCdme+r0FGJmk1/Gz5ZbVIKDVm48wjqMxI6tuyDM4Jeyg0WvzQ12Ug
	T4Bbiy4fLhKE6sXKV1/dhFFHnRB/3qap3lsncWk8ht0wbBm/C6B44VIu3LHnorN534DCxIPDDEAYV
	i0B4sjUQ==;
Received: from p578b9deb.dip0.t-ipconnect.de ([87.139.157.235] helo=ehlo.thunderbird.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1ws6B1-0000000BuDE-2pT4;
	Thu, 06 Aug 2026 22:02:59 +0000
Date: Fri, 07 Aug 2026 00:02:57 +0200
From: David Woodhouse <dwmw2@infradead.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Sean Christopherson <seanjc@google.com>, Boqun Feng <boqun@kernel.org>,
 kvm@vger.kernel.org, rcu@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_3/7=5D_KVM=3A_pfncache=3A_Us?=
 =?US-ASCII?Q?e_RCU_for_readers_instead_of_a_rwlock?=
User-Agent: K-9 Mail for Android
In-Reply-To: <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk> <20260805195528.3853473-4-dwmw@amazon.co.uk> <20260805203608.D3CA61F000E9@smtp.kernel.org> <anS8C4Cxqy6ehCo3@google.com> <bbb2ad42d2ee3b2c20cfc31c3d58a9fecebb77e4.camel@amazon.co.uk> <7dbe2929b5e7be6a2b9de860649598403d52f9a9.camel@infradead.org> <31e9a043-7d4b-40f3-8fdb-62701b730c5d@paulmck-laptop>
Message-ID: <9E3BF4F1-EB01-48DC-9DC3-6780EDE06CC2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 6 August 2026 23:52:06 CEST, "Paul E=2E McKenney" <paulmck@kernel=2Eorg>=
 wrote:
>On Thu, Aug 06, 2026 at 10:38:56PM +0200, David Woodhouse wrote:
>> On Thu, 2026-08-06 at 19:59 +0200, Woodhouse, David wrote:
>> > On Thu, 2026-08-06 at 09:53 -0700, Sean Christopherson wrote:
>> > > On Wed, Aug 05, 2026, sashiko-bot@kernel=2Eorg=C2=A0wrote:
>> > > > Replace the per-cache rwlock with RCU for the read side=2E
>> > >=20
>> > > I don't hate the idea, but I am very against using RCU=2E=C2=A0 Unl=
ess it's "impossible",
>> > > e=2Eg=2E because synchronize_srcu() allocates memory and breaks OOM=
 kill, I would
>> > > strongly prefer to use SRCU, probably with a dedicated kvm->gpc_src=
u, so that
>> > > synchronization doesn't need to wait on all CPUs in the system=2E=
=C2=A0 The tail latencies
>> > > for synchronize_rcu() are horrendous, especially for many-CPU syste=
ms=2E=C2=A0 If it
>> > > were only mmu_notifiers that got hit, it miiiight be acceptable, bu=
t since this
>> > > will affect vCPU tasks in the refresh() path as well, normal RCU is=
 pretty much
>> > > a non-starter=2E
>> >=20
>> > Yeah, the refresh() path got pretty slow in my first attempt, before
>> > optimising that *not* to have a grace period if the memslot generatio=
n
>> > changed but the actual GPA=E2=86=92uHVA (and memslot) don't *change*=
=2E
>> >=20
>> > > Even SRCU could be problematic: if synchronize_srcu_expedited() is =
forced to wait,
>> > > the wait time can easily get to 20+ milliseconds, which again is a =
non-starter for
>> > > things like steal-time updates and nVMX pages=2E
>> >=20
>> > But we don't have to synchronize from the read side=2E The code path
>> > which will do so most often is gfn_to_pfn_cache_invalidate_start()=2E=
 And
>> > the refresh() path which is already the fallback slow path which can
>> > sleep=2E Although in my tree I've optimised that *not* to incur a gra=
ce
>> > period when it's avoidable, as noted above=2E
>> >=20
>> > I'm more concerned by the fact that srcu_gp_end() might have to
>> > *allocate*, while the OOM reaper path waits for it=2E I'll see how we=
 can
>> > deal with that=2E=2E=2E
>>=20
>> I think I need to invoke Paul et al for that one=2E=2E=2E
>>=20
>> Paul, Boqun, please could I trouble you to look at the top commit in
>> https://git=2Einfradead=2Eorg/?p=3Dusers/dwmw2/linux=2Egit;a=3Dshortlog=
;h=3Drefs/heads/xen-rcu-srcu
>>=20
>> The "gfn_to_pfn_cache" (GPC) here is for all extents and purposes a
>> TLB=2E It's caching the full two-stage translation through KVM memslots
>> which map a guest physical address to a userspace virtual address, and
>> then through the standard process page tables to a host physical
>> address=2E
>>=20
>> It is the second stage we are interested in here=2E Invalidation happen=
s
>> through an MMU notifier, which (after I obey Sean's request to switch
>> to SRCU) calls synchronize_srcu_expedited()=2E
>>=20
>> My problem:
>>=20
>>  1=2E The MMU notifier invalidation can be called from the OOM reaper
>>     path=2E In this case it MUST NOT sleep to allocate memory, or block
>>     on anything which does so=2E cf=2E
>>     https://lore=2Ekernel=2Eorg/all/787aa26cf62dfd361eea8ed19f384fc5178=
92501=2Ecamel@infradead=2Eorg/
>>=20
>>  2=2E srcu_gp_end() does so, through init_srcu_struct_nodes(), while
>>     synchronize_srcu_expedited() effectively waits for it =E2=80=94 pre=
cisely
>>     the thing we must not do=2E (Strictly, the waiter's completion is
>>     queued to the same workqueue on which process_srcu() could be
>>     blocked in init_srcu_struct_nodes(=E2=80=A6, GFP_KERNEL))=2E
>>=20
>> On a system with >=3D 128 CPUs it's actually OK because that allocation
>> path never happens; everything's allocated in advance ("rcu: srcu_init:
>> Setting srcu_struct sizes to big")=2E But on smaller systems I don't se=
e
>> that we have a way to ensure that things are safe=2E (I don't count
>> setting big_cpu_lim to zero!)
>>=20
>> Could we change that init_srcu_struct_nodes(=E2=80=A6, GFP_KERNEL) to a=
 non-
>> sleeping allocation? If the allocation fails, that isn't fatal, is it?
>> Or some other way to trigger the transition to big under controlled
>> circumstances in advance=2E=2E=2E?=20
>
>We could easily provide such an interface=2E  However, is there some
>check that would allow us to determine when it is OK to use GFP_KERNEL?
>If there was, we could replace that GFP_KERNEL with something like this:
>
>	sleeping_alloc_ok() ? GFP_KERNEL : GPF_HEY_YOU_TELL_ME
>
>My best guess for GPF_HEY_YOU_TELL_ME is GFP_NOWAIT=2E
>
>That way, you don't need another SRCU API to transition to big, and
>everything "just works"=2E
>
>What say you?

Thanks for the prompt answer!

It's a nice idea, but I'm not sure what we'd trigger on=2E In an earlier p=
atch in this same series I already ripped *out* the non_block_start() for t=
his OOM reaper path, because that would make it sad even about the non-allo=
cating sleep for the (S)RCU wait=2E The actual criterion is more subtle tha=
n that=2E

And anyway, the allocation isn't even running from that thread; it's on th=
e workqueue=2E

I think it has to be an API which lets us upgrade in advance=2E Or just ma=
ke it GFP_NOWAIT unconditionally? What's the failure mode if the allocation=
 fails? My unreliable AI friend told me it was harmless enough=2E=2E=2E but=
 I don't trust it much, which is why I reached out to my meat friend=2E=2E=
=2E

