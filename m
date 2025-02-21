Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7121DA612;
	Fri, 21 Feb 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153163; cv=none; b=GWgqq4fpvxD1nRObsluZwijzqpl4SD7KNNMfM9j75Y7jc9ggFnc6Ov6XkuQIoMGg0odkypeDEd0/nz7ChL1k6Qygg9mtjT9ZtTCFcgBzeYirewQXQ8QF304R+qIPnwSp65uZSEsRDKFrPkiA+vYftC/3OpEFaZtqBdFUFrfRuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153163; c=relaxed/simple;
	bh=T2pIXkuccaH3wvzZZ+aaBnugn9hlqwMDeUUtq+JHoBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxdhiiHUPc5TGy7TaOgEfrMh7svQqpzIO6o8AmIvOQH/C0l8aQhWzwNu33qVYIJELgJRILPRtu5zg1lcFxz3MBb3ioDlRlLdaOZdxgenNNs0D/PGeOqDbM2A3m8UjLEmbCjD6WepF9d3FR1vF/Hm8G19YNDyPqJYv1DwjvAmGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHm2VAWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHm2VAWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A091C4CED6;
	Fri, 21 Feb 2025 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740153162;
	bh=T2pIXkuccaH3wvzZZ+aaBnugn9hlqwMDeUUtq+JHoBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHm2VAWaVJFVIpDDiqF9xlT4d9qDnMm9tvXttZutI3mEu8ev8XqBedNnx/CR5PK7i
	 2FpuLycf+EHln6f61U0gGpNMn7hAaSxVRpeAJ4G5jTp1XpYLMfgzjXB/3phqm0tVhS
	 lodUtL2/yFDmUHB87mp5K3dzhKRAf6VK1ASGIV7TNha4e5Psh062REqoNUDr+de/+P
	 RqIU0sbx5mF17+djPtBk/A5oLNap3AcsNMgbj4pPmQQ2ILW+klQTIK5gLrY3znwDim
	 PgkvpD7sYpL1NGd51ecpJhhae+dZ+UgkeOCR9grnvr1yvCGCe2YjHXYkFiPRAtreBu
	 lC5dwBkmeinaQ==
Date: Fri, 21 Feb 2025 16:52:39 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <Z7ihR0eMfoJMi-qx@localhost.localdomain>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
 <Z68yzBURiIr_7Lmy@pavilion.home>
 <610596cf-9836-473f-bcdc-15c69b7e0cd4@paulmck-laptop>
 <Z7ET8S4HKqSPubQY@pavilion.home>
 <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5ea9684-291f-4952-b834-ed8e39cfdf8f@paulmck-laptop>

Le Wed, Feb 19, 2025 at 06:58:36AM -0800, Paul E. McKenney a écrit :
> On Sat, Feb 15, 2025 at 11:23:45PM +0100, Frederic Weisbecker wrote:
> > > Before.  There was also some buggy debug code in play.  Also, to get the
> > > failure, it was necessary to make TREE03 disable preemption, as stock
> > > TREE03 has an empty sync_sched_exp_online_cleanup() function.
> > > 
> > > I am rerunning the test with a WARN_ON_ONCE() after the early exit from
> > > the sync_sched_exp_online_cleanup().  Of course, lack of a failure does
> > > not necessairly indicate
> > 
> > Cool, thanks!
> 
> No failures.  But might it be wise to put this WARN_ON_ONCE() in,
> let things go for a year or two, and complete the removal if it never
> triggers?  Or is the lack of forward progress warning enough?

Hmm, what prevents a WARN_ON_ONCE() after the early exit of
sync_sched_exp_online_cleanup() to hit?

All it takes is for sync_sched_exp_online_cleanup() to execute between
sync_exp_reset_tree() and  __sync_rcu_exp_select_node_cpus() manage
to send an IPI.

But we can warn about the lack of forward progress after a few iterations
of the retry_ipi label in __sync_rcu_exp_select_node_cpus().

> 
> > > > And if after do we know why?
> > > 
> > > Here are some (possibly bogus) possibilities that came to mind:
> > > 
> > > 1.	There is some coming-online race that deprives the incoming
> > > 	CPU of an IPI, but nevertheless marks that CPU as blocking the
> > > 	current grace period.
> > 
> > Arguably there is a tiny window between rcutree_report_cpu_starting()
> > and set_cpu_online() that could make ->qsmaskinitnext visible before
> > cpu_online() and therefore delay the IPI a bit. But I don't expect
> > more than a jiffy to fill up the gap. And if that's relevant, note that
> > only !PREEMPT_RCU is then "fixed" by sync_sched_exp_online_cleanup() here.
> 
> Agreed.  And I vaguely recall that there was some difference due to
> preemptible RCU's ability to clean up at the next rcu_read_unlock(),
> though more recently, possibly deferred.

Perhaps at the time but today at least I can't find any.

Thanks.
