Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486A436BFC;
	Sun, 11 Oct 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791749454; cv=none; b=Kc70mq6vtYeGIC6ePRzdNLnQ1Rsy7zpqZrMkI2PE6Rvu1RG4E9oXPV63oEzoYoByoxYknumvm9WvJruT/BJtBPQijHcTxMkEOIx+TKtbTzMb+fv7scYH3NZNA/LhhL75OLPn8un0PNCqBm1VmMkKNVgPN/2CFkEBcgK/hFAwQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791749454; c=relaxed/simple;
	bh=3nNhVlzFDN1C3Yi3vhGZPZz/3k1fznu0p46d5AnIJHg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=scOeu2aDDczctCiaZ2eoXQgYmDPsWpHVSIhIaBOrLy4bDkQ+Yea+6EJDJ9aY4F86CumiPb9MImwYLVBJNvZ/LV0nNdx6FKXni8Fp6t9Lq8BudbZAbD4NeTRnJGrrkM+ASGsYCPR6J0Y7a7e7uAVpS3RfT2uTPRztle1TgR1iix0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=dnrH/qKz; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=8M4PdR81; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="dnrH/qKz";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="8M4PdR81"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791749440; bh=y7FAwey3FeTopMC7Z8GaStR
	6H8VV6XeW1NOjVH3Et/0=; b=dnrH/qKzfGXJ/BiM4+NLa3CxWWLwvmM7G/WnUCzyTmiXyKEiV7
	1TqELpyr/VoDBNXYYNfamvtvZsMetXcEBWqJAaR0DybSZuYU0ssCeGjYiDF2E6SNaSC1wFCLu8Q
	DLFqOG9zqzYQUeLORGmWEBMX7MCR6AZ5A1fSIPEL4mMaZk1efIrskDNYanYVVkRVKZH0dSN8ynl
	GIohzRFC7QLoQG7bIXfx9NQUGBK0VPUygNUfmEm1YB0ukxEBSOjTR8eNfSXgCfSyYjPRC1Ud0tw
	1h/0MO3FVYRY72JpFTtftRzW6rA21hoz3Ltvz8jNSmqwIkk9yorszlWgVrwTGOmXpOg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791749440; bh=y7FAwey3FeTopMC7Z8GaStR
	6H8VV6XeW1NOjVH3Et/0=; b=8M4PdR814d2tbEnwVk+XYaTxexwo+8MQ/inp4jUO1KkCAAQNlZ
	nb2gfzTB6x0JBTt8mxEwDFYaF7zsqFUuyPAg==;
Date: Sun, 11 Oct 2026 21:10:39 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev,
 Lian Wang <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_hazptr_v3_4/4=5D_hazptr=3A_Introduce_=22tr?=
 =?US-ASCII?Q?y_acquire=22_fast_path=2C_fallback_to_overflow_list?=
In-Reply-To: <97f91313-e629-40c0-b3ff-f23c235a8ad8@efficios.com>
References: <20261011194902.97364-1-mathieu.desnoyers@efficios.com> <20261011194902.97364-5-mathieu.desnoyers@efficios.com> <E99B2D1B-6D27-4ED7-A7A4-083DB5427925@mainlining.org> <97f91313-e629-40c0-b3ff-f23c235a8ad8@efficios.com>
Message-ID: <72DC7FE8-1933-42D2-9B2A-445073BE45A6@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 October 2026 21:06:24 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-10-11 15:59, Bradley Morgan wrote:
>> On 11 October 2026 20:48:50 BST, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>> Introduce a "try acquire" hazard pointer fast path, which performs an
>>> early load of the address to store it into the hazard pointer slot, and
>>> then re-loads that address after a barrier to check whether it has
>>> changed meanwhile.
>>> 
>>> On comparison failure, rather than re-try, guarantee forward progress
>by
>>> falling back to the __hazptr_acquire slow path on failure.
>>> 
>>> The acquire slow path attempts a try-acquire for any available per-CPU
>>> slot. If that fails, it chains the backup slot into the overflow list,
>>> therefore guaranteeing forward progress for both hazard pointer
>>> read-side and synchronize:
>>> 
>>> - Readers set the wildcard, and then proceed to set the more
>>>   specific address to replace the wildcard.
>>> 
>>> - One synchronize alternates between two overflow list periods,
>>>   scanning each one while readers are added to the other period,
>>>   thus preventing a steady flow of readers from preventing
>>>   synchronize forward progress.
>>> 
>>> With this change, the scan on per-CPU slots don't need to expect a
>>> wildcard anymore, because none can be produced by readers. Wildcards
>are
>>> only expected within overflow lists.
>>> 
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Suggested-by: Gary Guo <gary@garyguo.net>
>>> Link:
>https://lore.kernel.org/lkmm/DLK9MW1N86KD.2GRWUAD2NX4FU@garyguo.net/
>>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> 
>> Hi, my R-B still stands from
>> 
>>
>https://lore.kernel.org/all/C53DEBF5-555F-44A8-A11C-A15C83AAD341@mainlining.org/
>> 
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>
>Sorry, I forgot to add it to my commit message. I'll add it to the next
>round (if there is one), else hopefully Paul can add the R-B tag if he
>picks up this series.
>
>Thanks!

Thanks, this thing happens.. :)

>
>Mathieu
>
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
