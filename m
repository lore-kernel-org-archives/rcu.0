Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1272C214A64;
	Mon,  3 Mar 2025 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028123; cv=none; b=Wi8E3G600CrdAVxzGVKgr6HpC8r2fplywOOVkFEG8jm7BEV8aq0YVOZHsB27ZM8Uk1OylcpEEaTeffvZMvf+b98zi7AFUw1SvSFxOS0eulMsf0ySURC2fh6S8u9RwVf1W7p1maOK6cGUuc1GcMZsq40MKL0IEs/9Y0ydPNgC5yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028123; c=relaxed/simple;
	bh=OMpsrjWjDmvSug1NBsbafCCMDIV5l3SQC3Fgc3Y2F+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkhYUU7C/qkqApt3EnWwh3nh7eFAcgS8UV4o9F8uo6ZBnX59ujNLsqRuxfcAIREf2lcHcvG3d5Z5b22K7a/+mbrpMqcBe+QmHnTPNzg1wC1uXi/ks4V3XC8mMydwIqgPg37Dbz/vBAxJ4Xlu6rA6raLR5iPsGa6exMgXi3RtXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMlwRxtx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMlwRxtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB73C4CED6;
	Mon,  3 Mar 2025 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028122;
	bh=OMpsrjWjDmvSug1NBsbafCCMDIV5l3SQC3Fgc3Y2F+Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=vMlwRxtxV7o4Dp88rLSQxANUp2Oxj22jKGlRYJWhjyMjDDhkqboLkxejBEsiBRi13
	 sxAVzMslqYio5xzBFgkOj/pfnCy1iQZGjTa6HWUBw+pIMUl+paU40QuXG4UC55IzKI
	 i91JXmNr9T55mYae0tiu6svmUC7DtjbKlPEX5fupK9Pdx882WtAfjHg0ChNL0gBU8e
	 ktGe3PlsElfndhrWxC1S8kKrBvFqqJzwTMESIDXg9b/rrwlSm77SwB4SUiM+dyNjGc
	 UJ1Y7xvR++XSLfaXrB/6WFqQiEBVgJj8rai5Ju9IAT79glm/x7vvqpNvZMMs8DnnoS
	 TT9HHfbhflv/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0866BCE0444; Mon,  3 Mar 2025 10:55:22 -0800 (PST)
Date: Mon, 3 Mar 2025 10:55:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <667b6907-7ac7-4217-a3e4-0ad299267754@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <Z8H_aYBUHD2sS2Ir@pc636>
 <73724164-71f4-4671-b612-eb82a784da58@paulmck-laptop>
 <Z8IKs-I-YsOoS4uw@pc636>
 <cdab57a4-8d58-41d9-a9b5-71d425a7375e@paulmck-laptop>
 <f6803081-8243-4723-a3ba-00db351aafff@paulmck-laptop>
 <20250303001507.GA3994772@joelnvbox>
 <20250303001710.GA3997787@joelnvbox>
 <20250303170040.GA31126@joelnvbox>
 <Z8Xh0pP4xaFm0nEV@tardis>
 <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f404973-380e-4626-a2ef-8c5c44d56b83@nvidia.com>

On Mon, Mar 03, 2025 at 12:30:51PM -0500, Joel Fernandes wrote:
> 
> 
> On 3/3/2025 12:07 PM, Boqun Feng wrote:
> > On Mon, Mar 03, 2025 at 12:00:40PM -0500, Joel Fernandes wrote:
> > [...]
> >>
> >> I see the original patch "rcu: Fix get_state_synchronize_rcu_full() GP-start
> >> detection" is not yet on -next. Once we are convinced about the fix, do we
> >> want to squash the fix into this patch and have Boqun take it?
> >>
> > 
> > Which "-next" are you talking about? The original patch and the fix is
> > already in next-20250303 of linux-next:
> > 
> > 	https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20250303&qt=range&q=153fc45000e0058435ec0609258fb16e7ea257d2
> I see it now during manual inspection, but I'm confused why git cherry tells me
> otherwise.

The gitk command for the win!  ;-)

Or, in non-GUI environments, tig.

> I tried the following command and it shows the patch in question in the first
> line of output. Basically the question that the command asks is "What is in
> Paul's dev branch that is not in RCU tree's -next branch".  This question is
> asked for the obvious raisins.
> So I am obviously missing something in the command. Thoughts?
> 
> (rcugit is the RCU tree, and paul/dev is Paul's dev branch)
> 
> git cherry --abbrev -v rcugit/next paul/dev | grep "^+" | cut -d' ' -f2,3-

I must defer to others on this one.  I must confess that I have not yet
found a good use case for "git cherry".

							Thanx, Paul

> 012f47f0f806 rcu: Fix get_state_synchronize_rcu_full() GP-start detection
> 2ada0addbdb6 tools/memory-model: Add atomic_and()/or()/xor() and add_negative
> e176ebffc3f4 tools/memory-model: Add atomic_andnot() with its variants
> de6f99723392 tools/memory-model: Legitimize current use of tags in LKMM macros
> 723177d71224 tools/memory-model: Define applicable tags on operation in tools/...
> 29279349a566 tools/memory-model: Define effect of Mb tags on RMWs in tools/...
> d80a8e016433 MAINTAINERS: Update Joel's email address
> fafa18068359 tools/memory-model: Switch to softcoded herd7 tags
> dcc5197839f2 tools/memory-model: Distinguish between syntactic and semantic tags
> fa9e35a0772a tools/memory-model/README: Fix typo
> a2bfbf847c96 tools/memory-model: glossary.txt: Fix indents
> 3839dbb05869 rcutorture: Make srcu_lockdep.sh check kernel Kconfig
> b5aa1c489085 rcutorture: Make srcu_lockdep.sh check reader-conflict handling
> 9a5720bad9ed rcu: Remove swake_up_one_online() bandaid
> 04159042a62b Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"
> fdc37fed1c81 rcutorture: Split out beginning and end from rcu_torture_one_read()
> 3c6b1925361e rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT
> fadc715785cc rcutorture: Add tests for SRCU up/down reader primitives
> 90a8f490324c rcutorture: Pull rcu_torture_updown() loop body into new function
> 5fbaa5179f6a rcutorture: Comment invocations of tick_dep_set_task()
> 461810471faa rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
> 35e1a180319d rcutorture: Check for ->up_read() without matching ->down_read()
> 0676ba797dfa EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=n kernels
> c8fff13fd2fd EXP rcutorture: Add SRCU-V scenario for preemptible Tiny SRCU
> 910a5f9ebf5f EXP rcutorture: Limit callback flooding for Tiny SRCU in
> preemptible kernels
> 8979a891a365 EXP hrtimers: Force migrate away hrtimers queued after
> CPUHP_AP_HRTIMERS_DYING
> 
> 
