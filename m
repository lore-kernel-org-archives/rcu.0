Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A42569F2B;
	Tue,  8 Sep 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884531; cv=none; b=Hf8Jh/x+VqdM5p5F+va9Q0axONaFjkI+8Pdec0C5jE+7G2wSZZAsPNGFduaD9qgoFqdAGtje0jHU+WxxekXnHMw+yIdCfpVKcTZSQ5lumCGfCWIdqLU1eLqt93wKIx7e7joyTLwRoKW9ekUkcErnzxM0AO+3oUnYXYNxrqpPliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884531; c=relaxed/simple;
	bh=dQbCytF7ju0V91tsQRdUAusKjVxMHW0Auep36Gzn3VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUDHIsoaLA+Z5bkw8u6xutbC/2jn1v1WoyOo9E/DRL0w6KSTJZXgjoQOe3i0rqqpc24CRWVnESg52h2Rob+n7T/KmuAHxwHf5yV6M+2T77nXfWAp9QvxPvuuUMtkPxb6UogJHoEV8PgAnAm8y8/SjeDTx1duXh07UkYvgQ5IHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfEndFay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfEndFay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC481F00A3A;
	Tue,  8 Sep 2026 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884529;
	bh=9KoMo8K6TWg2dI4x7T6lZ42YJr2uwM6Hu6Ud/gudxS8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=kfEndFay+1KLMVf7ADrxJsYMVbwHxKdDWxQKJszMm9kcE+e5UTuR1Z6dsZD5cIGAu
	 WyoNGswT068qLYGPB4wbh2fN38j/wrIwCRhNY/hgn9Vk+Tvepi5n3Yo+XUA7wK7zC4
	 bengSYAkqxGLQ9QLFW5ubrLErPS93ZP9tw+mgHtIMXlOcY/a+9g3cJ0XRHVLOtwPTR
	 F7hKuOzXqB7H4sNeB+LEFs9jlxLuVvPJG1uhKBOttKd0UXmjD2gX9ihOx94iIVh5rV
	 bqRkGX978lrC735yIsR+WDld80Ws/eCuSaAU8/+4xHXergJNqGjOn4BM1kHhzlf1kO
	 XcQGdDPqumC9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9C230CE0ABD; Tue,  8 Sep 2026 09:22:09 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:22:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Bradley Morgan <brads@mainlining.org>, linux-kernel@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>,
	Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
Message-ID: <da21c929-cd85-4ecb-8976-5948f080b6e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
 <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org>
 <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>

On Tue, Sep 08, 2026 at 11:29:31AM -0400, Mathieu Desnoyers wrote:
> On 2026-09-08 11:24, Bradley Morgan wrote:
> > On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > > When hazptr_acquire loads a NULL pointer, it sets:
> > > 
> > > - slot_item->slot.addr = NULL,
> > > - slot_item->ctx.ctx = ctx
> > > - ctx->slot = slot
> > > 
> > > And it returns NULL.
> > > 
> > > Then hazptr_detach is called on this ctx, it will act on the ctx as if
> > > needed to be promoted to backup slot, even though it has a NULL addr.
> > > 
> > > Looking at what hazptr_note_context_switch() does before promoting
> > > to backup slot, it checks for a NULL slot->addr, which is exactly
> > > what is missing from hazptr_detach.
> > > 
> > > With this in place there would be no need to explicitly check the
> > > hazptr_acquire() return value before calling hazptr_detach().
> > > 
> > > hazptr_release() has a early return check for NULL addr as well, so it
> > > makes sense that detach does an early return (no-op) similarly.
> > > 
> > 
> > You shall kill me for this!!
> > 
> > Could you perhaps do a splat in ze commit description pls?
> 
> The splat is available at the "Closes" URL below. I'm not sure whether
> we should duplicate this verbose information ?
> 
> Paul ?

I am fine either way, as long as the information is reasonably easily
accessible.  Which is the case either way.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > 
> > > Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
> > > Reported-by: kernel test robot <yi1.lai@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
> > > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Boqun Feng <boqun@kernel.org>
> > > Cc: Bradley Morgan <brads@mainlining.org>
> > > Cc: <rcu@vger.kernel.org>
> > > Cc: <lkmm@lists.linux.dev>
> > > ---
> > > include/linux/hazptr.h | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> > > index 43122c5673bd..d1670121947a 100644
> > > --- a/include/linux/hazptr.h
> > > +++ b/include/linux/hazptr.h
> > > @@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
> > > 	struct hazptr_slot *slot;
> > > 
> > > 	guard(preempt)();
> > > +	slot = ctx->slot;
> > > +	if (!slot->addr)
> > > +		return;
> > > #ifdef CONFIG_HAZPTR_DEBUG
> > > 	ctx->detach_task = ctx->detach_cpu = true;
> > > #endif
> > > -	slot = ctx->slot;
> > > 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> > > 		return;
> > > 	hazptr_promote_to_backup_slot(ctx, slot);
> > > 
> > 
> > --- Thanks!
> > https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
