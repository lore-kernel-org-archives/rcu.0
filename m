Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFA32AAA3;
	Wed, 25 Mar 2026 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774418072; cv=none; b=uICk/7YhjikSPAvg3P05A+v3HNYdL4Y4J/gWXMTlRAyrMnyyvwinRaNtGOMfH+W6kszLgVeDfa7SflE6b2xh6PYHxHgV9GWuXcQwbTBj7wOKv77iT1+SnV0Qe7aU8+gA7up+aCwzTcRGFkRGUN9b4HkYMQpf25qptesZ7PgsqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774418072; c=relaxed/simple;
	bh=O/DfGMV6h20F3xTRLWmaiDK6+ZYFTVfswpqJcM3DDoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OddbDyUn6cF0+U9A5pjVqP229abS4UPILhP6yhtgSNUqv0upS15bdBtCZMelov5t3zKHTBaQmmcbUCTeSsDnvuwE1/M4hX1tIJNvX8K5qtt3Db/zHD+U3tZ/FwZucUTtUihMqi+lLdZszXe/+fiNtiZ58A8PUaur02wzWeWAznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnazHkGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnazHkGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED01C2BC9E;
	Wed, 25 Mar 2026 05:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774418071;
	bh=O/DfGMV6h20F3xTRLWmaiDK6+ZYFTVfswpqJcM3DDoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnazHkGq6JmwGnlOGiQaBskU5RHp/1iNU/1a3S6AkzwzEDTXeA8kCn51+5lNh/LLN
	 zBoNzooBearz88PpiLmylZT1bYoza/Q7vPkXg4wPDvnQju4FBJw+3BIO2JbsR2/Cad
	 ovyrtEVZt0oJak+N7WJiKVITecyl2JgLZ3ZXGmIb+rWwceEYFv6mIXa6pk1T0yShAB
	 roDL3I1xpHQUS8GtNWy++GhUlWcI+KPsZBkWlxwLcMIrFNSDB3CWhgybTwFn6y3YMS
	 E3udvhQkkE+6kKZoqPUKufcVmDPKN6ylBlgEIiojIEtZyWIlQi+5eFsPEq5HLtYgsv
	 mw2sTzshWW67w==
Date: Wed, 25 Mar 2026 14:54:29 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dmitry Vyukov <dvyukov@google.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab,rcu: disable KVFREE_RCU_BATCHED for strict grace
 period
Message-ID: <acN4lWXD4IbvVxWi@hyeyoo>
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>

On Tue, Mar 24, 2026 at 10:35:12PM +0100, Jann Horn wrote:
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
> ---

Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon
