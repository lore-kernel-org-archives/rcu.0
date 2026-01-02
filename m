Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0042441A0;
	Fri,  2 Jan 2026 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767383447; cv=none; b=oZgEmehDyru2xtBnPrKN8GdcDoSYB89O+NBaXslbbJnLXX0vIaieHKyxR0nTrvllK6auWZvQYiuWz1frV/Age5zeXWoj9rWeBtLeuqfAlmko4vQp5w3/Ex13qmtmGF/mWLGIX34/BvfBm7FMRA0KOhg1dCyOp1mLsumBE8PCCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767383447; c=relaxed/simple;
	bh=buSANxpE0n8D3XYYsBOkRH7ksCktjQb4TqY55/yFJX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8OV3rjWw3fZzD+irksw0MlD6cliyFQh65mG+6mzQF3+qAb+MP8A/coxgij8fc1F/TLMSI6UxfHincPYE+cwMnfltaTkF9sONLESlYJdxlv9JvpbCPav2NPy6XzA5cUkRreQJeb+Ru4cLJJb2hi26vy2yJI4Dz85ZBPElTWVFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASFQxJet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASFQxJet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F015C116B1;
	Fri,  2 Jan 2026 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767383446;
	bh=buSANxpE0n8D3XYYsBOkRH7ksCktjQb4TqY55/yFJX8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ASFQxJetQNTLXJG0IC+jq+1zx2Uvw3TTjrjT4e31fu8fzmxNXYJJaioWMGQpxvc30
	 nojYbDQ4M9bNxwvANAiAEAVrRXMzgwltPvRFdE0UpLyvZ+hv0keIUuxRa6ux0LNHak
	 hWUM2jEx8jj3cAvgHVMnQGFbTiw2zaECtjkv6lzfg09CPYhcfTmCPcA/vM6e90DIh7
	 3wp8u291mYEJPfmUxW0rFTmkTA1uEqJEY2EFujTfMbS4jd00oGlvvdTFqUOmL9YIrx
	 jTXRgHtur993+kMr7ZgbQbWkGE1BAhdd8/In2SnauyrrwNOaNErFNZIo1a+Snz4SJY
	 6NFZH81d3R65g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D7AB4CE0D1C; Fri,  2 Jan 2026 11:50:45 -0800 (PST)
Date: Fri, 2 Jan 2026 11:50:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu <rcu@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <b8a78dd8-35c4-4ca4-bd6d-32b1bafd1b8d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e6ec0a2e-aadd-43fc-b54c-063926c39734@paulmck-laptop>
 <3D3F17CD-C7EC-44B1-85E2-95022BBDB55E@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D3F17CD-C7EC-44B1-85E2-95022BBDB55E@joelfernandes.org>

On Fri, Jan 02, 2026 at 12:58:08PM -0500, Joel Fernandes wrote:
> 
> 
> > On Jan 1, 2026, at 10:41 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Thu, Jan 01, 2026 at 09:59:27PM -0500, Joel Fernandes wrote:
> >> 
> >> 
> >>> On 1/1/2026 5:24 PM, Paul E. McKenney wrote:
> >>> On Thu, Dec 25, 2025 at 09:15:59PM -0500, Joel Fernandes wrote:
> >>>> On Thu, Dec 25, 2025 at 10:54:20AM -0800, Paul E. McKenney wrote:
> >>>>> On Tue, Dec 23, 2025 at 09:06:19PM -0500, Joel Fernandes wrote:
> >>>>>> Hi Paul,
> >>>>>> 
> >>>>>> On Tue, Dec 23, 2025 at 03:53:23PM -0800, Paul E. McKenney wrote:
> >>>>>>> On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> >>>>>>>> During studying some synchronize_rcu() latencies, I found that the
> >>>>>>>> jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> >>>>>>>> off by one. This is natural due to calc_index() rounding up.
> >>>>>>>> 
> >>>>>>>> For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> >>>>>>>> is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> >>>>>>>> never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> >>>>>>>> to interrupts.
> >>>>>>>> 
> >>>>>>>> Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> >>>>>>>> before passing it to the wait APIs.
> >>>>>>>> 
> >>>>>>>> But before I wanted to send a patch, I wanted to get everyone's thoughts.
> >>>>>>>> Considering this the RFC.
> >>>>>>> 
> >>>>>>> Inadvertent passing of the value zero?
> >>>>>> 
> >>>>>> This should not be an issue because at the moment, even a value of
> >>>>>> jiffies_till_first_fqs == 0 waits for ~1 jiffie due to schedule_timeout(0).
> >>>>>> 
> >>>>>> But you raise a good point, we should cap the minimum allowed jiffie value
> >>>>>> for the fqs parameters to 1 so that we don't pass schedule_timeout() with
> >>>>>> negative values when/if we do the reduce-by-one approach.
> >>>>> 
> >>>>> There is a potential use case for jiffies_till_first_fqs=0 and no wait,
> >>>>> which would be systems that want to scan for idle CPUs immediately after
> >>>>> the grace period has been initialized.  Note the word "potential".  ;-)
> >>>> 
> >>>> Sure, we could add support for that but that would be new behavior that is
> >>>> not in the existing code.
> >>>> 
> >>>> So jiffies_till_first_fqs=0 today, I think it is not 'working as intended'
> >>>> because it will never not wait I think.
> >>> 
> >>> Agreed.
> >>>>> So we should fix that too? Or maybe it can be a patch separate from this
> >>>> (that I can work on). I think no harming in allowing that mode, at least it
> >>>> will be more in line with the expected outcome.
> >>> 
> >>> Makes sense!  However, given that no one has complained, care is required.
> >>> Someone might be relying on the old behavior.  (In which case an easy
> >>> fix would be to make -1 be no waiting, though one might hope for a
> >>> better fix.)
> >> Some further investigations revealed that the "1 jiffie error" is actually worst
> >> case. In the best case, it could still be closer to a jiffie. It is just the
> >> nature of the timer wheel, since it snaps to numerical TICK_NS boundary, the
> >> rounding error is intentionally added depending on how far along in the boundary
> >> was the timer for the wait enqueued. If we took probability distributions, we
> >> should be landing with a 1/2 jiffie error, though in practice I've seen it to be
> >> 3/4 jiffie error on average.
> >> 
> >> Given this, it would probably not make sense for us to do the -1 to adjust for
> >> the error (since we don't clearly have bounds on the minimum error). We just
> >> have to accept that we'd lose 1-2 extra jiffie per FQS loop iteration wait,
> >> which is amplified if a grace period is already in progress. I've seen this add
> >> upto 4 jiffies to back-to-back synchronize_rcu() latency even when there are no
> >> readers in progress.
> > .
> >> But I had to go down the rabbit hole and check... ;-)
> > 
> > I was thinking in terms of special-casing -1 to skip the sleep, but I
> > guess that there are as many ways to skin a rabbit as a cat.  ;-)
> 
> Sure I am happy to do that. One of my fears though is no one will know to use it that way making it not that useful.
> 
> Do let me know if anyone sets it to 0 though. Perhaps for testing even to make the GP cycle shorter?

I do not know of anyone doing that, hence the non-urgency.  The "-1"
would be just in case someone actually is setting it to zero, and
complains about us breaking userspace.  :-/

							Thanx, Paul
