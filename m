Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970418DB35;
	Wed, 16 Apr 2025 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744762759; cv=none; b=XwzsSduLL75vKUTfLgn02SVUb5ap0zbs/A3Sdum+n2KaCx4VMnsIt5pisu8a6NBHFG2Ls5fykCZPtjUmabEcE1yC9OWEZdDwGzeYGLxP78T0FUO4IJaFvGNvvPCISufnBHnt0iU4gHRhm+foyKQ/ZtTqE431r3E0XAoMn9IKCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744762759; c=relaxed/simple;
	bh=oDX8l4em8cbUbQirirjX1naQvZgLfu+lh5AjYsF7I0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4PO+dft55G4a7vHhV6OUsAqObWiSsR/1rvqV91xd/eyCACVgev1bqzpuWtiZlcV294crhJBijIBnvfBL5GHimlPhutRFntfKvMTJ4wKj5Ou+YsMQ7RK0agwAccwBtBb5MTkYrqCloaG3iQIQ2cU8hUQK4roNUSdNjvmCtN1nfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwXrvQL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwXrvQL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7746C4CEE7;
	Wed, 16 Apr 2025 00:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744762757;
	bh=oDX8l4em8cbUbQirirjX1naQvZgLfu+lh5AjYsF7I0Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RwXrvQL/Hsgn7RosAZMiTqwXPae0wiKDtG3WHuUdgzJQiLQAf9EgSltODbwKuKKWi
	 Gg47ku2jY45QxR9DL9DqPgpoF1nmMFpIzvMeHsw3Y65mTNz6Eeq0PkOpwcAzSsavEI
	 zVwox//jMfhpgtC5RilP6uWl6B1YL3ecqPE4U2hgToNRxHIG0tApY2FZ7lTxfXRdTB
	 K8VfEtuyTuofYVyxVyfxN8V8b00Tclx3VxgE6f+2a7nLD7RXDX2zweEHs3RadvJHLk
	 Al5DTt+Iy6Y+dGZt5CuTcIYgjS/DademVMomHEAO8SBHYMS12vTYzF0CeXhRIauN/m
	 3qv2V6sl/MFsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 67631CE05B1; Tue, 15 Apr 2025 17:19:17 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:19:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, rcu@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rcutorture: Perform more frequent testing of
 ->gpwrap
Message-ID: <587e21be-9595-4625-b929-0e8b4a215a43@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250410150329.3807285-1-joelagnelf@nvidia.com>
 <20250410150329.3807285-2-joelagnelf@nvidia.com>
 <11caaa93-7acf-417c-9223-1b14a76310b2@paulmck-laptop>
 <5ee46103-caef-46ac-8660-4b9f4bb5e4f0@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee46103-caef-46ac-8660-4b9f4bb5e4f0@nvidia.com>

On Mon, Apr 14, 2025 at 11:05:45AM -0400, Joel Fernandes wrote:
> On 4/10/2025 2:29 PM, Paul E. McKenney wrote:
> >> +static int rcu_gpwrap_lag_init(void)
> >> +{
> >> +	if (gpwrap_lag_cycle_mins <= 0 || gpwrap_lag_active_mins <= 0) {
> >> +		pr_alert("rcu-torture: lag timing parameters must be positive\n");
> >> +		return -EINVAL;
> > When rcutorture is initiated by modprobe, this makes perfect sense.
> > 
> > But if rcutorture is built in, we have other choices:  (1) Disable gpwrap
> > testing and do other testing but splat so that the bogus scripting can
> > be fixed, (2) Force default values and splat as before, (3) Splat and
> > halt the system.
> > 
> > The usual approach has been #1, but what makes sense in this case?
> 
> If the user deliberately tries to prevent the test, I am Ok with #3 which I
> believe is the current behavior. But otherwise #1 is also Ok with me but I don't
> feel strongly about doing that.
> 
> If we want to do #3, it will just involve changing the "return -EINVAL" to
> "return 0" but also may need to be doing so only if RCU torture is a built-in.
> 
> IMO the current behavior is reasonable than adding more complexity for an
> unusual case for a built-in?

The danger is that someone adjusts a scenario, accidentally disables
*all* ->gpwrap testing during built-in tests (kvm.sh, kvm-remote,sh,
and torture.sh), and nobody notices.  This has tripped me up in the
past, hence the existing splats in rcutorture, but only for runs with
built-in rcutorture.

> On the other hand if the issue is with providing the user with a way to disable
> gpwrap testing, that should IMO be another parameter than setting the _mins
> parameters to be 0. But I think we may not want this testing disabled since it
> is already "self-disabled" for the first 25 miutes.

We do need a way of disabling the testing on long runs for fault-isolation
purposes.

For example, rcutorture.n_up_down=0 disables SRCU up/down testing.
Speaking of which, I am adding a section on that topic to this document:

https://docs.google.com/document/d/1RoYRrTsabdeTXcldzpoMnpmmCjGbJNWtDXN6ZNr_4H8/edit?usp=sharing

							Thanx, Paul
