Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908130AAD8;
	Mon,  3 Aug 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771046; cv=none; b=FMUJLcIMoZUMhqGb92QhGl8osM3PbA+0bcuT69hRVrZHGM9twOmoElfZfL2assqrIcPdPwUrnoiRKOVGXHNrXusm4FXhnXWnIMF8nFbKBPQsnBzvkMcNjmkOXPuhkswLfn1s2izQt8YVzZq0NkpeaRlQD72uLUiDTz0vSRG7FyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771046; c=relaxed/simple;
	bh=LYgVEw6TU4uM0WLict6gXRn0n4Sk0/ASBM+eXr+DMwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INMB3O6sN2PaCvOqcxO5llONQNjBumCQKKrwMYpMLftkOL9tqYsTBVah9MkvgUKy8HP1IWSxaxAYGjrWXWbVZiqzJ4aJlopJaZmkNqoBBnvItVYgNh/SIf0nKReHzKZb/pRYzHdg2QFikhTrCtHgNYPKrOnX5YVhTyfZkbPvhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4cM7EkQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4cM7EkQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C11F000E9;
	Mon,  3 Aug 2026 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785771045;
	bh=o2DlwFFQ7c69iQDGWX5wN0uky725dmGY92UH68gtyxg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=H4cM7EkQ3LmPnIVD1B4GJPrQpM2/VvFq8kIOmxYWwzqFmWEeC6Aai/uUHOFR2oVYU
	 NkSD9sg5hBgN/+MI/7ehjvmlgr+eIkgn2erHgLklpwfcTq4GGttuYAvl3VryS3HCeq
	 Io39nbVKt229iLOwbCp9l0BFsxkmxaRgfPVavAqpRbIvdH3cF5gSSPhZ3aG6ePv+EN
	 pVwxi5ttwl1MX6NnXocv7BT7A2un7C3dByDMUt1GXjmCoh98IjcV+mKUD2ie8hXhcM
	 Yb4nmBeTNFuZ3otl7WRCz4eOZM21QKunTtRJNrS8sguLSFEjuWCEpCums446vZO1K5
	 1qxxlyS3nBzwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E7F0BCE19B2; Mon,  3 Aug 2026 08:30:44 -0700 (PDT)
Date: Mon, 3 Aug 2026 08:30:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Harry Yoo <harry@kernel.org>
Cc: hu.shengming@zte.com.cn, vbabka@kernel.org, akpm@linux-foundation.org,
	hao.li@linux.dev, cl@gentwo.org, rientjes@google.com,
	roman.gushchin@linux.dev, ast@kernel.org, andrii@kernel.org,
	puranjay@kernel.org, ameryhung@gmail.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, boqun@kernel.org, urezki@gmail.com,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang@linux.dev, pfalcato@suse.de, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v5 3/8] mm/slab: use call_rcu() in unknown context if
 irqs are enabled
Message-ID: <03f04f1f-97c2-4800-b73c-23460ef15466@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
 <20260730192119586UvhYMv4xrNqaZLKIJH9X0@zte.com.cn>
 <anBAiTl_16H7NqEr@dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anBAiTl_16H7NqEr@dev>

On Mon, Aug 03, 2026 at 07:19:32AM +0000, Harry Yoo wrote:
> On Thu, Jul 30, 2026 at 07:21:19PM +0800, hu.shengming@zte.com.cn wrote:
> > Harry wrote:
> > > call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
> > > data structures. Therefore, if IRQs are not disabled, they cannot be
> > > corrupted by reentrance into call_rcu(). So fall back to the deferred
> > > path only when !allow_spin && irqs_disabled().
> > > 
> > > The RCU subsystem does not guarantee this contractually, and this
> > > optimization relies on RCU's implementation details. Ideally, it should
> > > be removed once call_rcu_nolock() is supported by the RCU subsystem.
> > > 
> > > Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
> > > ---
> > >  mm/slub.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/slub.c b/mm/slub.c
> > > index 2c5ba8c326e7..bb0f2975c95b 100644
> > > --- a/mm/slub.c
> > > +++ b/mm/slub.c
> > > @@ -6157,8 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
> > >      if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
> > >          rcu_sheaf = NULL;
> > >      } else {
> > > -        if (unlikely(!allow_spin)) {
> > > -            /* call_rcu() cannot be called in an unknown context */
> > > +        /*
> > > +         * With !allow_spin, we might have interrupted call_rcu()'s
> > > +         * IRQ-disabled critical section. If IRQs are not disabled,
> > > +         * we know that's not the case.
> > > +         */
> > > +        if (unlikely(!allow_spin && irqs_disabled())) {
> > 
> > LGTM!
> > Reviewed-by: Shengming Hu <hu.shengming@zte.com.cn>
> 
> Thanks a lot, Shengming!
> 
> > I initially wondered whether in_nmi() should also be checked here.
> > However, irqs_disabled() already covers the relevant reentrancy case,
> > since call_rcu() disables IRQs while modifying its per-CPU data.
> 
> Exactly, that was my reasoning ;)
> 
> As a side note there is an attempt to do this in call_rcu() instead of
> slab:
> 
> https://lore.kernel.org/all/20260729162207.1567770-1-puranjay@kernel.org
> 
> Just FYI.

Why not both?  ;-)

(Sorry, couldn't resist.)

							Thanx, Paul
