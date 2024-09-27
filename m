Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AAA932;
	Fri, 27 Sep 2024 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400144; cv=none; b=KWhcmpHQflQads0trR3fZGAR4/zEf89l/NV6AqjS1mJn57Guu5Kvz01qK7VFRq+PO3Jwqx/FzHpNQrbq0jtcQqg2GVkM4AccUtfL5W+m4HUmsiXbljpNrhVb/9fvnyXz+HzyklryEdCuay9wm2PEyDQgODiTV9L2gky0MgAByiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400144; c=relaxed/simple;
	bh=ElZAKhc9xfVL364QUUdcGdbCVJjoyaPqJZ5VzYUZDLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu5tMm14j+cfLdIvlaYygx97N0t0tnzuQPnMdgHVg0N2cD17HnVkt+X/xpDhkcEdDLYfE5YDQSESXn3i+RGSZbzr5XYr4HC00xA8PvbDhBUcx6h5mcy3cLajQtZmHoWnRFmCxDkLxv0jJ5VkYSw04SoUHpY05rxc7RzFW6pXvPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=W32bVJ7u; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="W32bVJ7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727400135;
	bh=ElZAKhc9xfVL364QUUdcGdbCVJjoyaPqJZ5VzYUZDLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W32bVJ7uvg72EJNsd3sQl4uL/XE6oglxztZY2TbDCA+zlmMR2CAVp007XFbaQGJah
	 Np0FQGOUG51m6HMNE3BGseVBXVhjNBT4bxH+TXAHGEihAQFzDYms7aHXpohI+XmSaW
	 bJW2ZYbm+6JXkwdFmGKkDeUXu9VAQS7szJwV07fi1n+v+nfugsid+OJiSkM9iM+sid
	 KD9mdOi6DOGKCoK+jDP8TbmEU9i5swLvwQtz/sz/LSeqRRjrL9w0jCG5MhVel3kRfO
	 fMggqCINXLRHnkGxhrPbUaya9BAn1q8uQUaR2SL4AUtgmE3wYSsFun1Ea+HLQhEDQN
	 FEOAy6rG3O30w==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFCPM25b7z1MZK;
	Thu, 26 Sep 2024 21:22:15 -0400 (EDT)
Message-ID: <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>
Date: Fri, 27 Sep 2024 03:20:40 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
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
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-26 18:12, Linus Torvalds wrote:
> On Thu, 26 Sept 2024 at 08:54, Jonas Oberhauser
> <jonas.oberhauser@huaweicloud.com> wrote:
>>
>> No, the issue introduced by the compiler optimization (or by your
>> original patch) is that the CPU can speculatively load from the first
>> pointer as soon as it has completed the load of that pointer:
> 
> You mean the compiler can do it. The inline asm has no impact on what
> the CPU does. The conditional isn't a barrier for the actual hardware.
> But once the compiler doesn't try to do it, the data dependency on the
> address does end up being an ordering constraint on the hardware too
> (I'm happy to say that I haven't heard from the crazies that want
> value prediction in a long time).
> 
> Just use a barrier.  Or make sure to use the proper ordered memory
> accesses when possible. Don't use an inline asm for the compare - we
> don't even have anything insane like that as a portable helper, and we
> shouldn't have it.

How does the compiler barrier help in any way here ?

I am concerned about the compiler SSA GVN (Global Value Numbering)
optimizations, and I don't think a compiler barrier solves anything.
(or I'm missing something obvious)

I was concerned about the suggestion from Jonas to use "node2"
rather than "node" after the equality check as a way to ensure
the intended register is used to return the pointer, because after
the SSA GVN optimization pass, AFAIU this won't help in any way.
I have a set of examples below that show gcc use the result of the
first load, and clang use the result of the second load (on
both x86-64 and aarch64). Likewise when a load-acquire is used as
second load, which I find odd. Hopefully mixing this optimization
from gcc with speculation still abide by the memory model.

Only the asm goto approach ensures that gcc uses the result from
the second load.

#include <stdbool.h>

#define READ_ONCE(x)   \
     (*(__volatile__  __typeof__(x) *)&(x))

static inline
bool same_ptr(void *a, void *b)
{
     asm goto (
#ifdef __x86_64__
         "cmpq %[a], %[b]\n\t"
         "jne %l[ne]\n\t"
#elif defined(__aarch64__)
         "cmp %[a], %[b]\n\t"
         "bne %l[ne]\n\t"
#else
# error "unimplemented"
#endif
         : : [a] "r" (a), [b] "r" (b)
         : : ne);
     return true;
ne:
     return false;
}

int *p;

int fct_2_volatile(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (a != b);
     return *b;
}

int fct_volatile_acquire(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = __atomic_load_n(&p, __ATOMIC_ACQUIRE);
     } while (a != b);
     return *b;
}

int fct_asm_compare(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (!same_ptr(a, b));
     return *b;
}

x86-64 gcc 14.2:

fct_2_volatile:
  mov    rax,QWORD PTR [rip+0x0]        # 7 <fct_2_volatile+0x7>
  mov    rdx,QWORD PTR [rip+0x0]        # e <fct_2_volatile+0xe>
  cmp    rax,rdx
  jne    0 <fct_2_volatile>
  mov    eax,DWORD PTR [rax]
  ret
  cs nop WORD PTR [rax+rax*1+0x0]
fct_volatile_acquire:
  mov    rax,QWORD PTR [rip+0x0]        # 27 <fct_volatile_acquire+0x7>
  mov    rdx,QWORD PTR [rip+0x0]        # 2e <fct_volatile_acquire+0xe>
  cmp    rax,rdx
  jne    20 <fct_volatile_acquire>
  mov    eax,DWORD PTR [rax]
  ret
  cs nop WORD PTR [rax+rax*1+0x0]
fct_asm_compare:
  mov    rdx,QWORD PTR [rip+0x0]        # 47 <fct_asm_compare+0x7>
  mov    rax,QWORD PTR [rip+0x0]        # 4e <fct_asm_compare+0xe>
  cmp    rax,rdx
  jne    40 <fct_asm_compare>
  mov    eax,DWORD PTR [rax]
  ret
main:
  xor    eax,eax
  ret

x86-64 clang 19.1.0:

fct_2_volatile:
  mov    rcx,QWORD PTR [rip+0x0]        # 7 <fct_2_volatile+0x7>
  mov    rax,QWORD PTR [rip+0x0]        # e <fct_2_volatile+0xe>
  cmp    rcx,rax
  jne    0 <fct_2_volatile>
  mov    eax,DWORD PTR [rax]
  ret
  cs nop WORD PTR [rax+rax*1+0x0]
fct_volatile_acquire:
  mov    rcx,QWORD PTR [rip+0x0]        # 27 <fct_volatile_acquire+0x7>
  mov    rax,QWORD PTR [rip+0x0]        # 2e <fct_volatile_acquire+0xe>
  cmp    rcx,rax
  jne    20 <fct_volatile_acquire>
  mov    eax,DWORD PTR [rax]
  ret
  cs nop WORD PTR [rax+rax*1+0x0]
fct_asm_compare:
  mov    rcx,QWORD PTR [rip+0x0]        # 47 <fct_asm_compare+0x7>
  mov    rax,QWORD PTR [rip+0x0]        # 4e <fct_asm_compare+0xe>
  cmp    rax,rcx
  jne    40 <fct_asm_compare>
  mov    eax,DWORD PTR [rax]
  ret
  cs nop WORD PTR [rax+rax*1+0x0]
main:
  xor    eax,eax
  ret

ARM64 gcc 14.2.0:

fct_2_volatile:
         adrp    x0, .LANCHOR0
         add     x0, x0, :lo12:.LANCHOR0
.L2:
         ldr     x1, [x0]
         ldr     x2, [x0]
         cmp     x1, x2
         bne     .L2
         ldr     w0, [x1]
         ret
fct_volatile_acquire:
         adrp    x0, .LANCHOR0
         add     x0, x0, :lo12:.LANCHOR0
.L6:
         ldr     x1, [x0]
         ldar    x2, [x0]
         cmp     x1, x2
         bne     .L6
         ldr     w0, [x1]
         ret
fct_asm_compare:
         adrp    x1, .LANCHOR0
         add     x1, x1, :lo12:.LANCHOR0
.L9:
         ldr     x2, [x1]
         ldr     x0, [x1]
         cmp x2, x0
         bne .L9

         ldr     w0, [x0]
         ret
p:
         .zero   8

armv8-a clang (trunk):

fct_2_volatile:
  adrp	x8, 0 <fct_2_volatile>
  ldr	x10, [x8]
  ldr	x9, [x8]
  cmp	x10, x9
  b.ne	4 <fct_2_volatile+0x4>  // b.any
  ldr	w0, [x9]
  ret
fct_volatile_acquire:
  adrp	x8, 0 <fct_2_volatile>
  add	x8, x8, #0x0
  ldr	x10, [x8]
  ldar	x9, [x8]
  cmp	x10, x9
  b.ne	24 <fct_volatile_acquire+0x8>  // b.any
  ldr	w0, [x9]
  ret
fct_asm_compare:
  adrp	x8, 0 <fct_2_volatile>
  ldr	x9, [x8]
  ldr	x8, [x8]
  cmp	x9, x8
  b.ne	3c <fct_asm_compare>  // b.any
  ldr	w0, [x8]
  ret
main:
  mov	w0, wzr

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

