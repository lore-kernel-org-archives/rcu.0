Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BC440C;
	Fri, 12 Jul 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797462; cv=none; b=eSlzFwGNHripWmOxbdKQhKGGOcm4L7WbLjLzAiM5HXB4TUvj6lySjlDdzx33C92Vu2K5F4qtyCznkqojdcUetRDPuKzc10b+/iOfUWCfNikpSY94Bj79numhJw/MCgESgzEX2w5LpufJ0RF0z8BG9rfPaviSsKLEcr35eAEUHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797462; c=relaxed/simple;
	bh=mnhCRqO2PZx6WI2111F6Qo7KzuZY9QNIjNpFSIP3YRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khZPtUpZQhZ+u9dZoWw4CKZnmw6Bj1NAVCWAKRkpv2aw8fcvUAVaZDBYgK6Yxfvbv/XFm9DTYWKw/c1+NINRZbgFXtgbcBaBcFnkZHPTNRAUvQTIhdf7z312u2Bww51Hf8nbq7wGraxL2vTCryXxZtBRnftDQf97bXdVSJtABqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T6cmDhn5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6cmDhn5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KgAgHjkNVVrh+oOOmdhTy+ri84P0GulqGbUwPI3o38A=; b=T6cmDhn5T5pbn5Zdf/mstAjnmF
	CSIAZW7+RPwR1MDsZbEe1KPdJUT3LavA1pcv/gGIf7ECZI5F84vOjm3fv0g9XoO8ikRP58fuPFvF4
	McYqgOzGqlbslM7LSVltgYI83EF/A42BSmNz9nbVOWXjUUpsx1PQvhvXv9Hi1y/7Apk2YzCy8wLSB
	QSVunGnsHvUjTbDML3Q4BF859lJmlE9w1pM99ZD0UINfq5bUZGbiVKge2/R1IiZNSo8JStGa91D7L
	z4A9peWH+71vLrKp2X0v5NfhpF0JSZi5q3ZqD9kMTWIZy0r8w6onTNshVX05YbpBT8c3vibZ6KJLR
	CvVJzIWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSI1c-0000000CbSH-3VHD;
	Fri, 12 Jul 2024 15:17:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F97630050D; Fri, 12 Jul 2024 17:17:32 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:17:32 +0200
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
Subject: Re: [RFC PATCH v3 02/10] irq_work: Split type definition to its own
 header
Message-ID: <20240712151732.GQ27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-3-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-3-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 02:59:56PM +0200, Valentin Schneider wrote:
> A later commit will add a struct irq_work member to struct task_struct, which
> would require <linux/sched.h> to include the definition of struct
> irq_work.
> 
> Thanks to header dependency hell, incudling <linux/irq_work.h> in <linux/sched.h>
> results in defining inline helpers using not-yet-defined fields (mm_struct,
> task_struct, various task states...).
> 
> Break off the definition of struct irq_work into its own header file.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/linux/irq_work.h       |  8 ++------
>  include/linux/irq_work_types.h | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/irq_work_types.h
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 136f2980cba30..7f6d2af360d91 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -5,6 +5,8 @@
>  #include <linux/smp_types.h>
>  #include <linux/rcuwait.h>
>  
> +#include <linux/irq_work_types.h>
> +
>  /*
>   * An entry can be in one of four states:
>   *
> @@ -14,12 +16,6 @@
>   * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
>   */
>  
> -struct irq_work {
> -	struct __call_single_node node;
> -	void (*func)(struct irq_work *);
> -	struct rcuwait irqwait;
> -};
> -
>  #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
>  	.node = { .u_flags = (_flags), },			\
>  	.func = (_func),					\
> diff --git a/include/linux/irq_work_types.h b/include/linux/irq_work_types.h
> new file mode 100644
> index 0000000000000..108cbc514733b
> --- /dev/null
> +++ b/include/linux/irq_work_types.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_IRQ_WORK_TYPES_H
> +#define _LINUX_IRQ_WORK_TYPES_H
> +
> +#include <linux/smp_types.h>
> +#include <linux/rcuwait_types.h>
> +
> +struct irq_work {
> +	struct __call_single_node node;
> +	void (*func)(struct irq_work *);
> +	struct rcuwait irqwait;
> +};
> +
> +#endif

Since smp_types.h already mentions IRQ_WORK, given how I tangled the
whole things together, should we just put this struct there as well?
