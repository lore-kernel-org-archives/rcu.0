Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AE58F097;
	Wed,  9 Sep 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963972; cv=none; b=jnpGpQEO939rg3taDTC57t3PRDdaWceoqFAqJqWTgesEgvYN55vIHga6tja0E+A+ytf5YNNR4IFnGAPPdcWp+fC5zWcizJgFHZ+vBwcQ14/xB0JDTQAe23oJZuZyvPkeXG5x3AMuyqdGDlDwzuKIFuZZQbrnNMG2ePAkk+8Xj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963972; c=relaxed/simple;
	bh=OEF2nL1MB3cGdIs7kfsCD4xcMPxbuefmxRARW5/zukk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qnw/rbyPFoI4C8LyGGwGZdx4cYxzV+vRz5tTtU87U7J6htGQ+8ev44hIQiw2Sn1qeYnJCQzhT5kBc74k3N3E41Lv97Me7b9SSW3K8NMb6ATOuKJjuAx588pdQnj+FxAkNPEYXO8xseJ0OjcYl++PBb5HChnzvz6aKojqmTgFTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dThimuQy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dThimuQy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D121A1F00A3D;
	Wed,  9 Sep 2026 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963971;
	bh=yxp56WrwXULUr8wGNB8WwITIC6sJ1IaZ6YhzXAjDymc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dThimuQyt/6ONTbtjVXNQCeU9T/1EWerh8NtJtv3HGLe0YrAGW7EQWb4US9HB7Dlc
	 +yyvk4R4jvoXuYToJwGyj5TddxYDECi6MO1yUMMcfHYu3KAukrQnWorMHoHXgTNWTk
	 OvC1iSyO5sOqrk7S484LpdWnTx17zoZqXpBRz0v2K3AjIUlJpPou9jtbK6JJoaCN8y
	 EHzTWvEcg6EITpTGl84YpQqFnh8z3CTgwu75iJxLRCGbngR+m6QPNH6aykOsiM1KX+
	 LXZW36JYMOM3nF0xIClM7Waydh9irjfw4ATu82rX36kvzw564uOCP5tPZ3YpDi94mU
	 /dR3iOB21qjrg==
Date: Wed, 9 Sep 2026 15:26:09 +0100
From: Harry Yoo <harry@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Zqiang <qiang.zhang@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Fleming <mfleming@cloudflare.com>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 1/6] rcu: Make call_rcu() safe to call from any context
Message-ID: <aqFebI06nXUccuwt@thinkstation>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-2-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810122758.183765-2-puranjay@kernel.org>

On Mon, Aug 10, 2026 at 05:27:50AM -0700, Puranjay Mohan wrote:
> ---
>  kernel/rcu/Kconfig |   6 +++
>  kernel/rcu/rcu.h   |  11 ++++
>  kernel/rcu/tree.c  | 131 +++++++++++++++++++++++++++++++++++++++++----
>  kernel/rcu/tree.h  |   6 +++
>  4 files changed, 143 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index f15da8038d0ba..1a5fb3156c062 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -175,6 +175,12 @@ config RCU_STALL_COMMON
>  config RCU_NEED_SEGCBLIST
>  	def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
>  
> +# The deferral (and the IRQ_WORK it uses) is only needed where call_rcu() /
> +# call_srcu() can be invoked while a callback-list operation is in flight.
> +config RCU_DEFER
> +	def_bool HAVE_NMI || KPROBES || FUNCTION_TRACER || TRACEPOINTS
> +	select IRQ_WORK

nit: I don't think this config belongs to RCU.
Do we really need this when majority of kernels enable those?

>  config RCU_FANOUT
>  	int "Tree-based hierarchical RCU fanout value"
>  	range 2 64 if 64BIT
> @@ -3206,6 +3204,103 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>  	local_irq_restore(flags);
>  }
>  
> +/*
> + * Stage @head for this CPU's irq_work to re-issue once interrupts are on.  Only
> + * the drain side takes a lock, so this stays safe from NMI.
> + */
> +static void call_rcu_defer(struct rcu_head *head, rcu_callback_t func)
> +{
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +
> +	/*
> +	 * Instrumentation on the enqueue path can re-enter here from inside the
> +	 * drain.  Re-queuing would livelock it, so drop the callback; an NMI
> +	 * cannot loop, so let it through.
> +
> +	 */
> +	if (READ_ONCE(rdp->defer_draining) && !in_nmi()) {
> +		WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> +			  "call_rcu() re-entered during callback drain; leaking callback\n");
> +		return;
> +	}
> +	head->func = func;
> +	if (llist_add((struct llist_node *)head, &rdp->defer_head))
> +		irq_work_queue(&rdp->defer_work);

Should RCU wait for the IRQ work to be processed during e.g.)
rcu_barrier()?

-- 
Cheers,
Harry / Hyeonggon
