Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CEC360736;
	Fri, 23 Jan 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769147220; cv=none; b=Ez0XiEo+nNu5o4baxuxUz+oFvcxf17x6GUucByKpm/rTejtvgE6LZJ+JIEu9UL+LI9tiPm8z7nOjjsm+2JWydJQBJfLyDZS15Wb+/QQGk7P68ikfDC/hk+1AhjMzcJDcSMeDfyFV4sPsotGnTKP7hp7XLJYFBtjj1WnAn5o7qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769147220; c=relaxed/simple;
	bh=iHu2VygHmjMmsl/tRNIyGfC8yO/yWtfKayzXHneWk3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOQkNcRQ5edPs74j6N337tz66AAskOSf2aMogBHLq1BLn4mzvhP2t7I8JtC+qq0U/fkaXiNjyb6UCRxDGukk0mOvQ6C9NW6ZAHeXyL+BqDMCcCAC4+FBJbnnDxkVyudenaJ0KvT9WMEUr6O7SjgN1Duv9jkR8huis8MXZCSjr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umRmKM9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umRmKM9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77F3C4CEF1;
	Fri, 23 Jan 2026 05:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769147218;
	bh=iHu2VygHmjMmsl/tRNIyGfC8yO/yWtfKayzXHneWk3o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=umRmKM9FvjcjjxbqVZAe1W40X8wPTd9xewDW7i4ih0OzCzYzMfa2kRNC/a4N9jwRL
	 YF3EjqjgrBaqGwG+qRn++uay+2NDUZJeAvwd9A+equ2qnubfni5EQF3cZxLPPuLFKw
	 zYQZnSXbDIhiI2nB+z6DE7H+xcUFiWJ9rLcMvvoUxAnZlevX+wjKB++Mv+6WjocyUy
	 To2eESMBNKjvQ5IXiBDFUM17hci9cBLcDlzTy5tQEucZm+XLJUzDOKIi17PzEenzd2
	 WWDH08weIv/15Xu+VuYIRlQ/V/CTB2BCyepNIIBGWzZRXI6WsdpNoPIJOOobFrPY57
	 7TFw5+jepC1HA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46E90CE0B94; Thu, 22 Jan 2026 21:46:58 -0800 (PST)
Date: Thu, 22 Jan 2026 21:46:58 -0800
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
Message-ID: <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
 <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>

On Thu, Jan 22, 2026 at 08:29:41PM -0500, Joel Fernandes wrote:
> On Jan 22, 2026, at 7:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, Jan 22, 2026 at 06:43:31PM -0500, Joel Fernandes wrote:
> > > On Thu, Jan 22, 2026 at 01:55:11PM -0800, Paul E. McKenney wrote:
> > > > On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
> > > > > -    } else if (len > rdp->qlen_last_fqs_check + qhimark) {
> > > > > -        /* ... or if many callbacks queued. */
> > > > > -        rdp->qlen_last_fqs_check = len;
> > > > > -        j = jiffies;
> > > > > -        if (j != rdp->nocb_gp_adv_time &&
> > > > > -            rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> > > > This places in cur_gp_seq not the grace period for the current callback
> > > > (which would be unlikely to have finished), but rather the grace period
> > > > for the oldest callback that has not yet been marked as done.  And that
> > > > callback started some time ago, and thus might well have finished.
> > > > So while this code might not have been executed in your tests, it is
> > > > definitely not a logical contradiction.
> > > > Or am I missing something subtle here?
> > > 
> > > You're right that it's not a logical contradiction - I was imprecise.
> > > rcu_segcblist_nextgp() returns the GP for the oldest pending callback,
> > > which could indeed have completed.
> > > 
> > > However, the question becomes: under what scenario do we need to advance
> > > here? If that GP completed, rcuog should have already advanced those
> > > callbacks. The only way this code path can execute is if rcuog is starved
> > > and not running to advance them, right?
> > 
> > That is one way.  The other way is if the RCU grace-period gets delayed
> > (perhaps by vCPU preemption) between the time that it updates the
> > leaf rcu_node structure's ->gp_seq field and the time that it invokes
> > rcu_nocb_gp_cleanup().
> 
> I see the window you're describing. In rcu_gp_cleanup(), for each leaf node:
> 
>     WRITE_ONCE(rnp->gp_seq, new_gp_seq);   // GP appears complete
>     ...
>     raw_spin_unlock_irq_rcu_node(rnp);
> 
>     /* vCPU preemption  */
>     rcu_nocb_gp_cleanup(sq);               // wakes rcuog
> 
> So yes, in this window, the call_rcu() CPU could see the updated gp_seq and
> have rcu_seq_done() return true for the now-completed GP.
> 
> However, even in this window, advancing callbacks doesn't help:
> 
> 1. We advance callbacks from WAIT to DONE state
> 2. But rcuog is still sleeping, waiting for GP kthread to wake it
> 3. rcuoc is still sleeping, waiting for rcuog to wake it
> 4. Callbacks sit in DONE state but nobody invokes them
> 
> So the critical path is unchanged:
>    swake_up_all() -> rcuog -> rcuoc -> invoke.
> 
> I guess this is the redundancy argument - the window exists, but
> exploiting it provides no meaningful benefit AFAICS.

I gave you a Reviewed-by for this one and reaffirm my Reviewed-by for
the other two.  But you break it, you buy it!  ;-)

> > > But as Frederic pointed out, even if rcuog is starved, advancing here
> > > doesn't help - rcuog must still run anyway to wake the callback thread.
> > > We're just duplicating work it will do when it finally gets to run.
> > 
> > So maybe we don't want that first patch after all?  ;-)
> 
> Do you mean we want the first patch so that it can remove the code that we
> don't want?

It would wake up the rcuog kthread if the RCU grace-period kthread was
slow to do so.  But I agree with simplifying it and working out how to
make it more robust as a separate effort.

> > > The extensive testing (300K callback floods, hours of rcutorture) showing
> > > zero hits confirms this window is practically unreachable. I can update the
> > > commit message to remove the "logical contradiction" claim and focus on the
> > > redundancy argument instead.
> > 
> > That would definitely be good!
> 
> Thanks. I will focus on this argument, then. I will resend with a better
> patch description in the morning.

And my Reviewed-by does assume that change, so go ahead and send the
improved commit log with my Reviewed-by appended.

> > > Would that address your concern?
> > 
> > Your point about the rcuoc kthread needing to be awakened is a good one.
> > I am still concerned about flooding on busy systems, especially if the
> > busy component is an underlying hypervisor, but we might need a more
> > principled approach for that situation.
> 
> Hmm true. There is also the case that any of the kthreads in the way of the
> callback getting preempted by the hypervisor could also be problematic, to
> your point of requiring a more principled approach. I guess we did not want
> the reader side vCPU preemption workarounds either for similar reason.

Well, principles only get you so far.  We need both the principles and the
pragmatism to know when to depart from those principles when warranted.

> One trick I found irrespective of virtualization, is, rcu_nocb_poll can
> result in grace periods completing faster. I think this could help overload
> situations by retiring callbacks sooner than later. I can experiment with
> this idea in future. Was considering a dynamic trigger to enable polling
> mode in overload. I guess there is one way to find out how well this will
> work, but initial testing does look promising. :-D.

Careful of the effect on power consumption, especially for the world of
battery-powered embedded systems!  ;-)

							Thanx, Paul
