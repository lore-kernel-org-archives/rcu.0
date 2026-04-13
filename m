Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702CE23E325;
	Mon, 13 Apr 2026 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103412; cv=none; b=prWlvT9WtAfq4E9BtIVN6b1irPAje91LF7Dt5T3hbqEBUQ0Xox9jSO1jnrjXpdOpfbXpwdssm25zwjD4qSnCa+aWrRmvr26J8FWIFpSpdL2VAdma5BwBxGZIL3PYjf93eVJBsT1fUC/FqjD0WUSuyn3RNWmQvIqG7FfNryMaZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103412; c=relaxed/simple;
	bh=1Nz1XpeoVK/S6XtEXMlmxpB5h8yuopYJts84jXNsX5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIvSEJvg+M5MwFWWAX3KH9XNLs7WrBRhrFiXPT6IB7UQn0DmKksaL+nQ4ngGl5RGSDcOd0uclLepQKthZofb9K8By2BAEzEdhqflFSoBsXfQ4Xzh2xUNJIJdoUUbGVaywCPGYe8k0QS6MGmpMXMdwLJpuArhsQugvA1qVvauN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so/tlMx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so/tlMx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D029C2BCAF;
	Mon, 13 Apr 2026 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776103412;
	bh=1Nz1XpeoVK/S6XtEXMlmxpB5h8yuopYJts84jXNsX5o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=so/tlMx9K+MQW3PImz/+Z0yn0B+U7lWhZLaY8CmB45erpu5oon1SPARdV8kWC7Ubc
	 v9Fv+OUpNtIreSe4BBnI7g/Qqp2hfsPih+DkGq+4UynNdyXDJTESWv3rXYjAfC5kea
	 J7xeyYNnaPaBpgY8kghlp+r5e+RhJwKx7IrhiR+ttUnd8Za84j+GCrQ2zrm1akMLjr
	 mYiRWPqtGO1TGoYibR3RO9sUckpPjQeXgMc4XNYqgddDQtGHXcf3Zc7dqn9XDAEknY
	 mivj0SjDcZ21IPzF7uua1unWbhuuwIs8/C0ExFWCr8geKJ3uyhDWN8I5lrwm9JPJHa
	 0h21MMqzc/5jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B0CBCCE0A6A; Mon, 13 Apr 2026 11:03:31 -0700 (PDT)
Date: Mon, 13 Apr 2026 11:03:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>, joel@joelfernandes.org,
	agnel.joel@gmail.com, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [GIT PULL] RCU changes for v7.1
Message-ID: <cefbf713-0b88-483e-89f2-2589919adb89@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1774978730.3972500.27807@nvidia.com>
 <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whigg3hvOy7c1j1MXFy6o6CHp0g4Tc3Y-MAk+XDssHU0A@mail.gmail.com>

On Mon, Apr 13, 2026 at 09:40:57AM -0700, Linus Torvalds wrote:
> On Tue, 31 Mar 2026 at 10:42, Joel Fernandes <joelagnelf@nvidia.com> wrote:
> >
> > RCU stall:
> >
> > - Add BOOTPARAM_RCU_STALL_PANIC Kconfig option to allow triggering a kernel
> >   panic on RCU stall via kernel boot parameter.
> 
> No.
> 
> Dammit, stop doing these horrible things.
> 
> I've said this a million times by now: the kernel config phase is
> probably one of the biggest pain points for random new people trying
> to build their own kernels, and we DO NOT ASK PEOPLE STUIPID THINGS.
> 
> People who want this can damn well use the sysctl or maybe some kernel
> command line option instead, and we DO NOT MAKE LIFE WORSE FOR
> EVERYBODY ELSE.
> 
> I have removed that disgusting kernel kconfig option, and I want to
> make it very clear to people that the kconfig files aren't your
> personal playgrounds: they are the most visible interface to NORMAL
> USERS that we want to encourage to build their own kernels so that
> they can participate in kernel development.
> 
> So people: next time you feel the urge to add a Kconfig option, take a
> deep breath, and look at that Kconfig file, and go "Maybe I can
> instead remove this *other* useless option instead".
> 
> Let's *improve* on the kernel instead of making things worse.

Apologies!  Would making this instead be a kernel boot parameter be
acceptable?

						Thanx, Paul
