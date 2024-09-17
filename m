Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877861FCE;
	Tue, 17 Sep 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569296; cv=none; b=GjD8Buc73Ey4cShPon9EGdZnRglsT2WvWRjzE9nuJEHoNdHCrot+22nZ12BHls14x96ukVuWDFQHGe9SSzINleQS4tIxs+uc4adkUHkrMA4ktWAvk4MgNKkDS25CleGvY8OV0lnTbsjjNIKOlNCnMj/qrut9oCkPqX2bqjcGS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569296; c=relaxed/simple;
	bh=jkoXYaDwCNxtdu1uXwJxHkE0KqMtq8XRlMuq5uYA7+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDPbresAHYEscxV8P/d8aqIHRucwuN6K8P7NBMHvpq0BEVtDOIWliXYUiCATWUJ8dt+ea4B8jsOJhVdNoIgG8Xm69Om6A1CBL3RcFWadSNVql92q+bRtMNt/lhm6T9i9sHFbxSmP/2yOXkDuxkmIm3N3OlDDlxUHErQBNYAEy/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQC6j6WM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQC6j6WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556F1C4CEC6;
	Tue, 17 Sep 2024 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726569295;
	bh=jkoXYaDwCNxtdu1uXwJxHkE0KqMtq8XRlMuq5uYA7+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQC6j6WM0pSGZOMjvw4jMiRTLPPxbzbIvA/OEmOQBzvMzc/RuMlAONRYmY/yA3i7F
	 q0CqWxT6t2XuukQyNlUrhR2VU862bo6KAKam31zYfGT2FG0SO79V1SBg3/pG0iY82i
	 bcsLb1yB0dvm6JbeJ0u9CBb4KwO30iP6zljXKG64l2IghIH2+1fZBk0UaZy/vtbdtK
	 USojShQXCJnEK2IUvhLOzIdBaXTVkdwFiaI+eWIFubioDJZQ9FQV9Rtws6+9VGSd1z
	 1dt1YJy0y6wP/Xlh0aQoejbdvMy2hjlhrBF4Lk40fX3L4UA3hF6k/W6C16n8VdnNGU
	 qAf3XH6WHM/8g==
Date: Tue, 17 Sep 2024 12:34:51 +0200
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
Message-ID: <ZulbS1MvZVVYe-YO@localhost.localdomain>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZukhKXxErPOaXtAL@tiehlicka>

Le Tue, Sep 17, 2024 at 08:26:49AM +0200, Michal Hocko a écrit :
> On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> > Kthreads attached to a preferred NUMA node for their task structure
> > allocation can also be assumed to run preferrably within that same node.
> > 
> > A more precise affinity is usually notified by calling
> > kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> > 
> > For the others, a default affinity to the node is desired and sometimes
> > implemented with more or less success when it comes to deal with hotplug
> > events and nohz_full / CPU Isolation interactions:
> > 
> > - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> > - kswapd is affine to its node and ignores hotplug and CPU Isolation
> > - A bunch of drivers create their kthreads on a specific node and
> >   don't take care about affining further.
> > 
> > Handle that default node affinity preference at the generic level
> > instead, provided a kthread is created on an actual node and doesn't
> > apply any specific affinity such as a given CPU or a custom cpumask to
> > bind to before its first wake-up.
> 
> Makes sense.
> 
> > This generic handling is aware of CPU hotplug events and CPU isolation
> > such that:
> > 
> > * When a housekeeping CPU goes up and is part of the node of a given
> >   kthread, it is added to its applied affinity set (and
> >   possibly the default last resort online housekeeping set is removed
> >   from the set).
> > 
> > * When a housekeeping CPU goes down while it was part of the node of a
> >   kthread, it is removed from the kthread's applied
> >   affinity. The last resort is to affine the kthread to all online
> >   housekeeping CPUs.
> 
> But I am not really sure about this part. Sure it makes sense to set the
> affinity to exclude isolated CPUs but why do we care about hotplug
> events at all. Let's say we offline all cpus from a given node (or
> that all but isolated cpus are offline - is this even
> realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> affinity in such a case? In other words how is that different from
> tasksetting an userspace task to a cpu that goes offline? We still do
> allow such a task to run, right? We just do not care about affinity
> anymore.

Suppose we have this artificial online set:

NODE 0 -> CPU 0
NODE 1 -> CPU 1
NODE 2 -> CPU 2

And we have nohz_full=1,2

So there is kswapd/2 that is affine to NODE 2 and thus CPU 2 for now.

Now CPU 2 goes offline. The scheduler migrates off all
tasks. select_fallback_rq() for kswapd/2 doesn't find a suitable CPU
to run to so it affines kswapd/2 to all remaining online CPUs (CPU 0, CPU 1)
(see the "No more Mr. Nice Guy" comment).

But CPU 1 is nohz_full, so kswapd/2 could run on that isolated CPU. Unless we
handle things before, like this patchset does.

And note that adding isolcpus=domain,1,2 or setting 1,2 as isolated
cpuset partition (like most isolated workloads should do) is not helping
here. And I'm not sure this last resort scheduler code is the right place
to handle isolated cpumasks.

So it looks necessary, unless I am missing something else?

And that is just for reaffine on CPU down. CPU up needs mirroring treatment
and also it must handle new CPUs freshly added to a node.

Thanks.

> -- 
> Michal Hocko
> SUSE Labs
> 
