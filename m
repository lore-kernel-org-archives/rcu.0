Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E594C66
	for <rcu@vger.kernel.org>; Sat,  7 Sep 2024 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725701387; cv=none; b=pNJLPWJhxyzbcbLl5TegMlCaqGUERm357GslcrURL8hA9h54VM6ZgWmrJJVz/MqJEv1F4WJVwYh3uSqtJJbfaSH1r/60X46owal0Na/JZV468m1dXkiEE2JqeAauxQBqYcg8B08GTA5jIMm7JMQUWKEBC6HtMAGVM7oyHMfPuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725701387; c=relaxed/simple;
	bh=erTJuHphRVw+zcbPSp5XI/CMPTa9Qs1zlYBX00MNmWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijJ5yoEc0Hqtyn1iC5KLTFqWRne/uEqb5uxsoxPh1xopVF6gkc5sMKjW77T7EiDdwZkWpKp/V/pGgv3hwz8DspBgCJC6mh/RQpxPA6ArGbYb2hEHox0NoTlX8e4/2ysaOb1kil68Xw8tNr/5riMz/t3fPCiO5eoc2J/ZMLY9iFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY/+tvZK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY/+tvZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A85C4CEC2;
	Sat,  7 Sep 2024 09:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725701386;
	bh=erTJuHphRVw+zcbPSp5XI/CMPTa9Qs1zlYBX00MNmWM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cY/+tvZK+p8t5/UaEHbFbLH9ysuRMvmiZIZecyYpN0JlIk16/w2dg02SWulGiExr4
	 u4iUPSO2iIX92JxjxkD1gVIqBeY5CiHMlccKyRyAm+mZ1s6ljAJ774wEBHLfB0wfLx
	 g6Y8HCC170muC4lz3AUs0Ma06czlcAGWLeSSwkYxreprP+ES+aM6KshE5zP8iG7D7s
	 k9Fa/rKnQb978++2bRa39KoTUnKS9W1L+YqDYqlewHLW8HdkKbHBp28j5hn+YddT1w
	 no5REotywCxU8B1X8NokJiXiREXYi4wbzeKqsJg6lBh4r5ImgGFZHv1x+8ikmsTJt3
	 4BepItqdF1hBg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79626CE0FAB; Sat,  7 Sep 2024 02:29:43 -0700 (PDT)
Date: Sat, 7 Sep 2024 02:29:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <b7e421d8-40e9-49ae-873e-cbc4ea80b3a6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
 <Ztn7PpfFiYDRBjWX@localhost.localdomain>
 <3e62cd89-441f-4a9a-aff7-7ca1dda3c34d@paulmck-laptop>
 <Ztr_q9dJIYdmc3q_@pavilion.home>
 <c6c9b808-aaaf-412f-8e2e-f509a8c4e266@paulmck-laptop>
 <CAFwiDX-G6CzV3gRnfzynrHje_BXWwTmifEABZ3JV42ZV4NQjMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX-G6CzV3gRnfzynrHje_BXWwTmifEABZ3JV42ZV4NQjMQ@mail.gmail.com>

On Sat, Sep 07, 2024 at 02:47:30PM +0530, Neeraj upadhyay wrote:
> On Fri, Sep 6, 2024 at 9:58 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Sep 06, 2024 at 03:12:11PM +0200, Frederic Weisbecker wrote:
> > > Le Thu, Sep 05, 2024 at 11:04:22PM -0700, Paul E. McKenney a écrit :
> > > > On Thu, Sep 05, 2024 at 08:41:02PM +0200, Frederic Weisbecker wrote:
> > > > > Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> > > > > > Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > > > > > > Yes, I'm preparing an update for the offending patch (which has one more
> > > > > > > > embarassing issue while I'm going through it again).
> > > > > > >
> > > > > > > Very good, thank you!
> > > > > >
> > > > > > So my proposal for a replacement patch is this (to replace the patch
> > > > > > of the same name in Neeraj tree):
> > > > >
> > > > > FYI, the diffstat against the previous version of the same patch is as follows.
> > > > > The rationale being:
> > > > >
> > > > > 1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex
> > > > >
> > > > > 2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
> > > > >    after the barrier's completion.
> > > > >
> > > > > 3) This fixes another issue: rcuoc must be parked _before_
> > > > >    rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
> > > > >    within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
> > > > >    leaving the nocb locked forever.
> > > >
> > > > Thank you!!!
> > > >
> > > > Just to make sure that I understand, I apply this patch on top of
> > > > Neeraj's current set of branches to get the fix, correct?
> > >
> > > Exactly!
> >
> > It passes the initial tests, an hour of 200*TREE01 and a 10-minute
> > torture.sh (which Neeraj likely already ran a longer version of).  I fired
> 
> 200-minute torture.sh completed successfully at my end.

Nice!!!  And thank you!

							Thanx, Paul

> - Neeraj
> 
> > off a 12-hour 200*TREE01 run and a 60-minute torture.sh for overnight.
> >
> > Here is hoping!  ;-)
> >
> >                                                         Thanx, Paul
