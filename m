Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359271C6F4F;
	Thu, 10 Oct 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564955; cv=none; b=I9QBJQG9AEWb6xE+HrXFljlxsVUXbDLR25xFXRMhFOvHgEUHL98PIqKnE4Lc/u2XvH1ETmkha6yHjJNsjWU1nBIAMC3a1wvOzRaNZHsZ0aYi9OGx4rDxGG13EC9wp14/CDnE+rg9bWNnyxb1YwBbSyrimBykvut4aKnLzkJaOkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564955; c=relaxed/simple;
	bh=q3OKxlVE864uk0NRq8J2IEfOmb/Be2vhnlZ9CAK/heE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDp2CAFzN/N8xrJqvalg3qFVJ6Lpm9wGgLM+bjKIWBOJZAt1e3Z9GcmgNHI3ScrVfwypJ87Bz/RGqe/OCR+A5i93sbz4BEwcH3NmlNjziu4r53jg/SaipG9HfMZrcqmJeCA80ZZyr8ikVFeIRJSCjq4L4ujUCFmFxg0U6FM1IEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIuwBJgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIuwBJgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69279C4CECC;
	Thu, 10 Oct 2024 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728564954;
	bh=q3OKxlVE864uk0NRq8J2IEfOmb/Be2vhnlZ9CAK/heE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIuwBJgx/21YS9C/CWU8amD+rvuvlt9wsMz8NVBPA8uPAz/ZP0aeWVhPja1smrAeQ
	 2LBr9Abn0wHokPaJqvRffE/tL5L51caNq2m755LfSoduakYLa4AM6sZNJc8434mg+/
	 8WW4dLcKtGj+/D94ZETEpMFnIzkxYLxPAFQbBtJe/tYww70G4Yd1fmkrqajRCe5kc+
	 /Y8yXVNx5pCgN71AEL9WIM8nxy6Is8USQksgSEFVi1S58yt0z1h+wEIprDXPcmwwCs
	 59F2OnRWbV1dsSIv4jF5Nck7inr2JX5Zy/DIuU/jNHhjTeQJn8CzM/2uyadoelbR9b
	 ZZBK96tIZeNSA==
Date: Thu, 10 Oct 2024 14:55:52 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/3] rcu/nocb: Use switch/case on NOCB timer state machine
Message-ID: <ZwfO2Llzeyh7En-N@localhost.localdomain>
References: <20241002145738.38226-1-frederic@kernel.org>
 <20241002145738.38226-2-frederic@kernel.org>
 <ZweNaSTMQOqXRIIN@boqun-archlinux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZweNaSTMQOqXRIIN@boqun-archlinux>

Le Thu, Oct 10, 2024 at 01:16:41AM -0700, Boqun Feng a écrit :
> On Wed, Oct 02, 2024 at 04:57:36PM +0200, Frederic Weisbecker wrote:
> > It's more convenient to benefit from the fallthrough feature of
> > switch / case to handle the timer state machine. Also a new state is
> > about to be added that will take advantage of it.
> > 
> > No intended functional change.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 97b99cd06923..2fb803f863da 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -271,22 +271,35 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
> >  
> >  	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
> >  
> > -	/*
> > -	 * Bypass wakeup overrides previous deferments. In case of
> > -	 * callback storms, no need to wake up too early.
> > -	 */
> > -	if (waketype == RCU_NOCB_WAKE_LAZY &&
> > -	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> 
> In the old code, if this "if" branch is not taken,
> 
> > -		mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> > -		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > -	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
> > +	switch (waketype) {
> > +	case RCU_NOCB_WAKE_BYPASS:
> > +		/*
> > +		 * Bypass wakeup overrides previous deferments. In case of
> > +		 * callback storms, no need to wake up too early.
> > +		 */
> >  		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
> >  		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > -	} else {
> 
> ... it will end up in this else branch, however,
> 
> > +		break;
> > +	case RCU_NOCB_WAKE_LAZY:
> > +		if (rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
> > +			mod_timer(&rdp_gp->nocb_timer, jiffies + rcu_get_jiffies_lazy_flush());
> > +			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > +		}
> > +		/*
> > +		 * If the timer is already armed, a non-lazy enqueue may have happened
> > +		 * in-between. Don't delay it and fall-through.
> > +		 */
> > +		break;
> 
> ... here we break instead of fallthrough when waketype ==
> RCU_NOCB_WAKE_LAZY and rdp->nocb_defer_wakeup != RCU_NOCB_WAKE_NOT, this
> seems to me a functional change, is this intented?

You unveiled my secret plans!

I think it was intended at the last minute, because it "fixes" some rare case
where RCU_NOCB_WAKE_LAZY can be spuriously set over a RCU_NOCB_WAKE. The effect
shouldn't be too bad because the timer still fires in one jiffy but still
this is confusing.

So saying in the changelog "No functional change intended" was not intended.

I'll refactor the changelogs and comments.

Thanks.

> 
> Regards,
> Boqun
> 
> > +	case RCU_NOCB_WAKE:
> > +		fallthrough;
> > +	case RCU_NOCB_WAKE_FORCE:
> >  		if (rdp_gp->nocb_defer_wakeup < RCU_NOCB_WAKE)
> >  			mod_timer(&rdp_gp->nocb_timer, jiffies + 1);
> >  		if (rdp_gp->nocb_defer_wakeup < waketype)
> >  			WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> >  	}
> >  
> >  	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
> > -- 
> > 2.46.0
> > 
