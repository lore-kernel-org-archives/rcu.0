Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA733AD8E;
	Wed, 12 Nov 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969304; cv=none; b=n0cgDwcJlzOGy0N2xVGLUWGPQh8M58L85hVlVNlcfxjrHuJTriAqtz3kp1CytFedVc8yP54CUTdmeT2AuZ27AUKOFoud6EgQvUXqkIed337Tig70006oyEd4VnPNkLMGXvfhuk4HYlu7zLFMJJHr6H6lbuMUQrFwLM+jbiiB+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969304; c=relaxed/simple;
	bh=vatjQDD96NvrnFv7YQECBTjlchyADPu1a063Q3T7roE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z141EIezDNn94nH4XeNE5hVyASRn5lh3Q43gls04m3ovZ5+xQqgx35LZwr0p+IPmuAZjefUhHH5EbssFhy6pzRg93tVpDY9BmFfYB/sXzgEZe7AIMi7uW+ja2OWoUsAT6QjEEPmPW1E4E66B3g9wENyl3HjaWwa92xjf1iFKOsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvFCPxqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvFCPxqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239F9C4CEF1;
	Wed, 12 Nov 2025 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969304;
	bh=vatjQDD96NvrnFv7YQECBTjlchyADPu1a063Q3T7roE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TvFCPxqIvfTSJdnRXqsZJh0i2L49UlQDIuP1Pab72dLsi5GDaPVuxqu65tMXdd/Jw
	 kkiZ5etNSdCdkuaN3Iwn9Kl46nG0FWId4GrFjvsoYaDtf3ECCsZaVHEnj6HzAAXSVS
	 kk6ISTzkxdkt2UMjcjmknnd7ugR/HKLpL9Bdo1iLxrrJSzFYF9Db7IBKKY577j0qdU
	 8WXEe0llwvUAsaDZnkgZTgBA0UeYSrKWiTC2OCPQXy2mCYzIXBbKgcX7RAKuAVHJSp
	 LeNQR+ldofKpuyLOHgGKXu+h8a/CCt4H8GDYAazhHtdjk949M7GtXIGdUY3OU5z8Vn
	 ZsbPBPMrRnITg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8B2A0CE0876; Wed, 12 Nov 2025 09:41:43 -0800 (PST)
Date: Wed, 12 Nov 2025 09:41:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH 3/8] refscale: Add local_bh_disable() readers
Message-ID: <758f6e84-e707-452c-b174-f9d03efb6819@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19fae851-0c49-43d2-9bbf-913424641ff4@paulmck-laptop>
 <20251102224948.3906224-3-paulmck@kernel.org>
 <20251111153803.5_08_ro2@linutronix.de>
 <5b1fa8a6-0f47-4ab8-af7a-74916bc520e2@paulmck-laptop>
 <20251112091452.AxsV206Y@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112091452.AxsV206Y@linutronix.de>

On Wed, Nov 12, 2025 at 10:14:52AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 11:21:04 [-0800], Paul E. McKenney wrote:
> > On Tue, Nov 11, 2025 at 04:38:03PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-11-02 14:49:43 [-0800], Paul E. McKenney wrote:
> > > > --- a/kernel/rcu/refscale.c
> > > > +++ b/kernel/rcu/refscale.c
> > > > @@ -636,6 +636,37 @@ static const struct ref_scale_ops jiffies_ops = {
> > > >  	.name		= "jiffies"
> > > >  };
> > > >  
> > > > +static void ref_bh_section(const int nloops)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	preempt_disable();
> > > > +	for (i = nloops; i >= 0; i--) {
> > > > +		local_bh_disable();
> > > 
> > > This (preempt off followed by bh off) may cause warnings. That would be
> > > bh is disabled on the CPU, it gets preempted by _this_ which disables
> > > first preemption and then bh. 
> > > I hid the code under CONFIG_PREEMPT_RT_NEEDS_BH_LOCK so it shouldn't be
> > > a problem in the long term I think. So just if you see a warning here
> > > under RT you know why :)
> > 
> > Huh.  Would migrate_disable() be appropriate?  Or I suppose I could just
> > let it migrate on RT.  So how about the fix shown below?
> 
> Depends on what you want to achieve. Even with that bh-disable you can
> be preempted but you can't migrate to another CPU.

Mostly just trying to measure the overhead of a local_bh_disable()
and local_bh_enable() pair.  Yes, I understand that this is a bit
iffy these days, but it at least gets us some indication of problems
like this one:
https://lore.kernel.org/all/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop/

> That preempt-disable() will keep the RCU read section open during
> bh-disable/ enable but migrate_disable() won't. But this not something I
> need to explain to you ;) 

Not necessary most of the time, anyway.  ;-)

> If that (to be within a RCU read section) is you intention you could
> explicitly add a rcu_read_lock() there.
> The change you suggested won't have the problem I mentioned.

Very good, thank you!  I am keeping it as an "EXP" (as in "experimental")
commit in my -rcu tree for the time being, given that it sounds like
you are looking to fix this within -rt.

							Thanx, Paul
