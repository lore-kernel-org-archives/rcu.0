Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016784;
	b=w1dykw5kbPmQiYWipeFaZFUanzlZxgPgbCwLf/P4KxYfFba6JCGAGH1CuH/XQCNlhLkm
	 cGlkUsqq1nrwWwRJZEzR+FvzJykxAw7FJad1hhTwRR/f74/nKCt7s3oLB151FfDKin3a/
	 /irD433lC4rJMJ/P2J2OxNVh1Anx0Z3IMAmcSpXTaYyAY2yAEWS0Hu6BXvEurfSC3wR3M
	 Ia18QTOy0SDpKN7ppBK8NSUdAwSz+8wreSxToappLmfC1Mu1bY4AxOCaBtZcxrFvGBXf0
	 irBqT79lelvMVAPREPes5ENaZ8+Ao2ut7F3OtdzqhtaeXe2is1Tt5v721cNt5utlp6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016784;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CF2MDwqlAkaO/EWxSuxXkXx6KM2nWeZeopTX1lZlDgA=;
	b=CJ+KHT0AZqTBuWyKIKRtK9uFmzi1xqAyQPXY39x/GQAt5jD3KAAARDVMGDkRU+tLiVTo
	 ZMyrqtA0yzrRmTaaEqTZYfmrMwcZ34dqyH1a50YoqLWUxsTjNrfr+Ec0UsjIrlum35hda
	 OOKh6QczSCl7+wc2taHvZX2Yd5fWT9YfL2EhHhakdEhFa9PO8Y85SLFR2a/kNAlwGX2la
	 x3IJQksxaEKc/7tNLyOOIbPqhoQyZS9eufmkOne/FbId6/LClEiEuzus5842CAGdQ9StD
	 UColG04rE0og6cxDDC+fXNSVd4j6bBmgKoLToCLYcwPdNJph1fUB81bzHLMMEt8DKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=LBNQXKGN;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ZjeGTjA0;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12272606A31A;
	Mon, 26 Oct 2026 12:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12272606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=LBNQXKGN;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=ZjeGTjA0
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793016700; bh=CF2MDwqlAkaO/EWxSuxXkXx
	6KM2nWeZeopTX1lZlDgA=; b=LBNQXKGNnBtOra4yyvzCwqsu1fiSj23F0390nED6If9CTaLkgk
	WDkcT1dYuQnxULVksvGuczIpRADXYSc1nfU8apcaaa5A+7rrhb4PeSfGvHu6l3ZLX5M8NWQwrc/
	W7oV8IGo7krlPmU9oTajQ7/clAZsMvhac1luKU1rRFy64I/v1kJWgjHJeQlFUWkvqVNQKyHjfhf
	p3OiPvwpDPPSZTC7bVskClAIzkEkq+Wx6qyfdb4eeYuEHihLw1cIuqhmDk68rxpr+3655xlVfOh
	iw8i6D5iooL10tjnAjmmHtpv9qlA7ChFs6gAalls1YUU4LzFRdTttKF72gaKeSIv/Sg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793016700; bh=CF2MDwqlAkaO/EWxSuxXkXx
	6KM2nWeZeopTX1lZlDgA=; b=ZjeGTjA0NTEvxc1mUPOMfRSZIkijYuq/EIgnXRATtTNgSkz11E
	03IGd5jCCLkqcz6d2Trpcq1be17acDO/t+Cw==;
Date: Mon, 26 Oct 2026 12:11:40 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Kai Ma <kai.ma1@huawei.com>, paulmck@kernel.org
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr v3 0/4] Hazard pointer updates
In-Reply-To: <87cxsw4qnl.fsf@huawei.com>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com> <2cf703a6-7828-4735-98af-1a6fe93abd3f@paulmck-laptop> <87cxsw4qnl.fsf@huawei.com>
Message-ID: <AA9A7911-ED16-4B2B-8C73-D6353D95A817@mainlining.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 26 October 2026 12:01:18 GMT, Kai Ma <kai.ma1@huawei.com> wrote:
>"Paul E. McKenney" <paulmck@kernel.org> writes:
>
>> On Sun, Oct 11, 2026 at 03:48:46PM -0400, Mathieu Desnoyers wrote:
>>> Hi Paul,
>>> 
>>> This series applies on top of "hazptr: handle NULL address in
>>> hazptr_detach" you have in your rcu dev tree.
>>> 
>>> This first patch addresses a race identified by Boqun Feng in the
>>> two-phase wildcard scheme. (no change since the last series)
>>> 
>>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>>> Those were discussed at length in a prior version of hazard pointer
>>> patches.
>>> 
>>> Since the last series, I have renamed ptreq.h to ptr_eq.h, addressing
>>> the feedback received from Boqun and Gary.
>>> 
>>> Patch 4 introduces a "try acquire" helper to allow the fast path
>>> to not rely on wildcards, while keeping the wildcard forward
>>> progress guarantees in the acquire slow path, used on fast path
>>> failure.
>>
>> I have pulled this in for additional review and testing, thank you!
>> (With Bradley's Reviewed-by on 4/4.)  Still subject to rebase, which
>means
>> that I can easily replace it with an updated series from you, if you
>> wish.
>
>Hi Paul, Mathieu, and everyone,
>
>I've been following the hazard pointer work and have done some testing
>on earlier versions. I'd be interested in getting more involved,
>particularly in concurrency correctness testing.
>
>If there are WIP patches or early design discussions where additional
>review or testing would be useful, could you please CC me? I'd
>appreciate the opportunity to get involved earlier and help identify
>potential concurrency issues.

Thanks for taking this job up, what you could do, is make Linus happy, if
that makes sense.

https://lore.kernel.org/all/CAHk-=wjyniJy-CX1muCrsZp-i-sLGRYeRYEPN7sw9orRZUCwag@mail.gmail.com/

>
>Thanks,
>Kai
>
>> But in the meantime, some additional testing.  ;-)
>>
>> 							Thanx, Paul
>>
>>> Thanks,
>>> 
>>> Mathieu
>>> 
>>> Mathieu Desnoyers (4):
>>>   hazptr: Fix two-phase hazptr_synchronize race with detach
>>>   ptr_eq.h: Introduce ptr_eq() to preserve address dependency
>>>   Documentation: RCU: Refer to ptr_eq()
>>>   hazptr: Introduce "try acquire" fast path, fallback to overflow list
>>> 
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun@kernel.org>
>>> Cc: Bradley Morgan <brads@mainlining.org>
>>> Cc: Gary Guo <gary@garyguo.net>
>>> Cc: <rcu@vger.kernel.org>
>>> Cc: <lkmm@lists.linux.dev>
>>> Cc: Lian Wang <lianux.mm@gmail.com>
>>> Cc: Kunwu Chan <kunwu.chan@gmail.com>
>>> 
>>>  Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>>>  arch/x86/include/asm/ptr_eq.h         |  16 +++
>>>  include/asm-generic/Kbuild            |   1 +
>>>  include/asm-generic/ptr_eq.h          |  16 +++
>>>  include/linux/hazptr.h                |  48 +++++----
>>>  include/linux/ptr_eq.h                |  63 ++++++++++++
>>>  kernel/hazptr.c                       | 135 +++++++++++++++-----------
>>>  7 files changed, 237 insertions(+), 80 deletions(-)
>>>  create mode 100644 arch/x86/include/asm/ptr_eq.h
>>>  create mode 100644 include/asm-generic/ptr_eq.h
>>>  create mode 100644 include/linux/ptr_eq.h
>>> 
>>> -- 
>>> 2.43.0
>>> 
>
>

--- Thanks!
