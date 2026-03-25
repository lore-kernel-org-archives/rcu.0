Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565AB1D45E8;
	Wed, 25 Mar 2026 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426867; cv=none; b=Ez+yRzsDOpqq77FGeaiDWKewouncljyzuUEKmAv0nQzsgE+mUQADBZ+Ty7vDB2fciZA93/6TUbESXSK/tPvwLkBYBC2R8N+WbB+bQLfNdAwKiCbN6qH5KLsbgrNH+PeYMDA5Z6o8BGnRpqbfV3G95mgBcpC+AzQH7Xbbwpxmomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426867; c=relaxed/simple;
	bh=xtTqnitu3TW48SKq+KlTXctNXAybsV4dU5ERnJ2rg7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzYK7Vrn2nNSeHOyJn/+VvehSWbRxfdJc5GaRZDULkpeBz2nSK4Sr3cawroW6VOwskkb7iqVzSpYkrRHIz8S4yYz8ysfrNpilS4QSW6DrxsQjMIfxa3E23WP7sYevVtCcmreSIMZLX6wu3oTxvNxNBrQKbhJfr+v33jNfQ5XcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgfwjAPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgfwjAPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA6DC4CEF7;
	Wed, 25 Mar 2026 08:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774426866;
	bh=xtTqnitu3TW48SKq+KlTXctNXAybsV4dU5ERnJ2rg7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CgfwjAPALc3vJtvk9P/WA4ZHnZCgtKjZq57MtcMFdQBGa4Q5Hr5uGHpd4JJYMHgHw
	 xNG4UXwNkp2n6/Q8u3YHlKNRoX8xEdyGtn1eA/qvX0Nz5ycfMtzrAZ6jJJ27l7j2Rp
	 qfKvvuIT1gbIY1YBFtAUC2L6+EijPtgrPqZtFSFNFteGTDGezz/Q2gOXjdbkAL1tk2
	 NouhzIJsE0LVLOEy3RdLXv0kFTU1AP6zdnlW/X/6ROLlkVsTFwkasWDqfheNa8VSQl
	 aOf+uL/TU198y+Xy7fgUBelvXgp72+62cBTIdpJ7cUfyoz2b0xOa0R6ZGvOSs+W7Oo
	 UoGHU8cdX09bw==
Date: Wed, 25 Mar 2026 17:21:04 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <acOa8ErxLgbj0Uer@hyeyoo>
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
 <ff139493-1964-4285-947d-1b43fe40f8e5@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff139493-1964-4285-947d-1b43fe40f8e5@kernel.org>

On Wed, Mar 25, 2026 at 08:50:07AM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/24/26 22:35, Jann Horn wrote:
> > Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
> > so that kernel fuzzers have an easier time finding use-after-free involving
> > kfree_rcu().
> > 
> > The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
> > callbacks and free objects as soon as possible (at a large performance
> > cost) so that kernel fuzzers and such have an easier time detecting
> > use-after-free bugs in objects with RCU lifetime.
> > 
> > CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
> > RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
> > expedite; for example, the following testcase doesn't trigger a KASAN splat
> > when CONFIG_KVFREE_RCU_BATCHED is enabled:
> > ```
> > struct foo_struct {
> >   struct rcu_head rcu;
> >   int a;
> > };
> > struct foo_struct *foo = kmalloc(sizeof(*foo),
> >     GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
> > 
> > pr_info("%s: calling kfree_rcu()\n", __func__);
> > kfree_rcu(foo, rcu);
> > msleep(10);
> > pr_info("%s: start UAF access\n", __func__);
> > READ_ONCE(foo->a);
> > pr_info("%s: end UAF access\n", __func__);
> > ```
> > 
> > Signed-off-by: Jann Horn <jannh@google.com>
> 
> Hm but with 7.0 we have sheaves everywhere including kmalloc caches, and
> there's a percpu rcu_free sheaf collecting kfree_rcu'd objects.

Right, but only when CONFIG_KVFREE_RCU_BATCHED=y

> Only when
> it's full it's submitted to call_rcu() where the callback rcu_free_sheaf()
> runs slab_free_hook() including kasan hooks etc. If there's nothing filling
> the rcu_free sheaf, the objects can sit there possibly indefinitely.

Right.

> That means CONFIG_KVFREE_RCU_BATCHED now handles only the rare cases where
> kfree_rcu() to the rcu_free sheaf fails (and I still owe it to Ulad to do
> something about this).

Right.

> So to complete the intent of this patch, we should perhaps also skip the
> rcu_free sheaf with RCU_STRICT_GRACE_PERIOD? (or with !KVFREE_RCU_BATCHED
> perhaps as it's also a form of batching).

Maybe I'm missing something, but...

by making KVFREE_RCU_BATCHED depend on !RCU_STRICT_GRACE_PERIOD,
selecting RCU_STRICT_GRACE_PERIOD disables all uses of rcu_free sheaves?

kvfree_call_rcu() implementation on !KVFREE_RCU_BATCHED does not call
kfree_rcu_sheaf().

> But then I wonder if the testcase in the changelog appeared to be fixed with
> this patch on a 7.0-rcX kernel (base-commit: below is rc3+) because by my
> understanding it shouldn't have been. (unless there happened to be enough
> kfree_rcu() activity on that cpu+kmalloc cache combination, so that the
> rcu_free sheaf got submitted withing that msleep(10)).
> 
> > ---
> >  mm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index ebd8ea353687..67a72fe89186 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -172,6 +172,7 @@ config SLUB
> >  config KVFREE_RCU_BATCHED
> >  	def_bool y
> >  	depends on !SLUB_TINY && !TINY_RCU
> > +	depends on !RCU_STRICT_GRACE_PERIOD
> >  
> >  config SLUB_TINY
> >  	bool "Configure for minimal memory footprint"
> > 
> > ---
> > base-commit: b29fb8829bff243512bb8c8908fd39406f9fd4c3
> > change-id: 20260324-kasan-kfree-rcu-4e7f490237ef
> > 
> > --  
> > Jann Horn <jannh@google.com>
> > 
> 
> 

-- 
Cheers,
Harry / Hyeonggon
