Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750183;
	b=hRuVXYDV9987S8edJ74wRhAAp/oyK8WxwMFN7CEVpBj8V8kopmt/s7sXqR6+neb+akYh
	 yX3fqIn0KxsO3KuXyMzWpeMr3h3DsRRd8zdeKHlRCIAhUm9Rc19xGgbC9tg+en8FIyJQ/
	 gS6ZXZaBYE+rggOdKjQwlpRIFfByeRQGqLYisTwrbnkEi1EkzqBgKPPjEGPSjAtP8CYe7
	 0aJFAASOzDQiLriXTCM393LaESkLtE7LFFaF4VEDrf/cWj8G/eKtam2ck1uHq15WTCDab
	 xsoueQm68ZnxK9ojfqgOLJf62jgfLlTpb/V+3gGh5jp8Jam13MS3ZHOA2v8jy9XD4lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750183;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=uz7s5rEpS3u5rUQw/TCG+JN8C3/Wo6LQAwPHf7MRvt8=;
	b=zWx6gfyqyVU4ODPoxmMCpIl21BY7FgFKZ3hKB9E37iHudn0OxclwhlcVt1ildd+Ri+bO
	 zseaBMTt9SXeLa0RSyy2rIUjxuJEF/2QOAcV2BsAp1fz3BVoYz9d7KdvscPEBaYtMTtaT
	 FY2QysAJocVoGWutI60M44DAgq/QQYVVWZMscooZEZYpYRBDlfMMdMM16l74IjxDEbdPx
	 7QwwR9/39ug708oJm6voTCnejwS07yQOu8nLs5RGUVRuoWdHipgBpffm3KHNZ5RxBaGMu
	 t6MmMzint4u5CSI2vfNiB/AMp/BFRZCJBKFX5zFM4x7yTDeGZIiO6Do5PpEuxGFLFcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0jIhATy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99498606A31B;
	Tue,  3 Nov 2026 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0jIhATy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8CA1F000C1;
	Tue,  3 Nov 2026 23:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750183;
	bh=uz7s5rEpS3u5rUQw/TCG+JN8C3/Wo6LQAwPHf7MRvt8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=S0jIhATyPOu6K82YDbANy8BVQeSquhoxT7Wk6g3ScqwfajznV1wdnak18T6J2oXRS
	 DhjzJTQHuXiQKCaqj+DSM66wIaFBeQUqF9s/fPHzBunheOkgrBhbLaGvwBC1XXttY4
	 bvrcIrfFlCk8cGtrq+dyj6XCt2TGJ5NMHsk1N5Dklv3DS1XSjSxAi6vvSDFL4D5HSf
	 D9kxFgCOfElf4dSFvKljClLYyFPB2Eo+nyIbKJGe1l+TlaTRX2BzsXmufoyE2QOVeH
	 CixJiXoesg9IFUgwUxGpU9b9Z/qO3ZHE8MPVfh9V9W3o9MYP3k7UCqv6puSRRYCeqg
	 A9/rRD8yv/Tmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DE107CE08CE; Tue,  3 Nov 2026 15:56:22 -0800 (PST)
Date: Tue, 3 Nov 2026 15:56:22 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu/dev 1/4] hazptrtorture: Release all deferred hazard
 pointers before stopping
Message-ID: <6e9a11e5-90d6-413f-81d0-cdd1c606cc83@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261027163811.2470569-1-parri.andrea@gmail.com>
 <20261027163811.2470569-2-parri.andrea@gmail.com>
 <eb59edbb-c6e8-49c6-a426-c55cdb792853@paulmck-laptop>
 <9da03ed6-fea2-44df-8aee-f7a61a1d35ce@paulmck-laptop>
 <178eaa0b-e7bd-455e-ac3c-f1115d731a52@paulmck-laptop>
 <20261103190507.1913628-1-parri.andrea@gmail.com>
 <ad753ec5-52ee-4fcf-8275-77095f42e8c9@paulmck-laptop>
 <20261103234246.2546810-1-parri.andrea@gmail.com>
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
In-Reply-To: <20261103234246.2546810-1-parri.andrea@gmail.com>

On Wed, Nov 04, 2026 at 12:42:41AM +0100, Andrea Parri wrote:
> On Tue, Nov 03, 2026 at 12:44:07PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 03, 2026 at 08:05:06PM +0100, Andrea Parri wrote:
> 
> [...]
> 
> > > >     hazptr_torture_cleanup() stops the kthreads in random order, which
> > >
> > > The order is fixed: do_pending, preempt, the writer, then the readers.
> >
> > That was my first thought, but then I remembered that torture_init_begin()
> > sets fullstop to FULLSTOP_DONTSTOP, which causes torture_must_stop()
> > to return true, thus stopping all the hazptrtorture kthread at about
> > the same time in some random order.
> >
> > By the time hazptr_torture_cleanup() gets around to invoking
> > torture_stop_kthread() for the various kthreads, the game is up.
> 
> torture_must_stop() does become true for all the kthreads at once,
> when torture_cleanup_begin() sets FULLSTOP_RMMOD, but each, once out of
> its loop, waits in torture_kthread_stopping() until
> hazptr_torture_cleanup() calls kthread_stop() on it, in the order above.
> 
> [...]

Fair point, and so I have moved the hazptr_torture_do_one_pending()
loop to precede that call to torture_kthread_stopping().

> > I instead dropped the torture_stop_kthread() reordering from the most
> > recent version of this patch shown below.  (Which still contains the
> > above typos, but could you please check it otherwise?)
> 
> With the pass after torture_kthread_stopping(), each reader reaches that
> pass only after kthread_stop() is called on it.  Cleanup now waits for
> the writer before making those calls:
> 
> 	/* hazptr_torture_cleanup(): */
> 	torture_stop_kthread(hazptr_torture_writer, ...)  /* waits */
> 	torture_stop_kthread(hazptr_torture_reader, ...)  /* releases */
> 
> So a writer waiting in ->sync() on a deferred hazard pointer left after
> do_pending's last pass keeps kthread_stop() on it from returning, as in
> the hang this patch fixes, and the readers are never stopped.
> 
> With ba9a3e4d3b237 and patches 2-4 on top (d0a4ec9443ee), both
> 3-minute PREEMPT runs with kthread_do_pending_ms=10000 hang this way:
> after "Stopping hazptr_torture_writer task", the writer stays in
> ->sync(), no reader is stopped, and 3823 and 4072 deferred hazard
> pointers are never released (reldefer - relundefer).
> 
> Keeping the reordering, or doing the pass right after the reader's
> loop, before torture_kthread_stopping(), avoids this.  Your previous
> version, which keeps the reordering, passed those runs, as did the
> variant from my earlier reply, which does both.

And your first sentence does cover it.  ;-)

Putting the hazptr_torture_do_one_pending() loop before the call to
torture_kthread_stopping() from hazptr_torture_reader() has less "spooky
action at a distance", so I am taking that approach.

Unless of course I am still missing something.

> > > Also, "hazptrtorture: Nest a second hazard pointer in readers" conflicts
> > > with moving hazptr_torture_do_one_pending() up, as both add a function
> > > after hazptr_torture_defer(); keeping both resolves it.
> >
> > I believe that I have resolved that correctly, but could you please
> > check v7.4-rc1..d0a4ec9443ee in my -rcu tree?
> 
> The resolution looks right to me: it keeps both functions, and the
> patch adds and removes the same lines as in v1.

Whew!!!

							Thanx, Paul
