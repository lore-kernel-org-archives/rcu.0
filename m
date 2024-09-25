Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A419F473;
	Wed, 25 Sep 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268503; cv=none; b=K4BRKV24p4ItacMR9ATRLAdMmFzTjS7PARzkepBPJjfRrpwMKEwwhpUeSNIOYY0zGh44sEHT1tSLWFWVjTzOlh7Nk1cOquJ+MPDAxF2gjPgWlerz/lWs/sF/HIVttJ5enucETjKNPFrh5A12H+NdkehvBocVrS538VU1QkcNNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268503; c=relaxed/simple;
	bh=24v3d1jjV4GAVX62MeV1ZzpVMnN+aHy8vAKvEJyK3Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGyrSAgX6VgiO1Yy0c9yPHc2zkOKZBRMCPJKKkAtNzxTc1sAlyVWOsDcDm7bPilPK9ygo0/TS0wgTjsws/MqUT8VrRnJ2wixwwTu5mkVSSBA7QsQ0j3OpW+nv1gGcQi8vH2f4Embs7Tmf1DdTCJoFp4EuFQWK89br9z4l0RFXH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VqeA6j3w; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VqeA6j3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727268498;
	bh=24v3d1jjV4GAVX62MeV1ZzpVMnN+aHy8vAKvEJyK3Yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VqeA6j3wW7L0gZavAW9VbhmKfkwEO9YJWLS97HC+4BVvFvj4UDFor1HyoQjDrl0vN
	 L8+alwtwKCELhjqbzBYXXxTd/OxnLTVA5wEaFsJvrZm8teAJ0wlK3FdbbpZ2aUmotj
	 u8NM0qv70aopRwRm//IlN99soxfiD+heN+y3LrHJCo/hLP1Ju/SR+SkHNbqR++Rfag
	 S3ieVP7cfVC6VsqWjLdlcQkrK3oIuhYNOToaLCMI3XWy3gT/sgUc3hBRETx2ZYhfUM
	 VSnySAm5d4+f6sBELPNgGQWT2oYhIyiUW33i0NqiY1l0fBc7SdIfpQlxX+IQbdssYG
	 ea5EBN1bg0hLQ==
Received: from [192.168.126.112] (unknown [147.75.204.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDGjg4b5Hz1M43;
	Wed, 25 Sep 2024 08:48:07 -0400 (EDT)
Message-ID: <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
Date: Wed, 25 Sep 2024 14:47:26 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZvP_H_R43bXpmkMS@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-25 14:16, Boqun Feng wrote:
> On Wed, Sep 25, 2024 at 01:59:06PM +0200, Mathieu Desnoyers wrote:
>> On 2024-09-25 12:45, Boqun Feng wrote:
>>> On Wed, Sep 25, 2024 at 12:11:52PM +0200, Jonas Oberhauser wrote:
>>>>
>>>>
>>>> Am 9/25/2024 um 12:02 PM schrieb Boqun Feng:
>>>>> Hi Jonas,
>>>>>
>>>>> Of
>>>>> course, if we are really worried about compilers being too "smart"
>>>>
>>>> Ah, I see you know me better and better...
>>>>
>>>>> we can always do the comparison in asm code, then compilers don't know
>>>>> anything of the equality between 'ptr' and 'head - head_offset'.
>>>> Yes, but then a simple compiler barrier between the comparison and returning
>>>> ptr would also do the trick, right? And maybe easier on the eyes.
>>>>
>>>
>>> The thing about putting a compiler barrier is that it will prevent all
>>> compiler reorderings, and some of the reordering may contribute to
>>> better codegen. (I know in this case, we have a smp_mb(), but still
>>> compilers can move unrelated code upto the second load for optimization
>>> purpose). Asm comparison is cheaper in this way. But TBH, compilers
>>> should provide a way to compare pointer values without using the result
>>> for pointer equality proof, if "convert to unsigned long" doesn't work,
>>> some other ways should work.
>>>
>>
>> Based on Documentation/RCU/rcu_dereference.rst :
>>
>> -       Be very careful about comparing pointers obtained from
>>          rcu_dereference() against non-NULL values.  As Linus Torvalds
>>          explained, if the two pointers are equal, the compiler could
>>          substitute the pointer you are comparing against for the pointer
>>          obtained from rcu_dereference().  For example::
>>
>>                  p = rcu_dereference(gp);
>>                  if (p == &default_struct)
>>                          do_default(p->a);
>>
>>          Because the compiler now knows that the value of "p" is exactly
>>          the address of the variable "default_struct", it is free to
>>          transform this code into the following::
>>
>>                  p = rcu_dereference(gp);
>>                  if (p == &default_struct)
>>                          do_default(default_struct.a);
>>
>>          On ARM and Power hardware, the load from "default_struct.a"
>>          can now be speculated, such that it might happen before the
>>          rcu_dereference().  This could result in bugs due to misordering.
>>
>> So I am not only concerned about compiler proofs here, as it appears
>> that the speculation done by the CPU can also cause issues on some
>> architectures.
>>
> 
> Note that the issue is caused by compiler replacing one pointer with
> the other, CPU speculation won't cause the issue solely, because all
> architectures Linux supports honor address dependencies (except for
> Alpha, but on Alpha, READ_ONCE() has a smp_mb() after the load). That
> is: if the compiler generates code as the code is written, there should
> be no problem.

I am starting to wonder if it would not be more robust to just bite
the bullet and add the inline asm helpers to do the pointer comparison
outside of the compiler knowledge for each architecture. This should
work fine in the short term, until compilers eventually give us a
"compare pointers without allowing the compiler to infer anything about
pointer equality".

Like so:

#include <stdio.h>

#define __str_1(x)  #x
#define __str(x)    __str_1(x)

/* x86-64 */
#define bne_ptr(_a, _b, _label) \
     asm goto ( \
         "cmpq %[a], %[b]\n\t" \
         "jne %l[" __str(_label) "]\n\t" \
         : : [a] "r" (_a), [b] "r" (_b) \
         : : _label)

int x;

int v[2];

int main(void)
{
     bne_ptr(v, v + 1, label_same);
     x = 1;
label_same:
     printf("%d\n", x);
     return 0;
}


> 
> Regards,
> Boqun
> 
>> Thanks,
>>
>> Mathieu
>>
>>> Regards,
>>> Boqun
>>>
>>>>
>>>> Have fun,
>>>>      jonas
>>>>
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

