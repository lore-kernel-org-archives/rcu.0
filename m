Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2BB2E62B;
	Fri, 13 Dec 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132557; cv=none; b=m4spPi1JebTCF+TJ9zp5i9A81scZPSdyy3l3Syk9UWO+NvL0ZqKrejQNsUmh1WTbbgviQ121sMr1Nydx0MrPAWp2j090E9JbYUHUGp/sKoEc8ofy6pn8Y+RIFKSGoaQ0McuQUOVCrZeUItkduPbfZ72p1Pd0gdulPgeZIzqdJZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132557; c=relaxed/simple;
	bh=ckm9LwwveYJTpzPTWlxHgTAdao9SqsuMMUcNSbs5oh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3wyTEx79lgzbzeYQQWWMStEJDTehNQKvVWZaEepQ8pbIuNF+7EUQhZ3NcYfnj+ZwDHBEHZUqQ9i/yQX8CBjcBfyxWgjqju7iF14Suz8AhQ2GH1+Z1H/jCoJugxuo3i389dEdAYbtWZI0cBFQDCQ0/h6bEe7Rwzxx3oGwkOehx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtpzhVHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtpzhVHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D0CC4CED0;
	Fri, 13 Dec 2024 23:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734132556;
	bh=ckm9LwwveYJTpzPTWlxHgTAdao9SqsuMMUcNSbs5oh4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QtpzhVHphHrMEOUY8fTWV0y0ANZO7An7ELMWW5mWgMbt0JmwR4tU95xLNqKU1cSnp
	 l/c0795DfuzEQOa8v7VaQwz7e/bGK9YQsWkoGmFHB0W+pBCHP0ahQBStmehpm5mCB3
	 CepTN/UWhuco43+n6xU/o4L7GrkyO7EzDGAUucOVMr/cfet1g/QtwX+N2V1JvTxpci
	 boTeZ9qc3i/b0X+lGTF9L9caPccSj75pxklgxQkX3XdRovuMYJSiSrW0jwPu5Kf6Tm
	 mY2Ie6bWdkI89BkSQXRDPPmfTjpCVcJP4lJOhFznsDjqH7IVYTZLeHXybBEbIFLLUy
	 5ssxKbdMfR44g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6498CCE0A0F; Fri, 13 Dec 2024 15:29:16 -0800 (PST)
Date: Fri, 13 Dec 2024 15:29:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, urezki@gmail.com
Subject: Re: [PATCH rcu 1/2] rcu/nocb: Use switch/case on NOCB timer state
 machine
Message-ID: <0d069012-ab5f-4126-89b4-5f2c186b18ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c0daba35-f647-40cd-b556-3a04e03da93c@paulmck-laptop>
 <20241212184214.2018411-1-paulmck@kernel.org>
 <Z1y-egJlaH9IWKsV@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1y-egJlaH9IWKsV@pavilion.home>

On Sat, Dec 14, 2024 at 12:08:42AM +0100, Frederic Weisbecker wrote:
> Le Thu, Dec 12, 2024 at 10:42:13AM -0800, Paul E. McKenney a écrit :
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > It's more convenient to benefit from the fallthrough feature of
> > switch / case to handle the timer state machine. Also a new state is
> > about to be added that will take advantage of it.
> > 
> > No intended functional change.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Please drop this one too. It introduced a subtle (yet desired) behaviour
> change as Boqun noted. I'll resend a better version.

I will drop both on my next rebase.  Uladzislau, over to you!

							Thanx, Paul

> Thanks!
> 
> > ---
> >  kernel/rcu/tree_nocb.h | 33 +++++++++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 2605dd234a13c..0923d60c5a338 100644
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
> > 2.40.1
> > 
