Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375517334E;
	Thu, 26 Sep 2024 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331414; cv=none; b=aMO/I0FbLR+JQJaXrP37oWVx0/3ibzBZm6wcndv7wv15CVUOehfh8cX4/nOylqoUpTg8e5PYGV8TE7UI1zpX4qG1RUJ3WtUCssvBUXrnLWhhnVxt/fIKiZQx5oQsvSYxSYJ/wK6qf44WzAvTAPy9rfWiRNYdAnB4kjNOSXQjB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331414; c=relaxed/simple;
	bh=2MryQ9y2u2yCeiP4+Tmgt60Q1T0o9VzZCCgVPAQ/SZU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JzUrH+ipAFcqx3PUY1gy6N64OeHiX2+gdRCKHjoPMgc1J1jWJKob1J1Ecqc/7p5X6qh2bJKyLtdZvJCGx1fEp145yW0iBtaz22iLsra7XskNK+5fXLAFHJhHIlVoZcd7g062hnweWTOl+Zo0Izdyb+45xzxfZOkCtb6ZJ3vUuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=uaTffgAN; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uaTffgAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727331410;
	bh=2MryQ9y2u2yCeiP4+Tmgt60Q1T0o9VzZCCgVPAQ/SZU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=uaTffgANpcaUG2l8vb0K1oMGlBXjCqou0aHpmIM+BLQrVN0IZp2fMg7Ssvr+ZRW3R
	 XUsN8xAiiO2th9NYdxyix6uCqOlSPM5iCEheI1dGDlT6uC6gPe+DD33cXoJxKidxMK
	 z75GOFKd2AEr4AHEf/516Z/+Acb1iEKhyEKZjwTx9O9WIje0J02IexJFYPA/bPu11/
	 joB/V6tVu5lfcC4w89rfGmD3CWDkkGEIIa6fSreoibsZVGe/JPFeSNiQeBw9RqSDwD
	 vEMWG0p4v4n0sg15c9W6UkNh//E9gmUpFgVWjE8L+t76+j6YGT2bOquVMAx3P5eO73
	 6e92FeOV8q31Q==
Received: from [172.17.2.162] (unknown [178.208.16.192])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XDjzg1sCtz1M6s;
	Thu, 26 Sep 2024 02:16:47 -0400 (EDT)
Message-ID: <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
Date: Thu, 26 Sep 2024 08:16:08 +0200
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
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
Content-Language: en-US
In-Reply-To: <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-25 15:20, Mathieu Desnoyers wrote:
[...]
> static inline
> bool same_ptr(void *a, void *b)
> {
>      asm goto (
>          "cmpq %[a], %[b]\n\t"
>          "jne %l[ne]\n\t"
>          : : [a] "r" (a), [b] "r" (b)
>          : : ne);
>      return true;
> ne:
>      return false;
> }

Based on the information provided in this email thread,
it appears the only concern when it comes to comparing a
pointer loaded by rcu_dereference() with another pointer
is the possibility of compiler optimizations.

In the specific case of hazard pointer hpref_hp_get(), this
function does both loads which are then compared with one
another. Therefore, it is not possible for the user to
provide a comparison value known at compile-time, except
in the unlikely scenario where the hazard pointer would
be const, which does not really make much sense.

Therefore, just using rcu_dereference() for the second
load should be fine.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

