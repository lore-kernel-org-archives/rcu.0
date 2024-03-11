Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB8622
	for <rcu@vger.kernel.org>; Mon, 11 Mar 2024 00:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710118116; cv=none; b=BAGAmndOk2Xiwfv8/CsQkjdKB9F61mH5DFwLl/gq1zUMG0B5fY6d+e6a5bs5vJ6Shc6DzynSLQotaRWeapamJ9GSufV0a1WzkIcRdokgY3Xf+7w2QBpBFCRLwfRNdnyWy+Z02pfKFkmw8+F7/XlG6uqxBdw0QM2MM+blpqdZd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710118116; c=relaxed/simple;
	bh=lLIfQtc2c8Q0jsN1oKwUuOVJDaowV3tD2r4ivl19zSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p03HlYmlc6Ze4BF6XJU9WYiIHTDxx9QhZEbIBQ+nkgzltD8MijYKmov36qhCIiFYViaQHFphJhqqhQouJB6cHT/dIAHxlDlEEFI1CNx6DWTmiYAMCJ6zVTuEQl8oo9iMpsMVQMVNsTEY6XYMtHEPtR1cxQX1EOWmFm6vc43Rx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Bc1+/UMO; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Bc1+/UMO"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a046c5262so20516777b3.2
        for <rcu@vger.kernel.org>; Sun, 10 Mar 2024 17:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710118114; x=1710722914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djbO+fy9ASP5VMlEtgdwtbtLbFo5gKWiP+KGfCbXaaA=;
        b=Bc1+/UMOzS05UdbSZHG1wP5djGvN3U/9nzmhfhr81+txWxF/uD22TaTz70u2q6Br9Z
         zmI7XrVDMIPUhRIBXMvmMV6bJliwYYvDw4+H0y+d05uPn2mOp/HD0nRpZfUpKyn6ZVl8
         dD8L+0qPbprWJGuI5Uh3YClvpYUgduqLxXYEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710118114; x=1710722914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djbO+fy9ASP5VMlEtgdwtbtLbFo5gKWiP+KGfCbXaaA=;
        b=D1LsMkFIJr/5lunjJ93EstCdpctZc7nj6dJmxQtQSKUzcvUAlEl/lGBVKYV6MiUjJH
         mybenZevdO/dl4/QSqTtuOL/4Ha928A7sLu7+InA/kQSSOFDRAM5D+El4OXkwMRcL/Ok
         RkJXZKgbWeVn6oGkbXnPEASZOioOBo1E7SvDjf/RcsuptL813zaex2yzSm8Cc7qbYz0i
         dMfHPGb7MctTVvPVre0nrhtNR4/koyp79xOjEHRRrvB9jhJ5IzG+hJSYUfk26VO5mYLR
         rn+U23/7ITD74NtwsXGvAAKlyIqnyVm0cFlKU8MoVRoBF6sIHsexulshe7cXZNhzhreS
         uZzA==
X-Forwarded-Encrypted: i=1; AJvYcCVztclfTGMl/FImNz9BCaRh3F6ggsBXiJdOcTQdAkcdG1QvgtTXmHVCVoMcivh+Tfahihv7zfvf6qdGZh12iJ9RwKFC
X-Gm-Message-State: AOJu0YwkTdtDd0W6PyNjKSQSySq03gjvwub8KKLd9eZo9VaMYedoLwhX
	pm40helAk51A4UrQbLshySvuUdD8tRhpxa909X98a3NjS8m4UAs7P0xMa95ouiM=
X-Google-Smtp-Source: AGHT+IGl/iuEjGQLjgZEYOu3RPjQ8nLN3jI8BTYdfcFOwfymUb+yIP7KTA9zuBeM1K5grmkD6D8n8Q==
X-Received: by 2002:a25:bc83:0:b0:dcd:24b6:1aee with SMTP id e3-20020a25bc83000000b00dcd24b61aeemr2598507ybk.47.1710118113354;
        Sun, 10 Mar 2024 17:48:33 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id j20-20020a05622a039400b0042f376886d2sm2066517qtx.36.2024.03.10.17.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 17:48:32 -0700 (PDT)
Message-ID: <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
Date: Sun, 10 Mar 2024 20:48:28 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, rcu@vger.kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/2024 2:56 PM, Paul E. McKenney wrote:
> On Sun, Mar 10, 2024 at 06:03:30AM -0400, Joel Fernandes wrote:
>> Hello Ankur and Paul,
>>
>> On Mon, Feb 12, 2024 at 09:55:39PM -0800, Ankur Arora wrote:
>>> With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>>> states for read-side critical sections via rcu_all_qs().
>>> One reason why this was necessary: lacking preempt-count, the tick
>>> handler has no way of knowing whether it is executing in a read-side
>>> critical section or not.
>>>
>>> With PREEMPT_AUTO=y, there can be configurations with (PREEMPT_COUNT=y,
>>> PREEMPT_RCU=n). This means that cond_resched() is a stub which does
>>> not provide for quiescent states via rcu_all_qs().
>>>
>>> So, use the availability of preempt_count() to report quiescent states
>>> in rcu_flavor_sched_clock_irq().
>>>
>>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> ---
>>>  kernel/rcu/tree_plugin.h | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>>> index 26c79246873a..9b72e9d2b6fe 100644
>>> --- a/kernel/rcu/tree_plugin.h
>>> +++ b/kernel/rcu/tree_plugin.h
>>> @@ -963,13 +963,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>>   */
>>>  static void rcu_flavor_sched_clock_irq(int user)
>>>  {
>>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>>> +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
>>> +	     !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
>>
>> I was wondering if it makes sense to even support !PREEMPT_RCU under
>> CONFIG_PREEMPT_AUTO.
>>
>> AFAIU, this CONFIG_PREEMPT_AUTO series preempts the kernel on
>> the next tick boundary in the worst case, with all preempt modes including
>> the preempt=none mode.
>>
>> Considering this, does it makes sense for RCU to be non-preemptible in
>> CONFIG_PREEMPT_AUTO=y? Because if that were the case, and a read-side critical
>> section extended beyond the tick, then it prevents the PREEMPT_AUTO preemption
>> from happening, because rcu_read_lock() would preempt_disable().
> 
> Yes, it does make sense for RCU to be non-preemptible in kernels
> built with CONFIG_PREEMPT_AUTO=y and either CONFIG_PREEMPT_NONE=y or
> CONFIG_PREEMPT_VOLUNTARY=y.
> As noted in earlier discussions, there are

Sorry if I missed a discussion, appreciate a link.

> systems that are adequately but not abundantly endowed with memory.
> Such systems need non-preemptible RCU to avoid preempted-reader OOMs.

Then why don't such systems have a problem with CONFIG_PREEMPT_DYNAMIC=y and
preempt=none mode? CONFIG_PREEMPT_DYNAMIC forces CONFIG_PREEMPT_RCU=y. There's
no way to set CONFIG_PREEMPT_RCU=n with CONFIG_PREEMPT_DYNAMIC=y and
preempt=none boot parameter.  IMHO, if this feature is inconsistent with
CONFIG_PREEMPT_DYNAMIC, that makes it super confusing.  In fact, I feel
CONFIG_PREEMPT_AUTO should instead just be another "preempt=auto" boot parameter
mode added to CONFIG_PREEMPT_DYNAMIC feature, otherwise the proliferation of
CONFIG_PREEMPT config options is getting a bit insane. And likely going to be
burden to the users configuring the PREEMPT Kconfig option IMHO.

> Note well that non-preemptible RCU explicitly disables preemption across
> all RCU readers.

Yes, I mentioned this 'disabling preemption' aspect in my last email. My point
being, unlike CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_AUTO allows for kernel
preemption in preempt=none. So the "Don't preempt the kernel" behavior has
changed. That is, preempt=none under CONFIG_PREEMPT_AUTO is different from
CONFIG_PREEMPT_NONE=y already. Here we *are* preempting. And RCU is getting on
the way. It is like saying, you want an option for CONFIG_PREEMPT_RCU to be set
to =n for CONFIG_PREEMPT=y kernels, sighting users who want a fully-preemptible
kernel but are worried about reader preemptions.

That aside, as such, I do agree your point of view, that preemptible readers
presents a problem to folks using preempt=none in this series and we could
decide to keep CONFIG_PREEMPT_RCU optional for whoever wants it that way. I was
just saying that I want CONFIG_PREEMPT_AUTO's preempt=none mode to be somewhat
consistent with CONFIG_PREEMPT_DYNAMIC's preempt=none. Because I'm pretty sure a
week from now, no one will likely be able to tell the difference ;-). So IMHO
either CONFIG_PREEMPT_DYNAMIC should be changed to make CONFIG_PREEMPT_RCU
optional, or this series should be altered to force CONFIG_PREEMPT_RCU=y.

Let me know if I missed something.

Thanks!

 - Joel
