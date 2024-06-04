Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021331420D7;
	Tue,  4 Jun 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499609; cv=none; b=mQN+RfukTrSIj4yG184Z8tkUWXZaLK0USwAcmPgtV2axFhR8SMrj8enBmIoD3GxqlgBo6nhmVzaxs+L7J4FNF47U7e23tCFdFCwBJBEUAwLbwv9YOoO9Bf0ByX6uAAQy/C5RXsVNa76GAAUDHVNbMF4dtSNC26gt39o6DORp1fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499609; c=relaxed/simple;
	bh=G4bcdfSkhr9b1oEzgL3rS01ajLXZ3Z5wtjM+zkVc240=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iORFApmKL8KN5lbvTiRqx6dcZYIpnbDiSPELvmvWJYkoN677lpLJCjiv547iJ3StBcZgEvA7I0o5/290xMl7xK3fRyzQBnZQAQV/TRThqVeJ7cz0FjBb4TLlggYhvJmqfLM3AZ8p9pnYq6y8AP6a/12YihWfjCz6TKcI11fL0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fso+L++o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fso+L++o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C17EC2BBFC;
	Tue,  4 Jun 2024 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717499608;
	bh=G4bcdfSkhr9b1oEzgL3rS01ajLXZ3Z5wtjM+zkVc240=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fso+L++ob6iiEnRG2ve+9AvufqnkHrJQ4v2N/L9WAYC6CeCfOYLb6QIlyE+/4F/2I
	 jAnKkEsBgwy43qLzJJe+lPBw+5vxsRxPfdrdvIiUHxDsi73HkWxyZNx8nB/nXoIY9Q
	 hKl2Ifq3lN/h/aLEc1RfcZ+UMo8rXnwA3lX+i4BxKLnHVUtKeE6prhp7ibO/Hx+Q9T
	 yTzVRcHScq7Uezq4xZWIRgkZ4fPrQyZkK+cuUCf1Ogoi5purO2x1ZY86suQZmj8fhv
	 CvxJVbPQoCNCn/A8QWVv/4Xx05rBltVQdWzBmwMj1yLgLr1oqXKPb3ZuinzHO+mu4s
	 lOVwwoTzXwcsw==
Date: Tue, 4 Jun 2024 13:13:25 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 5/6] rcu: Remove full memory barrier on RCU stall printout
Message-ID: <Zl721Qcu34ppCTuu@localhost.localdomain>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-6-frederic@kernel.org>
 <5bc2d72a-ae27-43f0-893e-afb202abd61b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bc2d72a-ae27-43f0-893e-afb202abd61b@paulmck-laptop>

Le Mon, Jun 03, 2024 at 05:10:54PM -0700, Paul E. McKenney a écrit :
> On Wed, May 15, 2024 at 02:53:31PM +0200, Frederic Weisbecker wrote:
> > RCU stall printout fetches the EQS state of a CPU with a preceding full
> > memory barrier. However there is nothing to order this read against at
> > this debugging stage. It is inherently racy when performed remotely.
> > 
> > Do a plain read instead.
> > 
> > This was the last user of rcu_dynticks_snap().
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> I went through all of these, and the look good.  Though I am a bit
> nervous about this one.  The RCU CPU stall warning code used to be
> completely unordered, but the hardware taught me better.  I did not
> add these in response to a problem (just lazily used the existing fully
> ordered primitive), but you never know.

At least I haven't found against what it is ordering the dynticks counter here.

> Me, I would have kept the extra
> memory barriers in all six patches because they are not on a fastpath,

It is still time to discard the patches :-)

> but you are quite correct that they are redundant.

Yes and it's not so much for optimization purpose, like you said it's
not a fast-path, although in the case of fqs round scan it _might_ be
debatable in the presence of hurry callbacks, but I use those changes
more for documentation purpose. My opinion on that being that having
memory barriers when they are not necessary doesn't help reviewers and
doesn't bring the incentive to actually verify that the ordering is
correct when it is really required, since there is so much of it
everywhere anyway. I'd rather have a clear, well visible and precise
picture. But that's just personal belief.

> 
> So I have queued these, and intend to send them into the next merge
> window.  However, you now own vanilla RCU grace-period memory ordering,
> both normal and expedited.  As in if someone else breaks it, you already
> bought it.  ;-)

Sure, but it's a bet. That one day a younger person will buy it from me
double the price ;-)

Thanks.
