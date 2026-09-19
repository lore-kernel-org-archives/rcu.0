Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7F3F329E;
	Sat, 19 Sep 2026 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789818223; cv=none; b=ESER2XMWr8S0URWaA5/ORmnShKdq80A5hWRsZQUa+YcjjnhJo7CCukdU10jTLYbZgrNPEq0WfoxnQM4baEdi1xT0ABaYxQ3TGFpNYLhnStxeXBbd1afpJROrRhmJSsg1q7gCsjA8OgDnJv8g5w0EWdo/vIn2Csl4Cq6+qPymleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789818223; c=relaxed/simple;
	bh=Vxw1QV3VZJN5Eg6rt97VtREf4Pmpu0Db4x/ZdKJrgVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6XVjs5FXYzZcXGVTp/1SpBBUcIIMolVcWaXPG0A7Zxe0EL+svccadrv1O0y7G9cO3EGM3Q+gekUO5GJHRzPcq2NNI/qXp4tpRp9VeSQb8bo7uZ0kfo5Ztx5xq1c2bBUP3CpIfeLUS89T8lweTwtpkBDGw8QZyHuh2+BDwqcj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTZyA4A0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTZyA4A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6CD1F000FF;
	Sat, 19 Sep 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789818221;
	bh=Q568QRVoqzIIZ66bmcYqQSYYi0DWlXxn2rWdRr531+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hTZyA4A0jtUxYyzz3LIf5wzAZQj/vs/mucVhBNVDX34Il2QsOlXks/+aQlh1GD1fp
	 UL+irnpGtL9UAJ9+vfVsqGBgIFdxOvr998Stik+Fng9bt5NOA3G8nMEUbsSoLIJzkM
	 7cPZ4GuT9IovCqCiR7DPaImCGg7rQsPzhb7xCynojlbfm7ItAVX4Pi+ekM9X/2qzoe
	 ichMITIl1xpCaCLEsKSmdUwDXrJLU/HCTjVgJ9wCWngvd8qr48uVFUn5ggqxYG7b2v
	 VMWLvUX4c9kVMAw7sbyEqWzK+QixTmH/RgVKxIXm2cy2WcOuRWWd9E23BRwt5BJ4ds
	 0oGE0jNyXWiug==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A4E43F40066;
	Sat, 19 Sep 2026 07:43:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 19 Sep 2026 07:43:40 -0400
X-ME-Sender: <xms:bHWuahDqQ9KlGwK8wgLPwhDGoQUshDh3SIDxYeiTB5YYa9woVr42rw>
    <xme:bHWual6HX4TU0nPc3-07S1RD7I2P5DCLSy76MbfZ6-CmWLuwAKkPT3qIfFrOKTVK4
    aV06LvSklo4Q5-_AeZnyAxPdaOm9-Wc9LrAE6rop9bbiJKxwDfsYw>
X-ME-Received: <xmr:bHWuao044_tcgIhZFmqF3kDUoK4mfC5x737E2j9qdCZSIDQEcY9rIqDND6lQ>
X-ME-Proxy-Cause: dmFkZTF3MsUIpyhJdWg+saxeUY9t+jx5LL1fCi1A49URGTjCHZqEq1Gg09QlUl2p39NhqW
    aM9uyBubZ6hZtA7ET4o7F1MwQtQ0HIOA8H4C+z3ude4FgehQcT4iud3kcVBXzHR/h4oIX5
    rpD4MQX1EHbcNvzGmurO5xzquiemg1qLsbiHPQLeE4OrIANXjK+0YKv/+XsX8QTuv48+kX
    GN/36+fKYiAubkcePP3w7rjaDPWWZRmmut3wriHQO1fOriSTAnZjqs6z4pvjJxEZlZtmwv
    vkPlos2wsfbPPo9A9LrG2hJOyXyxLLBLDJ2sixco7PaXtwhPyAy4OsFzIaX1ODI929ADRO
    wcmffcJvzajGkAOKfybxeHPv6I8rCC2Sq6wxarw5OGlVaKDFHTgEy5tkIQwy/a8SWKuozP
    htlU6g4gTL0ZrWVW51QzII+TqXzFDqaWmpg+ForoLWvvJmdQ9QLSh/L5SDgh76S+WbsznB
    07PoVfAgRkSZHZS95x0eJIM1m0KizFjhx39llwGqRUUrzHvKBQ9brM7qIMCe/1zEWE1j3O
    BK1pPfu+LySBjA9ywXXlj1pH3f6Y5fAixZ/ARWu2haEJr0amRUPl0BGaAkMu6fq0zLTtua
    vxMdODfKyn9KhRr43Haaaap4KCTz9nT9Eor46rvR6ReoMhfP9LdjzmWNxv5A
X-ME-Proxy: <xmx:bHWuaplh9zEhWNKM3ui3HYcn7s4pTj2SeGkBElVMZ15b0BXWs-SpUw>
    <xmx:bHWuau4O-sfxHzmnmlGNZAFIJuReT2D_5wd1Bo700FV-tovnW1USTw>
    <xmx:bHWuakl79AP8JGSrHITZUaq0tZK15uYr4jPC6swuGcDXfcTmJay2Jg>
    <xmx:bHWuahX3FcV3ShIlgm63fPc-GPFx1I85jHkbqlwV0yiTlF71KsyARQ>
    <xmx:bHWualQFeUGNbgPYq04k6XKAhllrckXeHXL0C6ji7a-qjX3u4OD95Rmd>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Sep 2026 07:43:40 -0400 (EDT)
Date: Sat, 19 Sep 2026 12:43:38 +0100
From: Boqun Feng <boqun@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>, lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>, Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH 19/28] hazptr: Permit detaching hazard pointers from
 contexts
Message-ID: <aq51aoHIICSA6376@MacBook-0RXW5>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
 <20260919000056.3132131-19-paulmck@kernel.org>
 <aq51OA4zu-p-nWyy@MacBook-0RXW5>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq51OA4zu-p-nWyy@MacBook-0RXW5>

On Sat, Sep 19, 2026 at 12:42:48PM +0100, Boqun Feng wrote:
> On Fri, Sep 18, 2026 at 05:00:47PM -0700, Paul E. McKenney wrote:
> > From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > Provide a new hazptr_detach() function that detaches a given hazard
> > pointer from its acquisition context.  This context might be a task or
> > an interrupt handler.
> > 
> > [ paulmck: s/hazptr_detach_from_task/hazptr_detach/ per Mathieu. ]
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun@kernel.org>
> > Cc: <rcu@vger.kernel.org>
> > Cc: <lkmm@lists.linux.dev>
> > ---
> >  include/linux/hazptr.h | 55 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 37 insertions(+), 18 deletions(-)
> > 
> > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> > index b121f7779cda..8197a51b9f7a 100644
> > --- a/include/linux/hazptr.h
> > +++ b/include/linux/hazptr.h
> > @@ -98,6 +98,41 @@ bool hazptr_slot_is_backup(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
> >  	return slot == &ctx->backup_slot.slot;
> >  }
> >  
> > +/* Internal helper. */
> > +static inline
> > +void hazptr_promote_to_backup_slot(struct hazptr_ctx *ctx, struct hazptr_slot *slot)
> > +{
> > +	struct hazptr_slot *backup_slot;
> > +
> > +	backup_slot = hazptr_chain_backup_slot(ctx);
> > +	/*
> > +	 * Move hazard pointer from the per-CPU slot to the
> > +	 * backup slot. This requires hazard pointer
> > +	 * synchronize to iterate on per-CPU slots with
> > +	 * load-acquire before iterating on the overflow list.
> > +	 */
> > +	WRITE_ONCE(backup_slot->addr, slot->addr);
> > +	/*
> > +	 * store-release orders store to backup slot addr before
> > +	 * store to per-CPU slot addr.
> > +	 */
> > +	smp_store_release(&slot->addr, NULL);
> > +	/* Use the backup slot for context. */
> > +	ctx->slot = backup_slot;
> > +}
> > +
> 
> Probably needs a function doc for hazptr_detach(), how about the
> following?
> 

Obivioulsy I'm missing patch #24, never mind then :)

Regards,
Boqun

> /*
>  * hazptr_detach: Detach the hazptr from its acquisition context.
>  *
>  * By default hazptr_acquire() expects to be released from its
>  * acquisition context. However there are cases where the acquisition
>  * context sends (in other words, transfers the ownership of) the hazptr
>  * to another context, e.g.
>  * 
>  * 	hazptr_acquire(ctx, gp);
>  * 	hazptr_detach(ctx);
>  * 	defer_work->hp = ctx;
>  * 	queue_work(..., defer_work);
>  * 	<in defer_work->func()>
>  * 	hazptr_release(ctx);
>  *
>  * Use hazptr_detach() before sending the hazptr across contexts.
>  *
>  * It's safe to detach an "already-detatched" hazptr.
>  */
> 
> Thoughts?
> 
> Regards,
> Boqun
> 
> > +static inline
> > +void hazptr_detach(struct hazptr_ctx *ctx)
> > +{
> > +	struct hazptr_slot *slot;
> > +
> > +	guard(preempt)();
> > +	slot = ctx->slot;
> > +	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> > +		return;
> > +	hazptr_promote_to_backup_slot(ctx, slot);
> > +}
> > +
> >  static inline
> >  void hazptr_note_context_switch(void)
> >  {
> > @@ -106,27 +141,11 @@ void hazptr_note_context_switch(void)
> >  
> >  	for (idx = 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> >  		struct hazptr_slot_item *item = &percpu_slots->items[idx];
> > -		struct hazptr_slot *slot = &item->slot, *backup_slot;
> > -		struct hazptr_ctx *ctx;
> > +		struct hazptr_slot *slot = &item->slot;
> >  
> >  		if (!slot->addr)
> >  			continue;
> > -		ctx = item->ctx.ctx;
> > -		backup_slot = hazptr_chain_backup_slot(ctx);
> > -		/*
> > -		 * Move hazard pointer from the per-CPU slot to the
> > -		 * backup slot. This requires hazard pointer
> > -		 * synchronize to iterate on per-CPU slots with
> > -		 * load-acquire before iterating on the overflow list.
> > -		 */
> > -		WRITE_ONCE(backup_slot->addr, slot->addr);
> > -		/*
> > -		 * store-release orders store to backup slot addr before
> > -		 * store to per-CPU slot addr.
> > -		 */
> > -		smp_store_release(&slot->addr, NULL);
> > -		/* Use the backup slot for context. */
> > -		ctx->slot = backup_slot;
> > +		hazptr_promote_to_backup_slot(item->ctx.ctx, slot);
> >  	}
> >  }
> >  
> > -- 
> > 2.40.1
> > 
