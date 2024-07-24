Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9C79F3
	for <rcu@vger.kernel.org>; Wed, 24 Jul 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721784856; cv=none; b=OopJQjhv4K7+HLodaLD/YVgoeoKeSm8BRt9N1F4I6MQkNyMqPXazJ84nk1T60H218AnmHyHLHP20v8Odkv5wj5YXVx23Eza9TgyssN40XaOieUFYAxOGjsEne/OLqvx6pOYFvXO8T4X4zZODOdpzbLqWTIleGO0rq8opolh75L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721784856; c=relaxed/simple;
	bh=aT+h210BT2JUWtrXjXFykcBpBDwnkrUWOD9dpgMA01M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rg8BUNsHXMmCNCS1F8+EGOLq6PQQ9FOdd430Kij4ZcqiY+LpR2PuyCL3BOUzsY/sIR/GDA7KNuw1Tt3r7s55fE+twhkvWnWn7eJX56nCH6DyXAk4EEYhLrLkezVuNnA4Sm9hfSqb7C/bJmXmBHEO4wH7jjYMERenOfW4MY77ogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfVjKEDj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfVjKEDj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fd7509397bso105025ad.0
        for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721784855; x=1722389655; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX7tUUTyuLfAxhlIQpJKT/5V3ggK/z1UtcxWyBnw4a4=;
        b=wfVjKEDjvCxn/B1iQdcYCD1m1EFcKGz2BEUiShmMZQ1m9qlAolXF2JRM/u+pK2EiZh
         HqDFwQatlk7i6xwiMJ88BMj6zQAHqaSeXwnd3YNel3deDw6fvuBh41+Vnan5DxGrVKkL
         Gz4yeiztX5YT85NptvvdDaIZ7otgfU2xKBBv87ZDzpVuDXXfgolzDUp4SqPVjq4EY6fy
         dtLQI3ikk8VYTcCf1f3E73CciPj90Y/wvaKij/zOzKj+jGfmsOsdfcAJlS/WXH/1g/ep
         whptJGQDnEeglVGto7qEvW/Aih94k3KORL10gftPdX6BdvT5CMHrAB5qDUafS4rXjQbm
         7LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721784855; x=1722389655;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX7tUUTyuLfAxhlIQpJKT/5V3ggK/z1UtcxWyBnw4a4=;
        b=pNksBmrzDfWwGoHIvhMNklZ88JATCUGoJ1zDhgwdFbWJuimQIo5G74P4ax3hGgSipy
         Z8SGkal/4L6CVjl7+QpczZmbCCLTJvtEXjO00jdYn7fEfbXBWOxYgR8xTquRQYdq8NfO
         lNpW8lSrInGhAhQ3rmlzjWHrDZo1WLDMN6Izp+0nljEkNDmaeaYXjmFp6l0Ofr4XzRO0
         gZaDZtvP4GjVqliDj3Q0J5y15ObuEs2TtHa8MUpB3WYqdYI1m53WSdLVHM/rcNp4Ifg+
         xEPLH8TX3qwCMh7brbpqWVeNgGpnofIcySiVzmJrKA1zdmUdLCf5THx0YbjSfe9RydFV
         48eg==
X-Forwarded-Encrypted: i=1; AJvYcCUqA2o/ypGunBwC65gKGri4ROQN2KKgKnDn12AInzNh1CSHcnp+wGtItzLfHwPjBu+Dou3nB92wHqtvMmXpGBKeCLNO
X-Gm-Message-State: AOJu0Yw05ko+mLrSFaMikEIu9CsaIPfVB3NJsVv2U31ORg97qW4m3gFn
	I4vAkNrP+bQXs9xVLOkyHsoRvA18GeIVhbFqrqZnjgmM7AiUTSMatMLrs0Go5w==
X-Google-Smtp-Source: AGHT+IGr1O86WP3V8FbnoWAMwrvFj7oMhzGCnQawx3yLPJFJyNjoBduQsQUlIObs2knWQP7kZkbTpA==
X-Received: by 2002:a17:902:da8a:b0:1f9:dc74:6c2b with SMTP id d9443c01a7336-1fdd3d4c5e0mr1816955ad.29.1721784854584;
        Tue, 23 Jul 2024 18:34:14 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b8166sm7577995b3a.85.2024.07.23.18.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:34:14 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,  rcu@vger.kernel.org,  Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Phil Auld
 <pauld@redhat.com>,  Clark Williams <williams@redhat.com>,  Tomas Glozar
 <tglozar@redhat.com>,  "Paul E. McKenney" <paulmck@kernel.org>,  Frederic
 Weisbecker <frederic@kernel.org>,  Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>,  Joel Fernandes <joel@joelfernandes.org>,
  Josh Triplett <josh@joshtriplett.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
  Zqiang <qiang.zhang1211@gmail.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Catalin Marinas <catalin.marinas@arm.com>,
  Arnd Bergmann <arnd@arndb.de>,  Guo Ren <guoren@kernel.org>,  Palmer
 Dabbelt <palmer@rivosinc.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Oleg Nesterov <oleg@redhat.com>,  Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC PATCH v3 10/10] sched/fair: Throttle CFS tasks on return
 to userspace
In-Reply-To: <xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	(Valentin Schneider's message of "Tue, 23 Jul 2024 17:16:20 +0200")
References: <20240711130004.2157737-1-vschneid@redhat.com>
	<20240711130004.2157737-11-vschneid@redhat.com>
	<xm26y15yz0q8.fsf@google.com>
	<xhsmhikwwyw8r.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Tue, 23 Jul 2024 18:34:11 -0700
Message-ID: <xm26a5i7zi7g.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Valentin Schneider <vschneid@redhat.com> writes:

> On 18/07/24 17:25, Benjamin Segall wrote:
>> Valentin Schneider <vschneid@redhat.com> writes:
>>
>>> I've tested a 10ms runtime / 100ms period cgroup with an always running
>>> task: upstream gets a "clean" periodic pattern of 10ms runtime every 100ms,
>>> whereas this gets something more like 40ms runtime every 400ms.
>>
>> Hmm, this seems a little odd since TWA_RESUME does a kick_process.
>
> I didn't ponder too much on the workload used here, but the point I wanted
> to bring up is: if you give a cgroup X amount of runtime, it may still
> consume more than that within a single period because execution in
> kernelspace isn't immediately stopped/throttled.
>
> It means the "standard" bandwidth control behaviour becomes a bit more
> bursty.

Yeah, more bursty behavior when doing cpu-burning syscalls is expected.
With the check on exit to user I wouldn't expect anything worse than the
duration of the syscall though, so it depends on what your test was.


>>> +
>>> +	/*
>>> +	 * Account tasks woken up in children; by this point all direct children
>>> +	 * have been visited.
>>> +	 */
>>> +	task_delta += cfs_rq->unthrottled_h_nr_running;
>>> +	idle_task_delta += cfs_rq->unthrottled_idle_h_nr_running;
>>> +
>>> +	cfs_rq->h_nr_running += task_delta;
>>> +	cfs_rq->idle_h_nr_running += idle_task_delta;
>>> +
>>> +	/*
>>> +	 * unthrottle_cfs_rq() needs a value to up-propagate above the
>>> +	 * freshly unthrottled cfs_rq.
>>> +	 */
>>> +	cfs_rq->unthrottled_h_nr_running = task_delta;
>>> +	cfs_rq->unthrottled_idle_h_nr_running = idle_task_delta;
>>
>> I think this should have no effect, right?
>
> Hm so my thoughts here are:
> The walk_tg_tree_from(tg_unthrottle_up) will update *nr_running counts up
> to the cfs_rq->tg->se[cpu_of(rq)]. However if that cfs_rq isn't the root
> one, we'll need the for_each_sched_entity() loop further down
> unthrottle_cfs_rq() to update the upper part of the hierarchy. The values
> that will be up-propagated there are the ones being saved here.

I'm pretty sure this comment was left over from when I didn't understand
what they were being used for. I'm pretty sure I remember intending to
remove it.

