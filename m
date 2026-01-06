Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1704340D92
	for <rcu@vger.kernel.org>; Tue,  6 Jan 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712137; cv=none; b=oZYaBk24ej6RxvRkCKBVRBzT24DkXVpfZ/+7FGqedELazsvIB5GuuFcV2gj1Dnlp/xlfW0ExDLNNypfE3FGHnS44yMm9X5lWeziWwOJTyK8f2Z6DGp+OnWu3udvyHvrRbnDg8Xdh21B90/qwIZKEIwnSdYLef1sEMfDxckGU7IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712137; c=relaxed/simple;
	bh=bQ7PerAuumNq1cYt6dYXzmQmSQmB8lD+lq8loKUkXPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpfYWeq9RCHBSqc4//IJsr2UxZycQiFg7ujMod+ggO5BVxa+eYGdEDX3ZF2vSru4LdHN7FPgee0SZa6Rh1qUt7UFc8W1l7UcdNA7AZLZslYadpTdM/tbwJp0k48s+uv664eAORtjYtT1dZM4NzpO+zJ7Zc/wGb0Xn21+ldynDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=oNVlxYGd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oNVlxYGd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b1e54aefc5so83687885a.1
        for <rcu@vger.kernel.org>; Tue, 06 Jan 2026 07:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767712133; x=1768316933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WEWMJLerlQ3gz/pd09BaonTBmRINa+XgbCZWTwhJG20=;
        b=oNVlxYGdyhpdLP+Kr0o4xXS7WGF0F5lMoBPssfyMxLXbg2Ao75YGJSBeL7HAKqbc7N
         uShI4H89mZRLvyXIK76DvMkpgw3pZOiCk/bSujw5uKYpUZn5RecIllawiueaaPKWPwjb
         2J4IbcqsSjf/GH6PoOcNokNAXL4GdSFxuPATU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712133; x=1768316933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEWMJLerlQ3gz/pd09BaonTBmRINa+XgbCZWTwhJG20=;
        b=HMWyLm2e/W8/d8Rvw1sAJ8xMv+sJtTZR39LsfPJXIi88BdDtBraUlNaoRRSWiHjV1G
         pYMwVLfTun6p0yqVD74fMOi/df/hRvRR9O723gpmcTEsJvSVXH/WMn6CXEgggPBKXjRp
         4o+0Kf8BDdNIUtZR6W5d83EIZgti12N2ubpugMRwvKrJDVI35FAOdrja+CPneNci/ZVt
         gcYH3boxSXqaZ0GrlSBF0sxEe2Ik0Y48Rpw+ery2tnCiVQaytxgUYA+2O8DBETE0VmJU
         fAoFyhp5LwFjQg54YXFC9Vc9FP34ZhjZ9ZxXxjBBzmNYzs8QpsHt4oJ/2oOVsGWabvfj
         VksQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfW61bLRWuxFBEIxOU8hUSwIdgk5bCOn6XER7YUFfD6mQGV53w8VcXRRwLhTTO2r+aXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZSHFjnzLHF71zA76RwQNXbC3H/HnTyIEF+zXTexE4nmSoakV
	UBEJ6aiP4J4SV+0bgQoN+8qO9YI/QUa0c54DBqXmNB94OaIM8vG3qzbYfyY77Mq7c6I=
X-Gm-Gg: AY/fxX4Iz9FqC90w4l8396sv2R6e7+RnI1YAiEn/L+wAgac8MzhSd3/GzbNkbR59st4
	V0oYkPzeDIZlzRE/VcnJGpqtwpzxiSokKze9JC61sBPkVCaaoQzQtwz048OPjzOyNEmz+lOQhQf
	2cfJWKVWfAi6qiVgKGEvniYYWFN9wjRNQi+Fp0tuZaBkMh1Ds8V6aDy2fj4Mhh8WnR+WzMc9YjP
	BCOrkmp28eg8vpFU+5LBepfxbbOoFMNrR8x1wXJlK7a5MHPXPtbfnhwT44A1LIKZjOTzngkBnJI
	mPbxQbkdlroW9FFp0uiaqoxeisAcFq6CGTI9sTaZ8fMYBMbZIIBlaPto+SN5Qvr62E37b9J7hV/
	IIt06tKbllD6RmEb1nRwxY3qveOzizoBvu01LVycsy5BS2/0kn/z3wVZsTNcm6CuV80HLcc4hhn
	V05MS+C6cuUbs0eSCQfZzgtB13Sw==
X-Google-Smtp-Source: AGHT+IG6VC9jnBCAl5Swnro55Pv+Hq6OeFbeU4hwv/+W3mm9xEWDeR8Cc8sbrG9MlJyORRrtZQcHAg==
X-Received: by 2002:ac8:7f54:0:b0:4ee:739:149 with SMTP id d75a77b69052e-4ffa77a8585mr47629461cf.46.1767712133477;
        Tue, 06 Jan 2026 07:08:53 -0800 (PST)
Received: from [192.168.0.99] ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm12745761cf.3.2026.01.06.07.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 07:08:52 -0800 (PST)
Message-ID: <936afbad-226f-4209-b347-c87b30b4a7f3@joelfernandes.org>
Date: Tue, 6 Jan 2026 10:08:51 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/14] rcu: Reduce rnp->lock contention with per-CPU
 blocked task lists
To: Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
 <658b114e-b362-47e1-9dc8-9271cbcf2c4d@paulmck-laptop>
 <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
Content-Language: en-US
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <f679698b-3fc3-4bcc-834a-97c670e6ffe1@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/5/2026 7:55 PM, Joel Fernandes wrote:
>> Also if so, would the following rather simpler patch do the same trick,
>> if accompanied by CONFIG_RCU_FANOUT_LEAF=1?
>>
>> ------------------------------------------------------------------------
>>
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index 6a319e2926589..04dbee983b37d 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -198,9 +198,9 @@ config RCU_FANOUT
>>  
>>  config RCU_FANOUT_LEAF
>>  	int "Tree-based hierarchical RCU leaf-level fanout value"
>> -	range 2 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>> -	range 2 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>> -	range 2 3 if RCU_STRICT_GRACE_PERIOD
>> +	range 1 64 if 64BIT && !RCU_STRICT_GRACE_PERIOD
>> +	range 1 32 if !64BIT && !RCU_STRICT_GRACE_PERIOD
>> +	range 1 3 if RCU_STRICT_GRACE_PERIOD
>>  	depends on TREE_RCU && RCU_EXPERT>  	default 16 if !RCU_STRICT_GRACE_PERIOD
>>  	default 2 if RCU_STRICT_GRACE_PERIOD
>>
>> ------------------------------------------------------------------------
>>
>> This passes a quick 20-minute rcutorture smoke test.  Does it provide
>> similar performance benefits?
>
> I tried this out, and it also brings down the contention and solves the problem
> I saw (in testing so far).
> 
> Would this work also if the test had grace periods init/cleanup racing with
> preempted RCU read-side critical sections? I'm doing longer tests now to see how
> this performs under GP-stress, versus my solution. I am also seeing that with
> just the node lists, not per-cpu list, I see a dramatic throughput drop after
> some amount of time, but I can't explain it. And I do not see this with the
> per-cpu list solution (I'm currently testing if I see the same throughput drop
> with the fan-out solution you proposed).
> 
> I'm also wondering whether relying on the user to set FANOUT_LEAF to 1 is
> reasonable, considering this is not a default. Are you suggesting defaulting to
> this for small systems? If not, then I guess the optimization will not be
> enabled by default. Eventually, with this patch set, if we are moving forward
> with this approach, I will remove the config option for per-CPU block list
> altogether so that it is enabled by default. That's kind of my plan if we agreed
> on this, but it is just an RFC stage 🙂.

So the fanout solution works great when there are grace periods in progress. I
see no throughput drop, and consistent performance with read site critical
sections. However, if we switch to having no grace periods continuously
happening in progress, I can see the throughput dropping quite a bit here
(-30%). I can't explain that, but I do not see that issue with per-CPU lists.

With the per-cpu list scheme, blocking does not involve the node at all, as long
as there is no grace period in progress. So, in that sense, per-CPU blocked list
is completely detached from RCU - it is a bit like lazy RCU in the sense instead
of a callback, it is the blocking task in a per-cpu list, relieving RCU of the
burden.

Maybe the extra layer of the node tree (with fanout == 1) somehow adds
unnecessary overhead that does not exist with Per CPU lists? Even though there
is this throughput drop, it still does better than baseline with a common RCU node.

Based on this, I would say per-cpu blocked list is still worth doing. Thoughts?

 - Joel


