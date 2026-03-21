Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BAB2D1F44;
	Sat, 21 Mar 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774121468; cv=none; b=cBanhxadBnouXcl1v+CkI2iw8IrAkO+dh1TrUABncj3RsVEn6kSuScb6STcsyz4f08WaIt38TwjlwBj94DG4hFUXcx03AQusPtxjilPSQ4gx/yi4Vpd6bTXFRjSObOe4G/mbstBp7svZznjxk9i1XJp1CJrZq9obE92iOB9teaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774121468; c=relaxed/simple;
	bh=O8XCX49zT3AdmSF1IpcXU11q4cnisu7bb0hvvBWO6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uub9QRjYLR8ALep9dsTcoPC1pCFgwXjDwijHZRHyNB+FrZqPkb2YQUO1eFoc+sfQPNorbAD6uZbQamufiZVvxgMka0UIPNOF7hhytD6yL7WdW4vOt4I8oq9EwU8p560UO8m8wSy5DI9/uWvlqQiXqmD1qjBw6+7qk86d+7zXN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwNRkcy5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwNRkcy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AF3C2BC87;
	Sat, 21 Mar 2026 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774121467;
	bh=O8XCX49zT3AdmSF1IpcXU11q4cnisu7bb0hvvBWO6U4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EwNRkcy595H+jy1nmswgUolxwOEjCwowOLPSsEX2OsAvSFbqnT/xvLGfAv6C/ZgCH
	 5BopUsalH1xLXwyN9F94qxZ6L1kPe6vUnCVz0NLtq+qn7LOSW5MDpq5D/+5V4CxX/S
	 i+uM1U0ctX9xsnMuoIis1w03EgqarUy0wkf+ABfRHmLkAehCR1F2IqxAH8tUndJhSq
	 9M3wB3ZCXfmz/LL3kc2qI/yj3v0n3OO+LBVD8yarX7cRqy/oeiQaRYOgJOd8yGEhK+
	 E34MaKA/lZoLpx86sqR/GGm2XM9UbL1TQLpltz40FBTNMvoOOWGgbSIbKY1JQLHhij
	 0g4jTrveMR9bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 059AFCE0B66; Sat, 21 Mar 2026 12:31:05 -0700 (PDT)
Date: Sat, 21 Mar 2026 12:31:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrea Righi <arighi@nvidia.com>, Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH] rcu: Use an intermediate irq_work to start process_srcu()
Message-ID: <609b5df1-aa06-46a9-8e93-0bf9eb8b7738@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2d9e7e42-8667-4880-9708-b81a82443809@nvidia.com>
 <20260320181400.15909-1-boqun@kernel.org>
 <b4857e4f-5a8d-4ccc-9e8b-df57718e4aee@paulmck-laptop>
 <ab7SQ3L1F-ap7mNl@tardis.local>
 <492ba226-79c7-4345-b691-eb775082b799@paulmck-laptop>
 <ab7eQ0QDNV9ZjQMN@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7eQ0QDNV9ZjQMN@tardis.local>

On Sat, Mar 21, 2026 at 11:06:59AM -0700, Boqun Feng wrote:
> On Sat, Mar 21, 2026 at 10:41:47AM -0700, Paul E. McKenney wrote:
> [...]
> > > > +	raw_spin_lock_rcu_node(ssp->srcu_sup);
> > > > +	delay = srcu_get_delay(ssp);
> > > > +	raw_spin_unlock_rcu_node(ssp->srcu_sup);
> > > > 
> > > 
> > > It was fixed differently in v2:
> > > 
> > > 	https://lore.kernel.org/rcu/20260320222916.19987-1-boqun@kernel.org/
> > > 
> > > I used _irqsave/_irqrestore just in case. Given it's an urgent fix,
> > > overly careful code is probably fine ;-)
> > > 
> > > Thanks for the testing and feedback.
> > 
> > OK, I will try that one, thank you!
> > 
> > FYI, with my change on your earlier version, SRCU-T got deadlocks between
> > the pi-lock and the workqueue pool lock.  Which might or might not be
> > particularly urgent.
> > 
> 
> I just checked my run yesterday, I also hit it. It's probably what
> Zqiang has found:
> 
> 	https://lore.kernel.org/rcu/4c23c66f86a2aff8f2d7b759f9dd257b82147a17@linux.dev/
> 
> We have a queue_work_on() in srcu_schedule_cbs_sdp(), so
> 
>     srcu_torture_deferred_free():
>       raw_spin_lock_irqsave(->pi_lock,...);
>       call_srcu():
>         if (snp == snp_leaf && snp_seq != s) {
>            srcu_schedule_cbs_sdp(sdp, do_norm ? SRCU_INTERVAL : 0):
> 	     if (!delay)
>                queue_work_on(...)
> 
> I was about to reply to Zqiang, fixing that could be a touch design
> decision. Since it's a per srcu_data work ;-) NR_CPUS x irq_work
> incoming.

Just to be clear, SRCU-T is Tiny SRCU rather than Tree SRCU.  So perhaps
lower priority, though perhaps not lower irritation.  ;-)

							Thanx, Paul
