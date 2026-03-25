Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412623F417;
	Wed, 25 Mar 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447053; cv=none; b=i4WVYOat6zr9G02ElbJJMw5I8IuMhLkXB+x7+9QzeN1Kz8zHnD8Rikw3UEHbsQ5CU+8yHT7GO7cY+PeSuh3IGhlkR3FBO4jKWNujcJmPJ+EgyASTzALYxIEEkS6CqeFGd/0estH3eBLxosp96QFFtsUt5sfBlhKKraKyV0Kj74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447053; c=relaxed/simple;
	bh=nR03rCeox1WQFtX6asW+4qXpDXlOlPtyI2H1ODatRBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaomiAvZo/EmaiiKZd5uQpFhYwL//+FvLWDCyv3rpJ8D0QnTPHa6ARaDvEuRv3BMRu9pvC0h3hem/CqrstktDUP26w/d63D4UoYhI9WKKxMS8+hBJ6SbFXiF/5d8t7yOA/+2NbA+zB7coDqBi5+FEyA9bQFs05RaigT8hDv9Nd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ttN72k3q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttN72k3q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nR03rCeox1WQFtX6asW+4qXpDXlOlPtyI2H1ODatRBY=; b=ttN72k3qRbVy4+xfcMzcCjipIX
	D9UzcHQATgEfHQlr458QEL8AmHNte0GpKytEfgo1wCHBvOKh9X7qAuJmMqFMJQmKARPqhK5klduzN
	njHOfo0MPaY+z3NcMKZ2nnboAfhVqp8bp38+4WEt162/Qj0RCEY0ilrhfXuWGI2tVRrFAvPZrEOsX
	iFLnAAKxS0NiDuf2DPFVmDfRn3XaEigwQL7o6wLGRg8F33uTm9gjexIIsqNyGNyMFYuowxXSPAWKl
	oOkf+xgtIz4rBMJyCpkkt/Mvhl2KJEAQgXojum/LQhOmPl66A9vUko0LnwupD1Ahvjjhv/A+d+oTZ
	8qTBoRsQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5OjM-0000000Fwyc-3yuR;
	Wed, 25 Mar 2026 13:57:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86741300400; Wed, 25 Mar 2026 14:57:07 +0100 (CET)
Date: Wed, 25 Mar 2026 14:57:07 +0100
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
Subject: Re: [PATCH 01/15] sched/isolation: Support dynamic allocation for
 housekeeping masks
Message-ID: <20260325135707.GZ3738786@noisy.programming.kicks-ass.net>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-1-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-dhei-v12-final-v1-1-919cca23cadf@gmail.com>

On Wed, Mar 25, 2026 at 05:09:32PM +0800, Qiliang Yuan wrote:
> The existing housekeeping infrastructure uses a single static cpumask
> for all isolation types. This prevents independent runtime
> reconfiguration of different services (like RCU vs. timers).

I think I asked this a while ago; why do we have more than one mask?
What is the actual purpose of being able to separate RCU from Timers?
