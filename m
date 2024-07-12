Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AFE8F58;
	Fri, 12 Jul 2024 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803924; cv=none; b=CmYS+U6DIUCePl0QdFkgC/SEi7Pym6KoNW0kqEZfpHzV/bSUjHiRZLZbUS56wRqlupJZO4n6lTLh7/vqghTmjhn7pfUlTGYrp9/y4nbpXKoH5J6rNrsxCKm9oRLSMHZjYzS6NMrzlP2eeVqS5COkI/eOedcZj837bIX934TwgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803924; c=relaxed/simple;
	bh=5QlXJxFLPsesDNENDb7wZhaFQLaV3GbL3uoNOGTcBMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWAigaOkrsFsUc5O5roLVd0PLnap8sXuTOeX6UegX5EahPyOHJbGChs3K43EADYKTOAr6KVpCEOT6HESocFMi9d9226tt1dIQdi/V8x2U1hZ9RJKYCrnvnWiyoSLWLireMCp9/csliU2gwMeR9xYqPg/PtQlvZGCKrkKwRi5HmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q683qsR9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q683qsR9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h3LUQh8q3xg5DWwMocTQ1bJgxWbWfsKZWLVjL9D19dY=; b=q683qsR9b0i7YeE9ORCNDN0CyQ
	gzUbis3W0pCWQ28P9XZ/Pir3ZRiQzGUOK1h+A4H8/aq0FegFjWdA8khGeI+5g6LFbFlnMLvF6r9op
	nJHBtw70Vd1o33HrmrQilRqsICf4ifCflevSItmBPJN2Z5BsuGZXe1l2bQfL3/V1fE0PfUvXPALRe
	tUdBr7XqdC38zYwXhujbX5XuveTOp28Ig5y4EHsoGQ5+y/EZUMTLVVu9Fnkl73Ry8YejS62HFfEmH
	fURrKsWWrDvc99SLvxv03qYuA129kRwwis4AFkRqnXLZxPIbrhyW43kNMwsGqO103O1vGrQc7rcLR
	SxdhHdRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSJhi-00000001Kks-17Th;
	Fri, 12 Jul 2024 17:05:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A309530050D; Fri, 12 Jul 2024 19:05:05 +0200 (CEST)
Date: Fri, 12 Jul 2024 19:05:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Phil Auld <pauld@redhat.com>, Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return to
 userspace
Message-ID: <20240712170505.GU27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-11-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 03:00:04PM +0200, Valentin Schneider wrote:
> +static inline void task_throttle_cancel_work(struct task_struct *p, int dst_cpu)
> +{
> +       /*
> +	* The calling context may be holding p->pi_lock, which is also acquired
> +	* by task_work_cancel_match().
> +	*
> +	* Lock recursion is prevented by punting the work cancellation to the
> +	* next IRQ enable. This is sent to the destination CPU rather than
> +	* >this< CPU to prevent the task from resuming execution and getting
> +	* throttled in its return to userspace.
> +	*/


u're having white space trouble there.. :-)

> +       irq_work_queue_on(&p->unthrottle_irq_work, dst_cpu);
> +}
