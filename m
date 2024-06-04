Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925B171CD;
	Tue,  4 Jun 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509654; cv=none; b=lZLE5fDq812uoZoYVe9xDlPlYJ1IMnBSMDYosOMBd1vX9/iLEJJFkcCFC0OvV+WmRb64UEcxsFDjeYmF4LeeP0Az8Wa6lb+wrMs3Lal6GwJxd01hqhkWC5dZjGnOfDCOL3F8CQYxoAn4JiJpoj7FtJnqUMbBnQg2nTGRyB5CbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509654; c=relaxed/simple;
	bh=OChRvoGJn3GDDG7duSTk/Ej21XJKNGy9RWK0+1RnEIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZtVE35Mf2XHUT7g6Ue41jLvbSYvmFphqJ7P7IV85lipnwX/8iWNo4FqDczPNZra2F6syEOrem9uEfDIWdby1QSTQqKIcuVy5tKzdVWqVPxoQfD3YpzH0NIrSsYgn7brd6M2x4z8ORtWlgl5DdO+3fU+Orvpn56JI4Z3OHHSGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFaFTTpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFaFTTpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32F5C2BBFC;
	Tue,  4 Jun 2024 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717509653;
	bh=OChRvoGJn3GDDG7duSTk/Ej21XJKNGy9RWK0+1RnEIo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hFaFTTpDXbMcBeKvKDNvYhK3+hWBsA1q6I9/NSY7xnwKe7BGPIG6I0tErMHYKRlWY
	 DNkAJLEUwPNSuYeHFtoHknSY+1s8sMrlpS/GcIUYA3zL5qAIi6hn3ElGozCx+hCdS/
	 s1RELxoqHP2GGCNPMvkOva1lCgVgqjHkpzHAYxYiSHd92BObc9E/ItA58dSy7HiZT0
	 PVdW5eEPvMwutv96GAVY0AW/BBoeZPPC+jVor6E7/NTTJ1kv2gueruq+V7Scd/qxQq
	 RQ6JKoafBNOkxvTeneXdary7Aur19v1qUIkdDNg5ax/TNXGQa5/FTJ6+lDgEISv0M3
	 YaiXZ2PqJwcLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47109CE147A; Tue,  4 Jun 2024 07:00:53 -0700 (PDT)
Date: Tue, 4 Jun 2024 07:00:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
Message-ID: <0ffd4bf0-bc66-4780-9851-2c3b0031a1bf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-6-frederic@kernel.org>
 <5bc2d72a-ae27-43f0-893e-afb202abd61b@paulmck-laptop>
 <Zl721Qcu34ppCTuu@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zl721Qcu34ppCTuu@localhost.localdomain>

On Tue, Jun 04, 2024 at 01:13:25PM +0200, Frederic Weisbecker wrote:
> Le Mon, Jun 03, 2024 at 05:10:54PM -0700, Paul E. McKenney a écrit :
> > On Wed, May 15, 2024 at 02:53:31PM +0200, Frederic Weisbecker wrote:
> > > RCU stall printout fetches the EQS state of a CPU with a preceding full
> > > memory barrier. However there is nothing to order this read against at
> > > this debugging stage. It is inherently racy when performed remotely.
> > > 
> > > Do a plain read instead.
> > > 
> > > This was the last user of rcu_dynticks_snap().
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > I went through all of these, and the look good.  Though I am a bit
> > nervous about this one.  The RCU CPU stall warning code used to be
> > completely unordered, but the hardware taught me better.  I did not
> > add these in response to a problem (just lazily used the existing fully
> > ordered primitive), but you never know.
> 
> At least I haven't found against what it is ordering the dynticks counter here.
> 
> > Me, I would have kept the extra
> > memory barriers in all six patches because they are not on a fastpath,
> 
> It is still time to discard the patches :-)

And there is also still time for you to add comments.  ;-)

> > but you are quite correct that they are redundant.
> 
> Yes and it's not so much for optimization purpose, like you said it's
> not a fast-path, although in the case of fqs round scan it _might_ be
> debatable in the presence of hurry callbacks, but I use those changes
> more for documentation purpose. My opinion on that being that having
> memory barriers when they are not necessary doesn't help reviewers and
> doesn't bring the incentive to actually verify that the ordering is
> correct when it is really required, since there is so much of it
> everywhere anyway. I'd rather have a clear, well visible and precise
> picture. But that's just personal belief.

Redundant memory barriers can be OK, but only if they make the algorithm
easier to understand, as we found in SRCU.  It is not clear that these
fit that bill, or, alternatively, that appropriate comments wouldn't be
an improvement over the redundant memory barrier.

> > So I have queued these, and intend to send them into the next merge
> > window.  However, you now own vanilla RCU grace-period memory ordering,
> > both normal and expedited.  As in if someone else breaks it, you already
> > bought it.  ;-)
> 
> Sure, but it's a bet. That one day a younger person will buy it from me
> double the price ;-)

;-) ;-) ;-)

							Thanx, Paul
