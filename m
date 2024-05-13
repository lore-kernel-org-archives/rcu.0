Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571863F9D2
	for <rcu@vger.kernel.org>; Mon, 13 May 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625592; cv=none; b=IR1KyOEqC8cTyfFSDjNNUOIp0B9+SXl0agC6tl7l3AlPzlvFiH1NzyM/O7bmwKQU2aMux9wtMP0vBPkHzR7G0rHoPVpzz/DY2oftAO9UadQ8OtX84kb/8lxjkO/ZhjOptf+i5hl/gy7t06yjdntsqpacnf67hhw/mot0ZnyKEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625592; c=relaxed/simple;
	bh=xsBW6MWthCeMuKhQVIGjp+aKg6ru1dCsE+J0TLAoA7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOJrKEEkt66McImgre8xLZ7ctAkdaRssB1Ri5M8mx4WpgS2wUoAUYZavM3cXX+Gvn2Vu6ImFQVT7IBLCYBSZsD3JX+Sve6nnhUHoWSOnEO07/KDjkTMIPCAChyRdojettv8Pfbp7m506kaGAqSozWOta1lcopoWqbLWOsLgs54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G43fEEbv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G43fEEbv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715625589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6lTs1D/Y5uzcHCcJ+UVapV8GTT8OimTrPdbM6ZTs5I=;
	b=G43fEEbvUSHwetdWumZeBaYyYH3OMKSSeEGyXKe2zaONdENqr3Fi4pjhCdDVHSQ4fo18XT
	OGVtXrUFRU220F+llKhAKrfaxczWlTTrbph6tHzdT2mIlSOwBLMNR/qnHWZC16JwUnBzNH
	d9/WoXmJhUycdkiNVXBAtrKUpDl67l8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-TQ_erVkFOTelgBfcJ99cVA-1; Mon, 13 May 2024 14:39:38 -0400
X-MC-Unique: TQ_erVkFOTelgBfcJ99cVA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c9987974a6so2866196b6e.3
        for <rcu@vger.kernel.org>; Mon, 13 May 2024 11:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715625576; x=1716230376;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6lTs1D/Y5uzcHCcJ+UVapV8GTT8OimTrPdbM6ZTs5I=;
        b=lA/j+tFS4+v6QYQR7OcFhm7U6iLDzAe0VXmCs6BVCJ1oslDaKRinQ9zplRGeCF3abi
         L1j6UaXHd77eYGRGa3j9H84SjDXpDjrbCNLJjQIVP/WWsaUQNWc5aF0BQULwRu3wfvdC
         LLS0pcGjGJayBKsEZqbhhJo7taDKArPSlhlfEfTeZQQyd9df1VPoUmkKwRHU4SrGMePD
         xTmBpDCioOEIBtfY0Y70tXxS1QuDd+IcDNexkcnxa/KyMXDJCWGHmZpAA3sfV6vzKQV8
         vdBtNC90u5DH6J0WSl5cnvARgiadBvCeRg9sOLQe+oNz0n2qTt1ft9n4SWq+/sWgbDss
         zgmA==
X-Gm-Message-State: AOJu0YzZP5CQYHv2P9KtrHo+fRfiVo0vheulREClKrCkzJIM7N7gN3+5
	BuYQg21k9yAwsFGc6jJQrQZag1ITXoXhQQY5FzACzRKvry+m2fapagvAGT3nXSFXNqT7wb4wWCw
	OMaAkTjd7pDrWaEEHzeb5NmbDDYJyk1Fleylk9PCm1eFQEGBToUSpyaYSzw==
X-Received: by 2002:a54:448b:0:b0:3c9:7461:68f2 with SMTP id 5614622812f47-3c9970cace5mr11124753b6e.53.1715625576280;
        Mon, 13 May 2024 11:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMFHbO5Vn85R5kzlO4/shYcLqVf3Z57zncqFm2ZKZwDWdhNvjz2ClMffdoXVyaehar4AHMOQ==
X-Received: by 2002:a54:448b:0:b0:3c9:7461:68f2 with SMTP id 5614622812f47-3c9970cace5mr11124740b6e.53.1715625575949;
        Mon, 13 May 2024 11:39:35 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f179aa6sm45806106d6.9.2024.05.13.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:39:34 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, "Paul E. McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 13/27] context_tracking, rcu: Rename
 rcu_dynticks_task*() into rcu_task*()
In-Reply-To: <ZjuOp78k9E0el_Rn@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-14-vschneid@redhat.com>
 <ZjuOp78k9E0el_Rn@localhost.localdomain>
Date: Mon, 13 May 2024 20:39:31 +0200
Message-ID: <xhsmhv83hh7z0.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/24 16:39, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:17AM +0200, Valentin Schneider a =C3=A9crit=
 :
>> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
>> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
>> meaning.
>>
>> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  kernel/context_tracking.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
>> index 647939b0befd9..9c8f7b9191cd4 100644
>> --- a/kernel/context_tracking.c
>> +++ b/kernel/context_tracking.c
>> @@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(context_tracking);
>>  #define TPS(x)  tracepoint_string(x)
>>
>>  /* Record the current task on dyntick-idle entry. */
>> -static __always_inline void rcu_dynticks_task_enter(void)
>> +static __always_inline void rcu_task_enter(void)
>
> On a second thought, this should be the reverse. We are not
> telling anymore that we are entering dynticks mode from an
> RCU-task perspective. We are telling that we are exiting RCU-tasks
> because we are in eqs mode (even though this is mostly a concern
> for nohz_full here, as idle tasks are entirely quiescent states
> but anyway...).
>
> So this should be s/rcu_dynticks_task_enter/rcu_task_exit
>

That definitely makes more sense, thanks!

>>  {
>>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>>      WRITE_ONCE(current->rcu_tasks_idle_cpu, smp_processor_id());
>> @@ -47,7 +47,7 @@ static __always_inline void rcu_dynticks_task_enter(vo=
id)
>>  }
>>
>>  /* Record no current task on dyntick-idle exit. */
>> -static __always_inline void rcu_dynticks_task_exit(void)
>> +static __always_inline void rcu_task_exit(void)
>
> And s/rcu_dynticks_task_exit/rcu_task_enter
>
>>  {
>>  #if defined(CONFIG_TASKS_RCU) && defined(CONFIG_NO_HZ_FULL)
>>      WRITE_ONCE(current->rcu_tasks_idle_cpu, -1);
>> @@ -55,7 +55,7 @@ static __always_inline void rcu_dynticks_task_exit(voi=
d)
>>  }
>>
>>  /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
>> -static __always_inline void rcu_dynticks_task_trace_enter(void)
>> +static __always_inline void rcu_task_trace_enter(void)
>
> The same reverse naming goes for task_trace (even though I can't make
> sense right now of what the barrier it implies orders exactly, but that's
> another story)

Ack.

>
>>  {
>>  #ifdef CONFIG_TASKS_TRACE_RCU
>>      if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
>> @@ -64,7 +64,7 @@ static __always_inline void rcu_dynticks_task_trace_en=
ter(void)
>>  }
>>
>>  /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
>> -static __always_inline void rcu_dynticks_task_trace_exit(void)
>> +static __always_inline void rcu_task_trace_exit(void)
>>  {
>>  #ifdef CONFIG_TASKS_TRACE_RCU
>>      if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
>> @@ -87,7 +87,7 @@ static noinstr void ct_kernel_exit_state(int offset)
>>       * critical sections, and we also must force ordering with the
>>       * next idle sojourn.
>>       */
>> -	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
>> +	rcu_task_trace_enter();  // Before ->dynticks update!
>
> s/->dynticks/->state
>
>>      seq =3D ct_state_inc(offset);
>>      // RCU is no longer watching.  Better be in extended quiescent stat=
e!
>>      WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATC=
HING));
>> @@ -109,7 +109,7 @@ static noinstr void ct_kernel_enter_state(int offset)
>>       */
>>      seq =3D ct_state_inc(offset);
>>      // RCU is now watching.  Better not be in an extended quiescent sta=
te!
>> -	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
>> +	rcu_task_trace_exit();  // After ->dynticks update!
>
> ditto

I've got these fixed in 25/27, but I can fold it down into the patches that
touch the related areas.

>
> Thanks!

