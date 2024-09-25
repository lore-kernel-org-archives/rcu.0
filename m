Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54218DF78;
	Wed, 25 Sep 2024 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264261; cv=none; b=NWN1AHDTp/i3td6Z96Iz14uKtfdvzOHZSKnwwK7Or3C5iYns2UMqjDns9Ib3b5e4bOfHlRoL/T564PclyUnn13kWdhBn9hbf9LgeK0vNSvmPH5+eblxIJ2IPZEboVv2D4OIMqAErPJERrFCSqejoC8BSFxd85BWPA714UNspXFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264261; c=relaxed/simple;
	bh=mNVhvWOEn6bEbyXBRFPt8xXjd1N12QiImpkDDnCHGZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul6KBDEgHbeDU9Fw+Wxoqoqom1O8VB33QnEbZ3b8u0pfuZHMorUCzxO3wsCG6/zff7O9Fheepfqb+PMHZxOUf+ozKCarkFaH4eJ3OFfAkwQzwTT/mK/gkjrXpPme3nNByuPqZc9J+MGkZnmGZ1KRCiHUZRR41kbo8ReW7jsYxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NzUR10xe; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NzUR10xe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727264258;
	bh=mNVhvWOEn6bEbyXBRFPt8xXjd1N12QiImpkDDnCHGZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NzUR10xe39M7KcplzFnp+pUsEnYBTpuWdGy3vbCLCSkWSGx7UPd4EO5CiQnCY1JYv
	 JtRxX5/Ixr7OvlSMQIatUb49kBUW3RitX8UtpVMisU2jOeRGePJAlTKFYsM9DatxiC
	 i6QageZOCnVC23DGwUXJfVSZG3TkO7GsMJitiSGz5o3khKYim3JA9CZgkBj4oyP6Bh
	 r4K6hqSj61MhTBA4aXhIbWOuA1mN4pMErKQ29tuxB+3hbN3+GUh2dqogU9ky+12xgT
	 wgQOr4BhV3FzutJAbY057deM4ZjVSuYufhlTHd+ecR9QhWlEcFwcK6EQMFnb6BbooY
	 PUPJVGFPX6eHQ==
Received: from [192.168.126.112] (unknown [147.75.204.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDF885PTZz1LfT;
	Wed, 25 Sep 2024 07:37:28 -0400 (EDT)
Message-ID: <38b04b86-1e85-40f0-8174-3c8ab29cbcaf@efficios.com>
Date: Wed, 25 Sep 2024 13:36:47 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
 <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
 <48ae741e-98aa-49d9-b677-6c4f8fd1bcb0@efficios.com>
 <07c9285f-44a1-486a-8390-0c63cefae35a@huaweicloud.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <07c9285f-44a1-486a-8390-0c63cefae35a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-25 12:06, Jonas Oberhauser wrote:
> 
> 
> Am 9/25/2024 um 8:35 AM schrieb Mathieu Desnoyers:
>> On 2024-09-25 07:57, Jonas Oberhauser wrote:
>>> Hi Mathieu,
> 
>>> I haven't read your code in detail but it seems to me you have an ABA 
>>> bug: as I explained elsewhere, you could read the same pointer after 
>>> ABA but you don't synchronize with the newer store that gave you 
>>> node2, leaving you to speculatively read stale values through *ctx->hp.
>>> (I am assuming here that ctx->hp is essentially an out parameter used 
>>> to let the caller know which node got protected).
>>
>> The following change should fix it:
>>
>>       cmm_barrier();
>> -    node2 = uatomic_load(node_p, CMM_RELAXED);    /* Load A */
>> +    node2 = rcu_dereference(*node_p);    /* Load A */
>>
> 
> I don't think this fixes it, because IIRC rcu_dereference relies on the 
> address dependency (which we don't have here) to provide ordering.
> 
> I would recommend either:
> 
> -    ctx->hp = node;
> +    ctx->hp = node2;
> 
> which fixes the problem under the perhaps too weak assumption that the 
> compiler doesn't use its knowledge that node==node2 to just undo this 
> fix, or more strictly,

As stated in Documentation/RCU/rcu_dereference.rst from the Linux
kernel, comparing the result of rcu_dereference against another
non-NULL pointer is discouraged, as you rightly point out.

> 
> +    ctx->hp = READ_ONCE(node2);
> 
> which I believe makes sure that the value of node2 is used.

I am not entirely sure this extra READ_ONCE() would be sufficient
to prevent the compiler from making assumptions about the content
of node2 and thus use the result of the first load (node) instead.
It would also not suffice to prevent the CPU from speculatively
using the result of the first load to perform dependent loads AFAIU.

> Alternatively you could always use an acquire load.

Unless someone comes up with a sound alternate approach,
I am tempted to go with an acquire load as the second load
within hpref_hp_get().

This way, the compiler would not attempt to use the
node value from the first load for dependent loads,
and the and CPU won't try to speculate dependent loads
either.

Thanks,

Mathieu

> 
> 
> Best wishes,
> 
>    jonas
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

