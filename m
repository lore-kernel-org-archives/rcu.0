Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A347AE71
	for <rcu@vger.kernel.org>; Mon,  4 Mar 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583197; cv=none; b=W0p1mheQoEDv18RBt62iwVrksw6U012iyC/kbmxwQeR5MfdEqVmjb0TqyFqKmOuBWzeN6ka+fE3lDGRK0cGDwZ1kwoJ/sz4OzKwe0yiUUjqRIUeWaZTZdUMzlr3ofwd7GkSbmPTR34LarHMWAwK5HQVm1h4PSaBEDQS4Cl5XIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583197; c=relaxed/simple;
	bh=97wLSRavPWpvj3qLgQpbHp3AjLHo4nR/4VmELoC2t0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pjl88tq5U8ylJLwM5W0CSRHIRhcxlZ8tKcBitU+7zMO6+3kdKHFIieTg81Y0r4MSgPDMI5poyRFTwMvRiFaLy1m9KtuP/mbjT5EZNDI5KkMhpuR9gV+CU2QoaNulaETFBx/EsuT4QYm/ZRaLyb6hy0wADBPQ6xPoCf9HJL2sCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=BlgCG/gT; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BlgCG/gT"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1e992f060so1005915b6e.0
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2024 12:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709583194; x=1710187994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I9hBziy42Zp0Bftc0h2FFnVy55qMVWSrsliZ52+smLE=;
        b=BlgCG/gTvqw4iGJbudPTSE3U7tbRR4M+KR/PUIpEiz8y9jlQUGByqfXFSbQqctqTBj
         AWS7daZofN1bxuuFR2wcGIzduf3Sfl9BCCks+rMgQCVhfFuqOo7CkHtK7drgAvIcdzcb
         U1d3xK65FD+IvenvohCapMV+F0e3w8aW7QhJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583194; x=1710187994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9hBziy42Zp0Bftc0h2FFnVy55qMVWSrsliZ52+smLE=;
        b=joqav1mfqjQnqEUmq1B4FuCgafpyIjMDfBUxPsnc3hINnM2I5clc9ZFsLKGinezRek
         gHTQjfTDiGH5+7odpI2WOdt3C/2eehmEPUyJKD8SbBguCgdOOSaA11D4QcCpz/ZBkE5C
         c1Z9xQJozn0fMiJ4cWUBBfNm5XHxOR6wcdbjSl4nYeSu1yySCxK2ckNgNmQOrM79vdr/
         IffpwuyXDa34rZmsRKan+1K60XTSBjMsUoXaElv04HgeDpTaExmeOM/Y36jw0Rsgf2AL
         vu5MSmQoPqyrGngAocwQ7+rng08FtSkJHDV15WihaCqkRCBeDpxksDCOtprFlrbZPLXf
         oCkg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Vywz18B2Kv4tW7chD3NZ10sI/wo/YBTLNaTdyyz6kNrvu7jqRioxgVhF+Zo9JXzpO1JC1z26EjO+N6Ul95WG66ao
X-Gm-Message-State: AOJu0Ywj1rU7qi2V9UfmeLVTZPvMtv/bmiPiX5DlJxc2lLd0Km3EZ708
	neo2jphp+rSLQBGLI4oh88QykYr8fL89h6Uu4eSK5YkRCq7uy1bWiE6Ly9dYpQs=
X-Google-Smtp-Source: AGHT+IGtQl9c1Evpp18ocZ5q/QQVhqE2/ZBbSr3U58j9PI2E4HefdEbETjVpINqcX9TcLPGz+COSDA==
X-Received: by 2002:a05:6808:201f:b0:3c1:cb2a:b7e with SMTP id q31-20020a056808201f00b003c1cb2a0b7emr13146894oiw.5.1709583193677;
        Mon, 04 Mar 2024 12:13:13 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id w15-20020a05622a190f00b0042dce775a4bsm4729533qtc.3.2024.03.04.12.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:13:12 -0800 (PST)
Message-ID: <51c4b25f-1cdc-4bcc-8b40-c98096bebacf@joelfernandes.org>
Date: Mon, 4 Mar 2024 15:13:10 -0500
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
To: paulmck@kernel.org
Cc: linke li <lilinke99@qq.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Josh Triplett <josh@joshtriplett.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>, Boqun Feng
 <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <tencent_B51A9DA220288A95A435E3435A0443BEB007@qq.com>
 <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
 <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>
 <a9ff4787-1b07-4d47-b2a0-5eb1336d3710@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <a9ff4787-1b07-4d47-b2a0-5eb1336d3710@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/2024 2:44 PM, Paul E. McKenney wrote:
> On Mon, Mar 04, 2024 at 02:10:09PM -0500, Joel Fernandes wrote:
>>
>>
>> On 3/4/2024 12:14 PM, Paul E. McKenney wrote:
>>> On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
>>>>
>>>>
>>>> On 3/4/2024 5:54 AM, linke li wrote:
>>>>> Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
>>>>>
>>>>>  {
>>>>>  	int i;
>>>>>
>>>>> -	i = rp->rtort_pipe_count;
>>>>> +	i = READ_ONCE(rp->rtort_pipe_count);
>>>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>>>> -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>>>> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>>>> +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>>>>  		rp->rtort_mbtest = 0;
>>>>>  		return true;
>>>>>  	}
>>>>>
>>>>> But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
>>>>> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
>>>>> rcu_torture_writer() concurrently.
>>>>>
>>>>> Also, rp->rtort_pipe_count in the next line should be read using
>>>>> READ_ONCE() because of data race.
>>>>>
>>>>> Signed-off-by: linke li <lilinke99@qq.com>
>>>>> ---
>>>>>  kernel/rcu/rcutorture.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>>>> index 7567ca8e743c..00059ace4fd5 100644
>>>>> --- a/kernel/rcu/rcutorture.c
>>>>> +++ b/kernel/rcu/rcutorture.c
>>>>> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>>>> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>>>> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>>>> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>>>> +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
>>>>
>>>> I want to say, I am not convinced with the patch because what's wrong with
>>>> writing to an old index?
>>>>
>>>> You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
>>>> early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
>>>> the "incremented i" or "the increment from the latest value of pipe_count".
>>>>
>>>> Anyway, a slightly related/different question:
>>>>
>>>> Should that:
>>>> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>>>
>>>> Be:
>>>> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
>>>>
>>>> ?
>>>
>>> Thank you both!
>>>
>>> At first glance, I would argue for something like this:
>>>
>>> ------------------------------------------------------------------------
>>>
>>> static bool
>>> rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>> {
>>> 	int i;
>>> 	struct rcu_torture_reader_check *rtrcp = READ_ONCE(rp->rtort_chkp);
>>>
>>> 	if (rtrcp) {
>>> 		WRITE_ONCE(rp->rtort_chkp, NULL);
>>> 		smp_store_release(&rtrcp->rtc_ready, 1); // Pair with smp_load_acquire().
>>> 	}
>>> 	i = READ_ONCE(rp->rtort_pipe_count) + 1;
>>> 	if (i > RCU_TORTURE_PIPE_LEN)
>>> 		i = RCU_TORTURE_PIPE_LEN;
>>> 	atomic_inc(&rcu_torture_wcount[i]);
>>> 	WRITE_ONCE(rp->rtort_pipe_count, i);
>>> 	if (i >= RCU_TORTURE_PIPE_LEN) {
>>> 		rp->rtort_mbtest = 0;
>>> 		return true;
>>> 	}
>>> 	return false;
>>> }
>>>
>>> ------------------------------------------------------------------------
>>>
>>> That is, move the increment to the read and replace the re-read with
>>> the value "i" that was just written.
>>
>> But that changes the original logic as well? It looks like with the above
>> change, you're now writing to rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)
>> + 1] instead of rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)].
>>
>> I think that might break rcutorture, because there is an increment outside of
>> the first 2 entries in rcu_torture_wcount but not sure (need to look more).
> 
> Good point on never incrementing the zeroth entry!  Clearly I should
> have waited before replying.
> 
> How about the following?
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
> 	i = READ_ONCE(rp->rtort_pipe_count);
> 	if (i > RCU_TORTURE_PIPE_LEN)
> 		i = RCU_TORTURE_PIPE_LEN;
> 	atomic_inc(&rcu_torture_wcount[i]);
> 	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
> 	if (i + 1 >= RCU_TORTURE_PIPE_LEN) {
> 		rp->rtort_mbtest = 0;
> 		return true;
> 	}
> 	return false;
> }

Yes, this looks good to me. Thanks,
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

