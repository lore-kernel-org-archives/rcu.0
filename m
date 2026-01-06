Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A534DB61;
	Tue,  6 Jan 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727472; cv=none; b=GTOFgj0aiQ3naLHm4iCp5AJGbj6FJUNmJ2XPHFYtHt3xDIBEjSNoKwxq+d1ibYuyZy8UDjYhpC47SiCD1BIjOo7QGISi/tyferb5DBa3YpoVpB7d1wFW0oVnwo+E1rcfBnYOIQYVB0bcFkcpnC4A21noQVUrsgawwtlAC9X/nlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727472; c=relaxed/simple;
	bh=8C+KrB9+g622gpUBABQFmrhxlv9o1wOfAJYqZ2KwQ+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG8ZPJIxug/bvvo0dSTYfSFNZq4mM+Z/JvU4TS7FZ5j2gt9RuCpqeL4k6rxDYTQCwe9uj3vccDgbLMF7VipUXyjQ6N4ANcfwAlRQMEnSN8VL4xmH7t50+I4RSd/L9hON7bKtVK09f6FUs9++yqU0XcK1j1kbsAA1cAD/34BULtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYds38yn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYds38yn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF58C116C6;
	Tue,  6 Jan 2026 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767727472;
	bh=8C+KrB9+g622gpUBABQFmrhxlv9o1wOfAJYqZ2KwQ+Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fYds38ynymrYIeTNRMXcR2g4303s2OimaXCrH3BaW1du8LPEcvEFhc/YMiIk0BPyg
	 opLldxrSOZnyVPQhwnproDC81OkGZHe3ZGiUpov0cA1xsEFAKohxyjbtc2n1JEQbiW
	 pZHblpXKBXQ5WtM+Ksm1KrfJ11OrXWlbxmgdc1xtmvPm3t2NxcVNmLJlttXuokM74p
	 U/eTFp2idrqCUN/Km7+fyzd3SVhzPY/aOzA4nhOonYfOsZ+Cp834ESPRjnTG29FJcJ
	 GMWa8FwkvToiftlFmkwbkIDXos58DANNWrovO1fw23PChDXc88EumlLP3NyZ4Jp1p+
	 MbPDJEbMJV7oA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5DB7CE0B06; Tue,  6 Jan 2026 11:24:31 -0800 (PST)
Date: Tue, 6 Jan 2026 11:24:31 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
Message-ID: <a40f5831-ae62-4d16-8a7b-b6adb2a59aa8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
 <936afbad-226f-4209-b347-c87b30b4a7f3@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <936afbad-226f-4209-b347-c87b30b4a7f3@joelfernandes.org>

On Tue, Jan 06, 2026 at 10:08:51AM -0500, Joel Fernandes wrote:
> 
> 
> On 1/5/2026 7:55 PM, Joel Fernandes wrote:
> >> Also if so, would the following rather simpler patch do the same trick,
> >> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
> >>
> >> ------------------------------------------------------------------------
> >>
> >> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> >> index 6a319e2926589..04dbee983b37d 100644
> >> --- a/kernel/rcu/Kconfig
> >> +++ b/kernel/rcu/Kconfig
> >> @@ -198,9 +198,9 @@ config RCU_FANOUT
> >>  
> >>  config RCU_FANOUT_LEAF
> >>  	int "Tree-based hierarchical RCU leaf-level fanout value"
> >> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
> >> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
> >> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
> >> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
> >>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
> >>  	default 2 if RCU_STRICT_GRACE_PERIOD
> >>
> >> ------------------------------------------------------------------------
> >>
> >> This passes a quick 20-minute rcutorture smoke test.  Does it provide
> >> similar performance benefits?
> >
> > I tried this out, and it also brings down the contention and solves the problem
> > I saw (in testing so far).
> > 
> > Would this work also if the test had grace periods init/cleanup racing with
> > preempted RCU read-side critical sections? I'm doing longer tests now to see how
> > this performs under GP-stress, versus my solution. I am also seeing that with
> > just the node lists, not per-cpu list, I see a dramatic throughput drop after
> > some amount of time, but I can't explain it. And I do not see this with the
> > per-cpu list solution (I'm currently testing if I see the same throughput drop
> > with the fan-out solution you proposed).
> > 
> > I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
> > reasonable, considering this is not a default. Are you suggesting defaulting to
> > this for small systems? If not, then I guess the optimization will not be
> > enabled by default. Eventually, with this patch set, if we are moving forward
> > with this approach, I will remove the config option for per-CPU block list
> > altogether so that it is enabled by default. That's kind of my plan if we agreed
> > on this, but it is just an RFC stage 🙂.
> 
> So the fanout solution works great when there are grace periods in progress. I
> see no throughput drop, and consistent performance with read site critical
> sections. However, if we switch to having no grace periods continuously
> happening in progress, I can see the throughput dropping quite a bit here
> (-30%). I can't explain that, but I do not see that issue with per-CPU lists.

Might this be due to the change in number of tasks?  Not having the
thread that continuously runs grace periods might be affecting scheduling
decisions, and with CPU overcommit, those scheduling decisions can cause
large changes in throughput.  Plus there are other spinlocks that might
be subject to vCPU preemption, including the various scheduler spinlocks.

> With the per-cpu list scheme, blocking does not involve the node at all, as long
> as there is no grace period in progress. So, in that sense, per-CPU blocked list
> is completely detached from RCU - it is a bit like lazy RCU in the sense instead
> of a callback, it is the blocking task in a per-cpu list, relieving RCU of the
> burden.

Unless I am seriously misreading your patch, the grace-period kthread still
acquires your per-CPU locks.  Also, reducing the number of grace periods
should *reduce* contention on the rcu_node ->lock.

> Maybe the extra layer of the node tree (with fanout == 1) somehow adds
> unnecessary overhead that does not exist with Per CPU lists? Even though there
> is this throughput drop, it still does better than baseline with a common RCU node.
> 
> Based on this, I would say per-cpu blocked list is still worth doing. Thoughts?

I think that we need to understand the differences before jumping
to conclusions.  There are a lot of possible reasons for changes in
throughput, especially given the CPU overload.  After all, queuing
theory suggests high variance in that case, possibly even on exactly
the same setup.

							Thanx, Paul
