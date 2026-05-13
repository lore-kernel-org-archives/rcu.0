Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316837DADD;
	Wed, 13 May 2026 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636555; cv=none; b=r59+rOxg1RheaKrAwbmRr/gffysCiVYOZiIEja10IbO+NroxuoU9/d3aKwnli7FYWjAwQYUynr33amJdV5Xxfz/+/AuHlbIM2wPXxDo0/ZQSgVGRawRzCSFBC1kXOq/6v5K0gOiATD/K4RjeHTJnioC2CC8hTOkknIk+rHYjrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636555; c=relaxed/simple;
	bh=HthjHhB0D6u8+NyQJ7bO+IK1oh2mtXAmYaHrf3QurKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBVYfnI+8L/9gYT1UDHPlSCQP52zth+g7v+z5UIKKHULhVtZWKiBO1vcC8alkCcyzRPMx5076KJa8JsJvaBW6COC8FT33pJqOboMiX209lQc3QzbgLxhyHnWaYkLiDAGy+dcifzrj8ch3eIo21oRIBkAsL3kHTOxJk7tgbBuZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/K5AxpU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/K5AxpU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753FAC2BCFA;
	Wed, 13 May 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636554;
	bh=HthjHhB0D6u8+NyQJ7bO+IK1oh2mtXAmYaHrf3QurKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/K5AxpUXDre3ob0iYRDnr1eaoUgqtSrMA0OnO9BP/KjYxwKoGGZHfXqYshBiBH5D
	 eSv+UwAF/zkFAYsPyM1O7We9ekGU0hmnxbTeIMf5PVQXXW+eGOu7oHLpRCd97ma+bH
	 QwmxCL1/yMFhSIHGHXC7PecDgd4pcmXXkeO/jKpwftMXeDXT+Co+QIbEpz/6pTZoUv
	 n10T2YAVDpbIojInwwPYjSi3Ezz19k+gh2mBSiOZrQ3M936cXOmfbxuX4tQpsepo96
	 LUzrPjSx8voyIYiuOJPx2+7Aq70ECO7ZJkXXPKP10n3I9/OLkI4Qk8cq0Z2ZaAxUhs
	 6s3h+K65ewHnQ==
Date: Wed, 13 May 2026 10:42:32 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Levi Zim <i@kxxt.dev>
Cc: linux-mm@kvack.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: kmalloc_nolock() follow-ups, including kfree_rcu_nolock()
Message-ID: <6wvjo33urd5i4jvbf6rwp7kwe3ppn3ktgmjk663hq2jxax65gm@kxljf3hkqs5e>
References: <esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3>
 <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bea1536-534a-4a59-9b5f-92389fb05688@kxxt.dev>

On Tue, May 12, 2026 at 09:46:33PM +0800, Levi Zim wrote:
> On 5/12/26 8:25 PM, Harry Yoo (Oracle) wrote:
> > Hello everybody. This is a follow-up discussion of
> > "kmalloc_nolock() follow-ups, including kfree_rcu_nolock()" topic at
> > LSFMMBPF 2026 last week. Unfortunately, many RCU folks were not there,
> > but we can still discuss over email ;)
> > 
> > The slides: https://docs.google.com/presentation/d/1kpaLd7D1dwRvIqRwQfSjJVVJL0CC2gwb-AV56yCMqXw/edit?usp=sharing
> > 
> > I'm copying the slides here to make it easier to reply.

[...]

> > The end goal
> > ============
> > 
> > - Drop the BPF memory allocator
> > - Avoid preallocation as much as possible in BPF
> > - Use kmalloc_nolock() and kfree_{,rcu_}nolock() (and friends) instead
> 
> By using kmalloc_nolock, a regression happens on architectures without HAVE_CMPXCHG_DOUBLE.
> For reference, currently only x86, arm64, s390 and loongarch selects HAVE_CMPXCHG_DOUBLE
>
> For example, this has already caused bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to always fail on riscv64 6.19 kernel.

Ouch.

> I attempted to fix it in https://lists.infradead.org/pipermail/linux-riscv/2026-March/087159.html,
> but as pointed out in the threads, the approach is not sound.
> 
> After that, I thought about using the BPF memory allocator instead of kmalloc_nolock on such
> architectures to fix it. But I haven't got time to implement it.

Oh please, let's not go in that direction :)

> I don't know how could we fix it otherwise after removing BPF memory allocator completely.
> Could we find a path to move forward without causing regressions on architectures without HAVE_CMPXCHG_DOUBLE?

Probably we can. Could you please see if this works for you?

https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log/?h=slab-kmalloc-nolock-without-cmpxchg-double-rfc-v1r1-wip

-- 
Cheers,
Harry / Hyeonggon
