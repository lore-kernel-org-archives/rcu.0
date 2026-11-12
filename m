Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503460;
	b=r++k58QqtpfLfDxn/0qtPLbI88jD9bDAkUiHRmDE4UKEtQ+G5WkJCAjncMrRBrsBuAmh
	 jNioc7TPnWFD8qtaiPaNJYlWUkGFqhsYyEEj0bXG/1VTeKnmzx+dCdxwsTSxLuW/cwjVQ
	 kB/RY2P9H+x/FaGvNxH9+fB7C0+76HkL4KAoHeQZ7BlycLkxWthWFxkCw4mosKBw7cHzU
	 pf4R6ClPlXFAQQju4hWK7WRCOMjVwZfEtmlsxz0zofRsnRNa+biBrbUqeRtYryPUYiRH5
	 FsGJYIYC0aNCl5Dz2Fpj/hAJDPpeGC9zeUk5su+061qU7+lKyseg9cDzfWSJggAxm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=rW3Kj0ulR3Ttq6n6mY5IEPta9ZcKpr108GkAVG+RGZ0=;
	b=dkY+r2vOqtdMhy98lJEMZDCvCdJ5NGle6rTzGFZxIdmi6ARTV9bXqiDeBuThCC+Nnem7
	 sFyz+r8mncsfbdmMAIIxdVhI5+FjbSgZHr9w8JM23OsLz+QG3lq9bBDjkn0Vrhsj/xrWp
	 7BRIQZcVBDgTiVuQrTMKccfPljLAV92ZA0N1uypoWvL+o0F27D7chXouPB5M2m/iGBCGt
	 Uun5ojAsypCWY00InddSaWVahAQH8exQnKB1cj7IeF4hY1vVjTu9WTGn787FsJVxU3Swz
	 198QMlgsNHzeFZ/pU7EitkDEQn9pNMgTS8usXIVY6ZA88tT07mcT45vg56p+7lLZ3Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKptDYBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05854606A32E;
	Thu, 12 Nov 2026 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKptDYBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B54A1F000C4;
	Thu, 12 Nov 2026 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794503459;
	bh=rW3Kj0ulR3Ttq6n6mY5IEPta9ZcKpr108GkAVG+RGZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKptDYBcMSg/IypP4vnzhY9OBUqL2dY9v64RYp6UrU5IMFPbzJAhXTduTv+N9QZV+
	 8LSwMXXhOT/2eh9bLYvIvQoiCoYxWSX5K2P6HqanGo0tDGoJqmlnFDmQROTR0d8XpP
	 7S0nrvUzF2EV0dIjE2/PlJym1X3Vit6ANIX2hnHGf6tmPfkGV60JCcx9lDSIG25oE9
	 S410RIqQlatZRErAhe+hjta67ADz9am+qRiyYjIOvL0GPc6CMXUwqx4D1PhpeSMoJq
	 mxRK7QH0c3soBzdSej0d5bwU9WzlCcfhes0YiOnKdFjt7Pk9ICduCUqdgfqr9kk5d/
	 KrME/GIHm5+1A==
Date: Thu, 12 Nov 2026 18:10:56 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>, rcu@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH v3 2/7] srcu: Rule for using synchronize_srcu_atomic()
 from interrupt handlers
Message-ID: <avXzIAXTkQnNsRmW@localhost.localdomain>
References: <20261112133731.127221-1-mathieu.desnoyers@efficios.com>
 <20261112133731.127221-3-mathieu.desnoyers@efficios.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112133731.127221-3-mathieu.desnoyers@efficios.com>

Le Thu, Nov 12, 2026 at 08:37:26AM -0500, Mathieu Desnoyers a écrit :
> This is about the update side.  A user that calls
> synchronize_srcu_atomic() from an interrupt handler must disable
> interrupts around all its calls on that srcu_struct, task context
> included.  Document this rule, and warn when it is broken.  The rules
> for readers are unchanged.
> 
> synchronize_srcu_atomic() spins rather than sleeps, so it may be called
> from atomic context, interrupt handlers included.  Its callers on one
> srcu_struct exclude each other with ->srcu_atomic_gp_flag.  One of them
> drives the grace period.  The others spin until a grace period ends.
> 
> The flag owner disables only preemption.  So an interrupt can arrive on
> its CPU while it holds the flag.  If that interrupt handler calls
> synchronize_srcu_atomic() on the same srcu_struct, it spins forever:
> 
>   CPU 0, task                        CPU 0, hardirq
>   synchronize_srcu_atomic()
>     takes ->srcu_atomic_gp_flag
>                                      synchronize_srcu_atomic()
>                                        spins until a grace period ends
>                                        it never ends: its driver is the
>                                        task this interrupt interrupted
> 
> Nothing reports it.  lockdep cannot, because lock_sync() records no
> interrupt state.
> 
> synchronize_srcu_atomic() cannot disable interrupts itself.  A reader
> that disables only preemption may wait for an IPI to the waiter's CPU.
> That IPI never runs while the waiter spins with interrupts disabled.
> The kernel-doc already lets the caller choose the waiter's context.
> It then asks the readers to run in that context, or a stricter one.
> 
> So the caller disables interrupts.  The existing reader rule then
> requires the readers of that srcu_struct to disable interrupts too.
> 
> Also store the owner's CPU number plus one in the flag, instead of 1.
> A waiter that finds its own CPU as the owner warns once.  It still
> hangs, but no longer silently.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
