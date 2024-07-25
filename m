Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949355884;
	Thu, 25 Jul 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935991; cv=none; b=dnSYa1ZqrrhLYoDKhnCxe6FISZ8P5uqJWMkRXGFm3zB9TZNK9UCu1HTPUS84gb8/tHnmIyKJv5D+fH45VUng7EvW7zSBlma0Zm3q9mnVh0JktdyCAs4utyaDCN6Q1ZXGX6/7WUDkyU/SVbhgdkxCmuemCbA8HTz7N8+4jSsACfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935991; c=relaxed/simple;
	bh=GPeR8ui0fh4uL8CvaOVchOv15+7fvh9FFplNSDqxdcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwvPekYujSUit9L0Xk1Qng82ChCeAuNd59/JMQTUZ37WUoNij91+8640DOPJ009q5WhQHFCG4b6p5IybHCKlkFmV4k+Vo4nyd1GE8gMheHqETJAN0Y3cAdtS3UuxHrS3jV69s5MTSQrXkcO7YkfVqG9ODFc7vf21Tiogc5g6EvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQDeSRqk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQDeSRqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04784C116B1;
	Thu, 25 Jul 2024 19:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721935990;
	bh=GPeR8ui0fh4uL8CvaOVchOv15+7fvh9FFplNSDqxdcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQDeSRqkSDzQnIlOLdtshznAGHSt4TTlTpyvcAyoOBrxY3teBiLK8nxw+S8D49BSG
	 MdGSwc/KJhq0JVD93lyFYo6pxBv6mSvQwI1eSiURufUszvdeT4MXd0nS+SJgeKmTEe
	 XjeniUmI7JwHGtnkeTgGXNDDnfueUMlKMXN1lRcOUJcMixkl+9LBDQK3uhjqG1FGAe
	 TWkaYCoOsgpFJQGZpNArBvs+9VRSy2IH3gD4onqwk8XmYxwkCEWRiZZ5yxTTzbZMo9
	 O8+Oa59HKjC6pYdfO8TA6QSZ/Jpg9iJ35qImVxYJ3oo+MyjBrl5h1Z+lzpXOh1eVEi
	 hOxQN0Mk+Cktg==
Date: Fri, 26 Jul 2024 01:03:02 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
Message-ID: <20240725193302.GA927854@neeraj.linux>
References: <20240723181025.187413-1-longman@redhat.com>
 <20240725153552.GA927762@neeraj.linux>
 <96aec91c-aa5c-4352-b93c-323b22011370@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96aec91c-aa5c-4352-b93c-323b22011370@redhat.com>

On Thu, Jul 25, 2024 at 01:02:01PM -0400, Waiman Long wrote:
> On 7/25/24 11:35, Neeraj Upadhyay wrote:
> > On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
> > > It was discovered that isolated CPUs could sometimes be disturbed by
> > > kworkers processing kfree_rcu() works causing higher than expected
> > > latency. It is because the RCU core uses "system_wq" which doesn't have
> > > the WQ_UNBOUND flag to handle all its work items. Fix this violation of
> > > latency limits by using "system_unbound_wq" in the RCU core instead.
> > > This will ensure that those work items will not be run on CPUs marked
> > > as isolated.
> > > 
> > Alternative approach here could be, in case we want to keep per CPU worker
> > pools, define a wq with WQ_CPU_INTENSIVE flag. Are there cases where
> > WQ_CPU_INTENSIVE wq won't be sufficient for the problem this patch
> > is fixing?
> 
> What exactly will we gain by defining a WQ_CPU_INTENSIVE workqueue? Or what
> will we lose by using system_unbound_wq? All the calls that are modified to
> use system_unbound_wq are using WORK_CPU_UNBOUND as their cpu. IOW, they
> doesn't care which CPUs are used to run the work items. The only downside I
> can see is the possible loss of some cache locality.
> 

For the nohz_full case, where unbounded pool workers run only on housekeeping CPU
(cpu0), if multiple other CPUs are queuing work, the execution of those
works could get delayed. However, this should not generally happen as
other CPUs would be mostly running in user mode.


> In fact, WQ_CPU_INTENSIVE can be considered a subset of WQ_UNBOUND. An
> WQ_UNBOUND workqueue will avoid using isolated CPUs, but not a
> WQ_CPU_INTENSIVE workqueue.

Got it, thanks!

I have picked the patch for further review and testing [1]


[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=next


- Neeraj

> 
> Cheers,
> Longman
> 
> 
