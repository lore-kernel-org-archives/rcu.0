Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761281E890
	for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138668; cv=none; b=qZ4Mks2OxU/fnYzz6CUdoSvW85whaaD1dLSIHYZb6ggA3YDmtvVFwHwr/ZKKWNvv7mO8PtYqcFkBjN9D5EgbyhmamqkvInRfIO1jEXARMApm/LhTK1lBB1gqCAfmMU6Gu9plTcndXYlu6D5pBrMds9Ma3O7iNOlDJJicixdV5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138668; c=relaxed/simple;
	bh=KJlhzIPR/vjW9vKySj9E3Vpnv5RoXvud7GTILjlLqx8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMqzgpwgcADzMVvrzUcTBlJPbCU5SGQxKtfYzZRJVn7trgQJUzGVmxuefMsE8j8kMIhCJsPdPJY+wN6hnenRmaWazzpdbycy/WIQfjej+R/bdcR3O1U9JgO+Kr5kCqz7vooUO7f3Fw49OltA7Ebkufm9hQQ0bVAAqWVzvzEkNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=yClr7yzr; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yClr7yzr"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c79664c71fso34330939f.0
        for <rcu@vger.kernel.org>; Wed, 28 Feb 2024 08:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709138664; x=1709743464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4XRPdwxUwqws5YY4VvPNG/LxgQfuluLcLEsy4IUoCQ=;
        b=yClr7yzrDC/SWzZyqDUnt3982p6KQZDRIsPI6bZTF/geYXuK4fIGinTnJ8z9IHVMDT
         7ZRwm1Qa1Yy85NtRLSSQ2Ckug0Tm7zfk29oWofuPR4oTwMsTl5t4pgzLS+auIrjcXlIW
         Z4fZyTquIOuTkQGpKKAbPShN9H8kJS+KPoFhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138664; x=1709743464;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4XRPdwxUwqws5YY4VvPNG/LxgQfuluLcLEsy4IUoCQ=;
        b=aEW/0oaD9P2A7hs2pfhsVzrNTqI1DTxL76ed6go2s3fTtc1miB2SnEaAKJGZ07gjUF
         6pYES92muClnb2ql5c2NoRWaYw+pVnvXUMKsqRXJkY+utXdgR4yjHzp4XflOsqe1Z3wd
         jt4h7xMFXgpy/B4274HSJ1HhD0FjpmYYOe69RbwjvuWlDDF+Btoqi1GYn+tt1ZzibooB
         MLMetV5LrG0UbB9HCGgti4oLDrhxDjTkJUA9ETweiMBnn2u4BiEOHbFTPbtiwO8kb5mo
         bnr1mh23YUCYWkLY2ZDkXbRG/h0DToHmbFNRH0FsVvwbTUIbNHQ7PE6oMZ/m1FbBlRJJ
         3qyg==
X-Gm-Message-State: AOJu0Yxam3vlnSv4VjVQez+eXtmEwqm0u+u7qnaEJrNLL8oEK+0+jUL6
	KiMdYtP6NzfmmCfVfLJ0SJbnvekdmJXDrcUAqaA54H6oc2aFYBQYIPDEOWsuHBE=
X-Google-Smtp-Source: AGHT+IEHOs4CxadxUk+QzF5PCarTAbEfy0WGLF1fUV8BDOqm/9M4WKn9+kuDXDQZhcNvB2495wtSKg==
X-Received: by 2002:a5e:8345:0:b0:7c7:f993:8c55 with SMTP id y5-20020a5e8345000000b007c7f9938c55mr4747iom.2.1709138663699;
        Wed, 28 Feb 2024 08:44:23 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b00474b2c54cf7sm156322jab.174.2024.02.28.08.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:44:23 -0800 (PST)
Message-ID: <44dce4fb-6198-4ca3-9535-566655fa8e35@joelfernandes.org>
Date: Wed, 28 Feb 2024 11:44:19 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
 Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <572f9069-f79f-4432-b2ac-7f963a526c0b@joelfernandes.org>
In-Reply-To: <572f9069-f79f-4432-b2ac-7f963a526c0b@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/2024 9:32 AM, Joel Fernandes wrote:
> 
> 
> On 2/20/2024 1:31 PM, Uladzislau Rezki (Sony) wrote:
[...]
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index c8980d76f402..1328da63c3cd 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -75,6 +75,7 @@
>>  #define MODULE_PARAM_PREFIX "rcutree."
>>  
>>  /* Data structures. */
>> +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *);
>>  
>>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
>>  	.gpwrap = true,
>> @@ -93,6 +94,8 @@ static struct rcu_state rcu_state = {
>>  	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>>  	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
>> +	.srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>> +		rcu_sr_normal_gp_cleanup_work),
>>  };
>>  
>>  /* Dump rcu_node combining tree at boot to verify correct setup. */
>> @@ -1422,6 +1425,282 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
>>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>>  }
> [..]
>> +static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
>> +{
>> +	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
>> +}
>> +
> 
> I'm a bit concerned from a memory order PoV about this llist_add() happening
> possibly on a different CPU than the GP thread, and different than the kworker
> thread. Basically we can have 3 CPUs simultaneously modifying and reading the
> list, but only 2 CPUs have the acq-rel pair AFAICS.
> 
> Consider the following situation:
> 
> synchronize_rcu() user
> ----------------------
> llist_add the user U - update srs_next list
> 
> rcu_gp_init() and rcu_gp_cleanup (SAME THREAD)
> --------------------
> insert dummy node in front of U, call it S
> update wait_tail to U
> 
> and then cleanup:
> read wait_tail to W
> set wait_tail to NULL
> set done_tail to W (RELEASE) -- this release ensures U and S are seen by worker.
> 
> workqueue handler
> -----------------
> read done_tail (ACQUIRE)
> disconnect rest of list -- disconnected list guaranteed to have U and S,
>                            if done_tail read was W.
> ---------------------------------
> 
> So llist_add() does this (assume new_first and new_last are same):
> 
> 	struct llist_node *first = READ_ONCE(head->first);
> 
> 	do {
> 		new_last->next = first;
> 	} while (!try_cmpxchg(&head->first, &first, new_first));
> 
> 	return !first;
> ---
> 
> It reads head->first, then writes the new_last->next (call it new_first->next)
> to the old first, then sets head->first to the new_first if head->first did not
> change in the meanwhile.
> 
> The problem I guess happens if the update the head->first is seen *after* the
> update to the new_first->next.
> 
> This potentially means a corrupted list is seen in the workqueue handler..
> because the "U" node is not yet seen pointing to the rest of the list
> (previously added nodes), but is already seen the head of the list.
> 
> I am not sure if this can happen, but AFAIK try_cmpxchg() doesn't imply ordering
> per-se. Maybe that try_cmpxchg() should be a try_cmpxchg_release() in llist_add() ?

Everyone in the internal RCU crew corrected me offline that try_cmpxchg() has
full ordering if the cmpxchg succeeded.

So I don't think the issue I mentioned can occur, So we can park this.

Thanks!

 - Joel

