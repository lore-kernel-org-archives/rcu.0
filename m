Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408787;
	b=0NBlja+A3g9tqww8FPOc1rkS7KUyP96e5+IUiSmFC+V1DzbgJ4yCRy7GMppjuUn1xE3y
	 3uGXITq3ZrQjyJ/PCZAAv9qvR93yIP5+KhKxMt/chBleWA7iom4wSk/s3YS+DSiGn5m95
	 E04CwPK9YJtd7+Xu4cma1UQ4vrHJ5cDd23FXGtKdxkWO8wjQD+7eD2UsUFDxe841jYwdw
	 lKMp6QFx2byoZS/N3ecrHMzw+WUfFUHlJxeUp2xTY8cdCmR6f8MWqN8iKar/hqhBrThNu
	 qPIQPcGvJFbCffwrl9l+YDIYcqjUOWjpPhWDx7n0cVdtaKlvdu72USVwUD4TU9RXj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408787;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/YTxRazV5XTN3hgImpgFfrkJyy4uWLI0hgi1WGQtQFI=;
	b=p4SEZH/+yqssf5nR1kXSFhpMETknFwQNyQCxwNnN8GtUVCnhHupmQzV41QkAxe5jiDhm
	 VI8DGU9Ng1zQ+fdOPQlbLLtoWS39vuhFXad/qB67eRvmy0IWsoN0o+ZKnfGJWDl38KI+/
	 ORUMy6+soS+p1EVi+ZQq8YlS69qqCNLB3VmCr6kDpouo8Dz23qf26U7w77GSBCrQNuVL9
	 wAZsBuLkap5Pd3WCXTOx+XCypLkNekMfFVgMkKW1YSZoNsVTmdcS+56zVeCRS5VwATgbA
	 ZhXL8bel5MNyrqV0Kuf5v0iGS4EIGcmyO7e7B4hnd6yictfHfPz9riNUT6w1yg9LL7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8MaNH1V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB1606A324;
	Wed, 11 Nov 2026 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8MaNH1V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720141F00A05;
	Wed, 11 Nov 2026 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408787;
	bh=/YTxRazV5XTN3hgImpgFfrkJyy4uWLI0hgi1WGQtQFI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=J8MaNH1VL/0+mryRSMj3pve+ZgenoO+9vLxvq+a5R9KM+lntP/QShFJrfsiLDFhan
	 NrEGXByifdN0X06Db3iDtpLnqd3SL0J9Ue3NPzzU2WevURmP208qIGbfxx5UJk69Ej
	 3ZT4elWbG2aLAJRK3Vb5yrJuuNwttv9KN8sdXRxpHyRTRo7gZJlz4LyhuRrjJC5B0G
	 /l3Da0/0wm6CspdqBxG/RvjJAiPIOtOo9Z8VRPvLF15nur5RNqO2bIDbHixgkH0QK0
	 K9QRw24tFbuc83/z0AlbZuIBG/WDwFOn8xYfUN08t+5OHZf+FFiZdvfuY6ShDDf1pt
	 1GlfuVwlPU/Fg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D121CE2510; Wed, 11 Nov 2026 06:53:07 -0800 (PST)
Date: Wed, 11 Nov 2026 06:53:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture: Run NMI-safe SRCU readers from NMI
Message-ID: <29c2c203-fce8-4735-a1a8-017d4733c6a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261110192844.44713-1-mathieu.desnoyers@efficios.com>
 <20261110192844.44713-4-mathieu.desnoyers@efficios.com>
 <9fbcb43b-ddea-44bf-b339-d01ba723d5a2@paulmck-laptop>
 <3f6746a7-e1eb-4463-aec6-687489d7c637@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6746a7-e1eb-4463-aec6-687489d7c637@efficios.com>

On Wed, Nov 11, 2026 at 09:10:35AM -0500, Mathieu Desnoyers wrote:
> On 2026-11-10 17:46, Paul E. McKenney wrote:
> > On Tue, Nov 10, 2026 at 02:28:43PM -0500, Mathieu Desnoyers wrote:
> [...]
> > A good addition!  Vanilla RCU could benefit from this as well, but that
> > can be done later.
> 
> Thanks!
> 
> [...]
> > > +            if (READ_ONCE(p->rtort_pipe_count) > 1)
> > > +                    atomic_inc(&n_rcu_torture_error);
> > 
> > Doesn't this miss doing a splat on RCU too-short grace period?
> [...]
> > Maybe a separate global array for NMIs, parallel to the "Reader Pipe:"
> > and "Reader Batch:" arrays, that is atomically updated and printed
> > separately, maybe "NMI Reader Pipe:" or similar?
> > 
> > Or is there a better way?
> 
> It does miss it.  The test still ends in FAILURE.  But there is no
> "!!!", no warning, and nothing in "Reader Pipe:".
> 
> v2 takes your approach.  The NMI reader counts its pipe and batch values
> in two arrays of atomic_long_t.  rcu_torture_stats_print() prints them
> as "NMI Reader Pipe:" and "NMI Reader Batch:", only when readers ran in
> NMI.  A too-short grace period in NMI joins the "!!!" condition, with
> its own WARN_ON_ONCE().  So the other readers keep their this_cpu_inc().
> 
> The NMI reader skips the trace event and rcu_ftrace_dump() of the other
> readers.  The "!!!" and the warning then come from the statistics
> kthread.
> 
> I checked it with a mutation that makes every NMI reader see a pipe
> count of 2: the run splats as expected.

That sounds very good, thank you!

							Thanx, Paul

> [...]
> > >              cur_ops->call(&rtncp->rh, rcu_torture_nmi_invoked);
> > 
> > OK, the invocation of ->call() without testing ->call() is OK because
> > rcu_torture_nmi_do_calls never gets set if ->call() is NULL.
> 
> Yes.
> 
> Thanks!
> 
> Mathieu
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
