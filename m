Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3B524C074;
	Tue,  4 Mar 2025 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116036; cv=none; b=Tdz/qHsaSw/yhGCSogL29FMstkGto4Usd3Bih+UKZpOwMVsAZEORUEA42MNnG4+tDCoX15NQl5/TfNV+5L4aqPgZGc8w8EuTX7mvwEBsNXpHheX9lAGhXQGJFfradlaDP/1gigWloCK0kpxwK0q5Dl9wXJ1zoAUR2jpnH6NdV7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116036; c=relaxed/simple;
	bh=RG8802wCdCboJkQuLk9it4WgecYm0iYOq8Tyfe3o3EA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3fFRDu7gLKUzHOuUFkP88mvcSAA/064TCTAUxq0fn0ecQPqZDRZjrpiX97RtLeeCupsoSz96h+R1+i6qe/kMUA6Ff9Tzdg5quYTQdC6czWL3b639AoxC9BcqHsFQbyxpTCpK9+i5mIujlU7g91NoKiSmphKN0zjFNUw4YNp8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05863C4CEE5;
	Tue,  4 Mar 2025 19:20:32 +0000 (UTC)
Date: Tue, 4 Mar 2025 14:21:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev, Ankur
 Arora <ankur.a.arora@oracle.com>
Subject: Re: [PATCH rcu 06/11] osnoise: provide quiescent states
Message-ID: <20250304142127.391ca6bd@gandalf.local.home>
In-Reply-To: <20250225035516.26443-7-boqun.feng@gmail.com>
References: <20250225035516.26443-1-boqun.feng@gmail.com>
	<20250225035516.26443-7-boqun.feng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 19:55:11 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> From: Ankur Arora <ankur.a.arora@oracle.com>
> 
> To reduce RCU noise for nohz_full configurations, osnoise depends
> on cond_resched() providing quiescent states for PREEMPT_RCU=n
> configurations. For PREEMPT_RCU=y configurations -- where
> cond_resched() is a stub -- we do this by directly calling
> rcu_momentary_eqs().
> 
> With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
> configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
> of the above can help.
> 
> Handle that by providing an explicit quiescent state here for all
> configurations.
> 
> As mentioned above this is not needed for non-stubbed cond_resched(),
> but, providing a quiescent state here just pulls in one that a future
> cond_resched() would provide, so doesn't cause any extra work for
> this configuration.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
