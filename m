Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746237A841;
	Thu, 10 Sep 2026 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789009921; cv=none; b=F7kUw1iqw4Wx3BeFFnci8zcUv9lth7bQjSokxkrNGYe/2XV/yuy2B7UE/hmliWs0hbBDzRYyediUgoQKh896NHsD1aD+OnFG2wUvx6FcLXJmqh2o3IQ3GjfgWUyTdBzuWJvlmXJLbTftZ1chddQnqkgkhUIXuFqD6Bmf5IZ8RjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789009921; c=relaxed/simple;
	bh=Vrz2DKJjKXu79OvoMbYjMk4TOgHqqb6BLgSxyeGf15M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp2EfSBqCpEMj/yHpVDe96Rp/mQODi13CwrZWXTkVfLOHjxoLeVs7MEPcx7F1T4gtWPfUCtci1JoDh1Cl/fvL8OFn8kbGM+NnltyOAP7QzFT5WXc0thzihawibBMWhcPEK1gEkzc7h0zlDr13vKsKK6Lab7G3i9aquJ9kSQl120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2O4tgqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2O4tgqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5391F0089B;
	Thu, 10 Sep 2026 03:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789009919;
	bh=O+67QnG6cRMQNHCj1E+51wtlgrXy9V/d2xUc7YbmAsI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=h2O4tgqDphn3yKoNut9DG8FRXfPFdeIjTqgq4Q8f7dY3Qsn/OmBLjsymZuJ92hiCq
	 7ceyMM+tK7nxSRgbJE7/EbdVBmmqc2/jb5ntbUtGOS1t/7LctsyuMVojBYOQla7qQz
	 oW3jKuiqDevG1jx+lp5uRsiizzuOC8gXdYdzRINBxZWrMQNXffyU1q+J2aOSfBVddN
	 K1DAU48tvBQzQeI8WgTb6vjbwSQUdPbwE/Pookp2zXkMdQZAoQkgl9XK515K/jA7lW
	 e31/jELuMahYrGDAcctIqgfRDV5O9g+8g7cQjoKbOyQUenp7K3t4dWXwyYU0z6HlkQ
	 u/jgBeX6X+bjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80D65CE086B; Wed,  9 Sep 2026 20:11:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 20:11:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <yi1.lai@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Bradley Morgan <brads@mainlining.org>,
	Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
Message-ID: <7f85b400-a9d5-412f-a619-69b38022c6be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com>
 <aqITB4oCfaR7vD+G@ly-workstation>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqITB4oCfaR7vD+G@ly-workstation>

On Thu, Sep 10, 2026 at 10:16:39AM +0800, kernel test robot wrote:
> On Tue, Sep 08, 2026 at 11:22:14AM -0400, Mathieu Desnoyers wrote:
> > When hazptr_acquire loads a NULL pointer, it sets:
> > 
> > - slot_item->slot.addr = NULL,
> > - slot_item->ctx.ctx = ctx
> > - ctx->slot = slot
> > 
> > And it returns NULL.
> > 
> > Then hazptr_detach is called on this ctx, it will act on the ctx as if
> > needed to be promoted to backup slot, even though it has a NULL addr.
> > 
> > Looking at what hazptr_note_context_switch() does before promoting
> > to backup slot, it checks for a NULL slot->addr, which is exactly
> > what is missing from hazptr_detach.
> > 
> > With this in place there would be no need to explicitly check the
> > hazptr_acquire() return value before calling hazptr_detach().
> > 
> > hazptr_release() has a early return check for NULL addr as well, so it
> > makes sense that detach does an early return (no-op) similarly.
> > 
> > Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
> > Reported-by: kernel test robot <yi1.lai@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Boqun Feng <boqun@kernel.org>
> > Cc: Bradley Morgan <brads@mainlining.org>
> > Cc: <rcu@vger.kernel.org>
> > Cc: <lkmm@lists.linux.dev>
> > ---
> >  include/linux/hazptr.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
> > index 43122c5673bd..d1670121947a 100644
> > --- a/include/linux/hazptr.h
> > +++ b/include/linux/hazptr.h
> > @@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
> >  	struct hazptr_slot *slot;
> >  
> >  	guard(preempt)();
> > +	slot = ctx->slot;
> > +	if (!slot->addr)
> > +		return;
> >  #ifdef CONFIG_HAZPTR_DEBUG
> >  	ctx->detach_task = ctx->detach_cpu = true;
> >  #endif
> > -	slot = ctx->slot;
> >  	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
> >  		return;
> >  	hazptr_promote_to_backup_slot(ctx, slot);
> > -- 
> > 2.43.0
> > 
> 
> Applied this fix patch on top of Pual's v2 RFC patch series. The issue
> cannot be reproduce.
> 
> Tested-by: kernel test robot <yi1.lai@intel.com>

Thank you!  I will apply this on my next rebase.

							Thanx, Paul
