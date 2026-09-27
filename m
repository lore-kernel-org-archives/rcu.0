Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A72411F9F;
	Sun, 27 Sep 2026 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526142; cv=none; b=Ztn2kLZ7rZv51wFHvxFjyd/m79EJsZWPqtZCITv9DzSIsuSiE2cI4NSAwKexvqIfAifCkFCYqjAmXUeam7oMxrwvoNQZtOSvlPOTcBXMc68NFY2QzVsM9K6MNRqDnlpKtH2RkU2r25TAy7btA+NRHhdl3yqmRePBQ9cIteJlx/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526142; c=relaxed/simple;
	bh=mYjtocGIr6mRHOHACD5LboCUU/wUtKKnbhn/N+HL7Eg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JoxwduxGuztc6ddfPlmxQoRINvnSMVFI3uxRipYMdf3u7C5fqW8uONX/BtMl4Z0rNoccnU24FuhHMs+ulro45GJbGFv9UrUTPzRwTEGeHA84pbOXzef/EkcQaAatAxtJZ9q48rOhVlg8ID2rc69XNU0PnVC5QTW2LqWjv3lmEVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=OfBuSuw6; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=jTrYsPLk; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="OfBuSuw6";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="jTrYsPLk"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790526124; bh=IGrpbAB8cYmQkrcuUIPiUPl
	RWvMZ+MWe1GnCV4POUrQ=; b=OfBuSuw6xoroUeiEesHXSQpsBrx1Z5ibmcrq49azxTnqRrFPsb
	JKKJlaI2uxLpFsPdPlq0ibdADNdcsnjo+kpyl8lCLMOVFGQA7yPQVfQl9/k8OQTMJ68BtnGbUiQ
	vSEipTwe74xIJcEjNcuC7ExIeFjB8qvdtxyqS30DAC4P8YAG4L9j40LpXr0ubeyZB9nC2FoPe98
	MJ/kjA2NBe8242mDCMw+/djjVJimGQF0OKpqgWBSqVM3RRybO1ncr5xQur1t7SbYF2p3jYuemMT
	2lmlQoPTsJRRDqhFoJvNajI07vvZEqFtl1uwgi0sjzY1CiV7bV/f9MkwV3L9sVJ684Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790526124; bh=IGrpbAB8cYmQkrcuUIPiUPl
	RWvMZ+MWe1GnCV4POUrQ=; b=jTrYsPLk3LrH0M9uGrTkCvHoBkX0ZYRB1IgAfbYkJjT3bKAcaC
	hGAlnpfWFqLwzW0hYogADoUnTvYPcmSbIrAA==;
Date: Sun, 27 Sep 2026 17:22:03 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun@kernel.org>
CC: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [PATCH hazptr 0/4] Hazard pointer updates
In-Reply-To: <c60567de-6583-47d3-a540-a7622855ccf0@efficios.com>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com> <arlBDX_907OBM5WY@MacBook-0RXW5> <c60567de-6583-47d3-a540-a7622855ccf0@efficios.com>
Message-ID: <3004FBCA-D11E-4DF3-A932-3F6036DF55A1@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 27 September 2026 17:20:36 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-27 12:15, Boqun Feng wrote:
>> On Sun, Sep 27, 2026 at 11:51:27AM -0400, Mathieu Desnoyers wrote:
>>> Hi Paul,
>>> 
>>> This series applies on top of "hazptr: handle NULL address in
>>> hazptr_detach" you have in your rcu dev tree.
>>> 
>>> This first patch addresses a race identified by Boqun Feng in the
>>> two-phase wildcard scheme.
>>> 
>> 
>> Thank you! That looks good from a quick look. I will give a deep look
>> later on (I was traveling).
>> 
>> For the following versions/patches, could you also Cc Kuwu Chan and
>> Liang Wang (Cced) ? They are helping on the scan thread and lockdep
>> integration, so it'll be good to keep them in the loop. Thank you!
>
>Noted, I've added them to my patch commit messages, so they should
>be there for the next round.
>

Maybe my tests could help you? Sorry to impede but the things I sent may
need a but if discussi9n around it

>> 
>>> Patches 2-3 are prerequisites for using ptr_eq() in the 4th patch.
>>> Those were discussed at length in a prior version of hazard pointer
>>> patches.
>>> 
>>> Patch 4 introduces a "try acquire" helper to allow the fast path
>>> to not rely on wildcards, while keeping the wildcard forward
>>> progress guarantees in the acquire slow path, used on fast path
>>> failure.
>>> 
>> 
>> Nice! I want to point out that later on if the reader can handle the
>> race with the updater (i.e. the readers don't need the progress
>> guarantees from hazptr, then we can expose a hazptr_try_acquire() for
>> exactly that). Although I do have some design trade-off questions for
>> patch 4.
>
>Sure, if you have a use-case in mind I'm interested to hear about it!
>
>Thanks,
>
>Mathieu
>
>> 
>> Regards,
>> Boqun
>> 
>>> Thanks,
>>> 
>>> Mathieu
>>> 
>>> Mathieu Desnoyers (4):
>>>    hazptr: Fix two-phase hazptr_synchronize race with detach
>>>    compiler.h: Introduce ptr_eq() to preserve address dependency
>>>    Documentation: RCU: Refer to ptr_eq()
>>>    hazptr: Introduce "try acquire" fast path, fallback to overflow list
>>> 
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun@kernel.org>
>>> Cc: Bradley Morgan <brads@mainlining.org>
>>> Cc: Gary Guo <gary@garyguo.net>
>>> Cc: <rcu@vger.kernel.org>
>>> Cc: <lkmm@lists.linux.dev>
>>> 
>>>   Documentation/RCU/rcu_dereference.rst |  38 +++++++-
>>>   include/linux/compiler.h              |  63 ++++++++++++
>>>   include/linux/hazptr.h                |  47 +++++----
>>>   kernel/hazptr.c                       | 135
>+++++++++++++++-----------
>>>   4 files changed, 203 insertions(+), 80 deletions(-)
>>> 
>>> -- 
>>> 2.43.0
>>> 
>
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
