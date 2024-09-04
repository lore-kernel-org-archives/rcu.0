Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2F1EEE4
	for <rcu@vger.kernel.org>; Wed,  4 Sep 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457685; cv=none; b=OuD1WI5awUHFUwEtdK9twPcDc+jNKgi+ba7aRNl8KEtOrDcMQbFJkRXbzYCa5relFKobmqxqpxD3nj/uQjmOlFlFcLeaLRHPcl1S0NpDbXCiDks0sv9PKWrsV8qWUIwXABD9amixvG+a0a1ssyWxY5sPGMbDCgkjNY98+b7kLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457685; c=relaxed/simple;
	bh=JJL+01nioC8/SeoOsSQSCyYRdVM5b2GJMKeQql93LUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEV6YaMCYq4QKetCxGiiXEA7jpwKyFOQWZNbgfPuPjPwQYKlNVGS2/q7x7TFJ3Y/PeD/d+YEEOtWwO55qF7bRoZ0TQCwc9N2EbczPUgpQCOZBHyIxJbiMOoKumA3yfMVtViiL6cIenF3OfvLF53jT130tLwY5sqOiO1kd1ByJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USj0ndVE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USj0ndVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F216C4CEC2;
	Wed,  4 Sep 2024 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457685;
	bh=JJL+01nioC8/SeoOsSQSCyYRdVM5b2GJMKeQql93LUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USj0ndVEArtTb8o0Ojs039jHBerVNoJ54eSz8tGnurmLj9o7TonB6QRyftpn+pKS6
	 mSWT65h9ict1nnXdlgr/nQIrZhsj3vAvVck5ltG31OukLnKqotNDnRu1HF0WdIzYnB
	 AbdlypnSjEY5ilo0Prw6cMu3Kp37qIQnhbTO74wxc03U7cjCOi+3NlLYDgcIuuYY9V
	 /9Sw95uPE7uBdxYEd1TapkAm9dNYJF/UXXDust35BmtjZFEqFZVLlst5QuELnWVSeV
	 5mMg0kTEeXIqFFK2WimMThqKzESOoMQfz1vRu6LkTeB2k507U+LNefDTqrfSgaMdtC
	 qgcu1nHyBMkCg==
Date: Wed, 4 Sep 2024 15:48:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <ZthlEg2njJwXMk32@localhost.localdomain>
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>

Le Wed, Sep 04, 2024 at 05:59:46AM -0700, Paul E. McKenney a écrit :
> On Tue, Aug 20, 2024 at 10:46:43AM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 20, 2024 at 04:43:39PM +0200, Frederic Weisbecker wrote:
> > > Sorry for the html mail, I only have my phone ...
> > > 
> > > Le mar. 20 août 2024, 13:07, Z qiang <qiang.zhang1211@gmail.com> a écrit :
> > > 
> > > > >
> > > > > Hello, Frederic,
> > > > >
> > > > > I have seen this once on Neeraj's tree with a few commits on top (-rcu
> > > > > commit 46774278c74f ("rcutorture: Test start-poll primitives with
> > > > > interrupts disabled").  But only the once so far.
> > > > >
> > > > > This is the WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist)) in
> > > > > rcu_nocb_rdp_deoffload().
> > > > >
> > > > > Thoughts?
> > > > >
> > > >
> > > > The rcu_segcblist_extract_done_cbs() doesn't reduce the count of
> > > > rsclp->len,
> > > > in rcu_do_bacth().  this may cause that after we execute the barrier rcu
> > > > callback, before decrementing the count of rsclp->len,  the rcu_barrier()
> > > > returns and makes a judgment of rcu_segcblist_n_cbs(&rdp->cblist)  in
> > > > rcu_nocb_rdp_deoffload().
> > > >
> > > 
> > > That sounds plausible! You just unlocked my thoughts running in circle
> > > since yesterday.
> > > 
> > > 
> > > > maybe can use WARN_ON_ONCE(rcu_segcblist_n_segment_cbs()) instead
> > > > of WARN_ON_ONCE(rcu_segcblist_n_cbs())
> > > >
> > > > Thoughts?
> > > 
> > > I'll test that once I'm back from vacation the september 2nd. Thanks!
> > 
> > Thank you both!!!
> > 
> > Running -next over last night hit a number of boot-time splats, so I
> > have no idea if this reproduces nicely.  Can't have everything!  ;-)
> 
> And it is now a two-off given another one last night's testing.  This was
> from 168 hours of TREE01 on my -rcu "dev" branch (as opposed to -next),
> but I have run many runs over the past two weeks.  So it is reproducible,
> but rare.
> 
> Ah, and if it matters, I synched up to Neeraj's latest as of about 18
> hours ago just before starting this test.

Yes, I'm preparing an update for the offending patch (which has one more
embarassing issue while I'm going through it again).

Thanks.
