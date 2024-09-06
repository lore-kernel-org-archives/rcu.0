Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32461D363C
	for <rcu@vger.kernel.org>; Fri,  6 Sep 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640127; cv=none; b=TwzDRYmgipk8pwWpKvqOPfUSYuknd/bZmlAJsrceqoZcQnnhyYHYEAO4DZo3k9hHzK/SWzXBQWj+KanfDSO/eSar4RtELsVTTv5BNMWhqbZ8y20Vzy0NPQ4tx+NH6lSlcD/J5S6VuhiG//42wyiqJOAkkoI0AN2csk6cGgMtYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640127; c=relaxed/simple;
	bh=8biPLn4kOygpT80E0VhpTBTd5nEl7wdF+B8UgrNvP2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMu8HnlgE98XaF1Eqv1HVBKNJJo13YKCCrNjd4M4yfy5TelcD35E0KTZCkrxhKrbXLolDIrE5q6SKXxcmiQwO/yIxLQjC2PmReOQpzgpj2T2ZhPRXMrexoq7o423GjOw7XQ/bUBz+iQ/AlIYlcCu70ay7JLtKf1YfkNzPsRxFKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q96jRgfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q96jRgfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B112C4CEC4;
	Fri,  6 Sep 2024 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640126;
	bh=8biPLn4kOygpT80E0VhpTBTd5nEl7wdF+B8UgrNvP2Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Q96jRgfmYjFg0hpWMNzMTteZ88I/HYg7vKMB4RzvaF6OA3kkBljPBvn1yEoC/RSt+
	 wY/G6hVJqMoV/iRYrnMxsUdM13ieKzrKcN4z/5FJkE/5sXeHtTW3AQ5gY584wJLR5S
	 bCItK9sVqd7R+ZXtiFU8ciUKUnSJU4AEWrvi8TpXm8hI/7O61PcEzTUC+yObQsw3sN
	 w0yBdUp0p1MoPK3IXW+Q7a+Hw6Wou5oXbj01KJ/7pgs9LP9LYVVcgRjqQyj60cufHo
	 M3i3bT+ZnEwMd/gr+nbh6UfL6KFN1kPkFhNJb8TxK3cnKjF2e0YVcRIlp1GMxsa4vH
	 h0JNsSjnN2FwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 614C3CE0D72; Fri,  6 Sep 2024 09:28:42 -0700 (PDT)
Date: Fri, 6 Sep 2024 09:28:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <c6c9b808-aaaf-412f-8e2e-f509a8c4e266@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
 <Ztr_q9dJIYdmc3q_@pavilion.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztr_q9dJIYdmc3q_@pavilion.home>

On Fri, Sep 06, 2024 at 03:12:11PM +0200, Frederic Weisbecker wrote:
> Le Thu, Sep 05, 2024 at 11:04:22PM -0700, Paul E. McKenney a écrit :
> > On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > > > embarassing issue while I'm going through it again).
> > > > > 
> > > > > Very good, thank you!
> > > > 
> > > > So my proposal for a replacement patch is this (to replace the patch
> > > > of the same name in Neeraj tree):
> > > 
> > > FYI, the diffstat against the previous version of the same patch is as follows.
> > > The rationale being:
> > > 
> > > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> > > 
> > > 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
> > >    after the barrier's completion.
> > > 
> > > 3) This fixes another issue: rcuoc must be parked _before_
> > >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
> > >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
> > >    leaving the nocb locked forever.
> > 
> > Thank you!!!
> > 
> > Just to make sure that I understand, I apply this patch on top of
> > Neeraj's current set of branches to get the fix, correct?
> 
> Exactly!

It passes the initial tests, an hour of 200*TREE01 and a 10-minute
torture.sh (which Neeraj likely already ran a longer version of).  I fired
off a 12-hour 200*TREE01 run and a 60-minute torture.sh for overnight.

Here is hoping!  ;-)

							Thanx, Paul
