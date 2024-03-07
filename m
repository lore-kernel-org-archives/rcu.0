Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21412C7F4
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817238; cv=none; b=htygXu8FN4JWwD4kqUVaAPEnflfJanKPIvybq/4CgwilGmqXTEGfJSenFM/OG1Iwg3Gv5VCaEWuIAOeTV9V3Cd+UB3U21iMXlR7svCMG0W+9ZFSOy2rHpw8fcKQz/zJP7C9PBrc1AjD81bz++EesueJU8i2e31bl1ediinv5QSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817238; c=relaxed/simple;
	bh=YzWo6bZjVi3+CiuwgtPUGT9CqDw4ctevPsNQfN3qsyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlBo453ZjggAnLuq9XVTu53uND3DD+chavgUSu4SpBt+hHod/9t1SYMDzVTmRlQq+AlW6oH+2zTGo/RgM3uOh742ZG09oRuy4q/CkjrXk6VdQpDm6GsyOyCPi0ET84QZIFh5geoE3zk9fgiVPJ/lodmTO6cM3FCMOwHTPvMyUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Tpc+euUg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Tpc+euUg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42e29149883so3963571cf.2
        for <rcu@vger.kernel.org>; Thu, 07 Mar 2024 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709817236; x=1710422036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1OoTfNZUFTPVlAZ173/fzFLYere8ARWOXdYi1oAk6Q=;
        b=Tpc+euUgupqAg4oc/pm3AYHSq7yd4ESXgym7zQODCB+TmyyaMdzMUrqPR3cOIzO9x0
         Xgs7BnzWmBbxVxCavVfqWHgqPijoFIfGKGDQwNujN29dwu4Wnx+PU0CfSBpgjIoGiA9X
         XQYhvzm2Ko1PqHStHX9+IPCfPk3BdcWtT1zf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817236; x=1710422036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1OoTfNZUFTPVlAZ173/fzFLYere8ARWOXdYi1oAk6Q=;
        b=AQQV3INc7C7i6pTtBliuwTPyWVjMsDwCVbyOs6ZD6ESMlGa9InOJLuJ58CKPb66wL+
         szKTeoZJ3wDwMrPA3sAj8Jnkktd3F2WkMHrgXzbwWzoY5d5AWjYIkPKeRCrHV/YNwg2g
         L+3qBBGyXcajPU26wNr1wC0z4diNEygESKNIaMkA8sRdxUaLh7l/uCDvzhRW+wp6eux3
         fXfoYYIyLYpFryOfrpRXRE4Qx6sSTQJQElPe2ubGKjmo62p91i3wx+NUEWbO5caLQ5Ck
         MB3y7WEDucLn10hDDBghmAiVEDZnkzgipUXe8wMpoEDImyA1Y3/WecpOVsN5SyBiKdWc
         TVgw==
X-Forwarded-Encrypted: i=1; AJvYcCXMjzw74dCRsn8S4ghyPzoc3+8dDn6vz02ecxotOzx/UAZ6QohpT0lZtVpYsPF+dfGXrVk4mt9iUGyBmD8OUXv3O5ir
X-Gm-Message-State: AOJu0YwuHI9lFpCqN3uoHC305JWGpeEcrQdk1I93iJLKkooIT8EuIFwh
	LiDtJqhVeMUW5i39XlFLJKt9omlQkfjEa+3fuhOlrtFdbfFw3ln0HKlFUahHvyQ=
X-Google-Smtp-Source: AGHT+IFyslsj0MWMhAVKZel/6tXgxls+JSfZUVEILC5yMctnngKd7TorXqNZ5qPd+kV12LpakJ93rA==
X-Received: by 2002:a05:622a:19a5:b0:42f:20b3:45af with SMTP id u37-20020a05622a19a500b0042f20b345afmr749262qtc.58.1709817235475;
        Thu, 07 Mar 2024 05:13:55 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id f17-20020a05620a15b100b00788287e3430sm4219771qkk.130.2024.03.07.05.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:13:54 -0800 (PST)
Message-ID: <7d754498-b22e-456c-a58a-c39d6bdba025@joelfernandes.org>
Date: Thu, 7 Mar 2024 08:13:53 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
 Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, Boqun Feng
 <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
 <Zem5pkNiAy-EZdo9@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <Zem5pkNiAy-EZdo9@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/2024 7:57 AM, Uladzislau Rezki wrote:
> On Wed, Mar 06, 2024 at 05:31:31PM -0500, Joel Fernandes wrote:
>>
>>
>> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
>>> Fix a below race by not releasing a wait-head from the
>>> GP-kthread as it can lead for reusing it whereas a worker
>>> can still access it thus execute newly added callbacks too
>>> early.
>>>
>>> CPU 0                              CPU 1
>>> -----                              -----
>>>
>>> // wait_tail == HEAD1
>>> rcu_sr_normal_gp_cleanup() {
>>>     // has passed SR_MAX_USERS_WAKE_FROM_GP
>>>     wait_tail->next = next;
>>>     // done_tail = HEAD1
>>>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>     queue_work() {
>>>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
>>>         __queue_work()
>>>     }
>>> }
>>>
>>>                                set_work_pool_and_clear_pending()
>>>                                rcu_sr_normal_gp_cleanup_work() {
[..]
>>>
>>> Reported-by: Frederic Weisbecker <frederic@kernel.org>
>>> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>> ---
>>>  kernel/rcu/tree.c | 22 ++++++++--------------
>>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>> index 31f3a61f9c38..475647620b12 100644
>>> --- a/kernel/rcu/tree.c
>>> +++ b/kernel/rcu/tree.c
>>> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
>>>  
>>>  	/*
>>> -	 * Process (a) and (d) cases. See an illustration. Apart of
>>> -	 * that it handles the scenario when all clients are done,
>>> -	 * wait-head is released if last. The worker is not kicked.
>>> +	 * Process (a) and (d) cases. See an illustration.
>>>  	 */
>>>  	llist_for_each_safe(rcu, next, wait_tail->next) {
>>> -		if (rcu_sr_is_wait_head(rcu)) {
>>> -			if (!rcu->next) {
>>> -				rcu_sr_put_wait_head(rcu);
>>> -				wait_tail->next = NULL;
>>> -			} else {
>>> -				wait_tail->next = rcu;
>>> -			}
>>> -
>>> +		if (rcu_sr_is_wait_head(rcu))
>>>  			break;
>>> -		}
>>>  
>>>  		rcu_sr_normal_complete(rcu);
>>>  		// It can be last, update a next on this step.
>>> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
>>>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>>>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>>>  
>>> -	if (wait_tail->next)
>>> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>> +	/*
>>> +	 * We schedule a work in order to perform a final processing
>>> +	 * of outstanding users(if still left) and releasing wait-heads
>>> +	 * added by rcu_sr_normal_gp_init() call.
>>> +	 */
>>> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>>>  }
>>
>> Ah, nice. So instead of allocating/freeing in GP thread and freeing in worker,
>> you allocate heads only in GP thread and free them only in worker, thus
>> essentially fixing the UAF that Frederick found.
>>
>> AFAICS, this fixes the issue.
>>
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
> Thank you for the review-by!
> 
>> There might a way to prevent queuing new work as fast-path optimization, incase
>> the CBs per GP will always be < SR_MAX_USERS_WAKE_FROM_GP but I could not find a
>> workqueue API that helps there, and work_busy() has comments saying not to use that.
>>
> This is not really critical but yes, we can think of it.
> 

Thanks, I have a patch that does that. I could not help but write it as soon as
I woke up in the morning, ;-). It passes torture and I will push it for further
review after some more testing.

thanks,

 - Joel
