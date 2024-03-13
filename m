Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E54481CD
	for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346426; cv=none; b=HWRazWmvLum6EeI3ZvJzHieD/XnAHyNxeQWzaw4bjX9hM+y9FY2btWNSw4ngph2H/QouLJho12BsyrAL/CS0tAPXdP5sMdDwg1nyPQIBF35krsqurddOGwFyW7a0gRZcalO5OpeJzk50jakydqNf9eWbGQQXqV+LlDGh2Hnidqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346426; c=relaxed/simple;
	bh=jJmIDaRn0Or9FghTpyzKhcD4M+MhdevWRGCsllzE61c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GInfaT+eJkKaa+gpYk8OnQwXNEhyQ3OpuzURokQ+0Y06vcKiVQlkwXEE2SOGOmVpJGTzdm0cSa4d8x9+tvjWuQdIcHETXmmtedOdO/+nyJufLV/vcuXiMo0llmwQvmqvIGekHUQf2KSXo1d180jTmXop2Djz7iGtpGFBrcUZvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=QzkDn3XF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QzkDn3XF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42ef1822b07so32966871cf.0
        for <rcu@vger.kernel.org>; Wed, 13 Mar 2024 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710346423; x=1710951223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwnqsAsnQJNzhhnd2M+aClTGEWIUxWCyEYQGJKC7krI=;
        b=QzkDn3XFZGX7d3nymNQggGPjB0+vntqH+HKS+iFcp2x+zd6gGFutBXEsB5x6W/pLAt
         jDsQeTIT6qoUi/Hhm5Jak/8HBMjmMBD6is+qLv2jO2MDEJyNIbUB77bmoxdAFTC1MLKK
         5jxhKBJKqaXyeQEKzLwRdo26KdwL1BV4at/Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710346423; x=1710951223;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwnqsAsnQJNzhhnd2M+aClTGEWIUxWCyEYQGJKC7krI=;
        b=Ht4qyTDAb21VKW5+8yKsro2Dywef3nBw+8CSUP4bzYkkPs307mbTQP1uIJ2HtmhX48
         jCgLwH5cq94XNi8KXsDT0lKsuEov4GQk2ZM5A3tzCnDj/3+BERf9RUuefHGlosWx3fNK
         PqBXKeh1dXYNHEX1Aac2GAXHhnZjssTk9AFF+UWkv0S7yMFgUj3FZuBlD5+nuSVlDAZP
         Xx9VpF/fStolgH19gT9X4cQ0pXiyRgGEU8W4hf00LUNTb0Djl4Po/FaUc9SbkFxRwH0k
         B63oVNaF4/v4Fj5rgNdOozsboJEU8sLDbqbt2ydabiq/I6YfzYUJQusBeG2o51tO1jZC
         IqWg==
X-Gm-Message-State: AOJu0Yxp4f0QeoDBnfdKxD7ZDtqAoDQ/K+ES9aMGBjxcrgmDMiDGyBWf
	ATxCO08ktDRE0OZibkhSbbW/ws1aIckzTp+nZ/y6sFnJMH/scGXgpCRL0B5taz4=
X-Google-Smtp-Source: AGHT+IEY6/HmkBbqn362cKxy6DI9FBqSw7ub1Sy4XbHuWdwiNfSrq/GjzUBDWl1O+OaPEf3Xoytscg==
X-Received: by 2002:a05:622a:295:b0:42e:f7cf:ff84 with SMTP id z21-20020a05622a029500b0042ef7cfff84mr17072690qtw.52.1710346423215;
        Wed, 13 Mar 2024 09:13:43 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id u25-20020ac87519000000b0042ec8412342sm4954841qtq.80.2024.03.13.09.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 09:13:42 -0700 (PDT)
Message-ID: <06e83751-3aef-4c7d-b4d4-e10e7da6d50a@joelfernandes.org>
Date: Wed, 13 Mar 2024 12:13:40 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Reduce synchronize_rcu() delays when all wait heads
 are in use
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paulmck@kernel.org,
 frederic@kernel.org, josh@joshtriplett.org, boqun.feng@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org
References: <20240313083228.233247-1-Neeraj.Upadhyay@amd.com>
 <aa221e99-bf08-4d36-aef1-07ffc5e71516@joelfernandes.org>
 <6c1ac571-b758-4168-a992-3704c60dba61@amd.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <6c1ac571-b758-4168-a992-3704c60dba61@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/13/2024 12:04 PM, Neeraj Upadhyay wrote:
> Hi Joel,
> 
> On 3/13/2024 8:10 PM, Joel Fernandes wrote:
>> Hi Neeraj,
>>
>> On 3/13/2024 4:32 AM, Neeraj Upadhyay wrote:
>>> When all wait heads are in use, which can happen when
>>> rcu_sr_normal_gp_cleanup_work()'s callback processing
>>> is slow, any new synchronize_rcu() user's rcu_synchronize
>>> node's processing is deferred to future GP periods. This
>>> can result in long list of synchronize_rcu() invocations
>>> waiting for full grace period processing, which can delay
>>> freeing of memory. Mitigate this problem by using first
>>> node in the list as wait tail when all wait heads are in use.
>>> While methods to speed up callback processing would be needed
>>> to recover from this situation, allowing new nodes to complete
>>> their grace period can help prevent delays due to a fixed
>>> number of wait head nodes.
>>>
>>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
>>> ---
>>>  kernel/rcu/tree.c | 27 +++++++++++++--------------
>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 9fbb5ab57c84..bdccce1ed62f 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1470,14 +1470,11 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>>   * for this new grace period. Given that there are a fixed
>>>   * number of wait nodes, if all wait nodes are in use
>>>   * (which can happen when kworker callback processing
>>> - * is delayed) and additional grace period is requested.
>>> - * This means, a system is slow in processing callbacks.
>>> - *
>>> - * TODO: If a slow processing is detected, a first node
>>> - * in the llist should be used as a wait-tail for this
>>> - * grace period, therefore users which should wait due
>>> - * to a slow process are handled by _this_ grace period
>>> - * and not next.
>>> + * is delayed), first node in the llist is used as wait
>>> + * tail for this grace period. This means, the first node
>>> + * has to go through additional grace periods before it is
>>> + * part of the wait callbacks. This should be ok, as
>>> + * the system is slow in processing callbacks anyway.
>>>   *
>>>   * Below is an illustration of how the done and wait
>>>   * tail pointers move from one set of rcu_synchronize nodes
>>> @@ -1725,15 +1722,17 @@ static bool rcu_sr_normal_gp_init(void)
>>>  		return start_new_poll;
>>>  
>>>  	wait_head = rcu_sr_get_wait_head();
>>> -	if (!wait_head) {
>>> -		// Kick another GP to retry.
>>> +	if (wait_head) {
>>> +		/* Inject a wait-dummy-node. */
>>> +		llist_add(wait_head, &rcu_state.srs_next);
>>> +	} else {
>>> +		// Kick another GP for first node.
>>>  		start_new_poll = true;
>>> -		return start_new_poll;
>>> +		if (first == rcu_state.srs_done_tail)
>>
>> small nit:
>> Does done_tail access here need smp_load_acquire() or READ_ONCE() to match the
>> other users?
>>
> 
> As srs_done_tail is only updated in RCU GP thread context, I think it is not required.
> Please correct me if I am wrong here.

But will KCSAN not scream that its a data race?

thanks,

 - Joel

