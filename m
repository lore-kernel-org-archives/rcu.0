Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312D238C0A;
	Fri,  9 Jan 2026 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924006; cv=none; b=Z27jPW7fU4hGc07E+oj0VCBXiYt2ij9EU20vTbH/FJ5TLjUv4Rjx97bV4+HKGCDHBk3EOozpi9I/M8GM5ZITzi8DpDRADEXrzN7KJmr1QbBMUUS64ATc0NhmnHVTNPCv9EVyKr83D+FSN1KikfKI+6MXJsLGr2M3XeWHNiqnfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924006; c=relaxed/simple;
	bh=FRHq1Izxb9rrtUAPiyCl80ykD6veFgHnPeczchO+SS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isscqUs8LfqPm/5p0PnlCwHqiTT/H/6X+up4ncX6EQyfz8L+L1o6SBQM4IVo5na7a2ohL18Xh8BIx8jnzGqRiAJYLTJYoYtNwftCBjIYZRdxLn3hhUpFZjjnMemKOS1WeTaWNoiPW9BC2w5JUAgek8wd5GR6Hi933/6QPqfuF6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvIc85Iw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvIc85Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CA1C116C6;
	Fri,  9 Jan 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924005;
	bh=FRHq1Izxb9rrtUAPiyCl80ykD6veFgHnPeczchO+SS4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SvIc85Iw5saEhyguFPEZEPYaEoMYhb251CpHFADvlMv8+ilTDo2dSoAZRBhtJNIFf
	 cx8sG3DVz3fSX96T7oAjiiDn18fDSpKpJfY6MpOTLVViI+8rabYdqZddI6zpktfxOq
	 nkCqTmH8H+VTUvgWE1Nh3XqOtTQB5i4ZBvT4+K4TyANInYAKOp6bWLPzKLydByGdMN
	 nIYwFvdE+wwNm8x6aQuMDs2y6DNutrx64JXNCCar3dRADv3nfVG39a8PpwBglLvIWa
	 T565E9hpC74KfhGfg5zVB/3iYhvgVttsVEpplTVnoHk/qm1mYd/KtA9qJ4M/IR8f1J
	 iKhzZhls6Pgcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D3BBECE1690; Thu,  8 Jan 2026 18:00:03 -0800 (PST)
Date: Thu, 8 Jan 2026 18:00:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <d8830d24-06a8-4565-9f60-694bb926f4b6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <936afbad-226f-4209-b347-c87b30b4a7f3@joelfernandes.org>
 <a40f5831-ae62-4d16-8a7b-b6adb2a59aa8@paulmck-laptop>
 <fa4d2f13-2fc1-4f2a-983d-66414b8ebb2d@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa4d2f13-2fc1-4f2a-983d-66414b8ebb2d@nvidia.com>

On Tue, Jan 06, 2026 at 04:24:07PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/6/2026 2:24 PM, Paul E. McKenney wrote:
> > On Tue, Jan 06, 2026 at 10:08:51AM -0500, Joel Fernandes wrote:
> >>
> >>
> >> On 1/5/2026 7:55 PM, Joel Fernandes wrote:
> >>>> Also if so, would the following rather simpler patch do the same trick,
> >>>> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
> >>>>
> >>>> ------------------------------------------------------------------------
> >>>>
> >>>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >>>> index 6a319e2926589..04dbee983b37d 100644
> >>>> --- a/kernel/rcu/Kconfig
> >>>> +++ b/kernel/rcu/Kconfig
> >>>> @@ -198,9 +198,9 @@ config RCU_FANOUT
> >>>>  
> >>>>  config RCU_FANOUT_LEAF
> >>>>  	int "Tree-based hierarchical RCU leaf-level fanout value"
> >>>> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >>>> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >>>> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
> >>>> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >>>> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >>>> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
> >>>>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
> >>>>  	default 2 if RCU_STRICT_GRACE_PERIOD
> >>>>
> >>>> ------------------------------------------------------------------------
> >>>>
> >>>> This passes a quick 20-minute rcutorture smoke test.  Does it provide
> >>>> similar performance benefits?
> >>>
> >>> I tried this out, and it also brings down the contention and solves the problem
> >>> I saw (in testing so far).
> >>>
> >>> Would this work also if the test had grace periods init/cleanup racing with
> >>> preempted RCU read-side critical sections? I'm doing longer tests now to see how
> >>> this performs under GP-stress, versus my solution. I am also seeing that with
> >>> just the node lists, not per-cpu list, I see a dramatic throughput drop after
> >>> some amount of time, but I can't explain it. And I do not see this with the
> >>> per-cpu list solution (I'm currently testing if I see the same throughput drop
> >>> with the fan-out solution you proposed).
> >>>
> >>> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
> >>> reasonable, considering this is not a default. Are you suggesting defaulting to
> >>> this for small systems? If not, then I guess the optimization will not be
> >>> enabled by default. Eventually, with this patch set, if we are moving forward
> >>> with this approach, I will remove the config option for per-CPU block list
> >>> altogether so that it is enabled by default. That's kind of my plan if we agreed
> >>> on this, but it is just an RFC stage 🙂.
> >>
> >> So the fanout solution works great when there are grace periods in progress. I
> >> see no throughput drop, and consistent performance with read site critical
> >> sections. However, if we switch to having no grace periods continuously
> >> happening in progress, I can see the throughput dropping quite a bit here
> >> (-30%). I can't explain that, but I do not see that issue with per-CPU lists.
> > 
> > Might this be due to the change in number of tasks?  Not having the
> > thread that continuously runs grace periods might be affecting scheduling
> > decisions, and with CPU overcommit, those scheduling decisions can cause
> > large changes in throughput.  Plus there are other spinlocks that might
> > be subject to vCPU preemption, including the various scheduler spinlocks.
> 
> Yeah these are all possible, currently studying it more :)

Looking forward to seeing what you find!

> >> With the per-cpu list scheme, blocking does not involve the node at all, as long
> >> as there is no grace period in progress. So, in that sense, per-CPU blocked list
> >> is completely detached from RCU - it is a bit like lazy RCU in the sense instead
> >> of a callback, it is the blocking task in a per-cpu list, relieving RCU of the
> >> burden.
> > 
> > Unless I am seriously misreading your patch, the grace-period kthread still
> > acquires your per-CPU locks.
> 
> Yes, but I am not triggering grace periods (in the tests where I am expecting an
> improvement). It is in those tests that I am seeing the throughput drop with
> FANOUT, but let me confirm that again. I did run it 200 times and notice this.
> I'm not sure what else a fanout of one for leaves does, but this is my chance to
> learn about it :).

Well, TREE09 has tested at least one aspect of this configuration quite
thoroughly over the years.  ;-)

> I am saying when there is no GPs active (that is when the optimization in these
> patches is active). In one of the patches, if grace period is in progress or
> already started, I do not trigger the optimization. The optimization is only
> when grace periods are not active. This is similar to lazy RCU, where, if we
> have active grace periods in progress, we don't really make new RCU callbacks
> lazy since it is pointless.

Interesting.  When there is no grace period is also when it is least
harmful to acquire the rcu_node structure's ->lock.

> > Also, reducing the number of grace periods> should *reduce* contention on the
> rcu_node ->lock.
> > 
> >> Maybe the extra layer of the node tree (with fanout == 1) somehow adds
> >> unnecessary overhead that does not exist with Per CPU lists? Even though there
> >> is this throughput drop, it still does better than baseline with a common RCU node.
> >>
> >> Based on this, I would say per-cpu blocked list is still worth doing. Thoughts?
> > 
> > I think that we need to understand the differences before jumping
> > to conclusions.  There are a lot of possible reasons for changes in
> > throughput, especially given the CPU overload.  After all, queuing
> > theory suggests high variance in that case, possibly even on exactly
> > the same setup.
> 
> Sure, that's why I'm doing hundreds of runs to get repetitive results and cut
> back on the outliers. But it is quite challenging to study all possibilities
> given the time constraints. I'm trying to collect traces as much as I can and
> study them. The synchronize RCU latency that I just improved, for instance, came
> from one of such exercises.

There is absolutely nothing wrong with experiments!

							Thanx, Paul
