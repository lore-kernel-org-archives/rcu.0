Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13518B1A;
	Fri, 27 Sep 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400743; cv=none; b=ARCaXm1ea6IwfIvaoo+WftnhxWm2rjDE5PcR4onxONPulRhbeRUGHUiYo/HdZ3IX/MAYccM9VAOIQwol8AlT303kAyVW8VW25tE7ZPORkMa/jFmFnEykpVd+zq41gNo5Xg9M+Vl4HQwWux7V4lWZ5S7xIPd3kYn2hxp7dJXSPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400743; c=relaxed/simple;
	bh=4DYv5PRySQeJ142c8DOzea7v9PzCCPllUBYrWz5mU+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exTjcqRAqYDr3epc0ZO57OoFijwWHe+GCQndy3bOQnfQF51vQg5OyCFFizA8ZZZ13qBLMD4j1YeYteCFdrD5BelAC+zhod/WZUN8/2p5aOAC5PWIS65QbxStC1ggas2lisAjwYCC953U21sgDn7PZUPuKX311gegnBn7J/Jkj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=QT8QNKm+; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QT8QNKm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727400740;
	bh=4DYv5PRySQeJ142c8DOzea7v9PzCCPllUBYrWz5mU+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QT8QNKm+w/wsXL27WqVFMjYByBNGKqWIGAbTWNusEfmQTWjXTu2B8H8XQwn1/aku0
	 LhZcIuqfQpXYm1+yD8NaWjTmD4fXpePAecZzGJ6pDiuI81XcW+OaGE+4w+SU1CRzGy
	 HgrQWjV5//zSJuL9zj/bQw7dKc//eKj3NMzRsCzqmpYndmN6nZ2eMCh/DEQetstm/C
	 9Qx6gPZh1qdt835YBtdoe7JQF5pi240kbEEIphI7H+tIljwztRLdEasSLdVEUq+l3D
	 aYf2mRuSyEZMfi24t1rEaRtFaEyat0Hn8NeXHke1msK/QZGPDQs+Rz3TOS0rUSsE/C
	 vv377Zu1Qrd/Q==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFCd01hTTz1Mlx;
	Thu, 26 Sep 2024 21:32:20 -0400 (EDT)
Message-ID: <0b262fe5-2fc5-478d-bf66-f208723238d5@efficios.com>
Date: Fri, 27 Sep 2024 03:30:48 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Boqun Feng <boqun.feng@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
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
 Kent Overstreet <kent.overstreet@gmail.com>, Vlastimil Babka
 <vbabka@suse.cz>, maged.michael@gmail.com,
 Neeraj Upadhyay <neeraj.upadhyay@amd.com>
References: <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <54487a36-f74c-46c3-aed7-fc86eaaa9ca2@huaweicloud.com>
 <CAHk-=wifOW0VEh6uL3sHSaAUA46YmPDS9Wh5HnNC2JyOiXVA=Q@mail.gmail.com>
 <ZvX12_1mK8983cXm@boqun-archlinux>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <ZvX12_1mK8983cXm@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 02:01, Boqun Feng wrote:
> 	#define ADDRESS_EQ(var, expr)							\
> 	({										\
> 		bool _____cmp_res = (unsigned long)(var) == (unsigned long)(expr);	\
> 											\
> 		OPTIMIZER_HIDE_VAR(var);						\
> 		_____cmp_res;								\
> 	})

If the goal is to ensure gcc uses the register populated by the
second, I'm afraid it does not work. AFAIU, "hiding" the dependency
chain does not prevent the SSA GVN optimization from combining the
registers as being one and choosing one arbitrary source. "hiding"
the dependency chain before or after the comparison won't help here.

int fct_hide_var_compare(void)
{
     int *a, *b;

     do {
         a = READ_ONCE(p);
         asm volatile ("" : : : "memory");
         b = READ_ONCE(p);
     } while (!ADDRESS_EQ(a, b));
     return *b;
}

gcc 14.2 x86-64:

fct_hide_var_compare:
  mov    rax,QWORD PTR [rip+0x0]        # 67 <fct_hide_var_compare+0x7>
  mov    rdx,QWORD PTR [rip+0x0]        # 6e <fct_hide_var_compare+0xe>
  cmp    rax,rdx
  jne    60 <fct_hide_var_compare>
  mov    eax,DWORD PTR [rax]
  ret
main:
  xor    eax,eax
  ret

gcc 14.2.0 ARM64:

fct_hide_var_compare:
         adrp    x0, .LANCHOR0
         add     x0, x0, :lo12:.LANCHOR0
.L12:
         ldr     x1, [x0]
         ldr     x2, [x0]
         cmp     x1, x2
         bne     .L12
         ldr     w0, [x1]
         ret
p:
         .zero   8


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

