Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F58821;
	Fri, 12 Jul 2024 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797365; cv=none; b=p+7HKlBlyEi5ry6X83jgAMotfeaX2CzbNJH1InmFY0PLX3JBKXHhmfkpSdsKLWyoQ1BwEzQec+OYKBudWoQ1+ZkA/fu3XhNwG3tv6je+pePDLdF78S+RD88xSudg3IMwg0xui+B7CWRJBI6NJJIcZGiBILvgKabNoMppFw3Gt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797365; c=relaxed/simple;
	bh=3Uyra+I9gWVUZYDdJEtl/V22Ithv/zIGafIIIUAr6hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIDYFKmzpZUy6j1ODiAIO7d3NIFTcOTHKfQWm5To4pTm/qVmnU8buGtt++7FHrqWZF9UajiJnsNKhONS6Uvt4nD4P2bZ8MdmVs8D1kecyClmziXYxudgoqZFxoG1S3bnn6cMTfY3pDL2+ichZRKghiTLXbPJ3TNFJSsXIIN52RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LBIQXUS/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LBIQXUS/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N7v6IM1e3THcsoa2stJs8cQaeqgO74WfVYjt6lw/o48=; b=LBIQXUS/5IqKEWICRHIe/zpbTn
	zJewW8BCB3O4JT40rtI/KJ9IA0KIfT77u1kzk1GUoB9XQ0Q+Pvn1+pP1+hB04AUSr7p1ORhtWTqLU
	znDFJ2UPJxfx9kEWh9HGSopz0t+F2v8mZ/J8PKRTBKcfp2O9T4AyIJcXBLssPWQ8pIq8+6aJ58/lC
	6ldh3ylzYqmnJiqb7C5ck/Yl9vhwRwtLxoSGTOFMZu2lWTaijNHNMYB4BS3b6ho2VSsesNXtDm7Q7
	DFX/AxWu9BwvZytvp8DG+2QXgi8UOqcXDnplJ/qXyvSx/gxYIzT3maV6PIYTF6/ZqG4rYJUtKeOMo
	D7cBMOeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHzw-0000000CbNA-014h;
	Fri, 12 Jul 2024 15:15:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A29E630050D; Fri, 12 Jul 2024 17:15:47 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:15:47 +0200
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
Subject: Re: [RFC PATCH v3 01/10] rcuwait: Split type definition to its own
 header
Message-ID: <20240712151547.GP27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-2-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711130004.2157737-2-vschneid@redhat.com>

On Thu, Jul 11, 2024 at 02:59:55PM +0200, Valentin Schneider wrote:
> A later commit will add a struct irq_work member to struct task_struct, which
> would require <linux/sched.h> to include the definition of struct
> irq_work.
> 
> Thanks to header dependency hell, incudling <linux/irq_work.h> in <linux/sched.h>
> results in defining inline helpers using not-yet-defined fields (mm_struct,
> task_struct, various task states...).
> 
> Break off the definition of struct rcuwait into its own header file.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  include/linux/rcuwait.h       |  9 ++-------
>  include/linux/rcuwait_types.h | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/rcuwait_types.h
> 
> diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
> index 27343424225cf..1f1ca7d38cdf8 100644
> --- a/include/linux/rcuwait.h
> +++ b/include/linux/rcuwait.h
> @@ -5,17 +5,12 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched/signal.h>
>  
> +#include <linux/rcuwait_types.h>
> +
>  /*
>   * rcuwait provides a way of blocking and waking up a single
>   * task in an rcu-safe manner.
> - *
> - * The only time @task is non-nil is when a user is blocked (or
> - * checking if it needs to) on a condition, and reset as soon as we
> - * know that the condition has succeeded and are awoken.
>   */
> -struct rcuwait {
> -	struct task_struct __rcu *task;
> -};
>  
>  #define __RCUWAIT_INITIALIZER(name)		\
>  	{ .task = NULL, }
> diff --git a/include/linux/rcuwait_types.h b/include/linux/rcuwait_types.h
> new file mode 100644
> index 0000000000000..60a4385a2c368
> --- /dev/null
> +++ b/include/linux/rcuwait_types.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RCUWAIT_TYPES_H_
> +#define _LINUX_RCUWAIT_TYPES_H_
> +
> +#include <linux/sched.h>
> +
> +/*
> + * The only time @task is non-nil is when a user is blocked (or
> + * checking if it needs to) on a condition, and reset as soon as we
> + * know that the condition has succeeded and are awoken.
> + */
> +struct rcuwait {
> +	struct task_struct __rcu *task;
> +};
> +
> +#endif

Can't we simplu stick this in include/linux/types.h ?
