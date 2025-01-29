Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80711712;
	Wed, 29 Jan 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738114397; cv=none; b=k1QuwPq3CaT+iUJsg7RKdqjgg+zzgBSqM1eST5qAiCJxHOh3mFrYyRo760vXWGgUYtInlL82NkJHvb/YRgWbsV+QKCCO/4jQk2j733Q6M9Sf817N/SiBVrRKPMNhALwDsr/73kgoCKpjVCQbEh26oANd0gXWfwZsdwrX/R/B05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738114397; c=relaxed/simple;
	bh=byZKqjD+dFwaM8s5YFC+h2maX9PAZKpZGiClAF26SdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POFFsjrYkBfqcc9Kwi0sn9vRFyHTZG1Y9iMaONdN/StcqzDVOS4O83eF+3J4r7WSJA2qBZQzQijgcZPK/pu9hbXy5miUjfVDrNhB3WN6abLdy5UxkBxvsMQTXlNVaTmoDwSoKR2VvafHfi1Bjx8yaVbHgwA3uJIHdwFipb0drv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWvt98b5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWvt98b5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD78C4CEDF;
	Wed, 29 Jan 2025 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738114397;
	bh=byZKqjD+dFwaM8s5YFC+h2maX9PAZKpZGiClAF26SdQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nWvt98b5kZgflsQUKplkaw3/TS7HWXmFxRqaV8FPLcGpAAoMFDP6iycEoxhXsCa16
	 wc4RuZssWkaOsja38c3zZQDirHjdMd4FlFm+DYyxHmtFKQb0bOqx4WInYFKKibOsPv
	 cNM22oVuHZzUmWLa4l6ZQk/bWICLs1CWSqOJGUrPOjhveI2U13bHb44JgDelop1sa/
	 7HqVUMhm4kJEDo9b5+sAu1slNxXlB1b4A/+iMLkIcvgNSlzwWQXYnt0DuDY2TcAZkv
	 X17uA3Ny7Wg2xJLHEAR7fQsyDdC7OHV2uE4qmF9G6Ur8BROFz7MqzEJUnQXVcqCoS9
	 KOsyd6LiR/YuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6DC0DCE0546; Tue, 28 Jan 2025 17:33:16 -0800 (PST)
Date: Tue, 28 Jan 2025 17:33:16 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Merge rcu_seq_done_exact() logic into rcu_seq_done()
Message-ID: <435e9637-6c5e-48a3-8d5d-c96ed890eb15@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250128000737.1264218-1-joel@joelfernandes.org>
 <CAEXW_YTQpAKLRp4Nv-zM7NJ7JAnuPKSaLicwzL6w9eqMXQFQYQ@mail.gmail.com>
 <20250129012248.GA3853708@joelbox2>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129012248.GA3853708@joelbox2>

On Tue, Jan 28, 2025 at 08:22:48PM -0500, Joel Fernandes wrote:
> On Mon, Jan 27, 2025 at 07:09:34PM -0500, Joel Fernandes wrote:
> > On Mon, Jan 27, 2025 at 7:07 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > The rcu_seq_done() API has a large "false-negative" windows of size
> > > ULONG_MAX/2, where after wrap around, it is possible that it will think
> > > that a GP has not completed if a wrap around happens and the delta is
> > > large.
> > >
> > > rcu_seq_done_exact() is more accurate avoiding this wrap around issue,
> > > by making the window of false-negativity by only 3 GPs. Use this logic
> > > for rcu_seq_done() which is a nice negative code delta and could
> > > potentially avoid issues in the future where rcu_seq_done() was
> > > reporting false-negatives for too long.
> > >
> > > rcutorture runs of all scenarios for 15 minutes passed. Code inspection
> > > was done of all users to convince the change would work.
> > >
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > I am leaving a 60 minute overnight run of all scenarios on my personal
> > server for further testing.
> 
> The run passed, details below:
> 
>  --- Mon Jan 27 11:49:49 PM EST 2025 Test summary:
> Results directory:
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 60
> RUDE01 ------- 14309 GPs (3.97472/s) [tasks-rude: g57884 f0x0 total-gps=57880] n_max_cbs: 0
> SRCU-L ------- 34121 GPs (9.47806/s) [srcu: g316564 f0x0 total-gps=79242] n_max_cbs: 150000
> SRCU-N ------- 151316 GPs (42.0322/s) [srcu: g1840064 f0x0 total-gps=460117] n_max_cbs: 150000
> SRCU-P ------- 35189 GPs (9.77472/s) [srcud: g320792 f0x0 total-gps=80299] n_max_cbs: 150000
> SRCU-T ------- 389034 GPs (108.065/s) [srcu: g4142406 f0x0 total-gps=1035602] n_max_cbs: 50000
> SRCU-U ------- 376267 GPs (104.519/s) [srcud: g3953834 f0x0 total-gps=988459] n_max_cbs: 50000
> SRCU-V ------- 407633 GPs (113.231/s) [srcud: g4371704 f0x0 total-gps=1092927] n_max_cbs: 1000
> TASKS01 ------- 11007 GPs (3.0575/s) [tasks: g57816 f0x0 total-gps=57808]
> TASKS02 ------- 10539 GPs (2.9275/s) [tasks: g57936 f0x0 total-gps=57936]
> TASKS03 ------- 10453 GPs (2.90361/s) [tasks: g57508 f0x0 total-gps=57508]
> TINY01 ------- 511634 GPs (142.121/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 57078
> TINY02 ------- 541799 GPs (150.5/s) [rcu: g0 f0x0 total-gps=0] n_max_cbs: 2619
> TRACE01 ------- 7299 GPs (2.0275/s) [tasks-tracing: g45844 f0x0 total-gps=45844] n_max_cbs: 50000
> TRACE02 ------- 101265 GPs (28.1292/s) [tasks-tracing: g305464 f0x0 total-gps=305456] n_max_cbs: 100000
> TREE01 ------- 97989 GPs (27.2192/s) [rcu: g479473 f0x0 total-gps=120151]
> TREE02 ------- 202908 GPs (56.3633/s) [rcu: g1459509 f0x0 total-gps=365162] n_max_cbs: 1139244
> TREE03 ------- 168901 GPs (46.9169/s) [rcu: g1764445 f0x0 total-gps=441393] n_max_cbs: 1341765
> TREE04 ------- 148876 GPs (41.3544/s) [rcu: g951744 f0x0 total-gps=238225] n_max_cbs: 236765
> TREE05 ------- 220092 GPs (61.1367/s) [rcu: g1234385 f0x0 total-gps=308880] n_max_cbs: 82801
> TREE07 ------- 34678 GPs (9.63278/s) [rcu: g207257 f0x0 total-gps=52094]
> TREE09 ------- 341706 GPs (94.9183/s) [rcu: g7693569 f0x0 total-gps=1923688] n_max_cbs: 1845334
>  --- Done at Mon Jan 27 11:49:55 PM EST 2025 (4:41:24) exitcode 0

Very good!

How would you go about analyzing whether this is really safe vs. getting
just getting lucky and not having provoked an overflow?

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > 
> > 
> > > ---
> > >  kernel/rcu/rcu.h  | 13 ++-----------
> > >  kernel/rcu/tree.c |  6 +++---
> > >  2 files changed, 5 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index eed2951a4962..c2ca196907cb 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -146,19 +146,10 @@ static inline bool rcu_seq_started(unsigned long *sp, unsigned long s)
> > >
> > >  /*
> > >   * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > > - * full update-side operation has occurred.
> > > + * full update-side operation has occurred while also handling
> > > + * wraparounds that exceed the (ULONG_MAX / 2) safety-factor/guard-band.
> > >   */
> > >  static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
> > > -{
> > > -       return ULONG_CMP_GE(READ_ONCE(*sp), s);
> > > -}
> > > -
> > > -/*
> > > - * Given a snapshot from rcu_seq_snap(), determine whether or not a
> > > - * full update-side operation has occurred, but do not allow the
> > > - * (ULONG_MAX / 2) safety-factor/guard-band.
> > > - */
> > > -static inline bool rcu_seq_done_exact(unsigned long *sp, unsigned long s)
> > >  {
> > >         unsigned long cur_s = READ_ONCE(*sp);
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b77ccc55557b..835600cec9ba 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -4300,7 +4300,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
> > >  bool poll_state_synchronize_rcu(unsigned long oldstate)
> > >  {
> > >         if (oldstate == RCU_GET_STATE_COMPLETED ||
> > > -           rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
> > > +           rcu_seq_done(&rcu_state.gp_seq_polled, oldstate)) {
> > >                 smp_mb(); /* Ensure GP ends before subsequent accesses. */
> > >                 return true;
> > >         }
> > > @@ -4347,9 +4347,9 @@ bool poll_state_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
> > >
> > >         smp_mb(); // Order against root rcu_node structure grace-period cleanup.
> > >         if (rgosp->rgos_norm == RCU_GET_STATE_COMPLETED ||
> > > -           rcu_seq_done_exact(&rnp->gp_seq, rgosp->rgos_norm) ||
> > > +           rcu_seq_done(&rnp->gp_seq, rgosp->rgos_norm) ||
> > >             rgosp->rgos_exp == RCU_GET_STATE_COMPLETED ||
> > > -           rcu_seq_done_exact(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
> > > +           rcu_seq_done(&rcu_state.expedited_sequence, rgosp->rgos_exp)) {
> > >                 smp_mb(); /* Ensure GP ends before subsequent accesses. */
> > >                 return true;
> > >         }
> > > --
> > > 2.34.1
> > >
