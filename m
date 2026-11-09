Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232039;
	b=lEZYT8ijVnGfAT/dn94XOR2YqR56MycQNyP5FlwYN3DaAzcx9caJ6OKMKrcQTwloFNwf
	 VH4VGcUB5WJZb7oRJmicOtQS/mD1FXho6PrmEbfhtXtovRmskDyd+OlmyI2HwQQuaSSpZ
	 9U0geFCG3/kXJJuZr9j3W5Nv/2cI7U11su8gxQZOhXTUe5r4MKD6r87Ong4WcDceWUl8i
	 +9w0c2clnQhcEYFRk/dw9STz9gOCYOq4HdkUtQBJHfcV5kMz5T2m0/UY0g5+ojPV9X5A1
	 4okWjICyKyBz5K7tdFY2Ivu+FMqIB3y1ya+KCj5VH7PQJ5oyYLIge2AkQK2zePrsjGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gb/McRGatQGrBV1WsdACGQfyLm2d4GS+1O2sMOZ+oYM=;
	b=IkcE6QUVJgVn3J/vIQsQ5FGE3habyFGwnhSa/SgG0FaPFzBqBtX+1VHLDVDT+kdtWD9S
	 QxNvlmcCFnRr4ga67cA4vLYJr96JzWYUtWadbqjHjK2izCQU5aAPehjr6mJIiNFeUoQQv
	 qvb+jj7EMbLsHJj5jkCxWVK5NVB4R3brgshpdWkSYBCq26CeUPgeX48DqS0gdVkqGN++b
	 sAp6M8Jv2cRxZtPvnYiEZQtC8NMa0SACZ8yQWFyYs/wu7QDRCYq005k0x9fgG+4fk9WAd
	 yfW613084fUb1jQag2OsshL/t2vdGDASKZZGNsTFtuJMxSa3XJqyNwCoeiQ36AtGNcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7ExUSm7;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC44F606A31C
	for <rcu@vger.kernel.org>; Mon,  9 Nov 2026 13:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC44F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7ExUSm7
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so1000509a12.0
        for <rcu@vger.kernel.org>; Mon, 09 Nov 2026 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232037; x=1794836837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gb/McRGatQGrBV1WsdACGQfyLm2d4GS+1O2sMOZ+oYM=;
        b=e7ExUSm76NkshYUOzc1Pz1ewL8FbwkfysLOZ2IVLp7+BcYeZHwd1Hbc2epgZ2NxJU/
         qg5fTY2cNrOtYUfv/yCoF5zPtvAPa54oK35FOF5oO/b6kkSQOk2Rc0eoirEn0Lp6GtDP
         R5QEQVumtcY+U0fvOxhIwqn9qHmDwt+6OMEgaBInjGgAxNd4ltHqVLN2/JihDpkhTCnV
         MZF9YoNYP49gWo8/rvAwvELWlEhg6hg3EiE7zbi1KdkMaW3OjPXKBlCwm5jJLaTs5yOQ
         01Cbtxl6zOdPpcaoXN5/IU8pooEV67WGfFmO9un89+nRNZiXwlaJSwraC5SE/Jnb60ia
         5c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232037; x=1794836837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gb/McRGatQGrBV1WsdACGQfyLm2d4GS+1O2sMOZ+oYM=;
        b=KNbAGGEWwo2gaHfNS/8AGtboUaHJnHKiH6bLDrFHR3s0J7o5hNZ2Qwn1fAGkIhKP/H
         hkrxX5yHegfOalA9G2E7Zs6zePsKwU2KOmhbHDcjKgC2L8tI1Rgzkf/1cPMLgkAoHx0T
         CHAssZtNSBka9MchGOYSU+HM74Aj3R9JOQ/i6P2RKG1XcUF5epPQiGsVneHB82rP/xXE
         agef2ChFE2yAp9ISgrM/4WLDx4kelJKD0tIGM0x1HxW30PXqjpxTxcOfnpsa1K7j3XJO
         W3OVeL3qdxqodLa7k4RT9bio/LdNSgC+ZP4BdCf9RY4AMptMIPfZTqg3rUDSouXvi+ep
         VdCA==
X-Forwarded-Encrypted: i=1; AL+hErFqSYjREaJR5vMLFqiNcBINSqv0ENuztS2SJxQVbCHFhIwtL/n4OuD6mpQ7LVpTR6EYY6Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4m90H7wk1mRHSnawKbZnQii6v4vOqJEVm0yDerebtNwvM3kG3
	Dvohfzla6XwF8fXv5dIL2NijilrF2ehWfGoXzftYEQhRX4/O/gJ0jfG3
X-Gm-Gg: AYBFou0Dc4Tlx9jE1XwXNiiEnk2Q9cmZO/PxLhmij17SoJKoczk7UIWOdLbc0d9vioN
	AQUx01EMEfEKCuEbt7gxTD7V60UEpkAqgYLgmhAwO1KUdSZ0F7xof6lrcxOcOAfq6fqo8lHvOza
	bmFOZYziaHzTkXF/z4KNoTyoIlaouvokfDyDv1Ot4lF5RVJ2i75yGUuPjnAJVOGd6xSO/+yh+ey
	7cV/z2iBG5Ri0DKvLPsImxP8k6Nup02UdZAb8I2j41xcUG5X5jyIIgrsbJ22h4IXEKdjHui9s+V
	W3Z1CKdIS/0p0zvAS9GuJqBaTwXAj/2VX/Ry6b5VQnS+MdyjsxlYv3uMFwSMfwtwUyW8AoyJjHd
	CDf7v8r1eQvpJNUphKNR5hoc4IaoTTyqmiT1iggBTarut5GeajtWyezzPJ8yvJmy9/Jns3ZYyTv
	VUNDu9LvN86V47YB6+VgU4VOuRfzAJlrhRSXBuvAGFQZuHaIf+iQ6jtGH6tFCpQnnaCnq2Wju4m
	V2e+9lPtiptwGLQfQaM1UWDPR0OgXGBMo0lwyqRRf9quzYZVgI0APk33LvZAYGYCutJvewRL+el
	3yxRXLnwaPuCEg==
X-Received: by 2002:a05:6402:1d4e:b0:6b7:6c8:70d7 with SMTP id 4fb4d7f45d1cf-6b7223c22e5mr2357975a12.1.1794232037247;
        Mon, 09 Nov 2026 05:47:17 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721eedd40sm1643775a12.32.2026.11.09.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:47:16 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Mon, 9 Nov 2026 14:47:14 +0100
To: Harry Yoo <harry@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>, vbabka@kernel.org,
	paulmck@kernel.org, qiang.zhang@linux.dev,
	akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <avHO4rQ-gKrxW2Nf@milan>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
 <au2fUYzBLv3uvj_2@milan>
 <au3ELzm_s9vhs7UO@thinkstation>
 <avGzD8CAgg9Hif__@milan>
 <avG1Yr9sjswFoJ9E@thinkstation>
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
In-Reply-To: <avG1Yr9sjswFoJ9E@thinkstation>

On Mon, Nov 09, 2026 at 01:13:46PM +0000, Harry Yoo wrote:
> On Mon, Nov 09, 2026 at 12:48:31PM +0100, Uladzislau Rezki wrote:
> > On Fri, Nov 06, 2026 at 12:21:28PM +0000, Harry Yoo wrote:
> > > On Fri, Nov 06, 2026 at 10:35:13AM +0100, Uladzislau Rezki wrote:
> > > > On Wed, Oct 28, 2026 at 09:46:47PM +0800, Zhan Xusheng wrote:
> > > > > From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > > > > 
> > > > > run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
> > > > > callers that may hold more, such as set_cpus_allowed_force() under
> > > > > pi_lock, so it kicks the refill work from an hrtimer.  Under memory
> > > > > pressure it instead queues the work with a delay of
> > > > > rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
> > > > > queues it at once, taking pool->lock under krcp->lock.
> > > > > 
> > > > > With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
> > > > > pi_lock after a drop_caches makes lockdep report:
> > > > > 
> > > > >   Chain exists of:
> > > > >     &pool->lock --> &p->pi_lock --> krc.lock
> > > > > 
> > > > > Use the hrtimer when the delay is 0.
> > > > > 
> > > > > Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
> > > > > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > > > > ---
> > > > >  mm/slab_common.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > > > > index 3729aa7a6156..ef5ff0a20249 100644
> > > > > --- a/mm/slab_common.c
> > > > > +++ b/mm/slab_common.c
> > > > > @@ -1987,7 +1987,13 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> > > > >  
> > > > >  	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> > > > >  			!atomic_xchg(&krcp->work_in_progress, 1)) {
> > > > > -		if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > > > > +		/*
> > > > > +		 * A zero delay would queue the work right here, under
> > > > > +		 * krcp->lock and possibly the caller's pi_lock, so let the
> > > > > +		 * hrtimer do it.
> > > > > +		 */
> > > > > +		if (atomic_read(&krcp->backoff_page_cache_fill) &&
> > > > > +		    rcu_delay_page_cache_fill_msec) {
> > > > >  			queue_delayed_work(rcu_reclaim_wq,
> > > > >  				&krcp->page_cache_work,
> > > > >  					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> > > > > -- 
> > > > > 2.43.0
> > > > > 
> > > > > 
> > > > Can we just clamp this to 1 - 100 seconds interval?
> > > 
> > > You mean clamp to [1:100,000] milliseconds interval?
> > > 
> > Yes. It is now in milliseconds.
> 
> Thanks for clarifying.
> 
> > So starting with 1 - means that it can be configured at least from 1 msec
> > whereas 0 is forbidden. Also we can drop the extra "if condition" proposed
> > in the patch as it never can be zero.
> 
> But can we explain why forbiding 0 msec can be justified (when there's
> an alternative approach to fix it?)
> 
I mean it is better to fix the threshold instead of adding checks.

--
Uladzislau Rezki
