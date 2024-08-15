Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8124211
	for <rcu@vger.kernel.org>; Thu, 15 Aug 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697849; cv=none; b=q/p3MSESu9MV9wwhrIvtR7ib+wpv9mSQYP+0jyiP1KiDBAjGzy0Z7fQvBYaIsne4I/L5in9u9z7vGu7OrXix1hTbg94i4t6sUJTE1vs/R0FsH33EHwpGEfIxNbbD4h+uiIzvIzHwUAynKROVanIjZacESHDRCbNG0fJgHEu7Gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697849; c=relaxed/simple;
	bh=71U3VpB9u3RN6iYWTjaE8CjugtAumKutA2rogJJchek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRgQnCM8crDpKIi6uPogoHYo1qKfFmGKrKPFCMGjLZoNd2TAZU/1BaXEhZ0O4qpuRXVh70ILM1N1+J6Ka6ob88P4TPi7XeiKwWvZbSfNiyuDvkbrjtgIOTBs/o0y9ek5rSWydqdd+b9x181bkLXD3aM/IG48vwXHIDhsBDneFqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrTUMnwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrTUMnwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC453C4AF09;
	Thu, 15 Aug 2024 04:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723697848;
	bh=71U3VpB9u3RN6iYWTjaE8CjugtAumKutA2rogJJchek=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RrTUMnwexNPOI9CvB4D8Ol9aklyeUIXDGuHdeWGtYw64cnRzQpkjFwEw9adLcvkzr
	 UZZ76eyKmWe2iGTrCtRLdfHY6Gqwrgp1GEafKD0CsLoQitvzC5YnfDYI7br4XLXScQ
	 bBvCdWrH0InjFYPlxi0x2WZ2tNl18t2T+ZbuA60KiGl4f4jeSULusxpoSdBx1zH6a6
	 aQhNCWVqxvaTeKCvjGbsBApaP+or+I43f6spAKlmfYhZhfZsFNe7zFYBN8yyAeVTu1
	 3T4zT++sEEXVNO5gA2MvyVNQNP0zkD/dqKChzOJu4Aeftm5BuVr6PXYEtmlLlQddxG
	 uP4NKWnfaC1rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4AF27CE0E02; Wed, 14 Aug 2024 21:57:28 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:57:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: neeraj.iitr10@gmail.com, frederic@kernel.org, rcu@vger.kernel.org
Subject: Re: Neeraj Upadhyay will do v6.12 RCU pull request, Frederic
 Weisbecker v6.13
Message-ID: <9b6adb62-aa70-41f9-b3e2-45e829d9d590@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <08c365a6-e382-4a0c-b1c6-89e57b87f6de@paulmck-laptop>
 <CAHk-=wg18amRv=vszzVZMo8L1C-jEExCQaVbjOCTDYFq_L1KOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg18amRv=vszzVZMo8L1C-jEExCQaVbjOCTDYFq_L1KOA@mail.gmail.com>

On Wed, Aug 14, 2024 at 06:11:48PM -0700, Linus Torvalds wrote:
> On Wed, 14 Aug 2024 at 09:32, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Just to let you know that Neeraj Upadhyay will be sending you the RCU
> > pull request for the v6.12 merge window.
> >
> > Frederic Weisbecker will be doing this for the v6.13 merge window.
> 
> Ack.
> 
> > Please let us know if you have any questions or concerns.
> 
> My goldfish-like memory *may* just barely remember this during the
> 6.12 merge window, but by the 6.13 one I will have completely
> forgotten.
> 
> That said, I use my email an extended memory bank, so when I get a
> pull request and wonder "was I ever informed about this", I'll
> _priobably_ just search my mailbox before I start making a fool of
> myself publicly by admitting that I'd completely forgotten that you
> told me the plan.
> 
> But if I *do* end up wondering aloud, just roll your eyes and point at
> this email, ok?

My plan is that we send you another email about Frederic after the v6.12
merge window closes.  So just trying to demonstrate that we are capable
of thinking more than one merge window ahead.  Perhaps I am overly proud
of this.  ;-)

On Neeraj doing the v6.12 merge window, you have been remembering (or
looking up your email) fine for the five or so !me RCU pull requests
thus far.

But it is easy for us to remind you if need be, so no worries either way!

Longer term, should we be thinking in terms of a web page somewhere that
says who is doing what merge window?  Or is there a better way?

							Thanx, Paul
