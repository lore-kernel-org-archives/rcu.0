Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=14.137.139.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016085;
	b=pdlpOB7Nt0OzC/MCOoZVSIeS0I5Z6TacPORXheA/DuXJaGg9j4fS+xMVJx5MmZv7O/+9
	 VmzK9iVv9IL8LqhMPaqrnPkKd03Zjt8BWoxMcYP7eT1UyAPq/rJKq9iAnd1n3mBRs7rnL
	 Opa27XTlGx0voRIElvkEgemmz3wkU+Y1o+l7NnKEQYduvhJ/DlRh/a6rtGsFB8thyy4VW
	 I5pbknmMZc02N1fELKyL7zcbskk8dJxODUz3cs8dc5SzRokaPmP++EcxJ8LHGpbLdU1eY
	 dmBcXIQJL9KGSoUjGrEgP+kTcOYWXVF+QBvPzZMx5cniV4qGjeQ7z00GWe6SH4RXpUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016085;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=9ecD0lIw5S2Wwx8/HWKybPtToBKIEJwvPma+Hr4KRfk=;
	b=GkiJyEOyR3EBB4n+Q42fKE2rkJnnkorNAkDiP1Msf5R+aI2Ltx62NFl4mRtH2rGBM4gm
	 9hgqZYgBNXU2/9O4aa68auI9NqABzmSH7w9VHvsL1/uWY02JfbFRSJasJmIAHN3W3Orav
	 dVMtRmMtfFPw442PuXpR0VEZefSiwVImtHqzRWi1IZBmjITbmytCi3tekaxGWVIBQw8Cn
	 0+WCkniiAYa/EaBsHZkl9HvclSPHDTOdQ4WjrNpP2ENAxah8y8qcowoUyY1rZlNrEMVpj
	 MDc6TQoxvza+i5OYcitnvuFPDhxLZdDBurshzyxb1/7TWMjT98rFr+6ccHu1W7rRGHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BgG15WAl;
	arc=none smtp.remote-ip=14.137.139.52
Received: from framsgout01.his.huawei.com (framsgout01.his.huawei.com [14.137.139.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E760A2629;
	Mon, 26 Oct 2026 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 019E760A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=BgG15WAl
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9ecD0lIw5S2Wwx8/HWKybPtToBKIEJwvPma+Hr4KRfk=;
	b=BgG15WAliRz3Ine17uRm8Co86FujUmmEztKSEfBl2soUDwTMF8+DyduV+aGWbdW/J1m0EfOfz
	Qpt9vnFXFDTDdmv+RwLv4qDie/Ykc/ixVH+CiWM9Nlb5Q4JySS9BQf9nRadRxDNMQcdcSjkhs4S
	BRC8ov3SblpF0ZLcLJTv/VI=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by framsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jCsfL4N9bz14K1y;
	Mon, 26 Oct 2026 20:01:14 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E54F4058B;
	Mon, 26 Oct 2026 20:01:19 +0800 (CST)
Received: from M2403003457HW (10.224.107.168) by
 frapema500004.china.huawei.com (7.182.19.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 26 Oct 2026 13:01:18 +0100
From: Kai Ma <kai.ma1@huawei.com>
To: <paulmck@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<linux-kernel@vger.kernel.org>, Boqun Feng <boqun@kernel.org>, "Bradley
 Morgan" <brads@mainlining.org>, Gary Guo <gary@garyguo.net>,
	<rcu@vger.kernel.org>, <lkmm@lists.linux.dev>, Lian Wang
	<lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v3 0/4] Hazard pointer updates
In-Reply-To: <2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com>
	<2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop>
Date: Mon, 26 Oct 2026 13:01:18 +0100
Message-ID: <87cxsw4qnl.fsf@huawei.com>
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
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500004.china.huawei.com (7.182.19.21)

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Sun, Oct 11, 2026 at 03:48:46PM -0400, Mathieu Desnoyers wrote:
>> Hi Paul,
>> 
>> This series applies on top of "hazptr: handle NULL address in
>> hazptr_detach" you have in your rcu dev tree.
>> 
>> This first patch addresses a race identified by Boqun Feng in the
>> two-phase wildcard scheme. (no change since the last series)
>> 
>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>> Those were discussed at length in a prior version of hazard pointer
>> patches.
>> 
>> Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
>> the feedback received from Boqun and Gary.
>> 
>> Patch 4 introduces a "try acquire" helper to allow the fast path
>> to not rely on wildcards, while keeping the wildcard forward
>> progress guarantees in the acquire slow path, used on fast path
>> failure.
>
> I have pulled this in for additional review and testing, thank you!
> (With Bradley's Reviewed-by on 4/4.)  Still subject to rebase, which means
> that I can easily replace it with an updated series from you, if you
> wish.

Hi Paul, Mathieu, and everyone,

I've been following the hazard pointer work and have done some testing
on earlier versions. I'd be interested in getting more involved,
particularly in concurrency correctness testing.

If there are WIP patches or early design discussions where additional
review or testing would be useful, could you please CC me? I'd
appreciate the opportunity to get involved earlier and help identify
potential concurrency issues.

Thanks,
Kai

> But in the meantime, some additional testing.  ;-)
>
> 							Thanx, Paul
>
>> Thanks,
>> 
>> Mathieu
>> 
>> Mathieu Desnoyers (4):
>>   hazptr: Fix two-phase hazptr_synchronize race with detach
>>   ptr_eq.h: Introduce ptr_eq() to preserve address dependency
>>   Documentation: RCU: Refer to ptr_eq()
>>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
>> 
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: Boqun Feng <boqun@kernel.org>
>> Cc: Bradley Morgan <brads@mainlining.org>
>> Cc: Gary Guo <gary@garyguo.net>
>> Cc: <rcu@vger.kernel.org>
>> Cc: <lkmm@lists.linux.dev>
>> Cc: Lian Wang <lianux.mm@gmail.com>
>> Cc: Kunwu Chan <kunwu.chan@gmail.com>
>> 
>>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>>  arch/x86/include/asm/ptr_eq.h         |  16 +++
>>  include/asm-generic/Kbuild            |   1 +
>>  include/asm-generic/ptr_eq.h          |  16 +++
>>  include/linux/hazptr.h                |  48 +++++----
>>  include/linux/ptr_eq.h                |  63 ++++++++++++
>>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
>>  7 files changed, 237 insertions(+), 80 deletions(-)
>>  create mode 100644 arch/x86/include/asm/ptr_eq.h
>>  create mode 100644 include/asm-generic/ptr_eq.h
>>  create mode 100644 include/linux/ptr_eq.h
>> 
>> -- 
>> 2.43.0
>> 

-- 
Kai Ma
