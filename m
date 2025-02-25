Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6F19CD0B
	for <rcu@vger.kernel.org>; Tue, 25 Feb 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520423; cv=none; b=Ui/zaiaTkdpbmz/CRE9Rp9sume80mBY9gYJNA/akGIzhdHH21u0I4wC9Qf0hyfebAFpE3ilKPIho1ClZkaQqLPJ0OMbBqPRQZvDs5KViG1TQgufI6bsRFApaf/I7ftfsROGmxIMsSQkN1HEtHwkcDM/PuPSmTz52rrGHxbVgLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520423; c=relaxed/simple;
	bh=g0JGPMNDvmJGeGQhS6ikkdFzL1bgRxTVKpUXbo8oSJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq0A85lwkldXm6hm57bDVVl/MUu13crlywsRsqwnXi+ys4aQ2EsJSV4wg6ISDKY56hsFLOl/oH5WQfUNezTbmbgrEgnoChsYut6T0KGdlHf8GprPrRi94PdjyVNlM6a5pmKGA9ry4kR8rPJa4iI5Vn/+SSpEz7WY6P0l+e1EDlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9fj1MRi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9fj1MRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4606C4CEED;
	Tue, 25 Feb 2025 21:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740520422;
	bh=g0JGPMNDvmJGeGQhS6ikkdFzL1bgRxTVKpUXbo8oSJo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=c9fj1MRiGHkFcG7xtYTfMz0HqxNJC5ZuGPBfqeYpJdLWZtyY1dfxpTIt5V7OyjPC9
	 s7Gvb97QLGtqrjDse4U+Azrj1DQRi3fAgPVhT8wPCrK7h3rgTIMh9Kuj+JfEe5Nzla
	 I6PF7Ps55U1wLXHz3t6GlxSuMcsUbl3R09arvZsp0CyGQrtd6TYOwu8g49VIjMgm43
	 JrQgRgwlYBVMmZVuFTqq42qrOPem+2+7zsEKqpElqwMd258wxJBWctVvpb9MkCVAW6
	 8B6kS61t38tTw33N7f7mZXf+7nX9Si+Q704JeQy2+6Uy0c+T1HP8L5BSdUfuOFyiGO
	 orfN1/n8VXV9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F20F7CE0B75; Tue, 25 Feb 2025 13:53:41 -0800 (PST)
Date: Tue, 25 Feb 2025 13:53:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org
Subject: Re: Testing of shared RCU branching
Message-ID: <e4853773-f834-4224-bf17-f7ed895ffef3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c5bd6873-6e29-4f44-9c40-fbdffc6d1165@paulmck-laptop>
 <Z73rFVTHr-etZ8SE@Mac.home>
 <Z73rn9nqlCwns1IY@Mac.home>
 <267f54c6-4604-41fc-8cc9-6adb761fa257@paulmck-laptop>
 <20250225212007.GA1806882@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225212007.GA1806882@joelnvbox>

On Tue, Feb 25, 2025 at 04:20:07PM -0500, Joel Fernandes wrote:
> On Tue, Feb 25, 2025 at 09:54:29AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 25, 2025 at 08:11:11AM -0800, Boqun Feng wrote:
> [...]
> > > > > These passed other than a KCSAN complaint involving
> > > > > rcu_preempt_deferred_qs_handler() and rcu_read_unlock_special().
> > > > > This looks like the plain C-language writes to ->defer_qs_iw_pending.
> > > > > 
> > > > > My guess is that this is low probability, despite having happened twice,
> > > > > and that it happens when rcu_read_unlock_special() is interrupted,
> > > > > resulting in rcu_preempt_deferred_qs_handler() being invoked as an
> > > > > IRQ-work handler.  Keeping in mind that RCU runs KCSAN so as to locate
> > > > > data races between task and handler on the same CPU.
> > > > > 
> > > > > Thoughts?
> > > > > 
> > > > 
> > > > Do you have a KCSAN of this? Also this is not a regression, right?
> > > > Meaning you probably have seen this before? Anyway, it should be an easy
> > > > fix (just using READ_ONCE() and WRITE_ONCE()). I can send the fix out
> > > > and put it in.
> > 
> > Here you go!  And you are right, if it is a regression, it is from a
> > long time ago, though something more recent might have made it more
> > probable.
> 
> In my opinion I probably wouldn't even call it a regression because the
> data-race is happening on a boolean element. If I am not mistaken, this is
> thus a false-positive and KCSAN has no way of silencing it?

You can still get in trouble with booleans.  The usual example
is as follows:

	bool x;

	...


	while (!x)
		do_something();

In many cases, the compiler is free to transform that "while" loop
into this:

	if (!x)
		for (;;)
			do_something();

Putting a READ_ONCE() in the original "while" condition prevents this
transformation.

							Thanx, Paul
