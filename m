Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C11A2C0B;
	Tue, 23 Dec 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534004; cv=none; b=KuNoZo9HqNku7RYRLUYL4zj7fJVy2rlmG8GhlBf2zwyvsZd0/uU5DT2YPP3mEv7TF54jObo5cy9t7NywAD6ZgEEiqrY49YNeq5+KzDL9IBce/NHrEmK+LCZ8DSDmO/y9242HBWRSNRiBvM9rzfDxF+aSb5BoxWaZ54ls+afBNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534004; c=relaxed/simple;
	bh=+JBtXqiAVQAr3RdHZuHvu9T0T/F4DWD3D8cxNmuH7kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZuhtzNmG6cuCf7oIy1Fh1MmeQP/zBc7nmtoBiQxhV8jm6vEJwAocgvj723raDxEsl4anHjA+3va747o0cGtbdJXbrtFGHgiO91KbSE5N6WPMMBKhqESv/jb24Qy18i+gurj0yX6oKyqIiks2afpU9I7xO4GG1kHrgACZpzDf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsfA+uG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsfA+uG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E147FC113D0;
	Tue, 23 Dec 2025 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766534003;
	bh=+JBtXqiAVQAr3RdHZuHvu9T0T/F4DWD3D8cxNmuH7kU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gsfA+uG51mJXfywH1H5G96UrUCEVn9hMkTp/SceeHakbn1dUHITgBhWUEb2YgmCtC
	 VlJMNXCfHlXk3TCGb+JdsR0IInnTi2/Qpk4dYWl+NeI05/kWCQ18q6Ou+aNIwhY15n
	 fQQCnI64yx5hfht1M0GJYw1B7ZsXYWymJl4HTj0YV3Mk4kFP9Zza+Z3QBvFNUUHtsc
	 BgkivPJ1CuBXGBhB4ANGTtBvWhR1u7XdRXNRP1ayuhceN5freqepPRFRlLaVwk3um9
	 /oO1bz3n8TqY2ftt18wPc1xNPFc3foMHMt474sP5h+j1DkEu4+sqIhVkYlAuOiOF1f
	 a6IzHDFjRKxBQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 87DAECE0D1C; Tue, 23 Dec 2025 15:53:23 -0800 (PST)
Date: Tue, 23 Dec 2025 15:53:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [RFC] jiffies_till_first_fqs off by 1
Message-ID: <2f95e414-7d0e-4e2a-9656-25abf84c27ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1efce983-639b-430d-a613-03baef81c416@nvidia.com>

On Tue, Dec 23, 2025 at 12:38:19PM -0500, Joel Fernandes wrote:
> Hello,
> 
> During studying some synchronize_rcu() latencies, I found that the
> jiffies_till_first_fqs value passed to the timer tick subsystem does is always
> off by one. This is natural due to calc_index() rounding up.
> 
> For example, jiffies_till_first_fqs=3 means the "Jiffies till first FQS" delay
> is actually 4ms. And same for the next FQS. In fact, in testing it shows it can
> never ever be 3ms for HZ=1000. And in rare cases, it will go to 5ms probably due
> to interrupts.
> 
> Considering this, I think it is better to reduce the jiffies_till_first_fqs by 1
> before passing it to the wait APIs.
> 
> But before I wanted to send a patch, I wanted to get everyone's thoughts.
> Considering this the RFC.

Inadvertent passing of the value zero?

> The other place I found this was when call_rcu_hurry() is called, but the GP
> thread takes a tick to wake up, but this isn't related to the timer per-se, it
> is just that we don't want to wake the GP thread too often. So we just wait for
> the next tick to notice callbacks before doing a wakeup.
> 
> Heh, and this means synchronize_rcu() latencies will multiply when HZ < 1000. I
> wonder if this is also what caused Uladzislau to investigate it for mobile devices.

Quite possibly!

Back in the day, the theory was that lower HZ tended to imply less-capable
CPUs, and thus a need to lighten the load.  So there might need to be
some adjustment for present-day hardware.

							Thanx, Paul
