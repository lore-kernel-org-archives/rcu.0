Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15893D541;
	Fri, 17 May 2024 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715946014; cv=none; b=H8dMEFz7wHQZO5ImWBdI1+Wb9SWxHsSJjS95mmdO4i6d0uciPKTqne1kcZswNhMs7L9vWGdqSHjbn4iZtl5oiE9sgtw24LtesFtflDCKT5Dct82OeMknuBSWY8MBcNa8aVBB4qA1JzDNl2qnTqtYH2xzpgxMOFaMvQDT82QQfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715946014; c=relaxed/simple;
	bh=D256TFI+0c0WlOF4Wi9/+Mvuafjti0O9GN9MOXChFTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIIETmOCOhHKy6d0r/DFdUSuGPMH7DfeSzH8DLHknlaXOtSsqqhZ801puFybejS8TE69gxPeOJoh95tROcEZxomZrS1xcqtmmdzfFOUwGa4zoWHR/5LMMDkSSbINwYIOnp3swrn3OaMwmEgz+4rgcxiNM2WoBViwNpKmP9gaXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7CpS19M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7CpS19M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF65CC2BD10;
	Fri, 17 May 2024 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715946014;
	bh=D256TFI+0c0WlOF4Wi9/+Mvuafjti0O9GN9MOXChFTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7CpS19MtjTMMeLh1uaMPRX3B8kkUBgRRIoCCPR/du5PzbO0OQaCLgG04bB0lPNSw
	 AWkfT4fXaxe4pPObdcjSZjYrghF90t8xpWkzJ47kHUXGh16nOromse0dMLich+hUt8
	 AaT4ycaZgOgvBzVvqKXf68jf57vxXcbifAc2H84sD5csirZ8yqcY+hv/CfFUcUf+R8
	 tSQby/+AzdECBBuDSAC3BtMUiJzTxf4yAioyQxTwRPuI9fWgv8vBpUPefwvyJ/i0wG
	 MJDcP9WHOG4GMgulHGMdLuAQs2wNOHN4vyYD2DzMdLmmCYAWaplHMTFrbyApaetdB5
	 lGWfXGXRoWs/Q==
Date: Fri, 17 May 2024 13:40:11 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZkdCG28qNha2vUSo@localhost.localdomain>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
 <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkYvemdrEOVFNtVu@lothringen>
 <xhsmha5kphefq.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZkcHSnvn0TZX6YzV@andrea>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkcHSnvn0TZX6YzV@andrea>

Le Fri, May 17, 2024 at 09:29:14AM +0200, Andrea Parri a écrit :
> I know my remark may seem a little biased,  ;-) but the semantics of
> smp_mb__after_unlock_lock() and smp_mb__after_spinlock() have been
> somehowr/formally documented in the LKMM.  This means, in particular,
> that one can write "litmus tests" with the barriers at stake and then
> "run"/check such tests against the _current model.
> 
> For example,  (based on inline comments in include/linux/spinlock.h)
> 
> $ cat after_spinlock.litmus
> C after_spinlock
> 
> { }
> 
> P0(int *x, spinlock_t *s)
> {
> 	spin_lock(s);
> 	WRITE_ONCE(*x, 1);
> 	spin_unlock(s);
> }
> 
> P1(int *x, int *y, spinlock_t *s)
> {
> 	int r0;
> 
> 	spin_lock(s);
> 	smp_mb__after_spinlock();
> 	r0 = READ_ONCE(*x);
> 	WRITE_ONCE(*y, 1);
> 	spin_unlock(s);
> }
> 
> P2(int *x, int *y)
> {
> 	int r1;
> 	int r2;
> 
> 	r1 = READ_ONCE(*y);
> 	smp_rmb();
> 	r2 = READ_ONCE(*x);
> }
> 
> exists (1:r0=1 /\ 2:r1=1 /\ 2:r2=0)
> 
> $ herd7 -conf linux-kernel.cfg after_spinlock.litmus
> Test after_spinlock Allowed
> States 7
> 1:r0=0; 2:r1=0; 2:r2=0;
> 1:r0=0; 2:r1=0; 2:r2=1;
> 1:r0=0; 2:r1=1; 2:r2=0;
> 1:r0=0; 2:r1=1; 2:r2=1;
> 1:r0=1; 2:r1=0; 2:r2=0;
> 1:r0=1; 2:r1=0; 2:r2=1;
> 1:r0=1; 2:r1=1; 2:r2=1;
> No
> Witnesses
> Positive: 0 Negative: 7
> Condition exists (1:r0=1 /\ 2:r1=1 /\ 2:r2=0)
> Observation after_spinlock Never 0 7
> Time after_spinlock 0.01
> Hash=b377bde8fe3565fcdd0eb2bdfaf3351e
> 
> Notice that, according to the current model at least, the state in
> the above "exists" clause remains forbidden _after removal of the
> smp_mb__after_spinlock() barrier.  In this sense, if you want, the
> inline comment (I contributed to) is misleading/incomplete.  :-/

Z6.0+pooncelock+poonceLock+pombonce.litmus shows an example of
how full ordering is subtely incomplete without smp_mb__after_spinlock().

But still, smp_mb__after_unlock_lock() is supposed to be weaker than
smp_mb__after_spinlock() and yet I'm failing to produce a litmus test
that is successfull with the latter and fails with the former.

For example, and assuming smp_mb__after_unlock_lock() is expected to be
chained across locking, here is a litmus test inspired by
Z6.0+pooncelock+poonceLock+pombonce.litmus that never observes the condition
even though I would expect it should, as opposed to using
smp_mb__after_spinlock():

C smp_mb__after_unlock_lock

{}

P0(int *w, int *x, spinlock_t *mylock)
{
	spin_lock(mylock);
	WRITE_ONCE(*w, 1);
	WRITE_ONCE(*x, 1);
	spin_unlock(mylock);
}

P1(int *x, int *y, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	smp_mb__after_unlock_lock();
	r0 = READ_ONCE(*x);
	WRITE_ONCE(*y, 1);
	spin_unlock(mylock);
}

P2(int *y, int *z, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	r0 = READ_ONCE(*y);
	WRITE_ONCE(*z, 1);
	spin_unlock(mylock);
}

P3(int *w, int *z)
{
	int r1;

	WRITE_ONCE(*z, 2);
	smp_mb();
	r1 = READ_ONCE(*w);
}

exists (1:r0=1 /\ 2:r0=1 /\ z=2 /\ 3:r1=0)


