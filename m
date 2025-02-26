Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EA218AAB;
	Wed, 26 Feb 2025 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580269; cv=none; b=XfUQjDiRekla9z3AkNtnoAwg9f8+WtvKNBjUsPIDi6kG7p8sdD6tV8+CNcK1bfR6bAqOQquL9WLTsc9JM9PMyDP5hQAnw3a5Fy+SR7iue21MYwK7LdkqOH3IkmZYat62sIi938w4u+jA63kyM+M2oV5qKG0O9xqtxEm16TbrEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580269; c=relaxed/simple;
	bh=32HpFo50ac9idpc84DjD9AHiRDMLXxEkvUovO/ujBfo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFiUHeq57RU+09NCXb83pGOwzSuvsnDYdL2qyPAFj+uD5ibc7XBP4aO+zKLRv3YXV+RA1BzgobYKJzjg/OzPRVEwcLuvZrxkvrCinnooQ2Tsx4sXr90/umq7wGvUZYpqCFMruMeEQ1t2HSrRtM7K9ewa8m8yc6KGNotJNhM7nWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Z20c4v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Z20c4v"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so50550961fa.1;
        Wed, 26 Feb 2025 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740580266; x=1741185066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eswWLfkEnQpdtu+isG+K14u+ZfJSvAbvqWCgztSMnzs=;
        b=g6Z20c4vzn6m7QRftTJifouyaoZmqTzg8hKvrifQAU6mEdPd9IYscYbGxuGXg7y5VH
         xKsSnCvx+ZFWP4WZB7nVMh9dE5r7ccNr92YKKwFyqT1mDoePZ0uwTTkYu54jfYAwZh/v
         TEydLx4Ut6AFIc1hc+Ulp8L9+knwp5RFb/ObiLyZpi5WMzHJFlMcGJJ56jkEd/EoVyta
         x8dURyDQjiSjTIg3dsOhG7Uq8G8yhyrA2Iyu8032Q1a5V65jFtQUyuY9L3ikdjr1BsXG
         ++zogDGQiXJUNJ4AXvJVpJB54IkEoVuPt5s2/iUQhiIRIhYjN+jUBVyjPUK5vIFYJ1fd
         kU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740580266; x=1741185066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eswWLfkEnQpdtu+isG+K14u+ZfJSvAbvqWCgztSMnzs=;
        b=FLu2zfuleyWJXT5in/nWns6t3+PLGSGs2O08Ibij+zy7RZi8zf3S5Zg3GdrxvGBV/K
         KvjW0N0G/jrpmt/cEO+imzl3XZjUKnqPbz27TP6RIOwzipOhZQ0NpOAwQcJEfjBIiih4
         VM72np+bwaYpUxZzi7P/fdD83D1cDdzGXQ5T2uF6EeMIz1+blGN2nOX9r7G+UDgUeTRP
         PrfWZyexz8KhW0EmUpbNqnQxLQAMoUs+S7k9MmXxla/49mHk3vKVp9o99mS9fmWE6Cqp
         gYQ/C+DGmQYvHxDXLAIYJOBGlbkPaQTLbSlpTZyVYy5TQOYZvYjzgyKv/H/swNptZ5vE
         +UNw==
X-Forwarded-Encrypted: i=1; AJvYcCUekZpOrtxLnHt7wJKv3L02+ACMb1wijMdatWGCq4HCtLJGI586BiT0eZ4yRhIXl0wiJBos/rXVT4GgMvQ=@vger.kernel.org, AJvYcCVtVvu8Sz3Pp9vm4ERbmyQg8HQ15aSHlifbYpiZnHR3grdsEVlWtKC9i2Q15MaOHaK+n2sM@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQe+9WCR78YUx0ijP6VWwpwRS/p+yHQhfuwGXV81iTbNtaa3A
	rXxNZI0kFD9iPESfSWlKhrDfKm8CA403rq9GdPGleR3k7sG4crPv
X-Gm-Gg: ASbGnctUWuW6Xo9gH/TbljQfj5nZ4sMYu+WnuYvT6CejqzMBUbXpOYMWhUhZN5sOM12
	tE8o8gjKoSfm6NgV5zyMIwoWFeWbg8375PnopLWGz8ev7D+mRu3ydEpwu+Qvov5x0EHSrXopAT7
	pBXqQYlaxT06qXLManD+mC3EsGqhuIrathuyX9JM/xCWwNpqac1IKzwtnIX7OAeh8wNwIKMgkiX
	bghRit56VIy+VdZ6BHC82URwk0EwUIaJSK5J2PNh713IuaR+usLxCvpO9qjvC+0hneRny4cQNoM
	35FlGgiYpEDvQjgJlOvpOjMU8VdwL0MAoNTl2vOE2UqOarDT
X-Google-Smtp-Source: AGHT+IGJW1NAlywvROVKX3Fy47FV/keZ7CVdQO/S4ffINoO6dO3Lou+LoCLXMQL+bGSH5kPPCn5/wg==
X-Received: by 2002:a2e:9a98:0:b0:307:5879:e7d8 with SMTP id 38308e7fff4ca-30b792cb29cmr26025521fa.30.1740580265244;
        Wed, 26 Feb 2025 06:31:05 -0800 (PST)
Received: from pc636 (host-95-203-6-24.mobileonline.telia.com. [95.203.6.24])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819f5e4asm5422341fa.63.2025.02.26.06.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:31:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 26 Feb 2025 15:31:01 +0100
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Keith Busch <keith.busch@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Jakub Kicinski <kuba@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-nvme@lists.infradead.org,
	leitao@debian.org
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Message-ID: <Z78lpfLFvNxjoTNf@pc636>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp>
 <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636>
 <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636>
 <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz>

On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
> >>
> > WQ_MEM_RECLAIM-patch fixes this for me:
> 
> Sounds good, can you send a formal patch then?
>
Do you mean both? Test case and fix? I can :)

> Some nits below:
> 
> > <snip>
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 4030907b6b7d..1b5ed5512782 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -1304,6 +1304,8 @@ module_param(rcu_min_cached_objs, int, 0444);
> >  static int rcu_delay_page_cache_fill_msec = 5000;
> >  module_param(rcu_delay_page_cache_fill_msec, int, 0444);
> > 
> > +static struct workqueue_struct *rcu_reclaim_wq;
> > +
> >  /* Maximum number of jiffies to wait before draining a batch. */
> >  #define KFREE_DRAIN_JIFFIES (5 * HZ)
> >  #define KFREE_N_BATCHES 2
> > @@ -1632,10 +1634,10 @@ __schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
> >         if (delayed_work_pending(&krcp->monitor_work)) {
> >                 delay_left = krcp->monitor_work.timer.expires - jiffies;
> >                 if (delay < delay_left)
> > -                       mod_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +                       mod_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >                 return;
> >         }
> > -       queue_delayed_work(system_unbound_wq, &krcp->monitor_work, delay);
> > +       queue_delayed_work(rcu_reclaim_wq, &krcp->monitor_work, delay);
> >  }
> > 
> >  static void
> > @@ -1733,7 +1735,7 @@ kvfree_rcu_queue_batch(struct kfree_rcu_cpu *krcp)
> >                         // "free channels", the batch can handle. Break
> >                         // the loop since it is done with this CPU thus
> >                         // queuing an RCU work is _always_ success here.
> > -                       queued = queue_rcu_work(system_unbound_wq, &krwp->rcu_work);
> > +                       queued = queue_rcu_work(rcu_reclaim_wq, &krwp->rcu_work);
> >                         WARN_ON_ONCE(!queued);
> >                         break;
> >                 }
> > @@ -1883,7 +1885,7 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
> >         if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
> >                         !atomic_xchg(&krcp->work_in_progress, 1)) {
> >                 if (atomic_read(&krcp->backoff_page_cache_fill)) {
> > -                       queue_delayed_work(system_unbound_wq,
> > +                       queue_delayed_work(rcu_reclaim_wq,
> >                                 &krcp->page_cache_work,
> >                                         msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
> >                 } else {
> > @@ -2120,6 +2122,10 @@ void __init kvfree_rcu_init(void)
> >         int i, j;
> >         struct shrinker *kfree_rcu_shrinker;
> > 
> > +       rcu_reclaim_wq = alloc_workqueue("rcu_reclaim",
> 
> Should we name it "kvfree_rcu_reclaim"? rcu_reclaim sounds too generic
> as if it's part of rcu itself?
> 
> > +               WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
> 
> Do we want WQ_SYSFS? Or maybe only when someone asks, with a use case?
> 
If someone asks, IMO.

--
Uladzislau Rezki
