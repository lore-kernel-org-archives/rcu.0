Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543381B962
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709790290; cv=none; b=XMNtv7a5Sk8VGKE7TUO/6QcVTb0vwQvBtItLAICfRb0918o6RNDFdRg9iOekdsDx+PrgcJgQybAc2zY5v/BZR5Ox3KAndAj3bVzCIhA7uLnh9mLdBtw3Fp4dpZGROsbKGRaQpwgcvr2sfGN32PhSULpN3OC4klPMzBW8WdGNpIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709790290; c=relaxed/simple;
	bh=rfZKX7mfs7a+UYEYHLCSU28fLQqq430VuLhIefMPzGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fYK/WoVwvXNzQoqqInvtxijnqfj/MhAeVhLVrfW7gjBinkbf2AxLZjntkh6DWSnBWVYwzSHjV5TxwR0zyYcZb2ikg0Wv7zRyuDCHdOSItpRFQ51C+HMylCb8qP7OjRWTWqlnK99zX962O/B/O9/4gJSscmKffLMxG6d1rZMokPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=smecX3B+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="smecX3B+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-788303f317eso29040985a.2
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 21:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709790286; x=1710395086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wMUEBg3aDzZSfvDUQdgnU/Cbl90aZubFUijFam4pZcM=;
        b=smecX3B+FaGbzQxI5LHTna1JE5UNPjFxIMAw3AzQ9qpeUzJQUV0yY9W8CpJi3GZz5T
         oaZXAGg23iTaguvMJ9HqP+EGawXkgfoHAoJiAAaPR1W/ytH/I7Gs9bOGLvEMmx3bQ+JX
         ZazTElVx4vRofdZj9BjEiDYoG4354ZNpIHAJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709790286; x=1710395086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMUEBg3aDzZSfvDUQdgnU/Cbl90aZubFUijFam4pZcM=;
        b=u7jkFTuP88De/jAP0Ui2SOExQkcRKPEgSTrp6R8oPa880pWP0r3YDyofRagSqWB6Dr
         nM7qa5clQQEGBkHFMZOSxiNRPkGAhHs8uYBGl5Td5jyoe8gXlMS0iX4/jT4PJxzX+65/
         J3UQPsochBMf5bNCrSpX26nKtaQfEDXkRbSh5VRUzAOD1szcxao5jEhNSyOfU/xamycj
         /ECXT9cqpYB5qzggaRhxCd2bQmZWc4w3D6p14iPgN4BlKG9C6S4V/4AnbhLzMIoJT557
         2YB2y2DlIO0OAz8KTdx3Qqc64CSYeeFgaFtMtLUD2NdSHP18bbz9Kl7tYQjBe+efOBXc
         g6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf6A1d/2PqPicwOQiMPJ2EHcx/Ggxra/0xIcvj06gnZt/VKXcihPpw38lBkY9A+yUawYYgVegCsGJt+jd0W2G0oJcZ
X-Gm-Message-State: AOJu0Yxg0yKGyqkRCPn1/qBPcyj12CQ9sQwEGg+QWEJurhMhRijP0GwB
	KPc2bJR2CSSkRRnG+3SGcDL7Jjog075rTYm73a/PFvtxNyfGxm/zFqBGu/vwHow=
X-Google-Smtp-Source: AGHT+IHyaGrtgyp0eqgvwKvSbZaKu1BKChgcNJnN7kYQIofPr91KSX1kRZ3GE3ITwkv8hxPjna5+2Q==
X-Received: by 2002:a05:620a:3b8c:b0:788:3187:f33c with SMTP id ye12-20020a05620a3b8c00b007883187f33cmr7007384qkn.13.1709790285961;
        Wed, 06 Mar 2024 21:44:45 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b007881f9c0397sm4931513qkn.60.2024.03.06.21.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 21:44:44 -0800 (PST)
Message-ID: <30b8966b-b31b-41d2-823e-11e60378cfd7@joelfernandes.org>
Date: Thu, 7 Mar 2024 00:44:39 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Content-Language: en-US
To: paulmck@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
 boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
References: <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
 <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/2024 10:37 PM, Paul E. McKenney wrote:
> On Wed, Mar 06, 2024 at 10:06:21PM -0500, Mathieu Desnoyers wrote:
>> On 2024-03-06 21:43, Linus Torvalds wrote:
>> [...]
>>>
>>> Honestly, this all makes me think that we'd be *much* better off
>>> showing the real "handoff" with smp_store_release() and
>>> smp_load_acquire().
>>
>> We've done something similar in liburcu (userspace code) to allow
>> Thread Sanitizer to understand the happens-before relationships
>> within the RCU implementations and lock-free data structures.
>>
>> Moving to load-acquire/store-release (C11 model in our case)
>> allowed us to provide enough happens-before relationship for
>> Thread Sanitizer to understand what is happening under the
>> hood in liburcu and perform relevant race detection of user
>> code.
> 
> Good point!
> 
> In the kernel, though, KCSAN understands the Linux-kernel memory model,
> and so we don't get that sort of false positive.
> 
>> As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
>> is concerned, the only valid use-case I can think of is
>> split counters or RCU implementations where there is a
>> single updater doing the increment, and one or more
>> concurrent reader threads that need to snapshot a
>> consistent value with READ_ONCE().
> 
> It is wrong here.  OK, not wrong from a functional viewpoint, but it
> is at best very confusing.  I am applying patches to fix this.  I will
> push out a new "dev" branch on -rcu that will make this function appear
> as shown below.
> 
> So what would you use that pattern for?
> 
> One possibility is a per-CPU statistical counter in userspace on a
> fastpath, in cases where losing the occasional count is OK.  Then learning
> your CPU (and possibly being immediately migrated to some other CPU),
> READ_ONCE() of the count, increment, and WRITE_ONCE() might (or might not)
> make sense.
> 
> I suppose the same in the kernel if there was a fastpath so extreme you
> could not afford to disable preemption.
> 
> At best, very niche.
> 
> Or am I suffering a failure of imagination yet again?  ;-)
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> static bool
> rcu_torture_pipe_update_one(struct rcu_torture *rp)
> {
> 	int i;
> 	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
> 
> 	if (rtrcp) {
> 		WRITE_ONCE(rp->rtort_chkp, NULL);
> 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
> 	}
> 	i = rp->rtort_pipe_count;
> 	if (i > RCU_TORTURE_PIPE_LEN)
> 		i = RCU_TORTURE_PIPE_LEN;
> 	atomic_inc(&rcu_torture_wcount[i]);
> 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> 	ASSERT_EXCLUSIVE_WRITER(rp->rtort_pipe_count);

I was going to say to add a comment here for the future reader, that update-side
->rtort_pipe_count READ/WRITE are already mutually exclusive, but this ASSERT
already documents it ;-)

Also FWIW I confirmed after starting at code that indeed only one update-side
access is possible at a time! Thanks,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel

