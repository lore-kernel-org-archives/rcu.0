Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44A370D61
	for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813264; cv=pass; b=TT/ArAf5+jV9NqJKjsaGDmDF1Uk9T2vX8KB+JX7FaLD7kKm3+hRKaU2LrALybdnXkif0CjG2wVYd7wgrvWGnbpMjfGtwHlSIbcIeCwfegV3iQ35/mMCi/gzzYXzjsx5JqDXVZ7KF25ELX/nq49yQ5g+CVnOCFihukFu7veXCEz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813264; c=relaxed/simple;
	bh=eFtrzIvskJTNSnz4lwFTPjY5iW/t88DaDlJdS6d/Y2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjocAKtyKsGU+jY/0V0nzvVj7fJXzUsXPvk6QoEhIq1K9GkQ1n98pJRalRjqPhJu6fX3lybyj1NphSC2Q1hD1lAudgxVfgNHanUuw0oT+bXaseT0VLNlW4WcKvjhynQ6j92UzM98fhIxt9k671tc7a1VHzfYGx6bY14tbcCb7xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORa4NLxQ; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORa4NLxQ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d73422431so4096418f8f.2
        for <rcu@vger.kernel.org>; Tue, 21 Apr 2026 16:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776813262; cv=none;
        d=google.com; s=arc-20240605;
        b=BN+YZ7ji5aLJG4LDAuOsZD9o2bGTBcbsa+rfu5EBxmXdLWCXY79idYaqlsoeID6GOI
         D+bE3vyvmaUqie5ySYQaWkF0Trki5UeoVVztbm5xpKf6f4GaKlj3BN6xsRVbsyB5iVbr
         vxXXPDR8y/1U6/uVByarQ2xnVLKgwosACkeID6Gun32aYzmSQIO+eoquTpYd6rf4fE5S
         JXGgs8jP//bg8oMAVI6anfrBFXiMcoqnk9e9IG1VFdK0ufT19Xz7x8h9t+BySuzGVYgb
         7m3/yondMqZ7O6xt9wVHdk6030NBIly0bEoVAhzvDbdSt5XvYf5FlOB2+h174wxlVahL
         oBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lSiUAjPuNkXKxVnQ9DAy1K0IVEzKOiBtHeFUSRjnTQQ=;
        fh=b4POv1TQlX/ln70WdKv4qtzLG3clsyCbpXLGuHxRRxg=;
        b=ek2XRNWWF3tKmNCeLU0HX3/SbqzGMrrimo057Tr9h3OVmfXiqoEBKnWHJulRVVepPA
         L/F7ryk+Zef2lqlySUVrQ1ikpCaGwoYpM0d2Ko/2hooMoOgzdXy0KNlbC4SwpIsiTmow
         +1GqHZb4JJlMZnBf0aexUJdIfQNeqNIivJN15EW2WNlajdTceE0bilY9f6ndd6zwzQhu
         9HAD5OP/qUA10+L3JY9ut/7YWDEiloMZ9GmmwJZoXezFHvSPqXx1rD/wpI33uOkfQQ3o
         2qbiugkhRer22ylP9vslGdrlNX2xVXDHmfdEgDvc9Dc33catK8oh+TcpMcW+xKJ8Yfoi
         9HGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813262; x=1777418062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSiUAjPuNkXKxVnQ9DAy1K0IVEzKOiBtHeFUSRjnTQQ=;
        b=ORa4NLxQwBeTIMnB++r+4RzST0khml1Ts0NmEsmksxAMyHFfx3OFp3iesbT+RRB26x
         c98gnTgrg5ZcfmqoWGuPhbJdxIrClRnIQPbs6QYhoGdPIaBAKSrNTlkKjk6hNCSEOJVI
         DFiaAWnxp2ZjCfzDiWrAEj1/CmCKginzhR4dlQS6oELoN2D8Yz8xJL54gE4iNKvlIsir
         9FTMMmPENzKzP5s/YeJWyUOhJsWPjN20gwZPSqEUcioWLlRO43nGHZ8F2hTDMQPhwE9f
         ZjHjJOZ3aQcu327ZQHkV2bspqJ2relvRL/gN6XxI5bIYqsmPd8tOxpPH4HxMlbfPxJUT
         5Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813262; x=1777418062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lSiUAjPuNkXKxVnQ9DAy1K0IVEzKOiBtHeFUSRjnTQQ=;
        b=orJbzNzOknCufWv8i3rVmwMlXqs6MsR7sL28U7FmMKEl4zneMZQQ6aBCZpw9yYOMtT
         ye1yZkxKSWMHW+1w5py/c8xjCj0LS3a4Utlmv5dCCs+eUV6t8srAlG9z65mIzQaE0wwM
         W3fJkxHCcQ8Leq75fJXCFvqXllA//hM5ZyLRpH1OjRuByZKefmIPxKjDOP83sGV/0COk
         r6gQqI+5BNWEXhiY/bKw590nBXja2AIBC4KJvGjInHtjFlkJjzo4vXIPdUNyxZEYSGeJ
         GZRaCEvmvzv7sYHdjJ1hgxNz02o2ycGa6mfg9gQRTT335ILTI33r+YU2sj5XAnud2R8g
         R6xQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CfHk8VrZvq/uO7D3+1+U9shJSqDuKguobwSbbgTL9HqYtmO1OlLK1Wdai0LyydXTVs/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDHLosrE44/1FR94nTDoNcRbE8eRoIF2LJwQlfrkgm0y9F9D+4
	oV7YFU1k6QrmmPzCK7BRBacX3z7UpSbLzjrNUiFspqQd6AAne5ZWB6kW9aiiK0BCeIK55rfdkvy
	Uk4+NPupxstsqSP99q9V14ZbnRfrNQUs=
X-Gm-Gg: AeBDieu4VuX+F10L30FqjSbBAdDVbEOC4fJcvjV+hYjdKHzHMtBa+iZAD2B+v0z+4O5
	DXu642sffERWi/h2vuI81F8g1BnHyL3wfCzpnVYFrKVqgoD6QPqROuV9kJOMbRGYRZ/zdVzFW6D
	vIJrTKKIt+C7oYfRAD0k73AP0kj08Ji1YPFafUUjLoZVrt648QODioI7Y6uB/DPLCMR6M+acKbA
	XhCT24QivSYVV2FrAc4S9H9Oj+ts1jsSz1vA0WXOddd570kZdM6IOtwqQ1eDICGpfOWcsdHuh/4
	e3PNV4X0JboJqLBcDs5FvN5B1U2TEtYDrTD0nfeGgMpBkyhElf58BK6vo5Y585BVlNlQZrLnSPf
	//FpqWXtt37wn6ZB3P/uwGljAh2ak65HZ+QLZ
X-Received: by 2002:a05:6000:18a6:b0:43d:1c59:2dc with SMTP id
 ffacd0b85a97d-43fe3e0dafemr32331162f8f.28.1776813261540; Tue, 21 Apr 2026
 16:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091022.36823-1-harry@kernel.org> <20260416091022.36823-5-harry@kernel.org>
 <DHZ7543VMYIQ.1US6BY7G0AUJK@gmail.com> <805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop>
In-Reply-To: <805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 16:14:10 -0700
X-Gm-Features: AQROBzCsiHo72T3ksF8bPj7_lkbDTn2EXriq67eSQ6XGFtwVUqizC07uHtJfjmM
Message-ID: <CAADnVQJCJsTWOaTWVVwtDZtd+UXMWz9SArTdYsAj7dyif5aJZw@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm/slab: introduce kfree_rcu_nolock()
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:10=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Apr 21, 2026 at 03:46:30PM -0700, Alexei Starovoitov wrote:
> > On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
> > >  struct kfree_rcu_cpu {
> > > +   // Objects queued on a lockless linked list, used to free objects
> > > +   // in unknown contexts when trylock fails.
> > > +   struct llist_head defer_head;
> > > +
> > > +   struct irq_work defer_free;
> > > +   struct irq_work sched_delayed_monitor;
> > > +   struct irq_work run_page_cache_worker;
> > > +
> > >     // Objects queued on a linked list
> > >     struct rcu_ptr *head;
> > >     unsigned long head_gp_snap;
> > > @@ -1333,12 +1341,99 @@ struct kfree_rcu_cpu {
> > >     struct llist_head bkvcache;
> > >     int nr_bkv_objs;
> > >  };
> > > +
> > > +static void defer_kfree_rcu_irq_work_fn(struct irq_work *work);
> > > +static void sched_delayed_monitor_irq_work_fn(struct irq_work *work)=
;
> > > +static void run_page_cache_worker_irq_work_fn(struct irq_work *work)=
;
> > > +
> > > +static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc) =3D {
> > > +   .lock =3D __RAW_SPIN_LOCK_UNLOCKED(krc.lock),
> > > +   .defer_head =3D LLIST_HEAD_INIT(defer_head),
> > > +   .defer_free =3D IRQ_WORK_INIT(defer_kfree_rcu_irq_work_fn),
> > > +   .sched_delayed_monitor =3D
> > > +           IRQ_WORK_INIT_LAZY(sched_delayed_monitor_irq_work_fn),
> > > +   .run_page_cache_worker =3D
> > > +           IRQ_WORK_INIT_LAZY(run_page_cache_worker_irq_work_fn),
> > > +};
> >
> > I think kfree_rcu_cpu doesn't need to be per-cpu.
> > It can be global llist with single irq_work for them all.
>
> I would be quite nervous about that, but you might well be right, given
> that this is a trylock-acquisition failure path.  Give or take people
> and/or machines analyzing the code for potential denial-of-service
> attacks.  :-/
>
> > Not sure about sched_delayed_monitor/run_page_cache_worker.
> > Do they have to be per-cpu ? Can all 3 share single irq_work?
>
> On the other hand, if all CPUs are doing kfree_rcu() in even a semi-tight
> loop, having them all unconditionally use global state is not going to
> make for a fun time on large systems.  And there already are situations
> where user code can make all CPUs to call_rcu() in a semi-tight loop,
> so even if that is not yet the case for kfree_rcu(), past experience
> indicates that it soon will be.

My understanding is that defer_head/defer_free will be used
when per-cpu trylock fails, so it should be rare.
Hence the suggestion to optimize for memory.
