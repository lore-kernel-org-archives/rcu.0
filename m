Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBC3909AD;
	Wed, 25 Mar 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425014; cv=none; b=BlZzKuHrRSUy6sR/PLbvTCQGF4p55zAU8R0yF2ey8bhPBu6aPm9a1kFgviyJhiHnJ5+EbPzs7R99jB6HR7NqOcUYLGBQk53dR+JlAOxsnxTX6vl+tg/AvhQ6p6ybZ5dJTVlyPVGy9iiUFRGravtv4ymdU5ZONB1xjA3kQ9GJnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425014; c=relaxed/simple;
	bh=4q3lt84y5xkJHX2NvqLyOD8t9dOLT0rNNkE7iPIURaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kuW69RPl4Conb6KH5lGAYUWPyohSlibFz2qIxQWVN3/PcZB1uK12ySf3zZQvbK+t3es7vgX1tQMgcdkAzVCE7Il03OVC3Jx6Yj8ohu2/c8TtklKTQV6JJXd5Jim2plO01G+2w1FwYDHGWfsZWj/q9/GASbKuehY5WFSzbqDRrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtagggpx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtagggpx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20FDC4CEF7;
	Wed, 25 Mar 2026 07:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774425013;
	bh=4q3lt84y5xkJHX2NvqLyOD8t9dOLT0rNNkE7iPIURaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gtagggpxwErZ7dDLrjYSUDCGIJ2Ntm7OBqIp2QanYz85t2kv8I7J12rhY1ig0mvFI
	 B6h5OW+ikTfI2BUZisXxQ4tA/XWL8BS6QLB9fI0us1uujV3qIWR/BBgqlRx9rGYhKJ
	 rukDSeA6eUvedu1HNtto2lJCinvFuAJEIiovd7VUST/9h2CEgPZJw5rVwSB8/UXE8F
	 pnck5C0jWVEQnsKIjtszrf3mo+PbCdU/s9AyNq2v++xUPJ/FUzR61yy8Xqfry3xcj0
	 5yYxc+xRTU4Z2/QO0p2P4pSB1ZSGKMQnaCclCB+8r5XBwOMrk+YOslxnl4ANCfs0eK
	 UOkqm6H20LmWg==
Message-ID: <ff139493-1964-4285-947d-1b43fe40f8e5@kernel.org>
Date: Wed, 25 Mar 2026 08:50:07 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab,rcu: disable KVFREE_RCU_BATCHED for strict grace
 period
Content-Language: en-US
To: Jann Horn <jannh@google.com>, Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Dmitry Vyukov <dvyukov@google.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 22:35, Jann Horn wrote:
> Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
> so that kernel fuzzers have an easier time finding use-after-free involving
> kfree_rcu().
> 
> The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
> callbacks and free objects as soon as possible (at a large performance
> cost) so that kernel fuzzers and such have an easier time detecting
> use-after-free bugs in objects with RCU lifetime.
> 
> CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
> RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
> expedite; for example, the following testcase doesn't trigger a KASAN splat
> when CONFIG_KVFREE_RCU_BATCHED is enabled:
> ```
> struct foo_struct {
>   struct rcu_head rcu;
>   int a;
> };
> struct foo_struct *foo = kmalloc(sizeof(*foo),
>     GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
> 
> pr_info("%s: calling kfree_rcu()\n", __func__);
> kfree_rcu(foo, rcu);
> msleep(10);
> pr_info("%s: start UAF access\n", __func__);
> READ_ONCE(foo->a);
> pr_info("%s: end UAF access\n", __func__);
> ```
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Hm but with 7.0 we have sheaves everywhere including kmalloc caches, and
there's a percpu rcu_free sheaf collecting kfree_rcu'd objects. Only when
it's full it's submitted to call_rcu() where the callback rcu_free_sheaf()
runs slab_free_hook() including kasan hooks etc. If there's nothing filling
the rcu_free sheaf, the objects can sit there possibly indefinitely.

That means CONFIG_KVFREE_RCU_BATCHED now handles only the rare cases where
kfree_rcu() to the rcu_free sheaf fails (and I still owe it to Ulad to do
something about this).

So to complete the intent of this patch, we should perhaps also skip the
rcu_free sheaf with RCU_STRICT_GRACE_PERIOD? (or with !KVFREE_RCU_BATCHED
perhaps as it's also a form of batching).

But then I wonder if the testcase in the changelog appeared to be fixed with
this patch on a 7.0-rcX kernel (base-commit: below is rc3+) because by my
understanding it shouldn't have been. (unless there happened to be enough
kfree_rcu() activity on that cpu+kmalloc cache combination, so that the
rcu_free sheaf got submitted withing that msleep(10)).

> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ebd8ea353687..67a72fe89186 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -172,6 +172,7 @@ config SLUB
>  config KVFREE_RCU_BATCHED
>  	def_bool y
>  	depends on !SLUB_TINY && !TINY_RCU
> +	depends on !RCU_STRICT_GRACE_PERIOD
>  
>  config SLUB_TINY
>  	bool "Configure for minimal memory footprint"
> 
> ---
> base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
> change-id: 20260324-kasan-kfree-rcu-4e7f490237ef
> 
> --  
> Jann Horn <jannh@google.com>
> 

