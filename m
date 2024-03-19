Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399843A1A8
	for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874369; cv=none; b=h70yBc/F3udT4bjBsIVQp1tOUljzoluw9rA9fHh8jqXECOZcvMl8OdhNNQN+hPRG4BuqzpRN9ImZe6Jsm09GUdHd8/jZAY2nNy+JKo02fUvJUZcvzR2VbvbzEXMcuvclCOF0P3PpKrIUQAtSgX4kI7/KndWTvcg4eAuelMUccSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874369; c=relaxed/simple;
	bh=YMcf1Teo8N+R/9ZvYJv0wCzFSJ96kGfhKVa3+RWP2jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUGpdL4Nda0WQ/THnlhO1Tzg3lMCbiwNBdqgFnxOSfh0BLY8T2+7Ik66Vr0mLMC1JhAPQgjkva5TXejZzJAqaOug0U+Xdz3lBhl0qN19OjdTbYzLDcp4zbNZJ2Gk+r9L2Zik5aOgff30iJPF+2DyjFyNih3BnWV1ufV+cxPewzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=NiAdxI3R; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NiAdxI3R"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-430acf667afso27662211cf.1
        for <rcu@vger.kernel.org>; Tue, 19 Mar 2024 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710874367; x=1711479167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XUbhEyXj+LZKWhZV1EwZUqlvpAwRJXLMFfCduNSBoQ=;
        b=NiAdxI3R+3Kkwz524Vw1H+1/F7ch7U9MtS1MtpjhEc9K00KecpRtFOcMtaQRhcKqHm
         XDPin6DbTy5G3GwV/W0K/abG6fY1MsNtlBnXkIWel42FCU4pJFORz0U+9sKs2uPaDP8B
         8AtLetiQ8uH0a4XQ+nQkIfPmAmptKbsX9MoFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710874367; x=1711479167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XUbhEyXj+LZKWhZV1EwZUqlvpAwRJXLMFfCduNSBoQ=;
        b=FIqNFANwjSuaFKoi3PF0vpcS/gjTdHzfUcd47tbuHxOtpJSrFTUF8gwbinSoef1lQc
         FjGt0R8mtPJD+f5TGzpWDX3aVTv0Kgr0L/fCZwP3lumqtUH2GpmmU5aIdpG0RIc0nC/O
         HFXJ51xJz6R3hQ8j9W8Ka0tpmiQef8HCQ4CcgJJvgz2kBO0ppqywMR+eweQRnLpixFNy
         onViAGd/i0RnW0gySeNvV/VvMABwhKc4WeG61fC4zrGZGnA2hnHzdzRI/GCK+T4uMJzS
         YggfazqHd51AQWZCZiGcdh9A1FUtJXWvCOioh5EaEGjpMToHKMQPnpelEzmseo/0cw/t
         n8mA==
X-Forwarded-Encrypted: i=1; AJvYcCXYwPw59kHpQCDBBJSkTJ0MjQr+NH+qbLXKFqCFjv78oZWaresIeF9K2r8pUuLe/yYK5PigkR7E3hXaUZeSwWqy22xm
X-Gm-Message-State: AOJu0YxUdAUx0cJHEmUbfYn4pbP5xxTGHSvQ4kqFQwZhKD3jpjPn1llY
	o/OuLUCdXZf+xo087C/SHcI2yFlY+UTCrg1Nvjq3/KCeQlZhG09mNqcOiwOQ+2I=
X-Google-Smtp-Source: AGHT+IH3roedALtUoDYZYwUKRo1yXZlB7D7+GpCtks4d7ueMNUsFAfMTp37hQ/KjfmjMwDBav4yU9g==
X-Received: by 2002:ac8:5756:0:b0:42e:ef7c:29a2 with SMTP id 22-20020ac85756000000b0042eef7c29a2mr3580446qtx.29.1710874366920;
        Tue, 19 Mar 2024 11:52:46 -0700 (PDT)
Received: from [10.5.0.2] ([185.195.59.198])
        by smtp.gmail.com with ESMTPSA id bq23-20020a05622a1c1700b00430d1c9bfebsm2676718qtb.43.2024.03.19.11.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:52:46 -0700 (PDT)
Message-ID: <1f7821ce-c036-4824-bb22-6d171714babf@joelfernandes.org>
Date: Tue, 19 Mar 2024 14:52:43 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636> <20240319160252.GA186534@joelbox2>
 <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
 <ZfnKv1K85Nkwy7p4@pc638.lan>
 <8f221ab6-6d34-4c3b-a6a7-6c1de405000a@joelfernandes.org>
 <851d8642-807c-481a-91e9-8b744c24913d@joelfernandes.org>
 <Zfnbc83lU6t8nIao@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <Zfnbc83lU6t8nIao@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/19/2024 2:37 PM, Uladzislau Rezki wrote:
> On Tue, Mar 19, 2024 at 01:33:11PM -0400, Joel Fernandes wrote:

>>> On 3/19/2024 1:26 PM, Uladzislau Rezki wrote:

>>>>>>>>>>>> /*
>>>>>>>>>>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
>>>>>>>>>>>> */
>>>>>>>>>>>> static void rcu_sr_normal_gp_cleanup(void)
>>>>>>>>>>>> {
>>>>>>>>>>>> -    struct llist_node *wait_tail, *next, *rcu;
>>>>>>>>>>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
>>>>>>>>>>>>   int done = 0;
>>>>>>>>>>>>
>>>>>>>>>>>>   wait_tail = rcu_state.srs_wait_tail;
>>>>>>>>>>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>>>>>>>>>>           break;
>>>>>>>>>>>>   }
>>>>>>>>>>>>
>>>>>>>>>>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
>>>>>>>>>>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>>>>>>>>>> +    /*
>>>>>>>>>>>> +     * Fast path, no more users to process. Remove the last wait head
>>>>>>>>>>>> +     * if no inflight-workers. If there are in-flight workers, let them
>>>>>>>>>>>> +     * remove the last wait head.
>>>>>>>>>>>> +     */
>>>>>>>>>>>> +    WARN_ON_ONCE(!rcu);
>>>>>>>>>>>>
>>>>>>>>>>> This assumption is not correct. An "rcu" can be NULL in fact.
>>>>>>>>>>
>>>>>>>>>> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
>>>>>>>>>> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
>>>>>>>>>> him to rebase his patch on top of this one.
>>>>>>>>>>
>>>>>>>>>> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
>>>>>>>>>>>
>>>>>>>>> I think we should agree on your patch first otherwise it becomes a bit
>>>>>>>>> messy or go with a Neeraj as first step and then work on youth. So, i
>>>>>>>>> reviewed this patch based on latest Paul's dev branch. I see that Neeraj
>>>>>>>>> needs further work.
>>>>>>>>
>>>>>>>> You are right. So the only change is to drop the warning and those braces. Agreed?
>>>>>>>>
>>>>>>> Let me check a bit. Looks like correct but just in case.
>>>>>>>
>>>>>>
>>>>>> Thanks. I was also considering improving it for the rcu == NULL case, as
>>>>>> below. I will test it more before re-sending.
>>>>>>
>>>>>> On top of my patch:
>>>>>>
>>>>>> ---8<-----------------------
>>>>>>
>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>> index 0df659a878ee..a5ef844835d4 100644
>>>>>> --- a/kernel/rcu/tree.c
>>>>>> +++ b/kernel/rcu/tree.c
>>>>>> @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>>>>                         break;
>>>>>>         }
>>>>>>
>>>>>> +
>>>>>> +       /* Last head stays. No more processing to do. */
>>>>>> +       if (!rcu)
>>>>>> +               return;
>>>>>> +
>>>>>
>>>>> Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
>>>>> in any case, the original patch except the warning should hold.
>>>>> Still, I am testing the above diff now.
>>>>>
>>>>>  - Joel
>>>>>
>>>> Just in case, it is based on your patch:
>>>>
>>>> <snip>
>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>> index bd29fe3c76bf..98546afe7c21 100644
>>>> --- a/kernel/rcu/tree.c
>>>> +++ b/kernel/rcu/tree.c
>>>> @@ -1711,29 +1711,25 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>>  	 * if no inflight-workers. If there are in-flight workers, let them
>>>>  	 * remove the last wait head.
>>>>  	 */
>>>> -	WARN_ON_ONCE(!rcu);
>>>> -	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>>>> -
>>>> -	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
>>>> -		/* Order atomic access with list manipulation. */
>>>> -		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
>>>> +	if (wait_tail->next && rcu_sr_is_wait_head(wait_tail->next) && !wait_tail->next->next &&
>>>> +			!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
>>>
>>>
>>> Yes this also works. But also if wait_tail->next == NULL, then you do not need
>>> to queue worker for that case as well. I sent this as v3.
>>>
>> Sorry, I see you did add that later in the patch ;-). I think we have converged
>> on the final patch then, give or take the use of 'rcu' versus 'wait_tail->next'.
>>
> Just combine all parts into one place and resend :)

Yes sir ;)

 - Joel

