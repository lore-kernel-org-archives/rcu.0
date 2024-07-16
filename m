Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE0143C5A
	for <rcu@vger.kernel.org>; Tue, 16 Jul 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721133984; cv=none; b=FX5hftjjUpUHqJqD+RMIpDT4TAqaO8FUsE6dhMTwZz6VnoOnU6EUgaA8zzJOKT0YKNOeufkK26zy8fxeoZjtyqRXUMZlzc146GX8eEtA6nh2X6+FnJljXXW4+yzgfgomY4AtNSB7gCBgXgxDXJ13A1D8Ot76/7Q+xBDz4wQzADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721133984; c=relaxed/simple;
	bh=g5r/HJ1teQALQogyI7TMwfvqoMO54yRFZm3jHkPf6B0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcR0/GANT9F3YhsXhj2rVTo1ncUVCz3ip3bNcGPPU/K6cVWpTvbx9X1heBp8njsR1/BHldrgqItRqKsxCRH2G5K26omLUhslIzspo2JFnKJ8++WIMKlqmrkywJ5vTEgVFa12OJcwiL/Xe/HoSfvDv+f0wSaMqMVURFnAazazvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SP9scvDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SP9scvDe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721133981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xzGdO6S5eSRG+rnFZDuzkBmlhIXBR+nmZsIINSlJ6S8=;
	b=SP9scvDet1aa9Ewc86bsyOxaDaJ4o2bZ6EtYVrhpFV3bZcxaYvqVjqPnXZbpR1AqSXb9aV
	jvSWAUut0ihqCNzLDA7lkt/HZBmSjZpJPZ7lWpStu+onBbON2CywOOC1dGUTQB0Zc6yfU7
	sdok6NYxalSGF6wuDsFf+mmUEkpEATY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-YbcdY3LWMzSRqC6AxVrJXQ-1; Tue, 16 Jul 2024 08:46:20 -0400
X-MC-Unique: YbcdY3LWMzSRqC6AxVrJXQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-367991a0a64so3512461f8f.1
        for <rcu@vger.kernel.org>; Tue, 16 Jul 2024 05:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721133978; x=1721738778;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzGdO6S5eSRG+rnFZDuzkBmlhIXBR+nmZsIINSlJ6S8=;
        b=w7wt8UtgPUJ+e5u3h8n80AiknYb1FcqDx8GgaP/tW+D+TxPGdKkRGyKfCxC3RmChfG
         NQKdqwzpd6qvBcaxT2chyvI+vsGgOBTaIbES57+QRLCLmCdziUbwAQZjE3InTUUnOqxl
         G3UKruaLfE5hOFQBaJReMHZLEDw5RdhjKFswgyw8v3gMITpuF2g2eY3ugcYBbWxrJcIX
         /MbHWSF3ulurS9CF6NZhLYDBy/t5rYcEzUzhYirfZlr7SuWf6oM/swHHY9zlUWILSrxb
         p/2ggzmXZIlTNUYN61wChgzl8fRZY5/eeskLx6Dq7hfDUM71utxkvZaHd0XlxSYSRCxI
         g5pA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMAXUJdvBjtLfZPEbVvYWYFEKiDbb2AkqXZ6FqR7Aqqwq+HSwmXcOlNn9oT9Xmsz+SFCQodPMCk/yat5oaoKCqGgE
X-Gm-Message-State: AOJu0YzMTYNLM37yi/GoiIxq/rHR+pV+Z+Y2l5DCan8r1d4nGJ2ji3Qc
	ovEzA3IzfzJIYq8xKraVhPbF9uU4ViLgYjfIyStDcuDDdWZVrn0EZtWqglYkX7RS163STYWf6EE
	sojjUInLUqSgCeOujBd6MtmhvgiEM7TU92M1YqxUJphujcoH5aw==
X-Received: by 2002:adf:eb10:0:b0:367:8909:197b with SMTP id ffacd0b85a97d-3682635bc3amr1223865f8f.61.1721133978279;
        Tue, 16 Jul 2024 05:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOPBeouHgfUIbvUjuYRYsvSnh62Z4YpynAmxslg3ykV9R9pitm3rEykHaRO/9G0+Tn34nEBg==
X-Received: by 2002:adf:eb10:0:b0:367:8909:197b with SMTP id ffacd0b85a97d-3682635bc3amr1223822f8f.61.1721133977913;
        Tue, 16 Jul 2024 05:46:17 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafba0esm8951528f8f.71.2024.07.16.05.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 05:46:17 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Ingo Molnar
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Phil Auld <pauld@redhat.com>, Clark Williams
 <williams@redhat.com>, Tomas Glozar <tglozar@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg
 Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <20240712174313.GW27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-11-vschneid@redhat.com>
 <20240712174313.GW27299@noisy.programming.kicks-ass.net>
Date: Tue, 16 Jul 2024 14:46:15 +0200
Message-ID: <xhsmhh6cp1p48.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 19:43, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 03:00:04PM +0200, Valentin Schneider wrote:
>
>> +static void throttle_one_task(struct cfs_rq *cfs_rq, struct task_struct *p)
>>  {
>> +	long task_delta, idle_task_delta;
>> +	struct sched_entity *se = &p->se;
>> +
>> +	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>>
>> +	task_delta = 1;
>> +	idle_task_delta = cfs_rq_is_idle(cfs_rq) ? 1 : 0;
>> +
>> +	for_each_sched_entity(se) {
>> +		cfs_rq = cfs_rq_of(se);
>> +
>> +		if (!se->on_rq)
>> +			return;
>> +
>> +		dequeue_entity(cfs_rq, se, DEQUEUE_SLEEP);
>> +		cfs_rq->h_nr_running -= task_delta;
>> +		cfs_rq->idle_h_nr_running -= idle_task_delta;
>> +
>> +		if (cfs_rq->load.weight) {
>> +			/* Avoid re-evaluating load for this entity: */
>> +			se = parent_entity(se);
>> +			break;
>> +		}
>> +	}
>> +
>> +	for_each_sched_entity(se) {
>> +		cfs_rq = cfs_rq_of(se);
>> +		/* throttled entity or throttle-on-deactivate */
>> +		if (!se->on_rq)
>> +			goto throttle_done;
>> +
>> +		update_load_avg(cfs_rq, se, 0);
>> +		se_update_runnable(se);
>> +		cfs_rq->h_nr_running -= task_delta;
>> +		cfs_rq->h_nr_running -= idle_task_delta;
>> +	}
>> +
>> +throttle_done:
>> +	/* At this point se is NULL and we are at root level*/
>> +	sub_nr_running(rq_of(cfs_rq), 1);
>>  }
>
> I know you're just moving code around, but we should look if we can
> share code between this and dequeue_task_fair().
>
> I have patches around this in that eevdf series I should send out again,
> I'll try and have a stab.
>

Looking at this again, couldn't this actually just be:

        list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
        dequeue_task_fair(rq, p, DEQUEUE_SLEEP);

?

Because the main deltas between throttle_one_task() and dequeue_task_fair()
are (other than the list_add()):
o Caring about throttled entities (!se->on_rq) - which AFAICT can't happen
  after this patch, since non-empty cfs_rq's are kept enqueued
o Load tracking faff (util_est, an extra update_cfs_group())
o The set_next_buddy() thing, which will always be a nop because of
  throttled_hierarchy()
o A rq->next_balance update
o hrtick_update()

I think some of these are omitted from throttle_cfs_rq() because the whole
cfs_rq is being taken out, but here we are genuinely taking just one task
out, so I think this does want to be pretty much dequeue_task_fair().

