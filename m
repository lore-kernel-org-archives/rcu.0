Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05731BFE18;
	Fri, 27 Sep 2024 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448371; cv=none; b=t358qkiCrAJP1vqaX4sPLpF/SLYlTcCadqqt4LrA7GyaIp4W5POOzD5c9fZIMDhhOGnbcQfrAGiM3f5MQOHBQJlpLE4XHM6DogzA4GI0aO+k6y8Ro8EmgUd/ZKSWM8P3PBs3CxCjmhOdsAXOtiXPlA1JxId3VTF1GXGYEY1eI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448371; c=relaxed/simple;
	bh=xD+akKG2WsLXNifs5kWRujVjHdAwiGgMHce05hDMYP4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m5A84lTuUYzrih7r11218ZXbRgmLGgTsWjrU7BU7CMtUfqA7FEAlBqdqJ10Kd8EMJWdoLkHeV/VRGVzk5DXULQ4NekcQZ2VYXNihLXFJhKG2W0UU0gM3zALedBtuj8REq8r1iRBFiQg1Lgm51HrSOSFCu29xeUwaYRi/1sVeB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HDaUr8Jl; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HDaUr8Jl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727448367;
	bh=xD+akKG2WsLXNifs5kWRujVjHdAwiGgMHce05hDMYP4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=HDaUr8JlcQb+Iam8HThov2FtvO0R0VEH8ApXioSxl/6HkWF9TM74GkVwndOYWxVPA
	 kcYrOkobLfkSlg4IoIDTikp5BFSibZzsVcr/AMdhA4HNrTUyi5Ys4HZKJcOWIM6jk6
	 vP3Op45mLNp8G+2yywkUtu3CLdXdU6Tubwy00zgg18t/SyWBMChXMQV4Z3KFSirpoq
	 bonlIgsrqOGNXpaYI3L4Zp8dzBV2shg1zt+OldcbN/td/yzMykX3uAN/XE+VKcom/G
	 EDe+il41Q3OW+SoANnOoRHipjtFxT7vkyeesC2dOK/Gj9cxJrgydqSI/eKenV00rrw
	 ZFSaSk5Z1fgMw==
Received: from [IPV6:2605:8d80:582:29fa:9e57:c437:e7dd:8f59] (unknown [IPv6:2605:8d80:582:29fa:9e57:c437:e7dd:8f59])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFYDs436zz1P2X;
	Fri, 27 Sep 2024 10:46:05 -0400 (EDT)
Message-ID: <08423acb-1f8e-407a-80fe-c424c6ee2861@efficios.com>
Date: Fri, 27 Sep 2024 10:43:59 -0400
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
To: Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, rostedt <rostedt@goodmis.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
 <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
 <e748893f-28a3-4b8a-a848-cfb1173ab940@app.fastmail.com>
 <ZvY0gG2dCJApPbp5@boqun-archlinux>
 <8aceaf4f-5578-4fca-8be7-3448d7b89721@efficios.com>
Content-Language: en-US
In-Reply-To: <8aceaf4f-5578-4fca-8be7-3448d7b89721@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 12:59, Mathieu Desnoyers wrote:
> On 2024-09-27 06:28, Boqun Feng wrote:
[...]
>> I replaced ADDRESS_EQ(a, b) with ADDRESS_EQ(b, a), and the compile
>> result shows it can prevent the issue:
> 
> I see, yes. It prevents the issue by making the compiler create
> a copy of the value "modified" by the asm before doing the equality
> comparison.
> 
> This means the compiler cannot derive the value for b from the first
> load when b is used after after the equality comparison.
> 
> The only downside of OPTIMIZER_HIDE_VAR() is that it adds an extra
> "mov" instruction to move the content across registers. I don't think
> it matters performance wise though, so that solution is appealing
> because it is arch-agnostic.
> 
> One small improvement over your proposed solution would be to apply
> OPTIMIZER_HIDE_VAR() on both inputs. Because this is not a volatile
> asm, it is simply optimized away if var1 or var2 is unused following
> the equality comparison. It is more convenient to prevent replacement
> of both addresses being compared by the other rather than providing
> the guarantee only on a single parameter:

Actually, your approach is better (only preserving the address
dependency on the first parameter), because it allows the second
parameter to be a constant.

Here is a diff. Please let me know if I need to improve anything wrt
comments or implementation:

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 2df665fa2964..52434eccd715 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,6 +186,32 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  	__asm__ ("" : "=r" (var) : "0" (var))
  #endif
  
+/*
+ * Compare an address with an expression while preserving the address
+ * dependencies for later use of the address. It should be used when
+ * comparing an address returned by rcu_dereference() with another
+ * address (either constant or in registers).
+ *
+ * This is needed to prevent the compiler SSA GVN optimization pass from
+ * replacing the register holding @addr by @expr (either a constant or a
+ * register) based on their equality, which does not preserve address
+ * dependencies and allows the following misordering speculations:
+ *
+ * - If @expr is a constant, the compiler can issue the loads which depend
+ *   on @addr before the load of @addr.
+ * - If @expr is a register populated by a prior load, weakly-ordered
+ *   CPUs can speculate loads which depend on @addr before the load of the
+ *   address they depend on.
+ */
+#ifndef ADDRESS_EQ
+#define ADDRESS_EQ(addr, expr)					\
+	({							\
+		bool __res = (addr) == (expr);			\
+		OPTIMIZER_HIDE_VAR(addr);			\
+		__res;						\
+	})
+#endif
+
  #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
  
  /**

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

