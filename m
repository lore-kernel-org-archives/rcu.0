Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D83C6A27;
	Wed, 25 Mar 2026 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447419; cv=none; b=uvuPoL5BYss1pO68UCnK/RUce2tPvHoBUloDCVP33q5P3wQ+Bn3KAVfQ66DnK/G+v8/h6BVIbmUOhqopCOvLK+zl1Wp2g8z+f1tBVL8kI+BxJSO05eIxDpHYgPWWSGJjGsoQMH87GoYNAokE/BQB0R4MEVUI5KQpTh9ATvDWTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447419; c=relaxed/simple;
	bh=FfECRdqKKfkI90jOz0VzVrGAYuaJ/JAd337oHiRkMlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjBSfHFl3tnlK+5FKJYywDZRW0x/HxEVxq7dih7vYInEWg9vGPX+P9uG00fWBZCQJzGFqtlgcskaq+IP3xffDN/F0variB+Q3scJBEXznx5xh8QfDflKSKtrlsYh2xPr/WUAbXt/iYjyh4JFxvHJQJ9muQLJugZMaJ9aHxgBDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ktgIYLtY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ktgIYLtY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N7t76lq+4DYdf4zt4uMNUzUlaUKfu3wh5rJDihRxgOs=; b=ktgIYLtYWVkXoXspxfWbJV4wRe
	w1LMcNyCticYILZiWuJQ9mr+llxlxHngNu9/EEoOH/LXlYsZRKCUmkJyLjRqRXtmEE532TZh5hy6P
	5lilkJG8QTR0exsg5AwyoSBmSOT6gM+TJw6+7jYJHCIiSeFQfNz5asWHYB908Ev4EwHYI8DV5/dLf
	vWAq70aQdw6clbvzx55rTMLoVu3sqdqofRuOZYlESwojZL7I6grKeClz53M48ll3V7Upf1TTfAOYx
	42MSx6EUo0CY5aglNAUDqUqVedvo+7SXq8dgM7QUbOggEZVLp0hxw4RHyhyPHAVTsek5YOkbLMO3N
	YhVVy9ow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OpR-00000006Ijg-1rCM;
	Wed, 25 Mar 2026 14:03:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EE5FB300400; Wed, 25 Mar 2026 15:03:24 +0100 (CET)
Date: Wed, 25 Mar 2026 15:03:24 +0100
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
Subject: Re: [PATCH 07/15] watchdog: Allow runtime toggle of lockup detector
 affinity
Message-ID: <20260325140324.GD3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-7-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-7-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:38PM +0800, Qiliang Yuan wrote:
> The hardlockup detector threads are affined to CPUs based on the
> HK_TYPE_TIMER housekeeping mask at boot. If this mask is updated at
> runtime, these threads remain on their original CPUs, potentially
> running on isolated cores.
> 
> Synchronize watchdog thread affinity with HK_TYPE_TIMER updates.

Doesn't the normal watchdog run off of perf, using NMIs? How is that
TIMER?

And again, why do you think you need more than _ONE_ mask?

In the end, NOHZ_FULL needs all the masks to be the same anyway. There
is absolutely no sane reason to have this much configuration space.
