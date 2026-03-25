Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832523D291;
	Wed, 25 Mar 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447487; cv=none; b=AYQ6nkKqAxP3zTm2BnLjuZhbDIMbkK/FdkaCwUSCiV27j5sfHcrWyOsO3m1F6gOQzh1F6xRkDgcnnKbONpX3C0ViJumz9VJZz0nfYzXamYHwvQR3JeVk4STwCaUt2oUM6EyJxdU8DJ7PoRYxXPHjjpRORoOQYtXBQ6USxrQi8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447487; c=relaxed/simple;
	bh=CyJeWKlFbrvnCxOxC0EcurYVg8nDOcPCp3k/A89VUpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAn1c0mQfLxwgQ0PHVLnIsXyCE1XrqVrXcMqfR+L1bTv66k4mp1DKupdCezF6qUEx6gL0QMfGXlA27UcAJIZMVqVO4JrMNTEUSiLoKS2+Hz1DJHN6LThmmNpCCPqhST5Dn5bKoWgpci5SYejoeNMXaiZaf9rOO4lI9Aj2LUBpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cYYVo4mP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYYVo4mP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C4hYkSjHXLlG/lE5YtgFwfQzyiouzhk/stE8uZzNUns=; b=cYYVo4mP2OcLhkLMLgnRlVDiEF
	9AvuTzF5T7Kvd1ShLQUTaSmF+gfsg/5R3+oiXFfJEdEcmB5USWlZa2IwOzaOEqZ1EcxES4esSOJkE
	IiH41k0iX+TIHwPfwscNPXmDtsMWsHF4wkJAhRSuXqpUm1fDr7MHi50UvuMFxjbmDrhuBRgD6b/ZM
	xI6esliOzQmKU5ZwPIGeDpmE2k8jJieIPJ3BQzZTiI32O7JEeLmbGcMc+1oO2szXXZyzPZ6eZufXt
	xkBcRkO+6V7j6qqpejq1FEMh/TSemHA268NiOOrSZpd5+jZzzyvboZMbbnQ9AvGlaPHMupsB0wDM0
	yunp/kXA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OqX-0000000FxZh-16yX;
	Wed, 25 Mar 2026 14:04:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D298D300578; Wed, 25 Mar 2026 15:04:32 +0100 (CET)
Date: Wed, 25 Mar 2026 15:04:32 +0100
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
Subject: Re: [PATCH 13/15] sched/isolation: Implement sysfs interface for
 dynamic housekeeping
Message-ID: <20260325140432.GE3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-13-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-13-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:44PM +0800, Qiliang Yuan wrote:
> Subsystem housekeeping masks are currently static and can only be set
> via boot-time parameters (isolcpus, nohz_full, etc.). There is no
> userspace interface to reconfigure these boundaries at runtime.
> 
> Implement the DHEI sysfs interface under /sys/kernel/housekeeping.
> 

Why? What was wrong with cpusets?
