Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC80D78B5A
	for <rcu@vger.kernel.org>; Mon,  4 Mar 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579415; cv=none; b=cw+AVjluSlNgkZLBgOBwe+iUwzKNfgtyQihBaEjuoEWj1ePGetpLS2y/7uLwvcuBeGb0CR/vL/46FDgHBCepqEdFUFWuuEXvTQUEjh+1BJYl/Ms3NP6Cl3qnUF5ASNaaXo8WGr1kM1kd12+e1QdUWNj8TyTPDEg8sESIPht80c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579415; c=relaxed/simple;
	bh=Hw/ZbeQVMiDbwu0iVTuLsc7vBc40rgkcKS8KKAcH1KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X5YwCP26nDHKybtxl/GeQwCv3vdTLT5/gOLRtC8Y+nFyL3nRcg2KzGz6DOB0im9SWecGs0RtreWKpqa7Fj4otfuvF0ZdBtJmw/VkIH/+FF0Kr2hG0UjTSjHKOjFGSmf1wW6iEZtHRyGx69ACwUmCqQQplJt+/ApT1wHF661duYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=oJvKdEAR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oJvKdEAR"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7882d75e766so26630285a.1
        for <rcu@vger.kernel.org>; Mon, 04 Mar 2024 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709579413; x=1710184213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKUa1+EBAtyJGDdTLiEQrn4ioKCgJdqIXHUpdnAkpJc=;
        b=oJvKdEARfmoTVaugjvQutQxysOz09t4MPaagxug4v0k5DzZlz50H4Gyw6Mv3PpDAca
         IIKpr/1NPBWNiA7SRdtttSujEjmVdkTc9+mk227JWRhQP2QXgzVf+GFylwpD5TvnUEfR
         ph/zL0GPLf1LJRVXtcVVOzw/UHZKhcYoTQJRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579413; x=1710184213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKUa1+EBAtyJGDdTLiEQrn4ioKCgJdqIXHUpdnAkpJc=;
        b=Cge0jWeTGTBXQDE4Byp5f+kTT73QsG/7Uk4/2dtBESOKP/2qCWKXnL+xOUnV8eN4Tq
         bxln5QuADEdd5NKcClTG3aNCdWgwWknMHSl8H469t0xOS9w2ro5hBVJJSERaczHyEp0w
         Hc0s0GGvB2QdbnajdHxHglYa6J/qqWbPt/O+TLtlvAQQQHL3+RlMdOfq+PW/r75O1Nkt
         vxywTKdF93BFp/jMhNIhifQpGW/ZDqsChlJPdeXT6iSKGPcI02xdzSDL5trPoTV0DFu9
         iKed4YRlfHbkfdzaDikuyhSZluk75aoxnNVKWJ5ZMuSBe/+LpwW6VVvv+GIF+shPxPVA
         cQvg==
X-Forwarded-Encrypted: i=1; AJvYcCUeqKhLxvw5Br5gttPwLpJIvcrhQpMT0XAW2rJXBe+s62aSp8//zJweNgwKdPQ/hKsGtfrrob3Xh6CiTajGuln0KrJX
X-Gm-Message-State: AOJu0YyHYiTNzs42wvFXLNxb+Cgv7xVIxENHs4UE96OEw0YsTn0XFi9B
	aaRMFKlhLgPt9U6Sq5zznpa6o90pfFFbkvXSIuYkTpQkrn+KUNnrjEp7+6GUXWFN4ph7cuoHKqt
	O
X-Google-Smtp-Source: AGHT+IE9dGhumWRtZFI/7CXp+JwpK3qDgkcJlEikBCa9J1hSp9fXrBScFgS2X6CdvMMR7i2xdF4YFA==
X-Received: by 2002:a05:620a:231:b0:788:26b5:d59e with SMTP id u17-20020a05620a023100b0078826b5d59emr4177760qkm.29.1709579412805;
        Mon, 04 Mar 2024 11:10:12 -0800 (PST)
Received: from [10.5.0.2] ([91.196.69.189])
        by smtp.gmail.com with ESMTPSA id g28-20020a05620a13dc00b00787d6814c10sm4626326qkl.13.2024.03.04.11.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:10:11 -0800 (PST)
Message-ID: <a8e9c84f-c354-4536-b676-d38043913d09@joelfernandes.org>
Date: Mon, 4 Mar 2024 14:10:09 -0500
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
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <4857c5ef-bd8f-4670-87ac-0600a1699d05@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/4/2024 12:14 PM, Paul E. McKenney wrote:
> On Mon, Mar 04, 2024 at 11:19:21AM -0500, Joel Fernandes wrote:
>>
>>
>> On 3/4/2024 5:54 AM, linke li wrote:
>>> Some changes are done to fix a data race in commit 202489101f2e ("rcutorture: Fix rcu_torture_one_read()/rcu_torture_writer() data race")
>>>
>>>  {
>>>  	int i;
>>>
>>> -	i = rp->rtort_pipe_count;
>>> +	i = READ_ONCE(rp->rtort_pipe_count);
>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>> -	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>> +	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>> +	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>>  		rp->rtort_mbtest = 0;
>>>  		return true;
>>>  	}
>>>
>>> But ++rp->rtort_pipe_count is meant to add itself by 1, not give i+1 to
>>> rp->rtort_pipe_count, because rp->rtort_pipe_count may write by
>>> rcu_torture_writer() concurrently.
>>>
>>> Also, rp->rtort_pipe_count in the next line should be read using
>>> READ_ONCE() because of data race.
>>>
>>> Signed-off-by: linke li <lilinke99@qq.com>
>>> ---
>>>  kernel/rcu/rcutorture.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
>>> index 7567ca8e743c..00059ace4fd5 100644
>>> --- a/kernel/rcu/rcutorture.c
>>> +++ b/kernel/rcu/rcutorture.c
>>> @@ -465,8 +465,8 @@ rcu_torture_pipe_update_one(struct rcu_torture *rp)
>>>  	if (i > RCU_TORTURE_PIPE_LEN)
>>>  		i = RCU_TORTURE_PIPE_LEN;
>>>  	atomic_inc(&rcu_torture_wcount[i]);
>>> -	WRITE_ONCE(rp->rtort_pipe_count, i + 1);
>>> -	if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
>>> +	WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>> +	if (READ_ONCE(rp->rtort_pipe_count) >= RCU_TORTURE_PIPE_LEN) {
>>
>> I want to say, I am not convinced with the patch because what's wrong with
>> writing to an old index?
>>
>> You win/lose the race anyway, say the CPU executed the WRITE_ONCE() a bit too
>> early/late and another WRITE_ONCE() lost/won, regardless of whether you wrote
>> the "incremented i" or "the increment from the latest value of pipe_count".
>>
>> Anyway, a slightly related/different question:
>>
>> Should that:
>> WRITE_ONCE(rp->rtort_pipe_count, rp->rtort_pipe_count + 1);
>>
>> Be:
>> WRITE_ONCE(rp->rtort_pipe_count, READ_ONCE(rp->rtort_pipe_count) + 1);
>>
>> ?
> 
> Thank you both!
> 
> At first glance, I would argue for something like this:
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
> 	i = READ_ONCE(rp->rtort_pipe_count) + 1;
> 	if (i > RCU_TORTURE_PIPE_LEN)
> 		i = RCU_TORTURE_PIPE_LEN;
> 	atomic_inc(&rcu_torture_wcount[i]);
> 	WRITE_ONCE(rp->rtort_pipe_count, i);
> 	if (i >= RCU_TORTURE_PIPE_LEN) {
> 		rp->rtort_mbtest = 0;
> 		return true;
> 	}
> 	return false;
> }
> 
> ------------------------------------------------------------------------
> 
> That is, move the increment to the read and replace the re-read with
> the value "i" that was just written.

But that changes the original logic as well? It looks like with the above
change, you're now writing to rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)
+ 1] instead of rcu_torture_wcount[READ_ONCE(rp->rtort_pipe_count)].

I think that might break rcutorture, because there is an increment outside of
the first 2 entries in rcu_torture_wcount but not sure (need to look more).

Thanks.
