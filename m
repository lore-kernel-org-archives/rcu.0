Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654A4D8AE
	for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066291; cv=none; b=WWKtU/93MiYp9Xo+z3CMPerQBnhmzYc2imgTYPKo9tPyF+8FB7mN6k5n0BkYJvphqN78e2oR0BMqfRfJFIUHmvo6WYqkH+jLAYUm/PVnNwj68dHG7sXcML1Vpia4uVY5EJeBXYe11nLelHkNet+sXKzgnjdjWTNoCJSmkvCKYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066291; c=relaxed/simple;
	bh=Ain5nSPiw7lNbJABKbWUNj9bz6NYPkehR1zADRdCQoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HpafWzS/XKEwDFPQBLZxSciVYHwV8ToStB8ZVOYZP3HNrv5zbSyF2aZF5b0kAbifaE8tQgrETdsDkQ7yfpibPBOL7e5ScN2hs2o4u+O/ephve2BwopBO8eNt8RlA6+S5mxQbBRIJT0MtUjWwQPUmdWF+R1OedcL9mcw85z7hpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4p6krJH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4p6krJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721066288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyVNluZIssgAn1o8oMq9PDVu4RkJuOP1nUmOEKmGOcU=;
	b=X4p6krJHPw4PmKJBcgzP6cZwrv3Be7aYOfQGEYFwyeSSauEj3Xd0S4DHrcC8ZSgwNngwjy
	9MnL1R2sntO/kxfozU0a+z/8Bff8deKwKEY4dV971CxmQOexNL8h/afZ6H27hhhZCySuia
	MYcrsXxva7+9w5hjq+YvUkoyrXaw5kk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-IMI7jYx8N7qE_rEE0PkYsg-1; Mon, 15 Jul 2024 13:58:06 -0400
X-MC-Unique: IMI7jYx8N7qE_rEE0PkYsg-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d9da3f8b28so3699214b6e.0
        for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721066286; x=1721671086;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyVNluZIssgAn1o8oMq9PDVu4RkJuOP1nUmOEKmGOcU=;
        b=jQTEwq/qjSayVDMeaTPrlHQlBCS/ZSt/IjB7YccgGGN2//fLYgLv5JcQhC2/nzVxsN
         poL81QLGPRSN7OFgaORrxBmTaY/bW1dTWuEosSd+RAkqiEzh1aogwPKOHzaPcW02ZX88
         f25XmzOijYUKAW6WS7Q8sQRKdM0P+zV5UvndJoOVhA57R1hhy33IzS6dwj7w3p2PjuIw
         UWVDXe3kH6PTC4uK9l4Ak6VrX7NhBcI5KYGm6Q+zbe3CPCwulV1YfaEe/4MQA+ZzId1b
         lN5Qe1P7WOPK1MZcYI8RcV/ucXtPIBnmmcgHmaY6JuP9fp9jkyE6PTLO5tH5MLKmD1/7
         Qekg==
X-Forwarded-Encrypted: i=1; AJvYcCWXDYZIH8K9OmXygj58q6P5tewGOsUlLoNTC2TAfuiPQIZ1n8cNQ8Zlra+/8xhMu7Wb36tsfQ86+VfY/CK3/RH8wbwh
X-Gm-Message-State: AOJu0YyIhhqADqEihoWdy5Grx+fBaVFDp1S5qhcPTxHu92FIFdV5VNGr
	ajxKFKLt3VgMeJzW5hzpn6/RPgGOmBvLAAt2zoVZA/8CbK0LUvutzoEVn/A3JlUFlQfCJatddw8
	PRZIFw6VywWbiVogfHMloj77vEipmxefzqrG9B3nGKG61eihCmQ==
X-Received: by 2002:a05:6808:2225:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3dac632346cmr362254b6e.10.1721066286031;
        Mon, 15 Jul 2024 10:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVCU8MN7DhrLsiuwZc963RljtvATaJVy4fNJFEYXFUGjmBmJoDfzyTAMTP0WdwPNOir3nLCg==
X-Received: by 2002:a05:6808:2225:b0:3d9:3e48:8b13 with SMTP id 5614622812f47-3dac632346cmr362221b6e.10.1721066285770;
        Mon, 15 Jul 2024 10:58:05 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160b908c3sm221471585a.25.2024.07.15.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:58:04 -0700 (PDT)
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
Subject: Re: [RFC PATCH v3 03/10] task_work, sched: Add a _locked variant to
 task_work_cancel()
In-Reply-To: <20240712152021.GR27299@noisy.programming.kicks-ass.net>
References: <20240711130004.2157737-1-vschneid@redhat.com>
 <20240711130004.2157737-4-vschneid@redhat.com>
 <20240712152021.GR27299@noisy.programming.kicks-ass.net>
Date: Mon, 15 Jul 2024 19:57:59 +0200
Message-ID: <xhsmhle221qs8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 12/07/24 17:20, Peter Zijlstra wrote:
> On Thu, Jul 11, 2024 at 02:59:57PM +0200, Valentin Schneider wrote:
>> Later commits will need to issue a task_work_cancel() from within the
>> scheduler with the task's ->pi_lock held.
>> 
>> Add a _locked variant that expects p->pi_lock to be held. Expose it in a
>> separate scheduler header file, as this really is a scheduler-only
>> interface.
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/sched/task_work_sched.h | 14 +++++++
>>  kernel/task_work.c             | 67 ++++++++++++++++++++++++++--------
>>  2 files changed, 66 insertions(+), 15 deletions(-)
>>  create mode 100644 kernel/sched/task_work_sched.h
>> 
>> diff --git a/kernel/sched/task_work_sched.h b/kernel/sched/task_work_sched.h
>> new file mode 100644
>> index 0000000000000..e235da456427f
>> --- /dev/null
>> +++ b/kernel/sched/task_work_sched.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Scheduler internal task_work methods
>> + */
>> +#ifndef _KERNEL_TASK_WORK_SCHED_H
>> +#define _KERNEL_TASK_WORK_SCHED_H
>> +
>> +#include <linux/task_work.h>
>> +#include <linux/sched.h>
>> +
>> +struct callback_head *
>> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func);
>> +
>> +#endif
>
>
> Do we really need that exposed? Can't we squirrel that way in
> kernel/sched/sched.h and forget about it?
>

Nah that's not required, I thought a clean cut header would be neater but
given its single user, tossing that to sched.h looks better.

>> +struct callback_head *
>> +task_work_cancel_locked(struct task_struct *task, task_work_func_t func)
>> +{
>> +	lockdep_assert_held(&task->pi_lock);
>
> I'm thinking that lockde_assert wants to live in your _locked function
> above.
>

Quite so!

