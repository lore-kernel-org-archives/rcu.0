Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE6176AA1;
	Fri, 12 Jul 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804258; cv=none; b=WhDOuwysNgY52M6+l6gdzsboOzUVGnwlhG5pUDl7EZAsDpUnhUbJ5PmtngYTMGQ6S9DWdCjeiRvPUyrxVFFh0+TXdPE4hnh470E9j5XyCBtBDgKhEkM8gH8gb95F78V95MuYTs1Eul+xxcySITCXIy9UVgEscohXkU51ZiiaEIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804258; c=relaxed/simple;
	bh=YFYW7ohFwexZPRCFEIjsdZvv0rsAI9C0gJZmdR/i08c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6LgUrLrkhWQiLXQTAfdOtUbxvcJs9QSPSj4SuOt4glpUq4qs/+qr1AShGzizSQ8SwjTcRlBpL2X4VSXtzaUFvUoWUVUjfglVHy8riFs3EIi+vUF7PI+mE8Ms/PvuQksZbTRAca8hVEpEkINVKOe9e2DwHMb1CSfXoqsJp41aIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C+nq+HEm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+nq+HEm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Mxbf8FLitTOfjwNEoKYOmBRT92nDTE315anxQnCaks=; b=C+nq+HEmmQT4iTtlElJ7vJyFnE
	upbha1rtgSC1dpxmKlpsVsCV1QBvxXbVtq0//zEkErDif30cMAMpo1g6mrc54gir+eSDMj7rnAU/5
	Y2GwKKT+qkFxW8JFyS6u9jIEYIU8YM7SWnJ6WqRR6sGa5wBiTWxIL0Qf8W2Jgs26Tse3zIPuYcZ1U
	YskYcLpz98Ic1Gh5eH5tJwjYSEiDSt21SeZk6g1mh15Hg3nanjKoidC68RPyXV+U1bJ3FsRAnTQWD
	SwpaOHLuZDyIWDzpYVMsTlGpfyr5UFJWtH3ppsf1n7VW8jtDwd316IGQ8OlyfDZanUkbsVBY9jvpi
	A+avs9Yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSJnD-00000001Ko4-0qFy;
	Fri, 12 Jul 2024 17:10:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D051530050D; Fri, 12 Jul 2024 19:10:46 +0200 (CEST)
Date: Fri, 12 Jul 2024 19:10:46 +0200
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
Message-ID: <20240712171046.GV27299@noisy.programming.kicks-ass.net>
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
> +static void task_throttle_cancel_irq_work_fn(struct irq_work *work)
> +{
> +	struct task_struct *p = container_of(work, struct task_struct, unthrottle_irq_work);
> +	int cpu = raw_smp_processor_id();
> +
> +	CLASS(task_rq_lock, rq_guard)(p);

	guard(task_rq_lock)(p);

> +	WARN_ON_ONCE(task_cpu(p) != cpu);
> +
> +	if (task_has_throttle_work(p) && !task_needs_throttling(p))
> +		task_throttle_do_cancel_work(p);
> +}
