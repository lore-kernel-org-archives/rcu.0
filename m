Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9219AA56
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527110; cv=none; b=GnAKzYWCX5jeDX3+B6ia/KyG3h05h0ufekq3gGGN7SKxcFaYxqsTTwUQUjweVQH1UY0DevNKaOoiYklH1FybxCG4aRKUszNgEKQpDHKZBLQwkZYaZObBeHMnpHFvVE6MasN4GTzFvLIO2kDkGuYDGJ7ZBUT6uYY3+wx1cQznnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527110; c=relaxed/simple;
	bh=13LdUDWPAPpjlFp+arx/PlnbMUaWA4FsbSmdEF9hIhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy2Xi6m/g055+M4MttWOZ8YPnYgtGsXw2ZIxJz4AmNbgG8gU5oTuaOP28/H3sa4Johf9fSyx3QZ6pFlZ2CEGU87ljDZc4i8UQinfvM6gkmokMzrVrVUNadQFKuguzVlt7i3onfifqnUjM2+oUmTHTA0qN/5vZ16rbzHu15Q3yps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi5nlY5V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi5nlY5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96642C4CEDD;
	Tue, 25 Feb 2025 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740527109;
	bh=13LdUDWPAPpjlFp+arx/PlnbMUaWA4FsbSmdEF9hIhc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bi5nlY5VJDFd+Fzkdt+B/OKR5NJRwW9VNRviYePUcn8JKSl/HjOe/AkJQdYuk37CH
	 f88o99z1PmSOLlSv0QSmCXfQwR3RHaGnhea4y//nxolTANOY+rBIKKTH/TNRR2XI6p
	 mbSJP0QcELqxfXcv0RFqJe2wwtwCpteO2+USRZ+Jfbn+Lqqf15XtQyvUrHW3etO9it
	 fm4xKdIGW5WqFAhaQ3wOv9xPtq4b/QtNWXR4pe85K36m0Mdk79LDAlohwFWpgt6wE8
	 bUBibIjf694rpcfg7J+75aEip/RNTCg7b7OV7aobcvBkI7ysoxTwL1S5Bxgcz9sfMo
	 e66UdFpaOhZDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2DEA9CE0B75; Tue, 25 Feb 2025 15:45:09 -0800 (PST)
Date: Tue, 25 Feb 2025 15:45:09 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <6bb936e8-5507-456c-a77c-3a72e40408cb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home>
 <Z73rn9nqlCwns1IY@Mac.home>
 <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
 <20250225212007.GA1806882@joelnvbox>
 <e4853773-f834-4224-bf17-f7ed895ffef3@paulmck-laptop>
 <5c7f08b3-a007-4bd4-b063-eb034373a385@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f08b3-a007-4bd4-b063-eb034373a385@nvidia.com>

On Tue, Feb 25, 2025 at 05:04:37PM -0500, Joel Fernandes wrote:
> 
> 
> On 2/25/2025 4:53 PM, Paul E. McKenney wrote:
> > On Tue, Feb 25, 2025 at 04:20:07PM -0500, Joel Fernandes wrote:
> >> On Tue, Feb 25, 2025 at 09:54:29AM -0800, Paul E. McKenney wrote:
> >>> On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
> >> [...]
> >>>>>> These passed other than a KCSAN complaint involving
> >>>>>> rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> >>>>>> This looks like the plain C-language writes to ->defer_qs_iw_pending.
> >>>>>>
> >>>>>> My guess is that this is low probability, despite having happened twice,
> >>>>>> and that it happens when rcu_read_unlock_special() is interrupted,
> >>>>>> resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> >>>>>> IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> >>>>>> data races between task and handler on the same CPU.
> >>>>>>
> >>>>>> Thoughts?
> >>>>>>
> >>>>>
> >>>>> Do you have a KCSAN of this? Also this is not a regression, right?
> >>>>> Meaning you probably have seen this before? Anyway, it should be an easy
> >>>>> fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
> >>>>> and put it in.
> >>>
> >>> Here you go!  And you are right, if it is a regression, it is from a
> >>> long time ago, though something more recent might have made it more
> >>> probable.
> >>
> >> In my opinion I probably wouldn't even call it a regression because the
> >> data-race is happening on a boolean element. If I am not mistaken, this is
> >> thus a false-positive and KCSAN has no way of silencing it?
> > 
> > You can still get in trouble with booleans.  The usual example
> > is as follows:
> > 
> > 	bool x;
> > 
> > 	...
> > 
> > 
> > 	while (!x)
> > 		do_something();
> > 
> > In many cases, the compiler is free to transform that "while" loop
> > into this:
> > 
> > 	if (!x)
> > 		for (;;)
> > 			do_something();
> > 
> > Putting a READ_ONCE() in the original "while" condition prevents this
> > transformation.
> 
> True, thanks for clarifying. I will be a bit more annoying and say that in
> rcu_read_unlock_special(), there is no such looping transformation possible
> though AFAICS. The test is an if() block. But this is beyond KCSAN's ability to
> analyze I guess.

Besides, better safe than sorry.  Especially given the decades-long
trend of increasingly clever compilers.  ;-)

							Thanx, Paul
