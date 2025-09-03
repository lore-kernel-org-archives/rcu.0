Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B02F28F4;
	Wed,  3 Sep 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896134; cv=none; b=WyAqjytXNN3QjyKGcF0TzGqQjYCUjCiP5tNr3g5JCFZ807subvlomo5A7wGZ25h/tWCll8cztBRJCZmwA1gD3zZf56oqWnALgfEkNQHY1vS1UCY/PGQXsZ/zepmVBVO4O2er8hKLqjFdTsJgLjpfi3Ly5GH1wGLnp3rbWEJsj7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896134; c=relaxed/simple;
	bh=YT7cjM3Zoi3YEp1FKG1M5J+ZgWc50WMxZbYZGpIszeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oai5DuhWFPiprq9QZZlaYPhNd9aikNNCZdUWqh6syrGpP8L8p/yoURLZ7pKutNLsy8BTGxZnL8bPMi4CCXojzhqy5uGa9kUd95iNDE9YdmoFuPDyWLojJVrNtC5C7jo/vZ3dU5TUAQdytpXQXasuMEjSHeTLJtlz/69kW6yMJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r70ix0ck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r70ix0ck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2B7C4CEF0;
	Wed,  3 Sep 2025 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756896133;
	bh=YT7cjM3Zoi3YEp1FKG1M5J+ZgWc50WMxZbYZGpIszeg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r70ix0ckTBJtmOV/g9se9Gpbzj73RFY2NNzx77KO6MG8Nxat8YalLyvV6wi8eEkYO
	 SPS+yJtc7RM7VCBhvEOHlenTkzxiMqtsrGHL2FcOW0XHxzAdjbf4eIpxSpwxF0so0w
	 TNfsJzScgSzrKg2Kr9NTZKp8wOrTE5RQ+tVNphZO9ZdU612+sHr+ZujEvSAHsMD0pQ
	 d38Mr7sHKo89tk+338oKVc7yCmlyAcCsZWkfNXHmvjqztsGeJgIJ1IkmWiFavPoV+N
	 nn88eHGOI3KbHTKWefES+VL4DxEHz4kOy14qISfaHCWiCKlcXFHx640u+m9gIfaWGu
	 YOXT+ioeb0BzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2093CCE0FFB; Wed,  3 Sep 2025 03:42:13 -0700 (PDT)
Date: Wed, 3 Sep 2025 03:42:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu]  8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <76ea5b26-92fb-470b-a3dc-3424944a50be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
 <aLeiBGeUj5nHBlK1@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLeiBGeUj5nHBlK1@xsang-OptiPlex-9020>

On Wed, Sep 03, 2025 at 10:03:48AM +0800, Oliver Sang wrote:
> hi, Paul,
> On Fri, Aug 29, 2025 at 10:23:17AM -0700, Paul E. McKenney wrote:
> 
> [...]
> 
> > Again, apologies for being slow, and thank you for your testing efforts.
> > 
> > Idiot here forgot about Tiny SRCU, so please see the end of this email
> > for an alleged fix.  Does it do the trick for you?
> 
> besides the patch [1] as in the end part of mail, we noticed you also have a
> patch in [2]. I don't have enough knowledge to follow the dicussion between
> you and Zqiang well. it just seems to me both patches are fixes which should
> be squashed into original patch?
> 
> I made below applyment:
> 
> * e5ab29c09c470e squash! rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast   <--- patch in [2]
> * f717bca99dfb15 1st fix patch for 8bd9383727 from Paul   <--- patch in [1]
> * 8bd9383727068a rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
> 
> by testing, the issue "WARNING:possible_circular_locking_dependency_detected"
> cannot be reproduced on both f717bca99dfb15 and e5ab29c09c470e
> 
> sorry if I miss or misunderstood something, otherwise,

You got it exactly!  The updated commit is this one:

a9e63382cbfa ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")

> Tested-by: kernel test robot <oliver.sang@intel.com>

I will apply on my next rebase, and thank you for your testing efforts!

							Thanx, Paul

> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb-lkp@intel.com
> 
> [...]
> 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20250826/202508261642.b15eefbb-lkp@intel.com
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
> 
> [1]
> 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> > index 6e9fe2ce1075d5..db63378f062051 100644
> > --- a/kernel/rcu/srcutiny.c
> > +++ b/kernel/rcu/srcutiny.c
> > @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
> >  	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> >  	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> >  	preempt_enable();
> > -	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> > +	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
> >  		swake_up_one(&ssp->srcu_wq);
> >  }
> >  EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> > 
> 
> [2] https://lore.kernel.org/all/8f43f958-e3e6-44d5-9600-9e096c3a06b7@paulmck-laptop/
