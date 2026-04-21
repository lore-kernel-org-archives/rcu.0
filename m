Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4C3A6B9E
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811599; cv=none; b=u1x107x//n3vFlOIXt+Km2v4qxtmmKN4KH64c8+aUI9gJvBEb4HbGhVdQd8auTKqVby5tBBP/b/bv0meDXKkcmTq2pJjKTLQqkOxfaEyFuYlOAheqbG/h1SnVbNMITv75yHYhaX8MjAyYpAPn2Xd3Hro0ZqpEqJgdpxdhmCxTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811599; c=relaxed/simple;
	bh=WriNZugWoCF6Emcloe3Ql7xk32IV/3Dq5w3ojoSr8lM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pWe/Bk83VxeomymxHk2sp7uEBxG9adJiun3p8+sb/dXjbMWQRGeoFDAgh53Gg0zEU3FlQLGG/NxBe3bRFleHDwxH9XpKdo088IYMYzTR+yIzs7Zxdk14TrBni4+QtXV5GOHJRUbwHm/cdEuoNls22tfQa6dDOdQ3vltNMriCHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvplTH5H; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvplTH5H"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6948fb494a0so1135248eaf.2
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776811592; x=1777416392; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d5I8BPQjRssZ1l0ozTg/ouvrTUnVMAjILN1cW7pQjc=;
        b=mvplTH5HNJn8BI/GT3NdQQW1SsU2/3vWCBw+rYJST5aJbZ9ARBihrVfKdpXxo8pFaB
         ifX97fIj/JFPyCbElTnSAT5j1MQvxrLDmJkBfivljzwOmQPiAILWRXuHpXCHGVCOS9CJ
         0J7G2LM8ojCDmSXL6rWu/w2K4ErhXMZDDd5t+KvRK7ZObE5P6CN3/JE9a92X9GTNI0wJ
         X7ANRgwvyGRlqXgCJNZK5BWsxBoC6wh6JYl/KjhpZ+wlr8Bsz1VT3S7TOn8YYRT1BRii
         qXt9R4Z+CESdLCZaY938NIfUjUUij/HWmTQv9iwQLNlsLlcx01SAgHojBSD9mvv20p6N
         8kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811592; x=1777416392;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d5I8BPQjRssZ1l0ozTg/ouvrTUnVMAjILN1cW7pQjc=;
        b=Olm+g6BVM9SceskiGCkTI89SGq3XpJLiicTfGSm5eEjxJbH5WDQ+utoVTwMHVhnjVO
         RtQUaAktlRvC5PcpmeaEHUWbstjjnrMGRJlYc4pR6m00GHkf/5xCsAG76NfmVX16VM/e
         2tWlt0tXnwLrdeLZmRIZPLvG2ZdcMEqjue20o0ZRLL4sEjINlDlfS5DjUrUsbXglBhVv
         Wew+WvES1OilbXm5nGo/qPjponudAjJ7yYrggR4AjL9y/TEHJl9P6wXJBwdY07F9skZ2
         uUi6oHrt0/oPUDsdAtvhZ1A3dBYC6pNXARKiii90sjKfD8i7Fm8N59jwiMbdnCwG2L5a
         o6jg==
X-Forwarded-Encrypted: i=1; AFNElJ/ygZGuPRYyBNiebkMmlYvmWDS47ITqJtqjsgjs8WwuvHv+5C81B9GgVcIxJ5ejPBzBfJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUipuMHPvVRasVmvvHCZeQdv0eKXrqeYs/G5oTIgPkX2vfcPJg
	T290P6SalqFfTgztbhv6Zmwz2q/5TukUDAj2yTYgBML88y4sGQjNX28B
X-Gm-Gg: AeBDieuRDZwjJzsyJHWAw3pgleEA6jmXjLvJ1FmEZEX8bvYNwN8Bgo2TvWyBRtEaI0l
	gQExRMJWcs5e7/46hymAXUzSA0fgBWfyduT5RFdGVvgj725aVp8LT9eKJBIWlp27V/siSz0CwEw
	zWRPn1+MK3IETAzKIpcsRaXjWp4q12vo5oJBfIaMk4oS/8H0+loVKE0pZUevx2FTE7LZ4DbbUpH
	Yn3qwVvF49w6deHWBR8Ora80DdavTljlZDfVqcu3fO16RMswiVImbvwqmUlWd4Zlh98DXPWSimu
	EhIrr9zN0RQ4b9uareRPIPiSVapTVo6NCO5mM8Glvu0IWuwCtfW/PB6BZTitNiWoKraFAjFdDoX
	DukekLjZ76wlh/yq4SoHnmyVW6hWlbembN4P3aU0KjCOca9k30jI1dHlr+jZR8d0PeL4qKtcfr2
	wT1bkZt5PjuXnrHU+GA7ygCy4yIMHG4TNiHG/5ngYxIPUr00+zsHadMXp8miL1t6Iz0k5uOnD8E
	Kgkv82DGNyEEy9TDj12dyCphO0M
X-Received: by 2002:a05:6820:16a9:b0:694:8646:9933 with SMTP id 006d021491bc7-69486469ecbmr5499437eaf.9.1776811592345;
        Tue, 21 Apr 2026 15:46:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-694984114f5sm2023411eaf.7.2026.04.21.15.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 15:46:30 -0700
Message-Id: <DHZ7543VMYIQ.1US6BY7G0AUJK@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>
Cc: "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Hao
 Li" <hao.li@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Neeraj Upadhyay"
 <neeraj.upadhyay@kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>,
 "Zqiang" <qiang.zhang@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Lai Jiangshan"
 <jiangshanlai@gmail.com>, <rcu@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-5-harry@kernel.org>
In-Reply-To: <20260416091022.36823-5-harry@kernel.org>

On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
>  struct kfree_rcu_cpu {
> +	// Objects queued on a lockless linked list, used to free objects
> +	// in unknown contexts when trylock fails.
> +	struct llist_head defer_head;
> +
> +	struct irq_work defer_free;
> +	struct irq_work sched_delayed_monitor;
> +	struct irq_work run_page_cache_worker;
> +
>  	// Objects queued on a linked list
>  	struct rcu_ptr *head;
>  	unsigned long head_gp_snap;
> @@ -1333,12 +1341,99 @@ struct kfree_rcu_cpu {
>  	struct llist_head bkvcache;
>  	int nr_bkv_objs;
>  };
> +
> +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work);
> +static void run_page_cache_worker_irq_work_fn(struct irq_work *work);
> +
> +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) =3D {
> +	.lock =3D __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> +	.defer_head =3D LLIST_HEAD_INIT(defer_head),
> +	.defer_free =3D IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> +	.sched_delayed_monitor =3D
> +		IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
> +	.run_page_cache_worker =3D
> +		IRQ_WORK_INIT_LAZY(run_page_cache_worker_irq_work_fn),
> +};

I think kfree_rcu_cpu doesn't need to be per-cpu.
It can be global llist with single irq_work for them all.
Not sure about sched_delayed_monitor/run_page_cache_worker.
Do they have to be per-cpu ? Can all 3 share single irq_work?

