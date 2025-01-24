Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF812C484;
	Fri, 24 Jan 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733765; cv=none; b=JZyqv4O0T7pcgYtP0DhLb7uBaNGcg3TTIR47QgvAL1oZHiyjOZ+tCJGfptmNpFmtH14esHehXMiX9RH6+MY0Y7xtMGYOt+4NNvgvsBnr9/qvTEkeumK1ye27xeIBPk2rxDLJFoKpgGGY0TSLjuhJ+mumkIjg3WXwfr7BZEoQbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733765; c=relaxed/simple;
	bh=4XS3R7mtDBzp/BdILqI6T6RrtsX/n40dLsgq4B6Nygk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvet1oNL5+IfmVx+qa8p5I+ThDKYEz0+cmkAKPXhBYvRzLtB/78BZ6l5mWhG8Ak0ceIUppCf6egJU8TVmZcLLZhiVotR9DtbWR9B7SnuIAoSQH+KFVH+CdG9xYkaBPUmL5HALClUWCZi+qiGu44tI3OjHwB4HIqAj17mib5b+5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kObnP978; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kObnP978"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C23C4CED2;
	Fri, 24 Jan 2025 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737733764;
	bh=4XS3R7mtDBzp/BdILqI6T6RrtsX/n40dLsgq4B6Nygk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kObnP978DRWu4I+c+rs6Vet5Z3I+DRAa09FxRt7yuRtYRag4/oHP2LoeABuJPfD04
	 LigW522udu6EnVDiSCCAioprB1p9UGhihfrCvsE4g2WohsMUKG9RYY2PvODdPk+iLC
	 /lQhiNzPK66wiv1xhjEnI6tFHwQluVemCdftDQsbs/rJHfw2WX1B2R6nsPa2DFkbYA
	 G+3COb2yYYZGsI0djqaDtx4XXuM9c2s3unTHiaN/ds3ydJzJQ/vUl08uKt63I3e3qH
	 2LDNnq8ixFdyD19jQ+za3GB78xyczcznUlvfWC69AFSE+Te0FTU/ClcFPMyaGPGCux
	 Sk38k5VtNB/sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 64228CE160E; Fri, 24 Jan 2025 07:49:24 -0800 (PST)
Date: Fri, 24 Jan 2025 07:49:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 4/4] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <00900afe-ac4e-4362-a3f9-d65f2c9dcd9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250123185828.460836-1-urezki@gmail.com>
 <20250123185828.460836-4-urezki@gmail.com>
 <ea7d8677-f81e-4590-9716-23ea41597873@paulmck-laptop>
 <Z5N9_EafVhSfE6nA@pc636>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5N9_EafVhSfE6nA@pc636>

On Fri, Jan 24, 2025 at 12:48:12PM +0100, Uladzislau Rezki wrote:
> On Thu, Jan 23, 2025 at 01:52:57PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 23, 2025 at 07:58:28PM +0100, Uladzislau Rezki (Sony) wrote:
> > > Switch for using of get_state_synchronize_rcu_full() and
> > > poll_state_synchronize_rcu_full() pair for debug a normal
> > > synchronize_rcu() call.
> > > 
> > > Just using "not" full APIs to identify if a grace period
> > > is passed or not might lead to a false kernel splat.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  include/linux/rcupdate_wait.h | 4 ++++
> > >  kernel/rcu/tree.c             | 8 +++-----
> > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > > index f9bed3d3f78d..a16fc2a9a7d7 100644
> > > --- a/include/linux/rcupdate_wait.h
> > > +++ b/include/linux/rcupdate_wait.h
> > > @@ -16,6 +16,10 @@
> > >  struct rcu_synchronize {
> > >  	struct rcu_head head;
> > >  	struct completion completion;
> > > +#ifdef CONFIG_PROVE_RCU
> > > +	/* This is for testing. */
> > > +	struct rcu_gp_oldstate oldstate;
> > > +#endif
> > >  };
> > >  void wakeme_after_rcu(struct rcu_head *head);
> > >  
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2795d6b5109c..0ae90089ef09 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1612,12 +1612,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> > >  {
> > >  	struct rcu_synchronize *rs = container_of(
> > >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > > -	unsigned long oldstate = (unsigned long) rs->head.func;
> > >  
> > >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > > -		!poll_state_synchronize_rcu(oldstate),
> > > -		"A full grace period is not passed yet: %lu",
> > > -		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> > > +		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > > +		"A full grace period is not passed yet!\n");
> > 
> > Looks good, but why not also continue printing out the required
> > grace-period sequence number?  Yes, there would need to be helper
> > sprintf()-style functions to paper over the difference between Tiny RCU
> > and Tree RCU.  ;-)
> > 
> Uhh :) Do we have rcu_seq_diff() for a _full() API? Looks like not :)
> 
> It contains both, rgos_norm and rgos_exp! Take a delta of both?

Why not?  Maybe separate the two differences with a colon.

Or maybe make a variant of poll_state_synchronize_rcu_full() that take
a char* argument, which uses the same value for the check and the string
to be output.

							Thanx, Paul
