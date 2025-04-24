Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96519A
	for <rcu@vger.kernel.org>; Thu, 24 Apr 2025 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745455298; cv=none; b=O7yC1mytBBXssWQ40dx3P8l9O2UcffIEih/gaaXHGs1IFfj3U08RWBsZadBd7hTcSHdimv0lgm0Navj3k3lhM0iMIGyPyMoPcWqPD5XeknCyLQvQ+E/CGB3FDq1ajFRrb0ZRSDmh1+uMgB5vQhoIgz4NnuE+MPFDM7KH8jkuYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745455298; c=relaxed/simple;
	bh=lmyAljHDnD9EHWVm3SyZMyY99yZ7flABaFzO+P8FiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noM5l/RHR48TQWJ6Sf42AtyfKws4DYRo0lm3h7GpcSNI/GxqHC0J9l6mj65D6W+oyQhSF2/kPwdt5OWJJULzdt20tsC6wnRyH2/hf00uA6aZPBeLK0iHd+swB2eBTvMon43SqziWix/2YAIpqGCbcvTbBxvQEs1QshX2OHfoZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8tQfuBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8tQfuBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6416C4CEE2;
	Thu, 24 Apr 2025 00:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745455297;
	bh=lmyAljHDnD9EHWVm3SyZMyY99yZ7flABaFzO+P8FiyQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=p8tQfuBT0JSuzPern/6OJzB3TcH2DStIw1jNX9aZ868iy8zag3MD4eoc2ANNhrmah
	 6hNexJ5W+cMlVyHnViGn6HjYf1l+C9oy1KIEfwqEf7+Z6gup6HIGPvxMChItMQvkni
	 IO04SK8toiAcfT4ytiAt4TeV7gZvrytIa9PQoZrLANqRWJhoLBt706MMXsjCBGgA4F
	 hAhj7UQpr9vHDJBJ7nmYQkI74PrtYuhcyzpBGrsVUIJ4mf0XZnbbPQy7W7aYN3p3mn
	 vh2WCr3T8Xy6cApbZ9tcNRD44O+FxS8ELq6Pm67Q/bcLNo6Z1afvizsSLhw+6UMg+k
	 F5HdwssUEz6zA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 75C55CE0B75; Wed, 23 Apr 2025 17:41:37 -0700 (PDT)
Date: Wed, 23 Apr 2025 17:41:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org
Subject: Re: [bug report] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <a2090431-7299-4fc3-89cb-114026f482b1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aAiT_KWYN-gP-2MN@stanley.mountain>
 <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8669b6b-63e0-454d-8a58-09043015bc61@stanley.mountain>

On Wed, Apr 23, 2025 at 10:19:56AM +0300, Dan Carpenter wrote:
> On Wed, Apr 23, 2025 at 10:17:16AM +0300, Dan Carpenter wrote:
> > Hello Joel Fernandes,
> > 
> > Commit bd57ec707441 ("rcutorture: Perform more frequent testing of
> > ->gpwrap") from Feb 16, 2025 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	kernel/rcu/rcutorture.c:4586 rcu_torture_init()
> > 	warn: missing error code 'firsterr'
> > 
> > kernel/rcu/rcutorture.c
> >     4576                 if (torture_init_error(firsterr))
> >     4577                         goto unwind;
> >     4578         }
> >     4579         if (object_debug)
> >     4580                 rcu_test_debug_objects();
> >     4581         torture_init_end();
>                    ^^^^^^^^^^^^^^^^^^^
> Also:
> 
> kernel/rcu/rcutorture.c:4591 rcu_torture_init() warn: double unlock 'global &fullstop_mutex' (orig line 4581)

You lost me on this one.  This mutex is acquired by the earlier call to
torture_init_begin(), but only if that function returns true.  If that
function returns false, yes, it releases fullstop_mutex, but in that case
rcu_torture_init() returns immediately, thus avoiding this invocation
of torture_init_end().

Or am I missing something subtle here?  Or missing something obvious,
for that matter!  ;-)

							Thanx, Paul

> >     4582         if (cur_ops->gp_slow_register && !WARN_ON_ONCE(!cur_ops->gp_slow_unregister))
> >     4583                 cur_ops->gp_slow_register(&rcu_fwd_cb_nodelay);
> >     4584 
> >     4585         if (cur_ops->set_gpwrap_lag && rcu_gpwrap_lag_init())
> > --> 4586                 goto unwind;
> > 
> > set an error code?
> > 
> >     4587 
> >     4588         return 0;
> >     4589 
> >     4590 unwind:
> >     4591         torture_init_end();
>                    ^^^^^^^^^^^^^^^^^^^
> 
> regards,
> dan carpenter
> 
> >     4592         rcu_torture_cleanup();
> >     4593         if (shutdown_secs) {
> >     4594                 WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
> >     4595                 kernel_power_off();
> >     4596         }
> >     4597         return firsterr;
> >     4598 }
> > 
> > regards,
> > dan carpenter
> 
