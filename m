Received: from mail.kxxt.dev (mail.kxxt.dev [74.48.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD522C3268;
	Wed, 13 May 2026 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.48.220.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778679261; cv=none; b=g7466EuUNGr0MZCH+OjOn5yVQPRBrWwH0xvEORsXR/XLJ0FB5BRq2UmKWpmMkk0q0yZtFxci800f6iJ9YXACp2TTyCHfwpSo6ScQ8Mc4dVdjd3LZvP7dZtiAUqs3bPFYypmVllSQGO5BBw88WSEuwVQbEnm5CAAGhTTuebsYGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778679261; c=relaxed/simple;
	bh=KVaG1fmn58xgn7fD1gXleKQK+T+FAtX2PHxxsreF6fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1bqMyx4u73WXgTj+9PsnrQ3XhCVP0VnR4eqs0w8ji0wvrFIP2Ib4aveC15CiPGkR7975fUOcDH/cvn0yD6DbNNnmNi4gNLWdCdN9CwbugFXToEj6/2OLnogXKSBzxqOMACi8awFXwyANda2/bRNiKpRZemGgHI/8yORBO1vNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev; spf=pass smtp.mailfrom=kxxt.dev; dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b=cnDIdqmA; arc=none smtp.client-ip=74.48.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kxxt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kxxt.dev header.i=@kxxt.dev header.b="cnDIdqmA"
Message-ID: <1315d145-49ee-412f-ad91-0f6c61c4c2c9@kxxt.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kxxt.dev; s=mail;
	t=1778679251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=psldIh7n5nVm+Rtaa/u/V2mN+7zDFvNrqqhD8DETpec=;
	b=cnDIdqmAIHI6Z9i4z4Fzs2EgIEwvu2fhMHxSHYx+jsmh8WYew61/BNiSh0bx8nzbKaH+af
	zFhayDHFZ1xwBiOthGyJumxVqCqWydEyxYNF6q9l7ytT2Ox5SnHaiIhIQ89GBqO5zCbIbH
	tTYxOBSg9VU/hAcPpU3jnyl7QjNEVCE=
Date: Wed, 13 May 2026 21:34:01 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: linux-mm@kvack.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Amery Hung <ameryhung@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
 <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
Content-Language: en-US
From: Levi Zim <i@kxxt.dev>
In-Reply-To: <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/26 9:42 AM, Harry Yoo (Oracle) wrote:
> On Tue, May 12, 2026 at 09:46:33PM +0800, Levi Zim wrote:
>> On 5/12/26 8:25 PM, Harry Yoo (Oracle) wrote:
>>> Hello everybody. This is a follow-up discussion of
>>> "kmalloc_nolock() follow-ups, including kfree_rcu_nolock()" topic at
>>> LSFMMBPF 2026 last week. Unfortunately, many RCU folks were not there,
>>> but we can still discuss over email ;)
>>>
>>> The slides: https://docs.google.com/presentation/d/1kpaLd7D1dwRvIqRwQfSjJVVJL0CC2gwb-AV56yCMqXw/edit?usp=sharing
>>>
>>> I'm copying the slides here to make it easier to reply.
> 
> [...]
> 
>>> The end goal
>>> ============
>>>
>>> - Drop the BPF memory allocator
>>> - Avoid preallocation as much as possible in BPF
>>> - Use kmalloc_nolock() and kfree_{,rcu_}nolock() (and friends) instead
>>
>> By using kmalloc_nolock, a regression happens on architectures without HAVE_CMPXCHG_DOUBLE.
>> For reference, currently only x86, arm64, s390 and loongarch selects HAVE_CMPXCHG_DOUBLE
>>
>> For example, this has already caused bpf_task_storage_get with flag
>> BPF_LOCAL_STORAGE_GET_F_CREATE to always fail on riscv64 6.19 kernel.
> 
> Ouch.
> 
>> I attempted to fix it in https://lists.infradead.org/pipermail/linux-riscv/2026-March/087159.html,
>> but as pointed out in the threads, the approach is not sound.
>>
>> After that, I thought about using the BPF memory allocator instead of kmalloc_nolock on such
>> architectures to fix it. But I haven't got time to implement it.
> 
> Oh please, let's not go in that direction :)
> 
>> I don't know how could we fix it otherwise after removing BPF memory allocator completely.
>> Could we find a path to move forward without causing regressions on architectures without HAVE_CMPXCHG_DOUBLE?
> 
> Probably we can. Could you please see if this works for you?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log/?h=slab-kmalloc-nolock-without-cmpxchg-double-rfc-v1r1-wip

Thanks a lot! I tested it and could confirm that it could fix the failure of
bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE) on riscv64.

The commit message says that the allocation may still fail if the slab lock
acquisition fails upon the first try. But this is still a great improvement
compared to the previous always failing code.

Thanks,
Levi

