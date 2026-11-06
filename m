Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957718;
	b=EyDI/p12rzzeDwz1WnKMQS44IdKDc8bT/BBSSK2I3f4rdPRZ/xr2WhyCfNdVwiMEwKZH
	 +DcyyPg4UzggsNRU1yQ48v15umCI+a6Dn7mHfUNYRHsLIef8pGClCMAztP99ZlLLdphjm
	 BUOZAPcv3xIbAQSxE0hFv09zUIepaTcu1nnRPqAZGnOPlZknETAbidmWSk3pBms93zMrd
	 YC/bQBdPGDDDkcKD5bzQjxUDuptXeYe26zONA5wjtRjGdhpVwpf3XIPS6yD54BTs29NOo
	 oGalfcOhtWyFiu+s6I/VEMDQjMYipxWv5OAskm1vtcG00iefbgPuBhANJGHezaWqrhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e+beHwPVnOrx0jzUBZNVM2/8fCDJRY0y3tTo+TmZt0s=;
	b=pvwP8g6OKCjO7+I+R3ILKETXuGkHU74D0xP2qpmco4iDZwmZi3cGwXo+kr8cu3kUTsVe
	 sDLfZd9H6e43bQULi3gV2zD4RdB+w96LDAuH/sTj+iisS45vDYG9ZD1LXzB18FNcS772L
	 /1YIMBZGCaOd+hvBwHERh0NVwQMI9cguCXZAuBOx0KgAKkL6eWa9/nu+DTFm9NUUW/DQS
	 ZX9Kh94UmyJcZa4LyX47O5Wnmm8vnLaoZjZwEzMC4rtMNXD3Us96gIEI3mA/2C9FPV1oM
	 BeY7f1jUts8jeJmnV5viSA8rN3q7GcW/8NY4sUnLxn/CprsEEQZSbWpByHhlJ5z2Jtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGxrb6hE;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF447606D809
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 09:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF447606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eGxrb6hE
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c43373ae89aso60580166b.3
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793957716; x=1794562516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e+beHwPVnOrx0jzUBZNVM2/8fCDJRY0y3tTo+TmZt0s=;
        b=eGxrb6hEW88atCdNy0tSfzxZ2DmYRRZnEzfrKDE47vNJ1C8+MVMJHFLz8nyZZFYPc2
         YbkEWrk+st5rKjhADm4H2dF6en2AuSRGEw43DnZ3g/jxxuNxor8FZX8SKpiBeHyAeYlK
         yEjky+hYTOzLxY3ClZRQt3hW/8uP6+jaK8fVbrZYld0qnS4Q2e2ZkFkMvtdRr7KRh1Qp
         Hu3mn3A8WPM+z35IPd2alklUeFgQAoLjbau1IMu9wNXYJ45dVpIAEGfRYqpTh/ZeNaG+
         5ggTcLMo1ZvB2zuxqPhwWl4bHLEfloC8ciV5WQB+znFUOcWWB32Cw7g+71ZjZhUIwWg6
         UN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957716; x=1794562516;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+beHwPVnOrx0jzUBZNVM2/8fCDJRY0y3tTo+TmZt0s=;
        b=jSVx0rVqZV4AmqvabMldx/JRsuZDXYxc0ikLcyT9aiM6Pzf8y90Dp/dlvMa8g2w3eY
         JKdC690xyUEpQU8IUWLsJ6Dd1FyhSnEFahTA4Q25CXCgBaVK2KBBjEUYO71Z92O+geRW
         ymAwBExl8m8MfYGhCZ+Xom2bGVtMb05QRxFkT2+tOT52347xCKzHggiTlSvhF9Nkwnep
         +04U5Rnb2LM2G0Fk4Wxtve+ctD+tj+XkfHU/p82e8o3vcjRUZKZSRSR7/2xxJwstZiLT
         Z2Cxv9OJu8r0abQ7jEvSsCzJVhwyGMxLm3010ZpJHjyiOv4wygpFdIiWJElpkL9Ybsx1
         Kb2w==
X-Forwarded-Encrypted: i=1; AKwUvBxop9KKZvoeDt0dPXc+rW0UC0Thxifphd3ooeGW4y7pC/cZtLQg7TvwJZUElDyzHJ2J5LU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lNdxBUJSxAAxds5nNW3f9a3yZELrRneqfE91GtWPvUm9jtrHv
	DvIbOGYlQHTUGF5ydSI4bSSTThZ4SgEOb61t35qEnMu9hbyiY6wyTH5U
X-Gm-Gg: AYBFou0hSfMZ/48VXQK1N1FeowtHl4HHAMcqpip6gFB6JXM9UrX/aiTN4CijMQgUb13
	RvRJk3hI25CQ0jbWW1btM1Qs9L5w1rLAJC/VOihcUqutmXY7LmLi78fP8ZwUrTunp+L3S35JZpI
	7AVhbJ5g9n37UC78Q7/2VT2IxopUSUwxKp6Vj2mX3djrvMVnCK5EXTr3DjItc3+uHRkXq4uKC8u
	2468QuJfmt/x9dErx9ZkDu3XHuhPyOO846PqH6rVEBxEotlY185itwb8RjmCTgs9GJydv2HvOnt
	AljDFhpuOTUkbpSi8QN/ErAixtc27nP7Ybzt615TGZKRmZIV+ZSsOgBBIBtVWcdmp4tJszh8EHj
	7ohDtYy/L2VkJdriLds5ybQqzW5SIZyCw31qv/YElRkc5DeFttw3hgh9J7ZErsi+pSpLu4rjquv
	+Zt0/Z/6Es0LvNT6d0zvFfhovrgvj3f9RPPo2lGFW/22U/QeR+reaxnZ/tVEJaEJpRSJwrEqR68
	PjNi9rVjvJ9CeD65fK60MhGHtNEZPjPO7VxNaqZAJtLLzrtt5/CPz1d18VhZQ4Une28
X-Received: by 2002:a17:907:a892:b0:c3f:153a:8663 with SMTP id a640c23a62f3a-c4d34bdd8camr155235166b.23.1793957715953;
        Fri, 06 Nov 2026 01:35:15 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35670169sm65381266b.42.2026.11.06.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:35:15 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 6 Nov 2026 10:35:13 +0100
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: vbabka@kernel.org, harry@kernel.org, urezki@gmail.com,
	paulmck@kernel.org, qiang.zhang@linux.dev,
	akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <au2fUYzBLv3uvj_2@milan>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028134647.3176080-2-zhanxusheng1024@gmail.com>

On Wed, Oct 28, 2026 at 09:46:47PM +0800, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> callers that may hold more, such as set_cpus_allowed_force() under
> pi_lock, so it kicks the refill work from an hrtimer.  Under memory
> pressure it instead queues the work with a delay of
> rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> queues it at once, taking pool->lock under krcp->lock.
> 
> With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> pi_lock after a drop_caches makes lockdep report:
> 
>   Chain exists of:
>     &pool->lock --> &p->pi_lock --> krc.lock
> 
> Use the hrtimer when the delay is 0.
> 
> Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  mm/slab_common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 3729aa7a6156..ef5ff0a20249 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1987,7 +1987,13 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
>  
>  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
>  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> +		/*
> +		 * A zero delay would queue the work right here, under
> +		 * krcp->lock and possibly the caller's pi_lock, so let the
> +		 * hrtimer do it.
> +		 */
> +		if (atomic_read(&krcp->backoff_page_cache_fill) &&
> +		    rcu_delay_page_cache_fill_msec) {
>  			queue_delayed_work(rcu_reclaim_wq,
>  				&krcp->page_cache_work,
>  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> -- 
> 2.43.0
> 
> 
Can we just clamp this to 1 - 100 seconds interval?

<snip>
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7223a7596dab..2c9236236ac9 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -2249,12 +2249,12 @@ void __init kvfree_rcu_init(void)
 			WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_reclaim_wq);
 
-	/* Clamp it to [0:100] seconds interval. */
-	if (rcu_delay_page_cache_fill_msec < 0 ||
+	/* Clamp it to [1:100] seconds interval. */
+	if (rcu_delay_page_cache_fill_msec <= 0 ||
 		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
 
 		rcu_delay_page_cache_fill_msec =
-			clamp(rcu_delay_page_cache_fill_msec, 0,
+			clamp(rcu_delay_page_cache_fill_msec, 1,
 				(int) (100 * MSEC_PER_SEC));
 
 		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
<snip>

so we forbid zero as value to use?

--
Uladzislau Rezki
