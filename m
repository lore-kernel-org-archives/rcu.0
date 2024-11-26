Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A51D63C5;
	Tue, 26 Nov 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637870; cv=none; b=sTyvH0FbJPzzONW9XI8i/APrrRpZ3TyvH+sQAKGB2kZSaqWP1EAQrPtkrbWJqowWy+pvPG87gLeaSkGyOOWbNByf9Gqjze/bidKKcyd8hPdfbjSsWgAq3np+zfLVaxaMuKylunpazr4EyFaBUTRnPst2U85128hRatngZ70/SmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637870; c=relaxed/simple;
	bh=1hDLF08vxv+3/CrIF4mxfa+/vOLXUuRESOZE58B97E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2VXyLpK3+gtsHX0OgvafasocUC20jU30I8wxUL/YDPJqbq2Fh61DdwwH44oLUAU865B9vl1bqAg+2uIrK+NFNSBrtLGEXRVO0nbl7uNubVHGGjT4Mi2CDoADiN5kkVbh8EU2/JoT0qaHKydnJ4GM3t3Xby34wjmC5CZCDHA83w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djJ6OsBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djJ6OsBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53682C4CECF;
	Tue, 26 Nov 2024 16:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732637870;
	bh=1hDLF08vxv+3/CrIF4mxfa+/vOLXUuRESOZE58B97E0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=djJ6OsBYD/lBxdZWUhXtWQe+DBxoXeh65iQMJqDzqYAEZpXQA3EeWST3YLzLrIApT
	 GHU5GvBzrO2IqMnWFLoP3J9RqTS0x1mjxiDVlKcz07nNTd1HhKT7idC4XxIXKo00WP
	 DGQhpHm4IwXeHt7dt0zmKii32Y0niMCiCpLh8hzMxv5QmOnJ+sha1OZE2nU5bg7/e+
	 JsTbmTHjOgPuY63j0VzBgX4E/FTWLnEL6jX3rDjI5vTvDSzmQHqhxCT1FQaY5qUT5A
	 mmeZc8t0cfMJQZ3rZHhmMqFK88OGVJ5Tza8cYFFcjnxSD2sVRNdh0SCKl9WUGySEs4
	 DZIc+Y/Qrgt/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E18C7CE0C3C; Tue, 26 Nov 2024 08:17:49 -0800 (PST)
Date: Tue, 26 Nov 2024 08:17:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: kernel test robot <oliver.sang@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [linus:master] [sched, x86]  476e8583ca:
 WARNING:at_kernel/rcu/update.c:#torture_sched_setaffinity
Message-ID: <9f5409d1-82c5-459c-a9cc-416e7320e044@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202411252253.e39d77c6-lkp@intel.com>
 <20241126143024.EKo6QfKL@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126143024.EKo6QfKL@linutronix.de>

On Tue, Nov 26, 2024 at 03:30:24PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-11-25 22:29:09 [+0800], kernel test robot wrote:
> > Hello,
> Hi,
> 
> > by this commit, we see the config has below diff:
> > 
> > --- /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/35772d627b55cc7fb4f33bae57c564a25b3121a9/.config   2024-11-22 17:03:32.458344665 +0800
> > +++ /pkg/linux/x86_64-randconfig-161-20241120/gcc-12/476e8583ca16eecec0a3a28b6ee7130f4e369389/.config   2024-11-22 17:02:59.440805587 +0800
> > @@ -121,9 +121,11 @@ CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
> >  # end of BPF subsystem
> > 
> >  CONFIG_PREEMPT_BUILD=y
> > -CONFIG_PREEMPT_NONE=y
> > +CONFIG_ARCH_HAS_PREEMPT_LAZY=y
> > +# CONFIG_PREEMPT_NONE is not set
> >  # CONFIG_PREEMPT_VOLUNTARY is not set
> >  # CONFIG_PREEMPT is not set
> > +CONFIG_PREEMPT_LAZY=y
> >  # CONFIG_PREEMPT_RT is not set
> >  CONFIG_PREEMPT_COUNT=y
> >  CONFIG_PREEMPTION=y
> > 
> …
> > commit: 476e8583ca16eecec0a3a28b6ee7130f4e369389 ("sched, x86: Enable Lazy preemption")
> …
> > 	runtime: 300s
> > 	test: cpuhotplug
> > 	torture_type: trivial
> …
> 
> > [  150.797530][  T445] ------------[ cut here ]------------
> > [  150.797915][  T445] torture_sched_setaffinity: sched_setaffinity(445) returned -22
> > [ 150.798353][ T445] WARNING: CPU: 0 PID: 445 at kernel/rcu/update.c:535 torture_sched_setaffinity (kernel/rcu/update.c:535 (discriminator 3)) 
> 
> I've been staring at this, and this is actually fine. Your config changes
> from CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_LAZY which implies
> CONFIG_PREEMPTION. The trivial RCU test there does sched_setaffinity()
> while preemption is enabled and CPU-hotplug runs in the background. So
> you get what you expect either by an attempt to move to a CPU which is
> no longer valid or by getting migrated to another CPU in the middle of
> your operation.
> 
> This is all fine. You need to update your config file or your test.

Good point, and I suspect that there will be a few rcutorture scenario
adjustments coming along shortly after -rc1 comes out.

							Thanx, Paul
