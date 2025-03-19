Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343FA35963;
	Wed, 19 Mar 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393027; cv=none; b=P+CbZwin2F63L6XXUdP9jYaiOUGar2SBrK996PAGFxjtd/aJX4UhncNH0hUQkWHAxK5+CMneA5uSrdwg1in4/0SDe6jkd0VYZ/UnLFnzRDxFyPRhENpkvfepotZeXCjncan8DqZrbjbwtQr5oekqDLdtmO4YXfR+7oWgao5Mue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393027; c=relaxed/simple;
	bh=Kq3JdDRefkF3JLMBZg5uwocJhrV5QGmrtryamXqG72g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrhuhNKF09hvJO4VkCE50ZBbr2DzbiuIHmzXmNcrjjYMAx+hp5JRx0NqxIaZ8mm/FZ8Bgoc/SQudrWVjixT+U7dhRKi0Di/y4YNO6ULhC5jN3hDJZAgM8b6vGsPhK3OS8I1GS2lKjxxSYUG8Yg1tHGBip6mO9U3ihewjqdUYavk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr6t+mX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr6t+mX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B95C4CEE8;
	Wed, 19 Mar 2025 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742393026;
	bh=Kq3JdDRefkF3JLMBZg5uwocJhrV5QGmrtryamXqG72g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gr6t+mX648P9xEZ7pD4NPpsRM6JngJ86Wgm8Rgbs/SrBoHslwozVHulYbiSCcUfJg
	 Dp8rSLQc8xtO7+9BqrEQjdONN+xiJi+/OB7hHC3jGsgRicNo/fYbkGxlgWo3fp0KeK
	 FpAMblt0TQ4SJ8yrdgmkLo30Tw3+5Su1HSZr/16UvRVBjGvu8CS0wJB1lK4qARGC/z
	 N4+CgaQ1AvD/KS19ERnN4ndwuyRoBwbCtZ5xWLHkitNxyq9p+gLH7dGubjxYfNXxKg
	 I9YXXg23pyiceR0qWTJBvZnBGbJqkzq2zICpnbbhbJImcEPyqFzOBNM9kGxiMixcgU
	 RLwVitf5EO8vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F136CE0BC5; Wed, 19 Mar 2025 07:03:46 -0700 (PDT)
Date: Wed, 19 Mar 2025 07:03:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/5] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <5bd01e08-85cd-4538-a75d-c230bed7b0dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-3-frederic@kernel.org>
 <6fa10edf-a04c-4a1d-9e11-fbed6332bff0@paulmck-laptop>
 <Z9qH8MHMtL-l_X-G@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9qH8MHMtL-l_X-G@p200300d06f3e98759ed3c196478e337b.dip0.t-ipconnect.de>

On Wed, Mar 19, 2025 at 10:01:36AM +0100, Frederic Weisbecker wrote:
> Le Tue, Mar 18, 2025 at 10:18:12AM -0700, Paul E. McKenney a écrit :
> > On Fri, Mar 14, 2025 at 03:36:39PM +0100, Frederic Weisbecker wrote:
> > > A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> > > to order the context switch (or rather the accesses prior to
> > > rcu_read_unlock()) with the expedited grace period fastpath.
> > > 
> > > However the grace period can not complete without the rnp calling into
> > > rcu_report_exp_rnp() with the node locked. This reports the quiescent
> > > state in a fully ordered fashion against updater's accesses thanks to:
> > > 
> > > 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
> > >    locking while propagating QS up to the root.
> > > 
> > > 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
> > >    the root rnp to wait/check for the GP completion.
> > > 
> > > 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
> > >    before the grace period completes.
> > > 
> > > This makes the explicit barrier in this place superflous. Therefore
> > > remove it as it is confusing.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Still cannot see a problem with this, but still a bit nervous.
> 
> Where is the challenge in life if we manage to fall alseep within a minute
> at bedtime?

;-) ;-) ;-)

Suppose that there was an issue with this that we are somehow not spotting.
How would you go about debugging it?

							Thanx, Paul

> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Thanks!
