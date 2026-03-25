Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAE3CCFDD;
	Wed, 25 Mar 2026 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447268; cv=none; b=hVO91OXGECVw0ELIm9AUEGc3+VqmJhg0S9dfRIt4gfMDryC1uhprA7+2UM+SvKaeLBHLhl9DrNjpeSb+SrSYYY3EcpjBptrkmkk8eJCn3HZQav2JWYKFGodupmq+gb9l/8upZcfiCvqplPvmE7wiGSoZcs61EMpJGYWGzDJD9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447268; c=relaxed/simple;
	bh=NF/Fzmt3riyXynsc3GneO0T3XfJ1kmXmj8mDb9HEBzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmASbbxAPT5Q7vzSrpj3KkLj8AZN+ZA0qi2NXF5Exx5z9bbAd0pjRQDah3Gz/ogubPrXQSb473aICoKE2bF0/t7kJUk+jEJu19zyqSbez2ioRde5e6yTXclqMmp2YS/ogQBbLb939JsTYJu0oNkPgT2GDwx2WqjnTAkMG01YCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uVreSsST; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uVreSsST"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NF/Fzmt3riyXynsc3GneO0T3XfJ1kmXmj8mDb9HEBzU=; b=uVreSsSTreEtJDOHcz9Zf36/0N
	Xeix1I/f118jkE4t4TN5lnwgOh1w9sp4ljJaeMD5e28uwk+8vGXr434dzkoUleWhb6NYyd1s9+I3u
	dYcpBveNuxRndLYDiv0TgPF/BN89+D6D5s/9W47W5zmalTuUWQS5bb8ypgExMqTy6Z+c0VVeZ0eUF
	BaFltWHK13Z/Iq+EDHsw+XkxOZ0PgqVbBbesavc1BajFsY19yoZx98GdcSvvCT8FCYe7bDOTAJZWl
	yVLWStNjSSBNhC/OQfoP/wLOg0SHShYs6EJyoKeAIhnvijTJFmTgdo7ODwoc61YDZIb2ksi8/Qph8
	TOy8dDJQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5On0-0000000FxLE-03fj;
	Wed, 25 Mar 2026 14:00:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2AE03300400; Wed, 25 Mar 2026 15:00:53 +0100 (CET)
Date: Wed, 25 Mar 2026 15:00:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 06/15] sched/core: Dynamically update scheduler domain
 housekeeping mask
Message-ID: <20260325140053.GC3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-6-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-6-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:37PM +0800, Qiliang Yuan wrote:
> Scheduler domains rely on HK_TYPE_DOMAIN to identify which CPUs are
> isolated from general load balancing. Currently, these boundaries are
> static and determined only during boot-time domain initialization.

This statement is factually incorrect. You can dynamically create
partitions with both cpuset-v1 and cpuset-v2.
