Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B154918
	for <rcu@vger.kernel.org>; Tue,  3 Jun 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985086; cv=none; b=j9PcOGAcg5EzxQxBMeAu8OSTkGEBYjeSJ8t88d+eTcZffwPQO92h5qr9Nl2SGmPHAEdcpw6cZzmtGLiDSrDX5U6pZyTaQU+gwrJFBoDPQoUvv/6i4pZZymQzdsmbfphW4bk9imt4vN6nqHAGsoNHt0extFLPff0HU9kODZjtZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985086; c=relaxed/simple;
	bh=E5+gxErBNrmFtvooXWXmzIuXdYiMKEf3CefP1VDpT2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTYYqqVHgu/XHYeunWpjAjlP4HQrHQGn+wdgre37QV6rl5LmNK702ErZFBI/cD+6GkwZ0Y03KL6m4LrG7AfSH1jngMgu8mt9+lQ5VrrLVMZgKyDjsE0Y9YbSt+Y6EqGLG8nP+z4+LZS77CrpmhCJa0k/j3sjnHT16etysfVcqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2Hs9VQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2Hs9VQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9890EC4CEED;
	Tue,  3 Jun 2025 21:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985085;
	bh=E5+gxErBNrmFtvooXWXmzIuXdYiMKEf3CefP1VDpT2Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=l2Hs9VQXJ5G76Kwm6jpsL2MyzgXLx95GdTRDrNYKJ2om3mxSTPjjpRiIF5croRpyJ
	 twPvUh/QWoLp6eXc4Jh1xQ89JTHZg0BES/YkINPg6lOa4p4MGhuFHA5UhjGwNMypkZ
	 OGyT67uf0O78lyuh96gjPhTmM9sesYfpnn9c3NotgMsyWjBGM2fDMtvlEsNhqOtl+9
	 rZ6Zi/nbfNA0CWcc684SjDEAGPskya1Xj4qOZw3w78XbFfj3gnJPPiXABhromCy8xW
	 MEaHMqm9ZlPEI59Nm/VCfW5hUJjrlwQREnDbDU+0E9GH0gs+OfLMu9D+fDq1hX4HQx
	 OktpXovVU2Y3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E284CE077B; Tue,  3 Jun 2025 14:11:25 -0700 (PDT)
Date: Tue, 3 Jun 2025 14:11:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, frederic@kernel.org,
	neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: RCU patches in flight
Message-ID: <4741ab72-7150-41c9-b214-b4c0f883ae3c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b7a341ba-cd4d-468a-9d66-4aabe70a747d@paulmck-laptop>
 <aD9exNsGkKng3ac5@tardis.local>
 <4e2211c9-d0ed-4c51-be9d-763c9eef370a@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e2211c9-d0ed-4c51-be9d-763c9eef370a@nvidia.com>

On Tue, Jun 03, 2025 at 04:51:00PM -0400, Joel Fernandes wrote:
> Hi Boqun and Paul,
> 
> On 6/3/2025 4:44 PM, Boqun Feng wrote:
> > On Tue, Jun 03, 2025 at 01:01:19PM -0700, Paul E. McKenney wrote:
> >> Hello!
> >>
> >> From what I can see, when I start testing v6.16-rc1, I will need to pull
> >> in the following commits and patches into my pile in my -rcu "dev" branch:
> >>
> >> 6c59a7c789f0 ("rcutorture: Add tests for SRCU up/down reader primitives")
> >> 0a67dd132d1d ("rcutorture: Pull rcu_torture_updown() loop body into new function")
> >> c27d0d38f2ca ("rcutorture: Complain if an ->up_read() is delayed more than 10 seconds")
> >> 3b4863a42139 ("rcutorture: Check for ->up_read() without matching ->down_read()")
> 
> Paul and this one too? I dropped it from both my PR and my rcu/dev branch:
> Subject: [PATCH 5/5] rcutorture: Fix rcutorture_one_extend_check() splat in RT

Good catch, but I do have that one in my -rcu "dev" branch.  Mostly
because I was lazy and never rebased on top of your final pull request.

Which reminds me, it is time to get Joel shared-RCU privileges if he
does not already have them, correct?

> >> The above commits must be ordered after this -rcu "dev" commit:
> >>
> >> db950fccd45a ("rcutorture: Make rcutorture_one_extend_check() account for hardirq")
> >> 	Tested-by: kernel test robot <oliver.sang@intel.com>
> >>
> >> There might be a few conflicts to resolve.  ;-)
> >>
> >> I need to drop the following commits because they are already in mainline
> >> (thank you, Joel!):
> >>
> >> 604d70035eaf ("torture: Check for "Call trace:" as well as "Call Trace:")
> >> 2e5158390089 ("rcutorture: Reduce TREE01 CPU overcommit")
> >> 90c0254a6d48 ("rcutorture: Remove MAXSMP and CPUMASK_OFFSTACK from TREE01")
> >>
> >> Anything else?
> >>
> > 
> > Hmm... we didn't sync Joel's rcu/dev to the rcu repo, did we? I believe
> > Joel had a few patches queued in the rcu/dev of his repo:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git rcu/dev
> > 
> > , which should be handed over to the next guy.
> > 
> > These are the commmits:
> > 
> > ac05b397cb2b ("rcutorture: Start rcu_torture_writer() after rcu_torture_reader()")
> > 006bc5216bd0 ("rcutorture: Print only one rtort_pipe_count splat")
> > af97b7685824 ("rcutorture: Check for no up/down readers at task level")
> > 2baf873c6c2b ("torture: Suppress torture.sh "Zero time" messages for disabled tests")

I have these.

> > b0fb3ada8fb0 ("rcu: Robustify rcu_is_cpu_rrupt_from_idle()")

I have this as an "EXP" experimental commit at the moment.

> > e2cf1ccc99a3 ("rcu/exp: Warn on CPU lagging for too long within hotplug IPI's blindspot")
> > e8b1ec78cf81 ("rcu/exp: Warn on QS requested on dying CPU")
> > b4783fc5ab1f ("rcu/exp: Remove needless CPU up quiescent state report")
> > a7e008d32033 ("rcu/exp: Remove confusing needless full barrier on task unblock")
> > 6e8a70ce57b6 ("rcu/exp: Protect against early QS report")

But I do not have these!

> > @Joel, do you want me to sync this rcu/dev branch to the rcu repo then?
> 
> Yes Boqun, go ahead and sync it with rcu's /dev. Thanks.
> 
> Also how do I get added to access the RCU tree?

Boqun, would you like to send the kernel.org request?  Just to get them
used to requests not coming from me?

							Thanx, Paul
