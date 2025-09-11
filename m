Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ADF1A2387;
	Thu, 11 Sep 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592373; cv=none; b=t7cKsPCdfVpZcIFVyTVtO8RCTW/oC/4Q/DZ8J2CacKJROuxP3yFifBK6YgeKK7sW7TVe3IHzkwYnYXgCt/qv8u1kClgIU7fKfGLnohFw87FT8JPgEPnH7VCEAmSsGg7logEihGLajSd3l22AoGfSb9cABE781a8G8AIZsrfnc7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592373; c=relaxed/simple;
	bh=OSJ2jcFpwfXRBQx9mfDbM5b/WgIMM0wznG9i3vTrIuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkWY/FLKLWOxRoZQyJ79yNhH9cEJLUoShtqmtSF5lrPGjaj2bLM25RvNFFGwdHsGl36qpXMJ8GH6jmVXb7JTs78VPlsfTm4U0T/Xqvc/93obchl/OsQBKXefxdwWqKKbkmwXpCOn7Z5YmuQ/SLQU1TtPoQZ4T1FVdufAWNKn1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyp5/pkS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyp5/pkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C273C4CEF0;
	Thu, 11 Sep 2025 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757592373;
	bh=OSJ2jcFpwfXRBQx9mfDbM5b/WgIMM0wznG9i3vTrIuY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nyp5/pkSEPU4nb/IushypKjW6jEAJhrBGduY6GreNHoH/wvjbG2NouOvyhNawBf8r
	 L8OYf9AYhIwmAfkRImAGl+lYyqyFe18Gry13Egdrp0LA/MuGMkMb8dzglHAG2Yn0h6
	 YAIE4ZHIfk+coYcRtrrD/mi/WHq74tN/IPwunfQFrQLV5HAWxe3sfDDf3UmWTnbgyl
	 v4cYJehGLcjshyNrip+KAYoCftezRRpEFJOnt5hgQBRPDXZfJlyXxEoDlWlj8kacXR
	 BWgJTfmjmg/RtcXzQxR4/OzVEPCvpzAJiGW1hB6Qo63aeGwU9x62F/5OZYEomwN5lF
	 7nlAlxENJMwLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CCDFDCE0C39; Thu, 11 Sep 2025 05:06:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 05:06:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, frederic@kernel.org,
	neeraj.upadhyay@kernel.org, boqun.feng@gmail.com, urezki@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in
 srcu_gp_start_if_needed()
Message-ID: <ab97f38c-2750-4cd7-a9a4-6c25fc1cc45d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250909133928.615218-1-qiang.zhang@linux.dev>
 <4c7d977b-7d09-48e0-9a88-bae93fa5e401@paulmck-laptop>
 <20250910143620.GA561834@joelbox2>
 <e5e69dc3-ebd3-47ae-b193-bc4b2de36904@paulmck-laptop>
 <70fa9fd07e4fe2b1b498109f3450804e731fd7ce@linux.dev>
 <430d5714-4a00-4a75-b763-34918f8017c3@paulmck-laptop>
 <1133458227af4b9a7a0cee284502a0643f1fad3f@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133458227af4b9a7a0cee284502a0643f1fad3f@linux.dev>

On Thu, Sep 11, 2025 at 11:46:36AM +0000, Zqiang wrote:
> > 
> > On Thu, Sep 11, 2025 at 12:36:45AM +0000, Zqiang wrote:
> > 
> > > 
> > > On Wed, Sep 10, 2025 at 10:36:20AM -0400, Joel Fernandes wrote:
> > >  
> > >  > 
> > >  > [..]
> > >  > > kernel/rcu/srcutiny.c | 4 +---
> > >  > > 1 file changed, 1 insertion(+), 3 deletions(-)
> > >  > > 
> > >  > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > >  > > index b52ec45698e8..b2da188133fc 100644
> > >  > > --- a/kernel/rcu/srcutiny.c
> > >  > > +++ b/kernel/rcu/srcutiny.c
> > >  > > @@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  > > {
> > >  > > unsigned long cookie;
> > >  > > 
> > >  > > - preempt_disable(); // Needed for PREEMPT_LAZY
> > >  > > + lockdep_assert_preemption_disabled();
> > >  > 
> > >  > nit: Do we still want to keep the comment that the expectation of preemption
> > >  > being disabled is for the LAZY case?
> > >  > 
> > >  Good point, and I do believe that we do. Zqiang, any reason not to
> > >  add this comment back in?
> > >  
> > >  in rcu-tree, this commit:
> > >  
> > >  (935147775c977 "EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels")
> > >  
> > >  make preempt disable needed for CONFIG_PREEMPT=y or CONFIG_PREEMPT_LAZY=y
> > >  when the CONFIG_SMP=n. do we need to replace "Needed for PREEMPT_LAZY"
> > >  comments with "Needed for PREEMPT or PREEMPT_LAZY"?
> > > 
> > Good point as well, thank you! And I need to decide whether I should
> > send that patch upstream. Its original purpose was to test PREEMPT_LAZY=y
> > better than could be tested with PREEMPT_LAZY.
> > 
> > Thoughts?
> 
> I will add "Needed for PREEMPT_LAZY" comments, if this commit (935147775c977) is
> send to upstream, will update comments again in the future.

That sounds good to me, thank you!

							Thanx, Paul

> Thanks
> Zqiang
> 
> > 
> >  Thanx, Paul
> > 
> > > 
> > > Thanks
> > >  Zqiang
> > >  
> > >  
> > >  
> > >  Thanx, Paul
> > >  
> > >  > 
> > >  > thanks,
> > >  > 
> > >  > - Joel
> > >  > 
> > >  > 
> > >  > > cookie = get_state_synchronize_srcu(ssp);
> > >  > > if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
> > >  > > - preempt_enable();
> > >  > > return;
> > >  > > }
> > >  > > WRITE_ONCE(ssp->srcu_idx_max, cookie);
> > >  > > @@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
> > >  > > else if (list_empty(&ssp->srcu_work.entry))
> > >  > > list_add(&ssp->srcu_work.entry, &srcu_boot_list);
> > >  > > }
> > >  > > - preempt_enable();
> > >  > > }
> > >  > > 
> > >  > > /*
> > >  > > -- 
> > >  > > 2.48.1
> > >  > >
> > >  >
> > >
> >
