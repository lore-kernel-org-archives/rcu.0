Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1915E5C8
	for <rcu@vger.kernel.org>; Fri, 27 Sep 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419833; cv=none; b=aJlYNON9PQF7FZN1D3HhTBGtdj3AcAg1pP6HzTTNgdE6oQN1/flRN3SAfl6zeAgtPe1sQXF53eR4IWWR/wXF/JHptRHHyK5UgjPXa1MxPX1X8rKnEQj03f4vyGHZRF9UVsyVy27U1UdkAirUy7Mdjab8Fo6OheqKpyvLm9N6o1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419833; c=relaxed/simple;
	bh=+cZAZViW1v0LQ0aLSqaIebziEsrwrTkIrkgvenkCMq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoIA85ev2rdLPuymZz910ft08zBFUdiSh3Vfyes7KNW/IlvHjZvPAdCL8AJ+7DfNue0bWyEq5Yver20SWA9yR+V57K3xpiNyQlAbBIGWwdcRmqimJPfS6sDlMFdNTM5qUfZA/bJ+SmM178hN58BWLbajWL7IqHpvzccpKk3PLCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrTBxoW7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrTBxoW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6FDC4CEC4;
	Fri, 27 Sep 2024 06:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727419832;
	bh=+cZAZViW1v0LQ0aLSqaIebziEsrwrTkIrkgvenkCMq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrTBxoW7O+f5Py8vklkd3Onn2DEtV5xNCWBpa2ZoQ1sDMUof68TfB34AYn5HvOUsU
	 /ZbhGaVUlG1UA1JDC7jiTvgVttiI/myM0+RjSEu84NKT+FyA/zOYcgnlrm43IMMWF6
	 9zQl8qFozYJb7Lm2Dq4VngW1stlzbT03ogDKB8fXGopep+0NwHA0bhumFfrugV3fK8
	 k4s2fMbl3EwVoK51LtBFbSr/S84uDtzgRqoYmV6vtVZqkLNmoxHeEOAAuqLI+SDvJb
	 DLUCkzJwL1L/Sl6Lyoo3xMogJcVZFPlrCtXhFElkL6L1IDm8xTskNYrIiXZZESBLF1
	 asBM25doIYplA==
Date: Fri, 27 Sep 2024 12:20:25 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] doc: rcu: update printed dynticks counter bits
Message-ID: <20240927065025.GA2649@neeraj.linux>
References: <5dd8782f70c3b2367ae3c7d9016eb8fb32c76b49.1723969097.git.baruch@tkos.co.il>
 <e1af4a94-577a-4fe4-be4f-e4c7b835aab7@paulmck-laptop>
 <87cykq23a5.fsf@tarshish>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cykq23a5.fsf@tarshish>

Hi Baruch,

On Thu, Sep 26, 2024 at 12:05:38PM +0300, Baruch Siach wrote:
> Hi Paul,
> 
> On Tue, Aug 20 2024, Paul E. McKenney wrote:
> > On Sun, Aug 18, 2024 at 11:18:17AM +0300, Baruch Siach wrote:
> >> The stall warning prints 16 bits since commit 171476775d32
> >> ("context_tracking: Convert state to atomic_t").
> >> 
> >> Fixes: 171476775d32 ("context_tracking: Convert state to atomic_t")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >
> > Good eyes!
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> I remember seeing this patch queued in one of the rcu git trees, but I
> can't find it anymore. I don't see it in Linus' tree either.
> 

This patch is included for v6.13 queue [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=dev


- Neeraj

> Thanks,
> baruch
> 
> >>  Documentation/RCU/stallwarn.rst | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> >> index ca7b7cd806a1..30080ff6f406 100644
> >> --- a/Documentation/RCU/stallwarn.rst
> >> +++ b/Documentation/RCU/stallwarn.rst
> >> @@ -249,7 +249,7 @@ ticks this GP)" indicates that this CPU has not taken any scheduling-clock
> >>  interrupts during the current stalled grace period.
> >>  
> >>  The "idle=" portion of the message prints the dyntick-idle state.
> >> -The hex number before the first "/" is the low-order 12 bits of the
> >> +The hex number before the first "/" is the low-order 16 bits of the
> >>  dynticks counter, which will have an even-numbered value if the CPU
> >>  is in dyntick-idle mode and an odd-numbered value otherwise.  The hex
> >>  number between the two "/"s is the value of the nesting, which will be
> >> -- 
> >> 2.43.0
> >> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
