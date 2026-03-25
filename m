Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D53DB642;
	Wed, 25 Mar 2026 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447155; cv=none; b=uS7pTXa5R/bYGE18kCZDX903XJwspwYrsF6BdGZxupJ+C+vbsAN9M41d5qLu+b6Drq/g6oFEOJKe32exWntUCIpGs23L9GDxCWgnzpYbb4J3SLGRxfFwBYlv/UXtwzDKSFlvxIguTBHkyn2TeIY0KT+bz07SEzNbAcvXTTKqEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447155; c=relaxed/simple;
	bh=7NBQ3YLCBPyJE40/oQ9j54Gn5eWG8H+3KsH21fG1Qz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjPbfIOIZNqZGS53fgB2Abf5LSxPVy7xRwEiAGjZsFpHxPx4xFGFC7/nh5BaU/bPZbwhPzgltZuHm8ihut6mcfPlVUXfu8w8ajcJ1KGbqMWmyQ91ZWmAAbrgnIPMb9lb/fkhFFq4bT1AAPnnSS3BGYigTzmRf1jbMa9hEcBl1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ux8oIrbz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ux8oIrbz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c2s+G5suXmI9oLXQ//HZ2D1vtF3Umo6K3pnwzbiOYHI=; b=Ux8oIrbzAFZvHaWUOdHG7SKeNa
	bLJRymJg5lIv33LglJg/4K5iVMBZWxJj63x5mjT/d9LcwROFeuw1U7vhxnpmW48sFnUJVZqNlebde
	m9CCdHTKOv1IRWsGDkVhxLGN9+W+Tesas6ihcFWg0wvECmSPu7TsniaiDUXxCBAjmq9T9wAd5h4nP
	vJfaOd0iHc2ZJd8nVSnopiHpGMTpGnrM6257/kp+Y1Kbd5cMNkz6N25u88M9clIcBTLc4kq3vL4gB
	y4lIImLt72V8GA+MD1rxgxxk+qRfiv3ABFaK2t15+SjnO3uY/LIF877ftltBdZlY+Pp6ckke5CnOU
	Z8lNYeTQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OlE-00000006I3e-3ZDt;
	Wed, 25 Mar 2026 13:59:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 716D8300400; Wed, 25 Mar 2026 14:59:04 +0100 (CET)
Date: Wed, 25 Mar 2026 14:59:04 +0100
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
Subject: Re: [PATCH 03/15] sched/isolation: Separate housekeeping types in
 enum hk_type
Message-ID: <20260325135904.GB3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-3-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-3-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:34PM +0800, Qiliang Yuan wrote:
> Most kernel noise types (TICK, TIMER, RCU, etc.) are currently
> aliased to a single HK_TYPE_KERNEL_NOISE enum value. This prevents
> fine-grained runtime isolation control as all masks are forced to be
> identical.
> 
> Un-alias service-specific housekeeping types in enum hk_type.
> 
> This separation provides the necessary granularity for DHEI subsystems
> to subscribe to and maintain independent affinity masks.

What the hell for?
