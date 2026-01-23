Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6698285CBA;
	Fri, 23 Jan 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186994; cv=none; b=ha/6bNqvmyG3MVeoIvxBJgwmpHSxZUCCpOSh6QK6neo/SGJ3+kNzjAjA0yHO1bMk1oXlfGWVfMST1Ejz1T2aX6dgbxqvUITHBaTQ7zpuZGYSp+VnbDMjawj51K43r2UHEfYVbRmwi27YRsfUKcT9hTIUkPXjmJk4k2KMTaWMNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186994; c=relaxed/simple;
	bh=fninbizIZi1imhMtU+cRrJS1GQ0RlumFl8G5k1tPvUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxJCp8tX/Uu86oRZKPEZdpoo+vnJJhnC7+CwXlkpdao4IpNhpCfUCQ+bqPDQbYFqb9MlHnbgrKM32p5M4UEGcdta9FO90/VkvGMNhc7EJQ6pIZuHLEWknvqYa58r9iQlLzP5j8KHwEx95cCECP+s+jokpH+jMrddTWxWfEhD1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlds+7hd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlds+7hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F6C4CEF1;
	Fri, 23 Jan 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186994;
	bh=fninbizIZi1imhMtU+cRrJS1GQ0RlumFl8G5k1tPvUE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qlds+7hd1mkKfxU0N69aRycVsVT1RBbRP85BV1rMeTqlUj68f+wquzeig6U9dxCAk
	 HA9WixuJue9HUPkXOGWWkGaLL3QsERQ/L78vJSHvHs2x8wyjtKiRHoCl3BnTh6t+OT
	 S3j/i2tk+ziaCZvTwoWwPHrRhmMEvuuQb3xrBLYxFxaxQF0nlgQDI/SoqdRUecvJka
	 SVQqTEemD2apYGcJuw2vvqNGZ0ryUkWoMvO4T1dOJalSxZcRihlDAQbNWAdkMBJp0k
	 yzp2aNl9hPLBdICQlic7dPb90gLI9wWloEy/F8Lhy9Q/qz5/5jDFBK0HKcJg+n5GSC
	 EkEqSdfIWnc7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DB6A9CE0972; Fri, 23 Jan 2026 08:49:53 -0800 (PST)
Date: Fri, 23 Jan 2026 08:49:53 -0800
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
Message-ID: <735d16d4-f727-4cc1-91d8-16155135f550@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <EBEF016B-721C-4A54-98E3-4B8BE6AA4C21@nvidia.com>
 <013102c7-a1c8-4f13-8dd9-5803e4d69aaf@nvidia.com>
 <68fd874e-ac9b-4d91-ab05-903bf45856fa@paulmck-laptop>
 <1737646200.reply.joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1737646200.reply.joelagnelf@nvidia.com>

On Fri, Jan 23, 2026 at 10:30:00AM -0500, Joel Fernandes wrote:
> On Thu, Jan 22, 2026 at 09:46:58PM -0800, Paul E. McKenney wrote:
> > > Thanks. I will focus on this argument, then. I will resend with a better
> > > patch description in the morning.
> > 
> > And my Reviewed-by does assume that change, so go ahead and send the
> > improved commit log with my Reviewed-by appended.
> 
> Sure, will do.
> 
> > > Hmm true. There is also the case that any of the kthreads in the way of the
> > > callback getting preempted by the hypervisor could also be problematic, to
> > > your point of requiring a more principled approach. I guess we did not want
> > > the reader side vCPU preemption workarounds either for similar reason.
> > 
> > Well, principles only get you so far.  We need both the principles and the
> > pragmatism to know when to depart from those principles when warranted.
> 
> Agreed. Indeed we have to balance the cost of workarounds and in the case
> of per cpu blocked lists, I agree that perhaps the balance tipped more in
> favor of not doing it pending other more comprehensive fixes.

I would feel better about that balance if we actually had some of these
more comprehensive fixes in mind.  ;-)

> > > One trick I found irrespective of virtualization, is, rcu_nocb_poll can
> > > result in grace periods completing faster. I think this could help overload
> > > situations by retiring callbacks sooner than later. I can experiment with
> > > this idea in future. Was considering a dynamic trigger to enable polling
> > > mode in overload. I guess there is one way to find out how well this will
> > > work, but initial testing does look promising. :-D.
> > 
> > Careful of the effect on power consumption, especially for the world of
> > battery-powered embedded systems!  ;-)
> 
> Thanks, yes I was considering this argument already to be honest as one of
> the potential pitfalls, but thanks for the reminder! FWIW, my inclination
> is that if we are in an overloaded situation, we would not benefit from
> idleness anyway. To the contrary, I think we may hurt idleness and power
> if we are not able to settle the system into a quiet state due to slowness
> in alleviating the callback overload. I will profile for CPU consumption
> and maybe run turbostat to check whenever I have the prototype.

We could have one CPU flooding and the rest idle, and many other
combinations.  And, if I recall correctly, polling can burn extra CPU
and cause extra wakeups even when the system is fully idle.  Or has
that changed?

							Thanx, Paul
