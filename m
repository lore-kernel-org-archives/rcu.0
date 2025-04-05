Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5D15746F;
	Sat,  5 Apr 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873027; cv=none; b=LwzfPuiybAjulYFOoMxr9vFS4LvEL5qXJtJ2NLM2FkvxX1RzF7VDYOj57rr343F5J6cnD6pxicWZ50uGVk+JTq8R6Mh45efSzdJaI6ccRYpBKhVTp820b16gPsG2F4c5/HzGvJvmFiGjNfV2+sgRHw+2Wrl0xuH6UcYUb8SPU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873027; c=relaxed/simple;
	bh=/xWkdnqp2z0xd4Qr23smKMD7mOJNO1DVLMn67LA7XM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ax8wSOly9wch9gJmBzxWTPN9yTM3SDPGfQK7BxiCkxanTkfaGIpLrRadEbdm3QgX9++8uB88KDdLa/okFHoQvPoOcZDiDdMu0nlBXrgbbZEFNOXb0lm8iX4+gs9yv2f6sW9zr0UGeLwhYrG9V67gvlbZ0BZzrx+hbQiFFKXbez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY031RlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY031RlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B5CC4CEE4;
	Sat,  5 Apr 2025 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743873027;
	bh=/xWkdnqp2z0xd4Qr23smKMD7mOJNO1DVLMn67LA7XM0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cY031RlAca2NX4hkAmNuDTM0cM8sdAavQHATQmdcXGS1lrqc5UZXI9MBNV1QlRW0y
	 kSIyVHnhQMPSgKNnHxgcoj7ZBxxKob+7kkAXpqS30y0/0zQLf6UJxX0IUUZ/1VivY9
	 0lNugt0Ti7o0V+qtStYEYXvyZwG4PecTS9f06pRLU3RjSF8Sn/yq4w7GbnP/Sy6Apv
	 Vljcyy+DFNbeUor9JZDzJncefiSLdMYYdsuBSVeak83bH7hjPoSIzJ2NcWOW1J//Co
	 RPjK/2hj9Q0FEpxZheowyG2I5kquyMv2ARKuMgYgoYuu3SDC/BptidCDxFga4BfnWH
	 jUHAaX1PFB9WA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB095CE0565; Sat,  5 Apr 2025 10:10:26 -0700 (PDT)
Date: Sat, 5 Apr 2025 10:10:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	rcu <rcu@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kernel-team <kernel-team@meta.com>, rostedt <rostedt@goodmis.org>
Subject: Re: [v2,04/12] rcutorture: Make torture.sh --do-rt use
 CONFIG_PREEMPT_RT
Message-ID: <7cf5ad76-7624-4714-a6d1-3e1dbb9ab7b3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5da8ff7a10670359647fc8135668be7c.joelagnelf@nvidia.com>
 <72693320-1863-4e47-941f-0e887f87a855@paulmck-laptop>
 <0dc1bec4-ed35-4852-a15b-781041d26df9@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dc1bec4-ed35-4852-a15b-781041d26df9@nvidia.com>

On Sat, Apr 05, 2025 at 07:01:13AM -0400, Joel Fernandes wrote:
> 
> 
> On 4/2/2025 3:17 PM, Paul E. McKenney wrote:
> > On Wed, Apr 02, 2025 at 12:19:13PM -0400, Joel Fernandes wrote:
> >> Hello,
> >>
> >> On Wed, 2 Apr 2025 16:17:06 GMT, Sebastian Andrzej Siewior wrote:
> >>> On 2025-03-31 14:03:06 [-0700], Paul E. McKenney wrote:
> >>>> The torture.sh --do-rt command-line parameter is intended to mimic -rt
> >>>> kernels.  Now that CONFIG_PREEMPT_RT is upstream, this commit makes this
> >>>> mimicking more precise.
> >>>>
> >>>> Note that testing of RCU priority boosting is disabled in favor
> >>>> of forward-progress testing of RCU callbacks.  If it turns out to be
> >>>> possible to make kernels built with CONFIG_PREEMPT_RT=y to tolerate
> >>>> testing of both, both will be enabled.
> >>>
> >>> Not sure what you point at here: You can build a PREEMPT_RT kernel and
> >>> RCU boosting is enabled by default. You could disable it if needed.
> >>
> >> Yeah, RCU_BOOST has default y if PREEMPT_RT.
> >>
> >> Paul, should we be disabling it in the --do-rt script?
> > 
> > You should have a "rcutorture.test_boost=0" from f2ac55968df2
> > ("rcutorture: Make torture.sh --do-rt use CONFIG_PREEMPT_RT").
> > 
> > Plus I just now made additional adjustments based on Sebastian Siewior's
> > feedback.  He is likely to have additional feedback, so this is currently
> > a "squash!" commit in my tree.
> Ok, thanks. If you could repost whenever it is ready to the list, I'll pull it.

If there are no complaints by Monday, Pacific Time, I will resend it.

> Also I'm guessing that checkpatch one does not need any changes, but we've to
> add a reminder to revert it in the future.

I have added a reminder in my usual todo.txt file.  I have no objection
to it being added to a more visible location.  On possible place would
be the RCU Design Documents gdoc, but I will let you guys choose.

							Thanx, Paul
