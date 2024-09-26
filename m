Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D3158553;
	Thu, 26 Sep 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349579; cv=none; b=OgaY9EuP8BGZ7ou3bvlUiJR4N/LbyAy2nUvsSaryjV3GYKXnmdhA9j4YPXbvg3HXqq2uJF20Ut6xSYcp5ALUYM+Klckm2Afw/eaCs1SUWNmFQt5TfMY6LIz6iacn6/tsjxHSh6Sy6mbWvZQ61cewylsgHHxNcA5AzV1+JGew8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349579; c=relaxed/simple;
	bh=Qo7MowOJ5RmfDWwzxOzaLg9TH67Af5mKzu1/BfKwgOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VppGFiG/mY45/1b9b5kYN+ISILOh0uWyq8u6tVCLO8L+l0hTQQh4AxCjI1bdEGXrQKAhoBYvl1C1FICbI/wFn7BoSccQNetzMh4Zhwujtn7nwbH9yOAhY6CKkv6ZUgJaBKd8Gc29DxffmTBzjS13WaBn1MdsyTO+q8+oL3oWD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0/wDcSn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0/wDcSn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71FDC4CEC5;
	Thu, 26 Sep 2024 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727349579;
	bh=Qo7MowOJ5RmfDWwzxOzaLg9TH67Af5mKzu1/BfKwgOA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r0/wDcSn2b8Jc86friT1rbCCR77QE9KYQHBL1VrQccJmaLHWxs65VcGMmHtDgdj6L
	 7rSN5r9Ds9eZIXGcBB1GaMiuWPEWA+Bo170neS632nt/hm5YQeCHApurHFBp7yNdK/
	 90+WIVjclqh2mC+TUIYNi6UARgiX+apFkvE6pgeFFvDuPsPs59td3Q8rQ5A++PTNFi
	 0qNkWrqOe/dukRUkLW7DBzautB4jiuZn8ObJqh1gD+juTz/77oAXK38UvbsASxBlCN
	 u3okUACz35ar5Xo64Wn6z0oKzMg6/Fx6r8DNjC2+LXf7AQQhvVweQ4PKQQy2UNVFE1
	 O3k/pvVQHmPcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ECA61CE0E61; Thu, 26 Sep 2024 04:19:37 -0700 (PDT)
Date: Thu, 26 Sep 2024 04:19:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, rcu@vger.kernel.org
Subject: Re: [paulmckrcu:dev] [srcu]  26cb612c43:
 BUG:using__this_cpu_read()in_preemptible
Message-ID: <2508c880-5449-4eb6-89be-f69b4d5d01ba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202409231124.358fed11-lkp@intel.com>
 <ff495e02-dcd4-4310-8806-58fad0dad794@paulmck-laptop>
 <ZvTHlplYV4acwazZ@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvTHlplYV4acwazZ@xsang-OptiPlex-9020>

On Thu, Sep 26, 2024 at 10:31:50AM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Wed, Sep 25, 2024 at 01:57:45AM -0700, Paul E. McKenney wrote:
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202409231124.358fed11-lkp@intel.com
> > > 
> > > 
> > > [  169.560380][   T76] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/1:2/76
> > > [ 169.561229][ T76] caller is try_check_zero (kernel/rcu/srcutree.c:485 kernel/rcu/srcutree.c:1149) 
> > 
> > Does this diff fix things for you?  Here the per-CPU access is a
> > heuristic that reduces overhead once the bulk of the CPUs have done
> > srcu_read_lock_lite().  So it is OK to get migrated just after the check.
> 
> yes, this patch fixed the random failures in our tests.
> Tested-by: kernel test robot <oliver.sang@intel.com>
> 
> we applied patch upon 26cb612c43 and run the same tests up to 200 times,
> didn't observe the issue. thanks!

Very good, and I will add your Tested-by on my next rebase.  Thank you
for all your testing efforts!

							Thanx, Paul

> =========================================================================================
> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase/torture_type:
>   gcc-12/x86_64-randconfig-006-20240921/debian-12-x86_64-20240206.cgz/300s/vm-snb/cpuhotplug/rcutorture/srcud
> 
> commit:
>   daf812f27d6bb ("srcu: Standardize srcu_data pointers to "sdp" and similar")
>   26cb612c431de ("srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()")
>   f2f1565029268  <--- your patch
> 
> daf812f27d6bbe4c 26cb612c431de5093ae6a3a67ec f2f1565029268e27760307bc82b
> ---------------- --------------------------- ---------------------------
>        fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
>            |             |             |             |             |
>            :50          66%          33:50           0%            :200   dmesg.BUG:using__this_cpu_read()in_preemptible
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index f3db4d42e70ab..07147efcb64d3 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -482,7 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
> >   */
> >  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
> >  {
> > -	bool did_gp = !!(__this_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> > +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
> >  	unsigned long unlocks;
> >  
> >  	unlocks = srcu_readers_unlock_idx(ssp, idx);
> > 
> > ------------------------------------------------------------------------
