Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A77188A0C
	for <rcu@vger.kernel.org>; Thu, 24 Apr 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505880; cv=none; b=gDNsjiM72Pdis9uu6BfIfYHHGyXhUnR+oNSA3Nu2mbAsUbzTJKLO7nRoY4jDxRZUMeHeoJLDKqB3pN9F1X3LDH2mMLocBchycnilEOkT6rrSZ5hn3UA2PqauPAlOmJ6Q8y7HEzY8qdd9nvB3Sf4JiN4RlEM1NSxwzmbJZKsGAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505880; c=relaxed/simple;
	bh=t0ZlM9NRFPpio9KkQryADgQ4IMmqMPxdb4w6UMi5c1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oh7G4OZGH22uZHpU2iPuDpyn/l2ZF81RQdYmVJY4G/VD3PY0u9NtLO6msM+2WBCGDgnYjYew6PGT2VU+gqrW1KbGYpDIc37etSwV5HtpMUHPevR3TIkNRrXTgxXiPuLlzgDb3FclsB4F8aQdGJYbW/1tpVtU8w67YPV5+vbeTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOL7a+LX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOL7a+LX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0FEC4CEE3;
	Thu, 24 Apr 2025 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745505880;
	bh=t0ZlM9NRFPpio9KkQryADgQ4IMmqMPxdb4w6UMi5c1Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TOL7a+LXWvCO4eKAiFAdwBS2ssfwAt7wiCL9gc7eSifj2ZLajXWMvZNlTjA3BoWnL
	 syQqinhI75Izp8NXjHwI4yRXvSlcnf3dffqmGqr9xjQEypfRvjYNIodJgBlwOQHCN4
	 aX8USm7GHli/DuzxZ9coLIJJFilih9SROreVi2jKpqfHcspSv1slYZE5g0n+lgpZCP
	 g97Ex/E9V0k6qXbEepyqc5/GchLNYg2wRHdIDT8Hp/X621cmtBeyi3UXTAJWLSMRf1
	 udRIssPaMD1njVBa8Uf+SI+CdgWE2rGKzQpLXI9NUoqvI/pgKN4HSm8wBbTrvW3OU1
	 GQNMFEvrC0Sww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 844BACE076F; Thu, 24 Apr 2025 07:44:39 -0700 (PDT)
Date: Thu, 24 Apr 2025 07:44:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <6b26b3cc-6429-48c4-ae58-868d6512f0d3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
 <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
 <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>
 <616131f6-5365-40ee-ab57-27d484077a31@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616131f6-5365-40ee-ab57-27d484077a31@stanley.mountain>

On Thu, Apr 24, 2025 at 09:54:14AM +0300, Dan Carpenter wrote:
> On Wed, Apr 23, 2025 at 05:41:37PM -0700, Paul E. McKenney wrote:
> > On Wed, Apr 23, 2025 at 10:19:56AM +0300, Dan Carpenter wrote:
> > > On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
> > > > Hello Joel Fernandes,
> > > > 
> > > > Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
> > > > ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
> > > > Smatch static checker warning:
> > > > 
> > > > 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
> > > > 	warn: missing error code 'firsterr'
> > > > 
> > > > kernel/rcu/rcutorture.c
> > > >     4576                 if (torture_init_error(firsterr))
> > > >     4577                         goto unwind;
> > > >     4578         }
> > > >     4579         if (object_debug)
> > > >     4580                 rcu_test_debug_objects();
> > > >     4581         torture_init_end();
> > >                    ^^^^^^^^^^^^^^^^^^^
> > > Also:
> > > 
> > > kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)
> > 
> > You lost me on this one.  This mutex is acquired by the earlier call to
> > torture_init_begin(), but only if that function returns true.  If that
> > function returns false, yes, it releases fullstop_mutex, but in that case
> > rcu_torture_init() returns immediately, thus avoiding this invocation
> > of torture_init_end().
> > 
> > Or am I missing something subtle here?  Or missing something obvious,
> > for that matter!  ;-)
> > 
> 
> I explained it badly.  Joel's patch added a goto so now we call
> torture_init_end() twice in a row.
> 
> > 							Thanx, Paul
> > 
> > > >     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
> > > >     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> > > >     4584 
> > > >     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> > > > --> 4586                 goto unwind;
> > > > 
> > > > set an error code?
> 
> Here is the goto.
> 
> > > > 
> > > >     4587 
> > > >     4588         return 0;
> > > >     4589 
> > > >     4590 unwind:
> > > >     4591         torture_init_end();
> > >                    ^^^^^^^^^^^^^^^^^^^
> 
> Here is the second torture_init_end().

Ah!  Thank you for persisting.  Over to you, Joel!

							Thanx, Paul
