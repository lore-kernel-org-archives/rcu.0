Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194A18C00C;
	Wed, 25 Sep 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269862; cv=none; b=FMaa7NzXIDty6xL29yCF+KpNGl2F07f+58G+00mPmxa5dBcTUV47h7ZQ1+kfdF/2bOMJUpwTXoHq8Z6PkwHfaA5X9I9mbU80WvsTnPX7ZtIKUJaZA5o6YdN08CF0NNRMQSO0LzAIGNp1pJukUtcB6nvQmIkomJFHh+a6vX1VDo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269862; c=relaxed/simple;
	bh=PIcjDAxhxhmeRYLU1Sp75CHF/2n2HX48fEla2+zT/ec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rDF/QUoWBzgg2lJVFaJSQYOQyAr/PgiKnDO414slsa3RJxkzV6avIxtFyF+2Ml6R4u2qM0G+1WoU1IWpeFwgqVGen71j3F0rWvum4on4n/KLyeezAWUcwbxXzAjnkTMVS1hoCCKcbYnLr91LP4jVFp5kQFkqd2GeXB0V4/cC/TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hgUKQz8S; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hgUKQz8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727269859;
	bh=PIcjDAxhxhmeRYLU1Sp75CHF/2n2HX48fEla2+zT/ec=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=hgUKQz8SowpTtP0MWxpogy40UW6I3MH61/B+Hf39WsbWia+GPtCjNYjmcXPgV/T0/
	 eaHHvdrwyenR5iBEx5JXbXfTrSdNV3HvZltE0zIV2DNGAbDzDQT2XpbgAYU9egP1TF
	 9GOYRN7EJKXMudrbbVNkmXalHvTqqSrhtXNv/NIYIxPZLFuXBj41VgQrr8yImhnxwG
	 OUV+kREsSqXdYy6xXvxozfPP+wWkETfNWwApAeoB8utPG9yeTAdkANL/6AhzfO9lHE
	 GPnNcjhxR+L30qURmQ59w5cZ9OVP8ozoiUX6MYm5mb05Tu7boUsG7e22PqjgbaFYob
	 Za4ppeJGMiCTw==
Received: from [192.168.126.112] (unknown [147.75.204.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDHCv1Rksz1LsS;
	Wed, 25 Sep 2024 09:10:50 -0400 (EDT)
Message-ID: <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
Date: Wed, 25 Sep 2024 15:10:11 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
 <20240917143402.930114-2-boqun.feng@gmail.com>
 <55975a55-302f-4c45-bfcc-192a8a1242e9@huaweicloud.com>
 <ZvPfmAp_2mDkI3ss@boqun-archlinux>
 <f5aeeeda-c725-422a-9481-4795bd3ade0f@huaweicloud.com>
 <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
Content-Language: en-US
In-Reply-To: <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-25 14:47, Mathieu Desnoyers wrote:
[...]

> Like so:
> 
> #include <stdio.h>
> 
> #define __str_1(x)  #x
> #define __str(x)    __str_1(x)
> 
> /* x86-64 */
> #define bne_ptr(_a, _b, _label) \
>      asm goto ( \
>          "cmpq %[a], %[b]\n\t" \
>          "jne %l[" __str(_label) "]\n\t" \
>          : : [a] "r" (_a), [b] "r" (_b) \
>          : : _label)
> 
> int x;
> 
> int v[2];
> 
> int main(void)
> {
>      bne_ptr(v, v + 1, label_same);
>      x = 1;
> label_same:

Note that this label should probably be called "label_ne".
I flipped the macro logic without changing the labels.

Thanks,

Mathieu

>      printf("%d\n", x);
>      return 0;
> }
> 
> 
>>
>> Regards,
>> Boqun
>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>>>> Regards,
>>>> Boqun
>>>>
>>>>>
>>>>> Have fun,
>>>>>      jonas
>>>>>
>>>
>>> -- 
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> https://www.efficios.com
>>>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

