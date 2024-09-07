Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992314F9E2
	for <rcu@vger.kernel.org>; Sat,  7 Sep 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701612; cv=none; b=Nf4n0892vshWNUezWePj0DQL1r+ssfSpP+WQ18HlEgoAZKjOwHHk3U3IVEn0gflbRe3TcYbxYOiByvjCPVn3KbtHTugXfjoxlKa3egybsTyqQs3BVdC6qvojmTAW5Mpkcueh3awfny9/uDRlUaFskdgnKnjAVCSKltbIEIvyVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701612; c=relaxed/simple;
	bh=VS3wLqomWSvXaD8cbsQz+M3Q4KJnECFV9UAorQFK40o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i38v3xgX5/XpJcyjvk2FgBv7lvbAF97pnKcXc8WNegnA3M4bWKNCsQCnN5zGDTVL20H81EoGW87HFVxnoEmlZM6DVkdQlTb/+CG7OoBsx6EDfHegPHgcLA+1Q3xZk8EZF6Qt3dcuAo2H4vX5T7rXS44BFe7kbo13NNaZWjTcHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agvI7lmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agvI7lmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D8CCC4CEC2;
	Sat,  7 Sep 2024 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725701612;
	bh=VS3wLqomWSvXaD8cbsQz+M3Q4KJnECFV9UAorQFK40o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=agvI7lmE3ESvY4Mad2wZxV4mwbjZf/vt6NIMgXwZh8bIjN3AFxlPkkwtzSNqEMS1Y
	 bsU0652qm7kVI/Zi3WjBuCqKy0hs4Vm1WOezQ0UOP87E8PFQu2+uLUxF+yIMUOQ6mm
	 2fEqRu3vJc/dL1K+8cqGGFOLu4Q/sUAmdOs2dfqiPUMoGb0w6dE+IgV6+BM57abCla
	 lVHnXzBKUevJ2ciSMZM5+tRwcrZrne73TjPwWm9F345SAYSqStrDy2D65/WX/3wxlF
	 p5EgWu2X+UAugeIOvoemhFFduSQB3MGJwmZJQn5fJnvUmc7lFEfDoHOsg/1Dvi2rFc
	 Ab5cfhylK+lqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BC5CCE0FAB; Sat,  7 Sep 2024 02:33:29 -0700 (PDT)
Date: Sat, 7 Sep 2024 02:33:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <a9d91e16-4241-4c72-abca-472933aa625b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
 <Ztr_q9dJIYdmc3q_@pavilion.home>
 <c6c9b808-aaaf-412f-8e2e-f509a8c4e266@paulmck-laptop>
 <CAFwiDX-G6CzV3gRnfzynrHje_BXWwTmifEABZ3JV42ZV4NQjMQ@mail.gmail.com>
 <b7e421d8-40e9-49ae-873e-cbc4ea80b3a6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7e421d8-40e9-49ae-873e-cbc4ea80b3a6@paulmck-laptop>

On Sat, Sep 07, 2024 at 02:29:43AM -0700, Paul E. McKenney wrote:
> On Sat, Sep 07, 2024 at 02:47:30PM +0530, Neeraj upadhyay wrote:
> > On Fri, Sep 6, 2024 at 9:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Sep 06, 2024 at 03:12:11PM +0200, Frederic Weisbecker wrote:
> > > > Le Thu, Sep 05, 2024 at 11:04:22PM -0700, Paul E. McKenney a écrit :
> > > > > On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > > > > > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > > > > > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > > > > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > > > > > > embarassing issue while I'm going through it again).
> > > > > > > >
> > > > > > > > Very good, thank you!
> > > > > > >
> > > > > > > So my proposal for a replacement patch is this (to replace the patch
> > > > > > > of the same name in Neeraj tree):
> > > > > >
> > > > > > FYI, the diffstat against the previous version of the same patch is as follows.
> > > > > > The rationale being:
> > > > > >
> > > > > > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> > > > > >
> > > > > > 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
> > > > > >    after the barrier's completion.
> > > > > >
> > > > > > 3) This fixes another issue: rcuoc must be parked _before_
> > > > > >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
> > > > > >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
> > > > > >    leaving the nocb locked forever.
> > > > >
> > > > > Thank you!!!
> > > > >
> > > > > Just to make sure that I understand, I apply this patch on top of
> > > > > Neeraj's current set of branches to get the fix, correct?
> > > >
> > > > Exactly!
> > >
> > > It passes the initial tests, an hour of 200*TREE01 and a 10-minute
> > > torture.sh (which Neeraj likely already ran a longer version of).  I fired
> > 
> > 200-minute torture.sh completed successfully at my end.
> 
> Nice!!!  And thank you!
> 
> 							Thanx, Paul
> 
> > - Neeraj
> > 
> > > off a 12-hour 200*TREE01 run and a 60-minute torture.sh for overnight.

And these passed as well.

> > > Here is hoping!  ;-)

                                                        Thanx, Paul
