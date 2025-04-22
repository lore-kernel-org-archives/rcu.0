Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 2F062347A2;
	Tue, 22 Apr 2025 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285866; cv=none; b=DOyfEVMHv/CAvjK1FY9sL+J09xFjrCVert7NA2tFfNCwjfjigOPj1QoTfuEvOYzvEg4ymCVWL41AzDU3wmOzTeE1qUnSj/mRqJQH9QvH3zD/0SQx1iCOJuz1FVZZXe0OdWbi6+S6Iyu3vA3+Q7tXuH5ZuSYKEgbMx8E6cn+cvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285866; c=relaxed/simple;
	bh=bun+qu7oOV+h1aeO2rCb4bUYD4jXaB+DMO2HFLCgdug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=GFoSvcLvRpbtLie0TzdjXIsm9l2pjjDUdURq+p0jh6Oq+U86AV3NtgAmEVaPpwyUV8iVM1FpJzkltZggQ0Q5bxrQWLZOF0mySSFIveE3jaPPGiwfoAr7jUz1u9zvoTLzWAUwl2r3mLhedLUfNrIg2NMN576kYfxUYhTul5eK3sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id A3FD060109955;
	Tue, 22 Apr 2025 09:37:39 +0800 (CST)
Message-ID: <576c236f-3c12-42d9-b2cc-7367339fb37e@nfschina.com>
Date: Tue, 22 Apr 2025 09:37:39 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcuscale: using kmalloc_array() to relpace kmalloc()
Content-Language: en-US
To: paulmck@kernel.org
Cc: dave@stgolabs.net, josh@joshtriplett.org, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
 urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <7743ff8a-1492-4191-95ec-abcb53001b83@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/4/21 21:49, Paul E. McKenney wrote:
> On Mon, Apr 21, 2025 at 02:15:09PM +0800, Su Hui wrote:
>> It's safer to using kmalloc_array() because it can prevent overflow
>> problem.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> Thank you!
>
> But isn't kcalloc just a wrapper around kmalloc_array() anyway?
Yes, and kcalloc() add the _GFP_ZERO flag. I can send a v2 patch with 
kcalloc().
Thanks for your suggestion.

Su Hui

>> ---
>>   kernel/rcu/rcuscale.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>> index 0f3059b1b80d..cbe2195f08d6 100644
>> --- a/kernel/rcu/rcuscale.c
>> +++ b/kernel/rcu/rcuscale.c
>> @@ -762,7 +762,7 @@ kfree_scale_thread(void *arg)
>>   		}
>>   
>>   		for (i = 0; i < kfree_alloc_num; i++) {
>> -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
>> +			alloc_ptr = kmalloc_array(kfree_mult, sizeof(struct kfree_obj), GFP_KERNEL);
>>   			if (!alloc_ptr)
>>   				return -ENOMEM;
>>   
>> -- 
>> 2.30.2
>>
>>
