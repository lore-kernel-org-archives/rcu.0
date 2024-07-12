Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6742E171081;
	Fri, 12 Jul 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797730; cv=none; b=QsNWLI2dZcMJ9wyFFBORFo2y40BrK+DOpVY8aoY+XRayYvVyxQXxgjndf6Xw4epv1E+2BYi9xCzQKz/+cRGzPPX0RB0ppvoeCEbghQh30nqWR6ipApJERWL9q4UdhNWJnpf1AIByOPpOhnd8GGE3e8XkdQ17hjTIEW+hK2YYW1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797730; c=relaxed/simple;
	bh=XiOEZJ28eOlyytbhOe4JOFyKb03S1tYgFHORxGIUfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNHKtTkHZB0g5CK7B6TcEkglLPHztt23EJh+rmWrmtMTLyXCkOjmHpdjHfQ39iXpneKLgOmlpJWxruTTkfHMNgDKLeiiZmAKh04PxGSWHKia0YaN2S0ThEgpojRc+0jwyCDmHA51HYpL3i8Nj2DcUi66u2REjcgFGt0/1p3EeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nfN2htqN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nfN2htqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FChUnW6i8e75fIzuc2Rh39TKXxvbcMtOXFO1VzX1qSY=; b=nfN2htqNFzbVtI3KSYeF10/ziy
	yUS2EzgxpFTtNMmDwCEVavrk7XFSO9rsWQlLahs3heZ4WnClMDiPvwHuRIdzPApBEBKMT+L0byiZj
	VIeurSao5cEpUYB8HA43pUQ1dA35dX/eaL3uZH1PIj/b4D+JiDc1Nhb7T9guV4OD6Lx7dingYjUCh
	nc8FrWn4dxPUpE5fI5SLudsNdzmLnYZE0TYP+B3iBdl/FZlXNGrU5/4oSTCzbgBRnBrVKfrjkbSwX
	2q0Th8LbLrpjk7TKOjqnO5/nmILhoGspkAwLimAuoFTMLEDYSt0a5W+VFjAxF6nQ8hrY8/0rNgqUM
	L21zoJ+Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSI5v-0000000CbeN-024G;
	Fri, 12 Jul 2024 15:21:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E9DC30050D; Fri, 12 Jul 2024 17:21:58 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:21:58 +0200
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
Subject: Re: [RFC PATCH v3 04/10] sched/fair: Introduce sched_throttle_work
Message-ID: <20240712152158.GS27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-5-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-5-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 02:59:58PM +0200, Valentin Schneider wrote:

> +void init_cfs_throttle_work(struct task_struct *p)
> +{
> +	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
> +	p->sched_throttle_work.next = &p->sched_throttle_work;
> +	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);

Yes, init_task_work() does not write .next, but can we please flip these
two statements and avoid me having to double check that every time I
seem them? :-)

> +}
