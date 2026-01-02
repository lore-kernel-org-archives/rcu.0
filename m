Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31626165F16;
	Fri,  2 Jan 2026 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767325270; cv=none; b=b2NghzvIy+W4LrW+d4EHrbOsYKRtnpji3vVMEM2J9IFZhsRhzTLZd9NzeCu8xABLTzRB0DXA52xmeF15SERsWYHqFvt0gNCIo+jeJNidSIWSrrEl/d60+sQ6MTCKEBMeayHfzsmMjWJ9k2DUCYawFMg/RofTwoV/Q1TOMoXVW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767325270; c=relaxed/simple;
	bh=Dyw2bX75jEiH69DFswvja06krh66QHHpDnI4nPgeE74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfFFDLrJgW/y1YL39kctDixyJLB73cpUZ2elwTMD+j7vI01A+a8C1KcpwtuGKD2lvFiChJe7rkzJno7/zpOYQpHQUpOVqMQmimv8N5/Mo0zKOUz7SMCV+Onudp7TU1z/qLMKQsKXbnglMRoDlILkQ5hA7c8jDC++W693gKj93g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZN9tDTx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZN9tDTx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B6DC4CEF7;
	Fri,  2 Jan 2026 03:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767325269;
	bh=Dyw2bX75jEiH69DFswvja06krh66QHHpDnI4nPgeE74=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gZN9tDTx6REBThYmN/mQ/VtkjZ4fW8A92Df10LZpWcxxKOmszDBbJ5S5QEJCtuOjg
	 ZLQ4senY4ITQXrO3dKzB7spA0PdPQka73j8vLBocgH4yMPAdnwclvEERw70+dqAlwJ
	 +JDfiI453f3EcWDHfaCv2bMJEl2q7BK08tKRT1mUclXyIF+BPZfFDoMm04lgGaoHSt
	 L68ZBsR9llWa3ZCEz1O2LRuIk3ckt4Ru6vrpXK4PK8+sHan/TUKyDVeQAj+dvlhLAf
	 x3+Egoh6r6NnI4OAzXkcfGOCckxFeZ7tOIA3dkDs+w5ZOaCZRUSV/VtZJqcAEfhB7u
	 1JSJ7leccE8DA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 065F2CE0D38; Thu,  1 Jan 2026 19:41:09 -0800 (PST)
Date: Thu, 1 Jan 2026 19:41:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <e6ec0a2e-aadd-43fc-b54c-063926c39734@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
 <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
 <20251224020619.GA1297269@joelbox2>
 <b6bd973d-3cc6-4174-aaae-f3d67d8ccca1@paulmck-laptop>
 <20251226021559.GA949635@joelbox2>
 <cc710326-1b49-4892-9805-a197d48d202f@paulmck-laptop>
 <e7db3fd5-9c2d-4d63-850d-dbbc1900d13c@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7db3fd5-9c2d-4d63-850d-dbbc1900d13c@nvidia.com>

On Thu, Jan 01, 2026 at 09:59:27PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/1/2026 5:24 PM, Paul E. McKenney wrote:
> > On Thu, Dec 25, 2025 at 09:15:59PM -0500, Joel Fernandes wrote:
> >> On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
> >>> On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
> >>>> Hi Paul,
> >>>>
> >>>> On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> >>>>> On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> >>>>>> During studying some synchronize_rcu() latencies, I found that the
> >>>>>> jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> >>>>>> off by one. This is natural due to calc_index() rounding up.
> >>>>>>
> >>>>>> For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> >>>>>> is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> >>>>>> never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> >>>>>> to interrupts.
> >>>>>>
> >>>>>> Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> >>>>>> before passing it to the wait APIs.
> >>>>>>
> >>>>>> But before I wanted to send a patch, I wanted to get everyone's thoughts.
> >>>>>> Considering this the RFC.
> >>>>>
> >>>>> Inadvertent passing of the value zero?
> >>>>
> >>>> This should not be an issue because at the moment, even a value of
> >>>> jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
> >>>>
> >>>> But you raise a good point, we should cap the minimum allowed jiffie value
> >>>> for the fqs parameters to 1 so that we don't pass schedule_timeout() with
> >>>> negative values when/if we do the reduce-by-one approach.
> >>>
> >>> There is a potential use case for jiffies_till_first_fqs=0 and no wait,
> >>> which would be systems that want to scan for idle CPUs immediately after
> >>> the grace period has been initialized.  Note the word "potential".  ;-)
> >>
> >> Sure, we could add support for that but that would be new behavior that is
> >> not in the existing code.
> >>
> >> So jiffies_till_first_fqs=0 today, I think it is not 'working as intended'
> >> because it will never not wait I think.
> > 
> > Agreed.
> > >> So we should fix that too? Or maybe it can be a patch separate from this
> >> (that I can work on). I think no harming in allowing that mode, at least it
> >> will be more in line with the expected outcome.
> > 
> > Makes sense!  However, given that no one has complained, care is required.
> > Someone might be relying on the old behavior.  (In which case an easy
> > fix would be to make -1 be no waiting, though one might hope for a
> > better fix.)
> Some further investigations revealed that the "1 jiffie error" is actually worst
> case. In the best case, it could still be closer to a jiffie. It is just the
> nature of the timer wheel, since it snaps to numerical TICK_NS boundary, the
> rounding error is intentionally added depending on how far along in the boundary
> was the timer for the wait enqueued. If we took probability distributions, we
> should be landing with a 1/2 jiffie error, though in practice I've seen it to be
> 3/4 jiffie error on average.
> 
> Given this, it would probably not make sense for us to do the -1 to adjust for
> the error (since we don't clearly have bounds on the minimum error). We just
> have to accept that we'd lose 1-2 extra jiffie per FQS loop iteration wait,
> which is amplified if a grace period is already in progress. I've seen this add
> upto 4 jiffies to back-to-back synchronize_rcu() latency even when there are no
> readers in progress.
. 
> But I had to go down the rabbit hole and check... ;-)

I was thinking in terms of special-casing -1 to skip the sleep, but I
guess that there are as many ways to skin a rabbit as a cat.  ;-)

							Thanx, Paul

