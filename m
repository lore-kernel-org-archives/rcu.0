Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B660B93
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609843; cv=none; b=OX8Z/gaZs5GlRcCMufGGQbOzAIe44HjVEHO78t/D5DffulRPONf+lwL0Ptq8G9yp1UU4LT+N3rl1xnK+YIzQWgaJQ65ua+qjgjCTCus9t9xwybYa8r+Cp1c2Z6LwCJ1NxIax29Ru3oQA5TMKYWUmiQNYu4ko42Q3gBaFj9CagL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609843; c=relaxed/simple;
	bh=FX4F52cS2pEuWO32PfNhg5re1cyIPrF/4AjlrzhWwFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKoVTe8Cis7rmVZgXjFNTEohRjaqBZ2lu5hK6xScr/Z+QxIfiMWwHCyql2RbLpB1clpcQ4Pzn6VDnb/mqDl8c2xM25MbBvLScRNY6tHXyDTwSSHonuX7fEt2+HF+vt84kF/0eHwxvnSmptlMAfi2MpmrlouWF3sVpOTuKVHlhbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+thLVEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+thLVEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3343BC433C7;
	Tue, 30 Jan 2024 10:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706609843;
	bh=FX4F52cS2pEuWO32PfNhg5re1cyIPrF/4AjlrzhWwFQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F+thLVEHlTUVTvjrRtp0riNvaaKKsViXHXVzbxq1GK+xbetRClX4cLjDOXPwkR7bB
	 lnWyxyH9G95IqE8GdS1AMKdRzQxPxa3vdUyEu/PPLAiiozFSBdccSP8oU98RBYHRRz
	 aGF+vOY15mkllAbxQ9RNYVsOX3ZHqhtol9joSU+mvny0reDbl07y20JWXqPddJUZmJ
	 xcCK6t95yj96nshRl00rs4EZZz0ydIYl9CfUMF9k3HgREg4EbxM5AHtE+EL2kfMFsb
	 Qp41UJqMbPPhxuec/xECwWMYUAZmDOk39Cyt2RShJhj4F+UznjuaGGvb6VNSpklFRH
	 bXY0Ij94IsyxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5D84CE0961; Tue, 30 Jan 2024 02:17:22 -0800 (PST)
Date: Tue, 30 Jan 2024 02:17:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
	"Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <cf1c60fc-6295-402e-b546-6f67cf0955b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
 <ZbieCjYk8cIgZS8L@gpd>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbieCjYk8cIgZS8L@gpd>

On Tue, Jan 30, 2024 at 07:58:18AM +0100, Andrea Righi wrote:
> Hi Joel and Paul,
> 
> comments below.
> 
> On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> > >> Hi Guys,
> > >> Something caught my eye in [1] which a colleague pointed me to
> > >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> > >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> > >>
> > >> The test in concern is:
> > >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> > >>
> > >> which is a CPU intensive test.
> > >>
> > >> Any thoughts on what else can attribute a 30% performance increase
> > >> versus non-nohz_full ? (Confession: No idea if the baseline is
> > >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> > >> nohz_full on some of our limited-CPU devices :)
> > > 
> > > The usual questions.  ;-)
> > > 
> > > Is this repeatable?  Is it under the same conditions of temperature,
> > > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > > guest OS, what was the load from other guest OSes on the same hypervisor
> > > or on the hypervisor itself?
> 
> That was the result of a quick test, so I expect it has some fuzzyness
> in there.
> 
> It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
> Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
> test with the default Ubuntu settings, that means having "power mode:
> balanced" enabled. I don't know exactly what it's doing (I'll check how
> it works in details), I think it's using intel p-states IIRC.
> 
> Also, the system was not completely isolated (my email client was
> running) but the system was mostly idle in general.
> 
> I was already planning to repeat the tests in a more "isolated"
> environment and add details to the bug tracker.
> 
> > > 
> > > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > > me wonder if someone enabled some heavy debug that is greatly
> > > increasing the overhead of the scheduling-clock interrupt.
> > > 
> > > Now, if that was the case, I would expect the 250HZ number to have
> > > three-quarters of the improvement of the nohz_full number compared
> > > to the 1000HZ number:
> > >> 17415.60-14866.05=2549.55
> > > 18505.52-14866.05=3639.47
> > > 
> > > 2549.55/3639.47=0.70
> > 
> > I wonder if the difference here could possibly also be because of CPU idle
> > governor. It may behave differently at differently clock rates so perhaps has
> > different overhead.
> 
> Could be, but, again, the balanced power mode could play a major role
> here.
> 
> > 
> > I have added trying nohz full to my list as well to evaluate. FWIW, when we
> > moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> > governor could put the CPUs in deeper idle states more quickly!
> 
> Interesting, another benefit to add to my proposal. :)
> 
> > 
> > > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > > test have enabled?  Also, if you use tracing (or whatever) to measure
> > > the typical duration of the scheduling-clock interrupt and related things
> > > like softirq handlers, does it fit with these numbers?  Such a measurment
> > > would look at how long it took to get back into userspace.

Just to emphasize...

The above calculations show that your measurements are close to what you
would expect if scheduling-clock interrupts took longer than one would
expect.  Here "scheduling-clock interrupts" includes softirq processing
(timers, networking, RCU, ...)  that piggybacks on each such interrupt.

Although softirq makes the most sense given the amount of time that must
be consumed, for the most part softirq work is conserved.  which suggests
that you should also at the rest of the system to check whether the
reported speedup is instead due to this work simply being moved to some
other CPU.

But maybe the fat softirqs are due to some debugging option that Ubuntu
enabled.  In which case checking up on the actual duration (perhaps
using some form of tracing) would provide useful information.  ;-)

							Thanx, Paul

> > Thanks for your detailed questions. I will add Andrea Righi to this list thread
> > since he is the author of the bug report. Andrea do you mind clarifying a few
> > things mentioned above? Also nice to see you are using CONFIG_RCU_LAZY for Ubuntu :)
> 
> Thanks for including me. Sorry that I didn't provide much details of my
> tests.
> 
> And yes, I really want to see CONFIG_RCU_LAZY enabled in the stock
> Ubuntu kernel, so the battery of my laptop lasts longer when I go to
> conferences. :)
> 
> -Andrea
> 
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 
> > >> Cheers,
> > >>
> > >>  - Joel
> > >>
> > >> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051342
> > > 
