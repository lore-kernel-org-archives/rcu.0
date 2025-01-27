Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52433D64;
	Mon, 27 Jan 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996558; cv=none; b=ewaXM9Fs+JYKGqC5kxUxVpvQRv+dREbki/En7g5NUV6hAsHkj2SJbyZnEXZzQ4y1XWzZRZdgJ2Zs0PaSzFIyZ6TyYBgQDr8lHf3QyQPDvfbZCV5MVw3XiIrCUeQyGq2qIc48FCenE0ayZkQmI0QzW4ZCTPUeZ+xaD0z25ZWsx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996558; c=relaxed/simple;
	bh=yVaBGZRS5giy0CAWZjD9f8gYIcMLtqmkS5ciC3RRAKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHuNQXhBXEZaF5pbS67Ufunpkff2ImhTpXUaKqdqscgoQ8MCoqEZ+GW1297qHUfNWsxdJa4ClonzaNhxc6JMbnoSgc6tJHTuc9wiKdIMNdkth412T8jlrbdx4M3my6kTuUDV3LHooWhuJymifAD67F8Y04BkYCSNQGQsdXv/4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSxq8h7T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSxq8h7T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2446EC4CED2;
	Mon, 27 Jan 2025 16:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737996558;
	bh=yVaBGZRS5giy0CAWZjD9f8gYIcMLtqmkS5ciC3RRAKg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kSxq8h7TBT+s/22piQ12XA4qxKr46KdVoqUK5KpIHLx0ViYuJhUGXZImo5fEPWMbt
	 XJh8D9xFVtIG62VTVUf9T9xVW9z9B/muH068Kl6dNxZWtJI9ctTJzHjsnM3igSZZi6
	 IM7KTParquj6jmjKJfjd5sGqCfbPf3PLLNl6A2F6hm8smW/t/41ycZrM5n/2l8+7XS
	 Em2P6DxR4/msV7amyiZjnyy4RssrOs/snV5f1uezxGNkc6oVqUurDmIkv6yarygoKX
	 MCpItKSaO2pyWjh76ueGqrWdo4Xi6yOeNMLczUG+bI+Z9Io6j+vvz8Upf1aJcDy1+L
	 Jpqes2lz7yakw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BCCF0CE13C2; Mon, 27 Jan 2025 08:49:17 -0800 (PST)
Date: Mon, 27 Jan 2025 08:49:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH RFC v2 rcu] Fix get_state_synchronize_rcu_full() GP-start
 detection
Message-ID: <76ea9e49-c8d9-4ddf-8dd5-65ba4096e242@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <da5065c4-79ba-431f-9d7e-1ca314394443@paulmck-laptop>
 <Z5QcXoE0lrS6yIBt@pavilion.home>
 <d7bbe2cd-d889-40e9-8d46-fb8772fed6db@paulmck-laptop>
 <Z5T7kF7LKIuk05FR@pavilion.home>
 <a18ec931-a7cb-408b-8707-f88068a13ba9@paulmck-laptop>
 <CAEXW_YReLoj+fofM9=fT-G0rz-E0z7vcwg_ANrbfCrPOX99tYA@mail.gmail.com>
 <CAEXW_YQaC+TYnXZca2MBcJQgf2EWD+pBp-Dih+b647RtpJ+LNQ@mail.gmail.com>
 <83f5a3ff-8f89-4994-844f-b7eb9e80b16d@paulmck-laptop>
 <CAEXW_YTiX2taVbg3keCR4RuxSdfpVA0fVPpCcDWXjF7rH7Kkdw@mail.gmail.com>
 <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTduDBJY2CbkStWc3-4MP06+bJVFmEbgvfayB6BQyyksw@mail.gmail.com>

On Sun, Jan 26, 2025 at 09:58:11PM -0500, Joel Fernandes wrote:
> On Sun, Jan 26, 2025 at 9:55 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Sun, Jan 26, 2025 at 9:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Jan 26, 2025 at 08:22:23PM -0500, Joel Fernandes wrote:
> > > > On Sun, Jan 26, 2025 at 8:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > >
> > > > > Hi, Paul and Frederic,
> > > > >
> > > > > [...]
> > > > > > > > On Sat, Jan 25, 2025 at 12:03:58AM +0100, Frederic Weisbecker wrote:
> > > > > > > > > Le Fri, Dec 13, 2024 at 11:49:49AM -0800, Paul E. McKenney a écrit :
> > > > > > > > > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > > > > > > > > index 2f9c9272cd486..d2a91f705a4ab 100644
> > > > > > > > > > --- a/kernel/rcu/rcu.h
> > > > > > > > > > +++ b/kernel/rcu/rcu.h
> > > > > > > > > > @@ -162,7 +162,7 @@ static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> > > > > > > > > >  {
> > > > > > > > > >         unsigned long cur_s = READ_ONCE(*sp);
> > > > > > > > > >
> > > > > > > > > > -       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (2 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > > > +       return ULONG_CMP_GE(cur_s, s) || ULONG_CMP_LT(cur_s, s - (3 * RCU_SEQ_STATE_MASK + 1));
> > > > > > > > >
> > > > > [...]
> > > > > > > > > The way I understand it is that rcu_state.gp_seq might be seen started while
> > > > > > > > > root_rnp->gp_seq is not. So rcu_seq_snap() on the started rcu_state.gp_seq
> > > > > > > > > may return maximum 2 full GPs ahead of root_rnp->gp_seq. And therefore it takes below
> > > > > > > > > 2 GPs to safely deduce we wrapped around.
> > > > > > > >
> > > > > > > > Exactly!
> > > > > > > >
> > > > > > > > > Should it be ULONG_CMP_LT(cur_s, s - (2 * (RCU_SEQ_STATE_MASK + 1))) ?
> > > > > > > >
> > > > > > > > Quite possibly.  I freely admit that I allowed a bit of slop because
> > > > > > > > time was of the essence (holidays and all that) and also it does not
> > > > > > > > hurt much to lose a couple of counts out of a 2^32 cycle, to say nothing
> > > > > > > > of the common-case 2^64 cycle.  It would not hurt to be exact, but it
> > > > > > > > would be necessary to convince ourselves that we were not off by one in
> > > > > > > > the wrong direction.
> > > > > > > >
> > > > > > > > I would be happy to see a patch, as long as it was sufficiently
> > > > > > > > convincing.
> > > > > > >
> > > > > > > I'm not so much concerned about being exact but rather about making
> > > > > > > sure we still understand what we did within one year. We can leave one
> > > > > > > more grace period than what we expect out of paranoia but, the most
> > > > > > > important is that we comment about what we expect and why. Let me
> > > > > > > prepare a patch for that.
> > > > > >
> > > > > > Even better!
> > > > >
> > > > > Do we really have users who could pass such a huge delta wrapped
> > > > > around value to poll() i.e > ULONG_MAX/2 ?  For 32-bit, that would be
> > > > > 2 billion count since the get() (500 million GPs on 32-bit?). I am
> > > > > curious if such a scenario should be a WARN() because also: If more
> > > > > than ULONG_MAX/2 values are possible after get(), then a full or
> > > > > multiple ULONG_MAX wraparound is also possible. This means then both
> > > > > rcu_seq_done() and rcu_seq_done_exact() become unreliable anyway for
> > > > > such stale get() values.
> > > > >
> > > > > I do agree with both your points on the side effect of the patch to
> > > > > rcu_seq_done_exact(), but I am not fully convinced myself about
> > > > > utility of rcu_seq_done_exact() versus the rcu_seq_done() but I could
> > > > > be missing something.
> > > >
> > > > I want to modify my comment on reliability. rcu_seq_done_exact() is
> > > > certainly more "reliable" than rcu_seq_done() for wraparound delta  >
> > > > ULONG_MAX/2. Still with such a huge wrap around it is not fail proof
> > > > if it lands within the "3 Grace period" window, so if it is not super
> > > > reliable and if the user should not rely on it, then I wonder if it is
> > > > better to not do it and instead warn the user they are playing with
> > > > fire. But a counter-argument might be, landing within the 3 GP window
> > > > is quite low probability...
> > >
> > > It is also a harmless false negative.  And another poll within a few
> > > hundred milliseconds will set things straight.  In contrast, if we
> > > used rcu_seq_done(), it would be a good long time before we got out of
> > > false-negative territory.
> >
> > True!
> >
> > > On a 32-bit system, if there was an expedited grace period every 10
> > > microseconds (just barely possible on small systems), then a 32-bit
> > > counter would wrap in about 12 hours.  So there would be a six-hour
> > > false-negative zone.
> > >
> > > So an expedited grace period every 10 microseconds combined with
> > > a six-hour polling delay is unlikely, but not out of the realm of
> > > possibility.
> >
> > Assuming that every 10 microsecond of the entire 6 hours is used for
> > an expedited GP, but I agree with your point.
> >
> > > Please feel free to nominate a comment.
> >
> > Ok thanks, I'll see what Frederic comes up with and can take it from there.
> 
> I forgot to ask is the reason for keeping rcu_seq_done_exact() to have
> more complexity only when needed, or does it make sense to rename
> rcu_seq_done_exact() as rcu_seq_done_done() and get rid of the old
> rcu_seq_done()?

We might well be able to use the rcu_seq_done_exact() algorithm for
all the uses, but that will require very careful review and testing.
Please keep in mind that there are quite a few uses, that the benefit
is small, and I was lazy.  ;-)

The difference with the polling APIs is that a user might well
legitimately hang onto a cookie for six hours, for example, by having
used it to tag a data structure in a block cache or similar.

							Thanx, Paul
