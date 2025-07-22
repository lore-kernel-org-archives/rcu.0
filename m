Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82604286887;
	Tue, 22 Jul 2025 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224694; cv=none; b=TQx1rJ4hO7DwdVl53cuNDX91mZPDD8vRF4awDxCgao0Ia946UaTsNyZBBqJ8wVJUrtOWuR9wltoZiLhIgz1+knatPVymhP+gwZiehJNlTN0cp6W+j+jfLGN6xruUFE7Flx02yyc0D9Okub2WjJbhDURJA/Ts+0DoHdIcxaTh8fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224694; c=relaxed/simple;
	bh=Qf4+3hzhq++pMMtmyb/lCgsMtpnDXI8dbOqxqPA4PTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUs760mQy767NOiip5gzTCvf2F4qQbmBX2d98q1ThC4QITyjSKWmljcYTDEAZyjwlex5aMkNe84JfiuCriXwlWD7k3Pm2bx3AtZxa14ThBY19AIdlKsDP7Rmat3DMcdRCGvXwuCPR+ZPRpOXPlGgK6BQAZp5NtOxrQC1ka5Wwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdDBYFnQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdDBYFnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01305C4CEEB;
	Tue, 22 Jul 2025 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753224694;
	bh=Qf4+3hzhq++pMMtmyb/lCgsMtpnDXI8dbOqxqPA4PTQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mdDBYFnQL4ua1OvXZQcYPMxPdRwcU79e49ckLyeWgvyhEbCH61kufbCgAdTETTwj4
	 Ne/AKiP9P/TMnjyU/wxV+KcYwoZ41dLHO2T+ekIdqG/FM7IjtfVdApcFdUkl4/VdVy
	 HTH1hmSs1vif894usnC+bblDc7VU0InJRaSYeYE71pJJzKfRx0ByJBmKuMBnjmZU/3
	 jWf6aS29w4ilXTcehTzJXBaMKH/kEMunq8mNO5lSdbpj3c/uVdHjLFluUA8CztRpM4
	 Eb57GpXjSTkCgnZ3pH9cQBdR4rxiNMCYa3hGNiLpaXNC9gZ/V7uKRGsn4H0aKzDpAk
	 decsl0f3gjkbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 950CFCE0DEC; Tue, 22 Jul 2025 15:51:33 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:51:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 2/4] srcu: Add srcu_read_lock_fast_notrace() and
 srcu_read_unlock_fast_notrace()
Message-ID: <9cfb7c56-3f21-4707-81e9-db356ec956ed@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
 <20250721162433.10454-2-paulmck@kernel.org>
 <20250722221100.GA377047@joelbox2>
 <4ac56245-3185-414d-9ee1-2c4b4c0a9d5b@paulmck-laptop>
 <20250722184736.13a0e879@gandalf.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722184736.13a0e879@gandalf.local.home>

On Tue, Jul 22, 2025 at 06:47:36PM -0400, Steven Rostedt wrote:
> On Tue, 22 Jul 2025 15:34:52 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > > > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast_notrace(struct srcu_struct *ssp)
> > > > +	__acquires(ssp)  
> > > 
> > > Should these also be marked with 'notrace' attribute?
> > > 
> > > I am not sure what the precedent is, I do see a few examples of 'notrace' and
> > > 'inline' in the same function signature though.  
> > 
> > Heh!!!
> > 
> > There are six instance of static-inline notrace functions, and eight
> > instances of static-inline non-notrace functions whose names contain
> > "_notrace", not counting the srcu_read_lock_fast_notrace() and
> > srcu_read_unlock_fast() functions currently under review.
> > 
> > My guess is that I should add "notrace" to handle the possible case
> > where the compiler declines to inline this function.  I will do this
> > on the next rebase unless I hear otherwise.
> > 
> > Steven, Mathieu, thoughts?
> 
> If you add "__always_inline" then it will include "notrace" as inlined
> functions are not traced. But we have removed "notrace" from the generic
> "inline" a while ago. If the compiler decides to ignore an "inline" it
> *will* be traced.
> 
> We probably should fix any "_notrace" functions that are not
> "__always_inline" and do not have "notrace".

Very good, and thank you!

On my next rebase, I will add "notrace" to srcu_read_lock_fast_notrace(),
srcu_read_unlock_fast_notrace(), __srcu_read_lock_fast(), and
__srcu_read_unlock_fast(), all of which are currently just static
inline.

							Thanx, Paul
