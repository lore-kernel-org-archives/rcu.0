Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B13383;
	Wed, 26 Feb 2025 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528053; cv=none; b=BvOQTMTo++IC3I/xMpxx2Ffco+RHZ3X6RSQBo7/KuKfs+FTppJ6trM8Sl4N8J1AZ5teR/m1kUHmSeipdr2jEsOWCLTUgrKLTdGMYQrO/LULCFWHxW4QfNM2b+Gnc3SeBCkExZYJvRagygkL6hnW3FCrgL0DmckL0ZA1ORWzsS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528053; c=relaxed/simple;
	bh=FUyqeCWZx5yDLvMhUXGRQhA9BQ3wD+MoRIPGa0LLz5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETAwNAFFbY/o9eFY8CCXpZIlP2CdSyMe5Xhkc5wkNhJtripIJD+rBHFAKxytxCSsf27vcL6UcRT7/MnldMtlJrB0huvb9vQjLWO6DJ6bx0zPNd/s48JkAZzv0pzvDOcQwnjxGvbgRFPmX31Isfoz4/TlMEI1rYx6m7DiNx4AlRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7DgOZEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7DgOZEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290FCC4CEDD;
	Wed, 26 Feb 2025 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740528053;
	bh=FUyqeCWZx5yDLvMhUXGRQhA9BQ3wD+MoRIPGa0LLz5Y=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F7DgOZEPdhvsUjvTjmW2IVW85oG1M2Alx/Vz2reqRnh9WjmTIjdlK22WcFWYjeFuq
	 6JPYUjgemdEXC45zy8yCKLJM3rWVMItK/jF45i45RoKfMVOtizqLDuBDSyk3k6Sf+V
	 u3YVtGyGn5hkVT7AN4hDbtstHC5hm1NfThEN0lmodgORtoZ4L4RbRsgXEhzCw1e8Gj
	 Oqj6vU9SsekmmMIul3q/pz/ItJU52vt4V2GnW2RhPqzj/akYEu38nDl2APylpy8BBK
	 jb7pF3Xz6wQMxU1XSM/7zHXQC+LXDeKw4h2786B0yab9qDsUU3NdBSHzcLzaBmZEOf
	 rVoLJDRlAKMTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA4CBCE0B75; Tue, 25 Feb 2025 16:00:52 -0800 (PST)
Date: Tue, 25 Feb 2025 16:00:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <be5188d7-0ae3-4f08-b6e9-759f45e45013@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
 <Z68yzBURiIr_7Lmy@pavilion.home>
 <610596cf-9836-473f-bcdc-15c69b7e0cd4@paulmck-laptop>
 <Z7ET8S4HKqSPubQY@pavilion.home>
 <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>
 <Z7ihR0eMfoJMi-qx@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7ihR0eMfoJMi-qx@localhost.localdomain>

On Fri, Feb 21, 2025 at 04:52:39PM +0100, Frederic Weisbecker wrote:
> Le Wed, Feb 19, 2025 at 06:58:36AM -0800, Paul E. McKenney a écrit :
> > On Sat, Feb 15, 2025 at 11:23:45PM +0100, Frederic Weisbecker wrote:
> > > > Before.  There was also some buggy debug code in play.  Also, to get the
> > > > failure, it was necessary to make TREE03 disable preemption, as stock
> > > > TREE03 has an empty sync_sched_exp_online_cleanup() function.
> > > > 
> > > > I am rerunning the test with a WARN_ON_ONCE() after the early exit from
> > > > the sync_sched_exp_online_cleanup().  Of course, lack of a failure does
> > > > not necessairly indicate
> > > 
> > > Cool, thanks!
> > 
> > No failures.  But might it be wise to put this WARN_ON_ONCE() in,
> > let things go for a year or two, and complete the removal if it never
> > triggers?  Or is the lack of forward progress warning enough?
> 
> Hmm, what prevents a WARN_ON_ONCE() after the early exit of
> sync_sched_exp_online_cleanup() to hit?
> 
> All it takes is for sync_sched_exp_online_cleanup() to execute between
> sync_exp_reset_tree() and  __sync_rcu_exp_select_node_cpus() manage
> to send an IPI.

You are right, that would do it!

> But we can warn about the lack of forward progress after a few iterations
> of the retry_ipi label in __sync_rcu_exp_select_node_cpus().

Agreed, that would make more sense.

> > > > > And if after do we know why?
> > > > 
> > > > Here are some (possibly bogus) possibilities that came to mind:
> > > > 
> > > > 1.	There is some coming-online race that deprives the incoming
> > > > 	CPU of an IPI, but nevertheless marks that CPU as blocking the
> > > > 	current grace period.
> > > 
> > > Arguably there is a tiny window between rcutree_report_cpu_starting()
> > > and set_cpu_online() that could make ->qsmaskinitnext visible before
> > > cpu_online() and therefore delay the IPI a bit. But I don't expect
> > > more than a jiffy to fill up the gap. And if that's relevant, note that
> > > only !PREEMPT_RCU is then "fixed" by sync_sched_exp_online_cleanup() here.
> > 
> > Agreed.  And I vaguely recall that there was some difference due to
> > preemptible RCU's ability to clean up at the next rcu_read_unlock(),
> > though more recently, possibly deferred.
> 
> Perhaps at the time but today at least I can't find any.

And maybe not even back then.  ;-)

							Thanx, Paul
