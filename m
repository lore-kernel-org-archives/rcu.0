Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105966;
	b=TEpy0M45t56JIZARUYgHXWbqW8Kn0TOJDceo7GjB0fMAUXMNL9F6Iv6y61q0+8fvX1D2
	 JyJ80bSTo8u+Bho6XafaauOv7J3TiYrFzWs9VTbR+Jjm98/x4R780pGjjJCe4WxitZG9+
	 xO63m63wfxlpUPZ7xXUAYPkazyOPt5DP6J6ZPcVns30iAWCTE589hwT1qpewldt8u0Sj4
	 pyomwTTdpFxOd1CsfGAPKvUCTrg/ZYPk/kJ3UzzrRgfWDvu/mGmjcublGl+73Drtzl0dY
	 F6fue/YPCowHaENpmX6zp1AaNI0uh/H+mdgBP+IWcGle5RRwCPt4pnKkUkBUJ1vJh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105966;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=rF+a08Lsku2sRPHUdkTK839lgFmJP9xDh/1R1mglwvU=;
	b=Cq5Yomp4nz+/vBVcl/Klcppbek3ZDiChwRT9k03JprfIlcjYz9Q89loRamsvIc4zueNN
	 L4XM09GtKxazXjzyNyu+FvpCTwl+PfNpfGYrhB93WAipJgk+6XFzggOVyzaQfEaHah3f7
	 hLEvM9jo72lxNSrVRMVauJp26cjmsmDXqYLzfUTg7dM3Ex+0ZOxYECMLIveXMSkNgraQU
	 EDx8L+76mpgiGMC8+i7eRupiNLVVrtnOWMnhoBCbBUc6p/ONsg+9bA4EL696bxqR4I8SJ
	 rp5l4x2apce0AeunjdHp4FyiROQWJseITeYpewvobHKqSl8N8CxV8Epe1ehUzBMPIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rn2OkQcs;
	arc=none smtp.remote-ip=14.137.139.54
Received: from framsgout02.his.huawei.com (framsgout02.his.huawei.com [14.137.139.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D23606A31B;
	Tue, 27 Oct 2026 12:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7D23606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=rn2OkQcs
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rF+a08Lsku2sRPHUdkTK839lgFmJP9xDh/1R1mglwvU=;
	b=rn2OkQcs9y8sJqgPBxCCEJiRagpb/zg7BoYc0KELGsnzCf0lV1r5lB25Lzo4xwVJTgdahl8Nm
	WpYFhFcpmtU/ftBAuc97R/mOmJbgy28buxWZCn+q+Z5MXuPmaKliiMoAYrrzJtVzfc44h3uSXnj
	ecf+SkPnxj5H/AtqB/CReX4=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by framsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jDVtk136PzLlSd;
	Tue, 27 Oct 2026 20:59:10 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 750CD40584;
	Tue, 27 Oct 2026 20:59:16 +0800 (CST)
Received: from M2403003457HW (10.224.107.248) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 27 Oct 2026 13:59:16 +0100
From: Kai Ma <kai.ma1@huawei.com>
To: <paulmck@kernel.org>
CC: Kai Ma <kai.ma1@huawei.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, Bradley Morgan <brads@mainlining.org>, Gary Guo
	<gary@garyguo.net>, <rcu@vger.kernel.org>, <lkmm@lists.linux.dev>, "Lian
 Wang" <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v3 0/4] Hazard pointer updates
In-Reply-To: <e3b1c73d-8248-4644-80e7-a0640538fde6@paulmck-laptop>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
	<2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop>
	<87cxsw4qnl.fsf@huawei.com>
	<e3b1c73d-8248-4644-80e7-a0640538fde6@paulmck-laptop>
Date: Tue, 27 Oct 2026 13:59:13 +0100
Message-ID: <87zevz2tb2.fsf@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: frapema500003.china.huawei.com (7.182.19.114) To
 frapema500004.china.huawei.com (7.182.19.21)

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Mon, Oct 26, 2026 at 01:01:18PM +0100, Kai Ma wrote:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> 
>> > On Sun, Oct 11, 2026 at 03:48:46PM -0400, Mathieu Desnoyers wrote:
>> >> Hi Paul,
>> >> 
>> >> This series applies on top of "hazptr: handle NULL address in
>> >> hazptr_detach" you have in your rcu dev tree.
>> >> 
>> >> This first patch addresses a race identified by Boqun Feng in the
>> >> two-phase wildcard scheme. (no change since the last series)
>> >> 
>> >> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>> >> Those were discussed at length in a prior version of hazard pointer
>> >> patches.
>> >> 
>> >> Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
>> >> the feedback received from Boqun and Gary.
>> >> 
>> >> Patch 4 introduces a "try acquire" helper to allow the fast path
>> >> to not rely on wildcards, while keeping the wildcard forward
>> >> progress guarantees in the acquire slow path, used on fast path
>> >> failure.
>> >
>> > I have pulled this in for additional review and testing, thank you!
>> > (With Bradley's Reviewed-by on 4/4.)  Still subject to rebase, which means
>> > that I can easily replace it with an updated series from you, if you
>> > wish.
>> 
>> Hi Paul, Mathieu, and everyone,
>> 
>> I've been following the hazard pointer work and have done some testing
>> on earlier versions. I'd be interested in getting more involved,
>> particularly in concurrency correctness testing.
>> 
>> If there are WIP patches or early design discussions where additional
>> review or testing would be useful, could you please CC me? I'd
>> appreciate the opportunity to get involved earlier and help identify
>> potential concurrency issues.
>
> The current stack is in my -rcu tree [1] at v7.3-rc1..c3aea7747975,
> with these patches on top:
>
> 5df49d76ff3a3 hazptr: Fix two-phase hazptr_synchronize race with detach
> b41c6c2d4a33f ptr_eq.h: Introduce ptr_eq() to preserve address dependency
> 97ff14db1c381 Documentation: RCU: Refer to ptr_eq()
> 451174c765179 hazptr: Introduce "try acquire" fast path, fallback to overflow list
> 633f91e3408cc hazptr: Record per-CPU slot owner after claiming the slot
>
> The biggest need is use cases, with the most likely ones being cases
> where per-CPU reference counts consume too much memory or a reference
> count is suffering from memory contention.  However, we are still finding
> critical bugs both in the mechanism and the torture tests, so as you say,
> review or testing is also very important.
>
> These patches CC the rcu@vger.kernel.org list, so the best way to get
> involved in the discussions is to join that list.
>
> And welcome aboard!!!

Thank you and also Bradley!

Kai

>
> 							Thanx, Paul
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>
>> Thanks,
>> Kai
>> 
>> > But in the meantime, some additional testing.  ;-)
>> >
>> > 							Thanx, Paul
>> >
>> >> Thanks,
>> >> 
>> >> Mathieu
>> >> 
>> >> Mathieu Desnoyers (4):
>> >>   hazptr: Fix two-phase hazptr_synchronize race with detach
>> >>   ptr_eq.h: Introduce ptr_eq() to preserve address dependency
>> >>   Documentation: RCU: Refer to ptr_eq()
>> >>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
>> >> 
>> >> Cc: Paul E. McKenney <paulmck@kernel.org>
>> >> Cc: Boqun Feng <boqun@kernel.org>
>> >> Cc: Bradley Morgan <brads@mainlining.org>
>> >> Cc: Gary Guo <gary@garyguo.net>
>> >> Cc: <rcu@vger.kernel.org>
>> >> Cc: <lkmm@lists.linux.dev>
>> >> Cc: Lian Wang <lianux.mm@gmail.com>
>> >> Cc: Kunwu Chan <kunwu.chan@gmail.com>
>> >> 
>> >>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>> >>  arch/x86/include/asm/ptr_eq.h         |  16 +++
>> >>  include/asm-generic/Kbuild            |   1 +
>> >>  include/asm-generic/ptr_eq.h          |  16 +++
>> >>  include/linux/hazptr.h                |  48 +++++----
>> >>  include/linux/ptr_eq.h                |  63 ++++++++++++
>> >>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
>> >>  7 files changed, 237 insertions(+), 80 deletions(-)
>> >>  create mode 100644 arch/x86/include/asm/ptr_eq.h
>> >>  create mode 100644 include/asm-generic/ptr_eq.h
>> >>  create mode 100644 include/linux/ptr_eq.h
>> >> 
>> >> -- 
>> >> 2.43.0
>> >> 
