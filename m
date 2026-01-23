Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403D2D781F;
	Fri, 23 Jan 2026 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769127149; cv=none; b=XZdfuS0f4QXM5qR9KoFh7zMr4U31EZAu+w1Reczl7K71nm3/DYid6gwuV8zZIrE9Bxv7OR0U2qZbi/zVBciMp9L4K/jd66nPqT/8zswLlI7wL2M5kc2fAfGM4ltjC54uFSCkbX4V/lbXtodcueGSJ1V90ybcvpxYoN1NY9YQ7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769127149; c=relaxed/simple;
	bh=wLIl+ClD7N3wQT/EjiUNKTnGjEjEJWiU7HHm+eEgcEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brs8gI6cgJeoncsdS4vYJ1ckRuuEetF32d9BoasrglbZfPjbLzTw88+EIvGDvzu5/hUQMKZyk/imXjb6OXGxGAs8HNphOaELph6wdE486oLoMXYQPwlqihbDg8vLDZxCDYoug913ZcUCnJOoCmMMQvbMlkGyKtBf7Cvk+6gzUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URSse5oR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URSse5oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD8AC116C6;
	Fri, 23 Jan 2026 00:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769127148;
	bh=wLIl+ClD7N3wQT/EjiUNKTnGjEjEJWiU7HHm+eEgcEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=URSse5oR0cu+9GoQYq88xcU/MtIhkS/ppwN4FjiJyrvSJlahrmcwP3rFcqPhOMKam
	 n1LwJMN8LS3dEiXVHl+I8j1qrkNalpyvlXKsZsUdYY63e8MzMsl4PJMBKBGYW1uumb
	 VXA3EpiYhJ1E97cpcqbXktABvTON8WCwkq+JwN9IxuBdVobb+1/0NBfWx36esUvUtF
	 XnKYXNrGK3JRnHNPdP3wYJ3XYV6yfb9/VUfoWayGGfDxbDkvqMSpe4mgSJaAsi/V2r
	 7izP2b8MyZIwqYTDCZE3RWwGyM0oJj9adO4tIFbymHevwFPtYeZGnWWfjx+bc++1iz
	 QYq9ULn2e4khA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED709CE0B94; Thu, 22 Jan 2026 16:12:27 -0800 (PST)
Date: Thu, 22 Jan 2026 16:12:27 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <a0b81523-636b-46e4-88a0-4cc4ddad4ea4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-3-joelagnelf@nvidia.com>
 <986b4f25-5fbf-45b1-8475-721bc3e95223@paulmck-laptop>
 <CY5PR12MB6479B3FCFF3531F26FDE7C89A397A@CY5PR12MB6479.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB6479B3FCFF3531F26FDE7C89A397A@CY5PR12MB6479.namprd12.prod.outlook.com>

On Thu, Jan 22, 2026 at 06:43:31PM -0500, Joel Fernandes wrote:
> On Thu, Jan 22, 2026 at 01:55:11PM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
> > > -	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> > > -		/* ... or if many callbacks queued. */
> > > -		rdp->qlen_last_fqs_check = len;
> > > -		j = jiffies;
> > > -		if (j != rdp->nocb_gp_adv_time &&
> > > -		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> >
> > This places in cur_gp_seq not the grace period for the current callback
> > (which would be unlikely to have finished), but rather the grace period
> > for the oldest callback that has not yet been marked as done.  And that
> > callback started some time ago, and thus might well have finished.
> >
> > So while this code might not have been executed in your tests, it is
> > definitely not a logical contradiction.
> >
> > Or am I missing something subtle here?
> 
> You're right that it's not a logical contradiction - I was imprecise.
> rcu_segcblist_nextgp() returns the GP for the oldest pending callback,
> which could indeed have completed.
> 
> However, the question becomes: under what scenario do we need to advance
> here? If that GP completed, rcuog should have already advanced those
> callbacks. The only way this code path can execute is if rcuog is starved
> and not running to advance them, right?

That is one way.  The other way is if the RCU grace-period gets delayed
(perhaps by vCPU preemption) between the time that it updates the
leaf rcu_node structure's ->gp_seq field and the time that it invokes
rcu_nocb_gp_cleanup().

> But as Frederic pointed out, even if rcuog is starved, advancing here
> doesn't help - rcuog must still run anyway to wake the callback thread.
> We're just duplicating work it will do when it finally gets to run.

So maybe we don't want that first patch after all?  ;-)

> The extensive testing (300K callback floods, hours of rcutorture) showing
> zero hits confirms this window is practically unreachable. I can update the
> commit message to remove the "logical contradiction" claim and focus on the
> redundancy argument instead.

That would definitely be good!

> Would that address your concern?

Your point about the rcuoc kthread needing to be awakened is a good one.
I am still concerned about flooding on busy systems, especially if the
busy component is an underlying hypervisor, but we might need a more
principled approach for that situation.

							Thanx, Paul
