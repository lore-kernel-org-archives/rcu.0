Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4429337BA4;
	Wed, 25 Mar 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428065; cv=none; b=hrbuk/7qQp3V+7pfSGKMDEFcQw8gipYQ54QrnNP9xTAbTD7V1YkRPFaSjoigE2V4YCiWjqRjhT0ETO/uWKTR+cnMG8xgjEQdXUtDdHmYve1tOtFvdwqAEyqvD+jiY4D9RK5TVl2lxYHQtrxkXme5GkXr4MvcE5oJHqRUb+8/JE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428065; c=relaxed/simple;
	bh=VoCiz3ON/XRxstQzyULut+tSmIRHjLrwWfAkX9hDBNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQuJj1cVyL7edubKQuqo5Wr6ZkHbqXvGoSfHzOAtr0ba7fcgqtpV13gfQzbd4Yf/JPraniDzdiiWezc1bqpx6lIXylMZ7VsWH6f8y7QMi+vGg4BvCQwiQB1W7yngEMTiGXinBOrVSZHH7mdfP/zSiyU0W5rbmpAG7+8g6KL26CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4jFv167; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4jFv167"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738AEC4CEF7;
	Wed, 25 Mar 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774428064;
	bh=VoCiz3ON/XRxstQzyULut+tSmIRHjLrwWfAkX9hDBNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4jFv167vNjvFKyMG21F9RFl83kEBTAPdr0uiDYB1d6HBPHx3BLTOjCvh/zXm6J6l
	 t/lvzvxt9tQnQqGXp5RQIfmlCl3+eoiJunwtNPaDhqaYFt0XO/sWtfXimjSqg80BQt
	 2u2rldl0O/UOe5Fx1IA+TT+rpLCZwG0qXhqLe35bHuDSITtH92zp9MC1pawOrtUKMz
	 awULzxr3hKuWlQnLj79eLRLboJHo1OyYqOV3WOUMBWLfe2yCiw+kekz1FwICRGGoc5
	 U3D5B+aHxRD1PChTl9tUDH38NtXNVXyleODdzFGiJoc9Uevu7ReAGA+cIB4FMiVjng
	 AaBPV1D/rP2XA==
Date: Wed, 25 Mar 2026 17:41:02 +0900
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
Message-ID: <acOfnpjoj0FIGXKc@hyeyoo>
References: <20260324-kasan-kfree-rcu-v1-1-ac58a7a13d03@google.com>
 <ff139493-1964-4285-947d-1b43fe40f8e5@kernel.org>
 <acOa8ErxLgbj0Uer@hyeyoo>
 <de209b21-a39a-4c8e-8f13-458d095c1325@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de209b21-a39a-4c8e-8f13-458d095c1325@kernel.org>

On Wed, Mar 25, 2026 at 09:34:40AM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/25/26 09:21, Harry Yoo (Oracle) wrote:
> > On Wed, Mar 25, 2026 at 08:50:07AM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 3/24/26 22:35, Jann Horn wrote:
> >> > Disable CONFIG_KVFREE_RCU_BATCHED in CONFIG_RCU_STRICT_GRACE_PERIOD builds
> >> > so that kernel fuzzers have an easier time finding use-after-free involving
> >> > kfree_rcu().
> >> > 
> >> > The intent behind CONFIG_RCU_STRICT_GRACE_PERIOD is that RCU should invoke
> >> > callbacks and free objects as soon as possible (at a large performance
> >> > cost) so that kernel fuzzers and such have an easier time detecting
> >> > use-after-free bugs in objects with RCU lifetime.
> >> > 
> >> > CONFIG_KVFREE_RCU_BATCHED is a performance optimization that queues
> >> > RCU-freed objects in ways that CONFIG_RCU_STRICT_GRACE_PERIOD can't
> >> > expedite; for example, the following testcase doesn't trigger a KASAN splat
> >> > when CONFIG_KVFREE_RCU_BATCHED is enabled:
> >> > ```
> >> > struct foo_struct {
> >> >   struct rcu_head rcu;
> >> >   int a;
> >> > };
> >> > struct foo_struct *foo = kmalloc(sizeof(*foo),
> >> >     GFP_KERNEL | __GFP_NOFAIL | __GFP_ZERO);
> >> > 
> >> > pr_info("%s: calling kfree_rcu()\n", __func__);
> >> > kfree_rcu(foo, rcu);
> >> > msleep(10);
> >> > pr_info("%s: start UAF access\n", __func__);
> >> > READ_ONCE(foo->a);
> >> > pr_info("%s: end UAF access\n", __func__);
> >> > ```
> >> > 
> >> > Signed-off-by: Jann Horn <jannh@google.com>
> >> 
> >> Hm but with 7.0 we have sheaves everywhere including kmalloc caches, and
> >> there's a percpu rcu_free sheaf collecting kfree_rcu'd objects.
> > 
> > Right, but only when CONFIG_KVFREE_RCU_BATCHED=y
> > 
> >> Only when
> >> it's full it's submitted to call_rcu() where the callback rcu_free_sheaf()
> >> runs slab_free_hook() including kasan hooks etc. If there's nothing filling
> >> the rcu_free sheaf, the objects can sit there possibly indefinitely.
> > 
> > Right.
> > 
> >> That means CONFIG_KVFREE_RCU_BATCHED now handles only the rare cases where
> >> kfree_rcu() to the rcu_free sheaf fails (and I still owe it to Ulad to do
> >> something about this).
> > 
> > Right.
> > 
> >> So to complete the intent of this patch, we should perhaps also skip the
> >> rcu_free sheaf with RCU_STRICT_GRACE_PERIOD? (or with !KVFREE_RCU_BATCHED
> >> perhaps as it's also a form of batching).
> > 
> > Maybe I'm missing something, but...
> > 
> > by making KVFREE_RCU_BATCHED depend on !RCU_STRICT_GRACE_PERIOD,
> > selecting RCU_STRICT_GRACE_PERIOD disables all uses of rcu_free sheaves?
> > 
> > kvfree_call_rcu() implementation on !KVFREE_RCU_BATCHED does not call
> > kfree_rcu_sheaf().
> 
> Ah yeah, I missed that there are two kvfree_call_rcu() implementations and
> kfree_rcu_sheaf() is only used in the batched one. Sorry for the noise.

It's confusing indeed. I was trapped by this yesterday, thinking...

"Oh, why doesn't kvfree_rcu_barrier() on !KVFREE_RCU_BATCHED flush
 rcu sheaves? It's broken!"

and then realized that I was confused :)

> Will queue the patch

Thanks!

-- 
Cheers,
Harry / Hyeonggon
