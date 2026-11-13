Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585654;
	b=lcwdbm7NQ6HIntQbG10pJFOAHstN67n3vgispDgM/jzXDE8QS7yRCPQ8crTuK4KukJVx
	 tmsGfmKBGW3g9lSGUalUrROy4yNWYp/C5zmt6WeH652xQ+KuDgcjPZbK5ch2xswbRFaiz
	 bXC7eaGd93GOVvR2gIC6TyTGAGBXsktJGqYxZhMJjs/N0gEsf7qT3fj17qyjWG94sW+wq
	 5RgRgRFyVExbN6BG2hhAy5vwCdt7dxnesC7pmOY89+UWbx0nADp92j/3og/kBdnwvcSeY
	 qrj2tbovSWdftvbcjsQ3GVgbbiexS5kGfbxSeRUqum3HEK2UC+3Sp15drJtGjeY4aTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585654;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Z5AMrLdhYu3o8bnJFe21h2a0/PArI+9FQIHEaU4uGWU=;
	b=CRBy6wJpQoQIvJPfRZfQrGyvar7nDDT2lpAH5fWF/6jsUTQXQeyPIYKf7qju2+rm3zlM
	 EBjMbnihL7dm8wgRxXpuc+gO3Zq3YozPSy8KdNykY5koLvJxURKYtuv7aL3iII8RP3j0j
	 F4RBW3Qy4KVrdUs0OHIviB3VYOy7YbntRuqIFP9eH2yt1o1zqurxnCjTD4Qy/oidWwM4d
	 hW29jPdqfqs6xGsc8jus5CWSRQzZ76nm6mi/TDu73xZdqOH3acvHHTrQJjZMSV2bohmtW
	 Jdqg5SN521rtCmKA9wAhS5NdmECVb9UHZrcZk4cln/CTyoIr7MTkktonXp523G/6V1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fhiuQWbC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JNCt0olN;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC0606B2DB;
	Fri, 13 Nov 2026 16:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EC0606B2DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fhiuQWbC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=JNCt0olN
Date: Fri, 13 Nov 2026 17:00:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794585652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5AMrLdhYu3o8bnJFe21h2a0/PArI+9FQIHEaU4uGWU=;
	b=fhiuQWbCw4/pClsneYKaGXY3aCwZeytN6pdPfON1YTSjiy0OykSfat3X3DyNgfJHwUiBFE
	nDifJhtj89l6852IyTwgawjRa/3U4onEzT+2H0tkkx8ymElDvYbunnOc+/Sdq64qQjQkMF
	UVGKbltAClEUqWJ2AIAR8tuy+E8NtBMYH4JrwP8sA7QX4X+pwhMRLV0qI8dbMyHbSpBzYI
	Cs4ww+o8oKdsGBSkJ3LJ27mgKYRDUy6FTpyjhcBK6nZcoffJ8dEgyZNd6hWAXiDk50ZROm
	pyzakZmqYAKrNJtHpJruC6MMWSOdKkSWP8zcQfGlyxU/WhvVvyTVyvxWLzn2hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794585652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5AMrLdhYu3o8bnJFe21h2a0/PArI+9FQIHEaU4uGWU=;
	b=JNCt0olNNpqWWQ+xRy7AQ0dFqkYUEK/wrmMePeA6oxeeZIB5KgT1LHFd0UuY/IfaLUyNu/
	ghPKDYudMmPfTqAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] rcutorture: Remove unused check_boost_failed hook
Message-ID: <20261113160050.qzln3dcd@linutronix.de>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
 <20261111213826.2035045-4-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111213826.2035045-4-joelagnelf@nvidia.com>

On 2026-11-11 16:38:21 [-0500], Joel Fernandes wrote:
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -43,6 +43,7 @@
>  #include <linux/torture.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched/debug.h>
> +#include <linux/sched/sysctl.h>
>  #include <linux/oom.h>
>  #include <linux/tick.h>
>  #include <linux/rcupdate_trace.h>

This looks like folding and rebase went wrong.

> @@ -425,7 +426,6 @@ struct rcu_torture_ops {
>  	void (*fqs)(void);
>  	void (*stats)(void);
>  	void (*gp_kthread_dbg)(void);
> -	bool (*check_boost_failed)(unsigned long gp_state, int *cpup);
>  	int (*stall_dur)(void);
>  	void (*get_gp_data)(int *flags, unsigned long *gp_seq);
>  	void (*gp_slow_register)(atomic_t *rgssp);
> @@ -637,7 +637,6 @@ static struct rcu_torture_ops rcu_ops = {
>  	.cb_barrier		= rcu_barrier,
>  	.fqs			= rcu_force_quiescent_state,
>  	.gp_kthread_dbg		= show_rcu_gp_kthreads,
> -	.check_boost_failed	= rcu_check_boost_fail,
>  	.stall_dur		= rcu_jiffies_till_stall_check,
>  	.get_gp_data		= rcutorture_get_gp_data,
>  	.gp_slow_register	= rcu_gp_slow_register,

if I grep for rcu_check_boost_fail at this point I see the function, its
declaration but no users. That means it could be removed, too.

Sebastian
