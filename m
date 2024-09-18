Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E62F2E;
	Wed, 18 Sep 2024 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652267; cv=none; b=PmyTeGPj+Pz64bJaWSah+43VLqzs0xyy8uLuoqWMB/AsUzkmWUW4ObuW7Zl5mUKioeX/aQmcxls0cyRRviHmDA9LLxGK3/vGL9LMDb4doorUVy1jFe7kP0BFijeslmgBraqspl9AW6uMSP9DBZtZ6lNXe3D9MB6LWw3k9gSD3XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652267; c=relaxed/simple;
	bh=/YXKhttM8zuIxIN2nJwr0w1M7H9NGUcLtOuFqlKqeEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVphvudnuNLbEam3qI7eUs9L9MHPuNp6CxaKWixlanfC53T4+GRGPyO4XHGzylSAA6uFKUV9FLfap7zOtUWpqtmYNqHzjue+TnvAHwn/7SwSxtadw8nUaEw2aCy3bDRObgjyxStbnt1dCdNkZ11mv1Ke3CLUFErlRA3NG2fXNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfDmmr8N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfDmmr8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D067C4CECD;
	Wed, 18 Sep 2024 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726652267;
	bh=/YXKhttM8zuIxIN2nJwr0w1M7H9NGUcLtOuFqlKqeEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfDmmr8NP+uNEGat9zwE4x/mVW1JZYse1XNkUuiEEDbK/cFLPhGCDHt7TKtPJ4NNn
	 N6XGkK+u3SX0FOpsepD29fY+1TwzPijd5DjvvQcy/HH0MNd3/kP7L5M3JVrbScoUP2
	 IbDj5kLpSNPP4qaMNv4xWHi70/iFxf2FlysUOqANq1+6bdc/DcBJZMTyU4Qys26y1K
	 cbOkhtIVXmVqv1VSelR71BnSSscvqB6YBUePi36XDE4MUGc10YMh2vc84fozJJaPUl
	 g7Q/z5I1RzCPCXrbu/Q6NYcD9H9iEAp84i/UPJ9aBYLhGkZxkkfX+d9K2h5+hf6GiA
	 kkIEqIMHI8gxw==
Date: Wed, 18 Sep 2024 11:37:42 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <ZuqfZhvWB5ox4nh3@localhost.localdomain>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
 <ZulbS1MvZVVYe-YO@localhost.localdomain>
 <Zuli7SGxkbEbQraJ@tiehlicka>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zuli7SGxkbEbQraJ@tiehlicka>

Le Tue, Sep 17, 2024 at 01:07:25PM +0200, Michal Hocko a écrit :
> On Tue 17-09-24 12:34:51, Frederic Weisbecker wrote:
> > Le Tue, Sep 17, 2024 at 08:26:49AM +0200, Michal Hocko a écrit :
> > > On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> > > > Kthreads attached to a preferred NUMA node for their task structure
> > > > allocation can also be assumed to run preferrably within that same node.
> > > > 
> > > > A more precise affinity is usually notified by calling
> > > > kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> > > > 
> > > > For the others, a default affinity to the node is desired and sometimes
> > > > implemented with more or less success when it comes to deal with hotplug
> > > > events and nohz_full / CPU Isolation interactions:
> > > > 
> > > > - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> > > > - kswapd is affine to its node and ignores hotplug and CPU Isolation
> > > > - A bunch of drivers create their kthreads on a specific node and
> > > >   don't take care about affining further.
> > > > 
> > > > Handle that default node affinity preference at the generic level
> > > > instead, provided a kthread is created on an actual node and doesn't
> > > > apply any specific affinity such as a given CPU or a custom cpumask to
> > > > bind to before its first wake-up.
> > > 
> > > Makes sense.
> > > 
> > > > This generic handling is aware of CPU hotplug events and CPU isolation
> > > > such that:
> > > > 
> > > > * When a housekeeping CPU goes up and is part of the node of a given
> > > >   kthread, it is added to its applied affinity set (and
> > > >   possibly the default last resort online housekeeping set is removed
> > > >   from the set).
> > > > 
> > > > * When a housekeeping CPU goes down while it was part of the node of a
> > > >   kthread, it is removed from the kthread's applied
> > > >   affinity. The last resort is to affine the kthread to all online
> > > >   housekeeping CPUs.
> > > 
> > > But I am not really sure about this part. Sure it makes sense to set the
> > > affinity to exclude isolated CPUs but why do we care about hotplug
> > > events at all. Let's say we offline all cpus from a given node (or
> > > that all but isolated cpus are offline - is this even
> > > realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> > > affinity in such a case? In other words how is that different from
> > > tasksetting an userspace task to a cpu that goes offline? We still do
> > > allow such a task to run, right? We just do not care about affinity
> > > anymore.
> > 
> > Suppose we have this artificial online set:
> > 
> > NODE 0 -> CPU 0
> > NODE 1 -> CPU 1
> > NODE 2 -> CPU 2
> > 
> > And we have nohz_full=1,2
> > 
> > So there is kswapd/2 that is affine to NODE 2 and thus CPU 2 for now.
> > 
> > Now CPU 2 goes offline. The scheduler migrates off all
> > tasks. select_fallback_rq() for kswapd/2 doesn't find a suitable CPU
> > to run to so it affines kswapd/2 to all remaining online CPUs (CPU 0, CPU 1)
> > (see the "No more Mr. Nice Guy" comment).
> > 
> > But CPU 1 is nohz_full, so kswapd/2 could run on that isolated CPU. Unless we
> > handle things before, like this patchset does.
> 
> But that is equally broken as before, no? CPU2 is isolated as well so it
> doesn't really make much of a difference.

Right. I should correct my example with nohz_full=1 only.

> 
> > And note that adding isolcpus=domain,1,2 or setting 1,2 as isolated
> > cpuset partition (like most isolated workloads should do) is not helping
> > here. And I'm not sure this last resort scheduler code is the right place
> > to handle isolated cpumasks.
> 
> Well, we would have the same situation with userspace tasks, no? Say I
> have taskset -p 2 (because I want bidning to node2) and that CPU2 goes
> offline. The task needs to be moved somewhere. And it would be last
> resort logic to do that unless I am missing anything. Why should kernel
> threads be any different?

Good point.

> 
> > So it looks necessary, unless I am missing something else?
> 
> I am not objecting to patch per se. I am just not sure this is really
> needed. It is great to have kernel threads bound to non isolated cpus by
> default if they have node preferences. But as soon as somebody starts
> offlining cpus excessively and make the initial cpumask empty then
> select_fallback_rq sounds like the right thing to do.
> 
> Not my call though. I was just curious why this is needed and it seems
> to me you are looking for some sort of correctness for broken setups.

It looks like it makes sense to explore that path. We still need the
cpu up probe to reaffine when a suitable target comes up. But it seems
the CPU down part can be handled by select_fallback_rq. I'll try that.

Thanks.

> -- 
> Michal Hocko
> SUSE Labs
> 
