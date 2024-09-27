Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092446B8;
	Fri, 27 Sep 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467954; cv=none; b=f/pnf5Im7wrd5Mur9V7zPd3p9vQ45Gi5LNXgcwJ3Z8yEIKLTXlfWbCPLuvO+WlXI1gAezo/QBfpD2fNIuqrB/uwF3vey+7TOyO4VgMOnFJngrZxqYLqI5Uw9weMVn38Nb5T3kE9XRQ3q8mszWp7C4KAZsMANI6rl8HPBTlOSIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467954; c=relaxed/simple;
	bh=giYaesQDn/2SyGYHPHFv51rKO/LSurqf9VIA4G1DfXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRJEE9IondRKI7KRCEIoFw5XHdPSMDjPA8v93kc/s4axaPD1CS928/7r2RMhF9euhpbClWTqVoyq6fWQbD8wu+7A2ROJq9O+4HYlpZQuqPcr74SA2/KI05O/AfHuB85LZvk0Ol6r6gk1dT0zFSuhGzlaG+lyCw002CZ7FApUD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h/gVdDqW; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h/gVdDqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727467949;
	bh=giYaesQDn/2SyGYHPHFv51rKO/LSurqf9VIA4G1DfXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h/gVdDqWm/SS892LiCq+fgT33YFdAPHAxwlH9+UWeKHgPVdc7bc/tgiqXEpouAlO1
	 qLxRwOMf1oGIKWfL8m1tnkw/5q0czWgmROZIJtEMof+Mc5GFh+h0TiQZB+3Nft7nKO
	 5lxvA5J08rSnVlJRKM5V8plqzEfCcSEGn1+IxgUADjj4OW0bPl6L+bSpVk+F1koTU5
	 Xo8+OK17DXBvFqRjU3iIICo8IHab0Hd7OZKtofWor67rsDnUZMglqv4AYlgddx3rsz
	 NcmQrGRfZPallzkvkih/4r9w0ueaUYeEd4K9tMpBOTteFxxKV+93CSXixgKlk6H3Dz
	 Hr+XeRd+oBkcA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFhTT2srmz1RXx;
	Fri, 27 Sep 2024 16:12:29 -0400 (EDT)
Message-ID: <d86536d9-9c5a-48ab-abf3-3483e2e5e980@efficios.com>
Date: Fri, 27 Sep 2024 16:10:25 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] hazptr: Add initial implementation of hazard
 pointers
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <ZvPp4taB9uu__oSQ@boqun-archlinux>
 <4167e6f5-4ff9-4aaa-915e-c1e692ac785a@efficios.com>
 <ZvP_H_R43bXpmkMS@boqun-archlinux>
 <a87040be-890b-4e83-86bb-5018da4a894d@efficios.com>
 <48992c9f-6c61-4716-977c-66e946adb399@efficios.com>
 <e2733938-06fa-46c3-8839-4349fe50d46f@efficios.com>
 <2b2aea37-06fe-40cb-8458-9408406ebda6@efficios.com>
 <55633835-242c-4d7f-875b-24b16f17939c@huaweicloud.com>
 <CAHk-=wjL803+FxtAPSGrWqThGQP5cCHzzwZJFq+-fkgt5DQ3VQ@mail.gmail.com>
 <bba2e656-4c3b-46db-b308-483de440b922@efficios.com>
 <ZvY2zBiluLkqRSkc@boqun-archlinux>
 <62508c1f-66ca-450d-abb6-236ca3b9096d@huaweicloud.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <62508c1f-66ca-450d-abb6-236ca3b9096d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-09-27 21:23, Jonas Oberhauser wrote:
[...]
> That idea seems to be confirmed by this (atrocious, not to be copied!) 
> example:
> 
> int fct_escape_address_of_b(void)
> {
>      int *a, *b;
> 
>      do {
>          a = READ_ONCE(p);
>          asm volatile ("" : : : "memory");
>          b = READ_ONCE(p);
>      } while (a != b);
> 
>      // really really hide b
>      int **p = &b;
>      OPTIMIZER_HIDE_VAR(p);
> 
>      asm volatile ("" : : : "memory");
>      return *b;
> }
> 
> This also does not generate any additional instructions, unlike just 
> using OPTIMIZER_HIDE_VAR(b).
> 
> What is the advantage of defining OPTIMIZE_HIDE_VAR the way it currently 
> works instead of like above?

Did you try it on godbolt.org ? Does it have the intended effect ?
By the looks of it, you're just creating another version of @b called
"p", which is then never used and would be discarded by further
optimization. I'm unsure what you are trying to achieve here.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

