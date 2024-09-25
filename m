Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8777518C03D;
	Wed, 25 Sep 2024 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270510; cv=none; b=Pai477fhdvIKux7B3tDbfzrwq1WClkz4eUNuc87Wz+BUDZwjKSvOui1hq6d9DuQpJQl70tpopZY8hzmsdlB1dYSPgGkW56LrzQWNIhSBYUEETiwWGZmd8PWMZFekQcvariBPYk0jFc/DAeejF94pMAvr1iEE3eZsLM5D6DuorM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270510; c=relaxed/simple;
	bh=b3Uax3+rp7gtwhp//ajM56k9gXFv76k3I57QzMJ/Jic=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nr4UjQiYC/Qd2KXCM8HsZDNS9DkMsaOIw0t1LzmR7EwwDfaSsqyPn+g6UDvbm6xaERIuyZn1KluavUAYZdQ+s5R4jmxSmDqbtXMu4r1t6XmMsF+jAIW0j9wJy0ZiWhJJZOx5DpO+CCrUc4esdRiIEWfBsIN/kVL6iC2zEJmWhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=nPlSkVvc; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nPlSkVvc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727270508;
	bh=b3Uax3+rp7gtwhp//ajM56k9gXFv76k3I57QzMJ/Jic=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nPlSkVvcakqjs0Pf5vAv5qs75CAE4pm0O+LM83/WA1QNYIOxm5VMP5e1CncMDM6mu
	 XTy8gvC3iaHwaKKA+AQ/IbBOi1tZjzfYYh9GEznLuGVk7fiBq6zbYxMy7Ee6FLyjsI
	 O2B1bpVv1NjrSJ/qGcQZBpUEiypcAC7Vn6e+WdcW+I0YRTXyG8bYlBY4RkUXwUWhoO
	 4z73XTbzvWAAf66z4NXmUehWTL0D9UTdhyNLIwcFC7lrT93Vtn+ec2CTwhC2gxrDuH
	 yOvv0ZJ0AlBhDMuPlHKGjF0zNcqe/S8ofDorLNq6jafLN3z8cUU1nkX6gdtdV5lk0P
	 K0lS1ikXWI4XA==
Received: from [192.168.126.112] (unknown [147.75.204.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDHSM2sF6z1M9H;
	Wed, 25 Sep 2024 09:21:39 -0400 (EDT)
Message-ID: <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
Date: Wed, 25 Sep 2024 15:20:59 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
Content-Language: en-US
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
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
In-Reply-To: <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-25 15:10, Mathieu Desnoyers wrote:
[...]

Cleaner without goto in the user code:

#include <stdio.h>
#include <stdbool.h>

static inline
bool same_ptr(void *a, void *b)
{
     asm goto (
         "cmpq %[a], %[b]\n\t"
         "jne %l[ne]\n\t"
         : : [a] "r" (a), [b] "r" (b)
         : : ne);
     return true;
ne:
     return false;
}

int x;

int v[2];

int main(void)
{
     if (same_ptr(v, v + 1))
         x = 1;
     printf("%d\n", x);
     return 0;
}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

