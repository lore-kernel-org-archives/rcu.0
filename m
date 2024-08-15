Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC4517C9B6;
	Thu, 15 Aug 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731258; cv=none; b=gIfeTm0ZjMvqlSAjuWx5S0OSczvRuxSerVn6bWzgPXKpKaM3YINdNU8K97yyXvWsVW8hPZYy+QQlxkxP+87tUeyjhIzGdzFFSsA77Dex9wNrB3C5n3RheueNIepuj5FPq8oE9hYJKntGBhJme+c69nbTzZcX3yr8K0YhD+Hl+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731258; c=relaxed/simple;
	bh=auBu9+oC83v29ZheKF493q3yi+itL8YaD8SgmjgHmeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFdpfmYUKrgjFAO5vNFuHAnH9pAcHNlg1yF5+diDFvDyun5oQF9NQplWm8T0qnV8JNTxYa+intwkfINI/Q0ThbRZ9izeFzx4uce3i77rO2USXrlk+4I07sz/OdFAfztyyGlF2zY3yu7RXsXgIMxnMauDYCMJgaa1tLSXdZJ3MaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVOYGwY/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVOYGwY/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB42C32786;
	Thu, 15 Aug 2024 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723731258;
	bh=auBu9+oC83v29ZheKF493q3yi+itL8YaD8SgmjgHmeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVOYGwY/YiP2UY21n7UnJgB6VxYfZtItgGIAROlmUPhpGi1vsXCnsIveU1Xx64iIo
	 oTuOIY6z/HvvDPjoo1TXk5n3JEZni2h5oX93GrTgCuxc8itESEjr2/scSoqPXnIo9i
	 fctL6A3nLfoeCUa9cuLa+jTuooQ6QM1qgjdPeGiK28bvH1SwFNWFpzlT22ZFHGyV4f
	 WWCDmAUVeoe2FLqWFoedOf7KHzlUzQXy7hxvf6Lc5Zf1+1SbCY1sX/45GepKnRi8up
	 LUbuLiezlMEX8cnF4wFu3dgR26fmmaybVNPrUAHqggNoFJIKRPwy88lPQct6+HrQCG
	 HjsWoDRoIXLSA==
Date: Thu, 15 Aug 2024 16:14:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 13/25] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
Message-ID: <Zr4NN7mZQRQaTyl0@pavilion.home>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-14-vschneid@redhat.com>
 <ZqphRBrI4mlSdER4@localhost.localdomain>
 <20240814120655.GA1412760@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814120655.GA1412760@neeraj.linux>

Le Wed, Aug 14, 2024 at 05:36:55PM +0530, Neeraj Upadhyay a écrit :
> On Wed, Jul 31, 2024 at 06:07:32PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Jul 24, 2024 at 04:43:13PM +0200, Valentin Schneider a écrit :
> > > The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> > > RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> > > meaning.
> > > 
> > > While at it, flip the suffixes of these helpers. We are not telling
> > > that we are entering dynticks mode from an RCU-task perspective anymore; we
> > > are telling that we are exiting RCU-tasks because we are in eqs mode.
> > > 
> > > Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > > ---
> > >  kernel/context_tracking.c | 28 ++++++++++++++--------------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> > > index 8262f57a43636..1c16a7336360f 100644
> > > --- a/kernel/context_tracking.c
> > > +++ b/kernel/context_tracking.c
> > > @@ -38,24 +38,24 @@ EXPORT_SYMBOL_GPL(context_tracking);
> > >  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
> > >  #define TPS(x)  tracepoint_string(x)
> > >  
> > > -/* Record the current task on dyntick-idle entry. */
> > > -static __always_inline void rcu_dynticks_task_enter(void)
> > > +/* Record the current task on exiting RCU-tasks (dyntick-idle entry). */
> > > +static __always_inline void rcu_task_exit(void)
> > 
> > So this makes sense.
> > 
> > >  {
> > >  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
> > >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
> > >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> > >  }
> > >  
> > > -/* Record no current task on dyntick-idle exit. */
> > > -static __always_inline void rcu_dynticks_task_exit(void)
> > > +/* Record no current task on entering RCU-tasks (dyntick-idle exit). */
> > > +static __always_inline void rcu_task_enter(void)
> > 
> > That too.
> > 
> > >  {
> > >  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
> > >  	WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
> > >  #endif /* #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL) */
> > >  }
> > >  
> > > -/* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
> > > -static __always_inline void rcu_dynticks_task_trace_enter(void)
> > > +/* Turn on heavyweight RCU tasks trace readers on kernel exit. */
> > > +static __always_inline void rcu_task_trace_exit(void)
> > 
> > But that eventually doesn't, because it's not about not wathing anymore from
> > an RCU-TASKS-TRACE perspective. It's actually about adding more heavyweight
> > ordering to track down RCU-TASKS-TRACE read side while traditional RCU is not
> > watching. Sorry for understanding it that late.
> > 
> > Oh well. So a more accurate name here would be rcu_task_trace_heavyweight_enter().
> > 
> > >  {
> > >  #ifdef CONFIG_TASKS_TRACE_RCU
> > >  	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
> > > @@ -63,8 +63,8 @@ static __always_inline void rcu_dynticks_task_trace_enter(void)
> > >  #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
> > >  }
> > >  
> > > -/* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
> > > -static __always_inline void rcu_dynticks_task_trace_exit(void)
> > > +/* Turn off heavyweight RCU tasks trace readers on kernel entry. */
> > > +static __always_inline void rcu_task_trace_enter(void)
> > 
> > And rcu_task_trace_heavyweight_exit().
> > 
> 
> I have updated it here [1]. Please let me know if something looks
> incorrect.
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24a&id=cfc22b9f1572b137dd9f36da831dd7b69c9fe352

Looks good!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
