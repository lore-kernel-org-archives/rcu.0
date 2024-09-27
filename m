Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC71B3B32;
	Fri, 27 Sep 2024 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727478482; cv=none; b=F74CUMDcbz9I7ICctWScdgRg3m9GBM//vCM0cRe7XSo0s+BLPTjaNHXvsMisE62xq/dGrAOlyWYUZ2QDfUDQKnmBl3cIcAGFCgNyLuV1MzbC6qE0Jprz4qGig9iuKJA68NhL2w7UBfSyFd932yvJMBA4aDe3T4CgZZh+PWoinM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727478482; c=relaxed/simple;
	bh=vZdofi7hPf6lEnQiTIeeDsfTwH6BQfwxwcUvBX4YTf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBi+d+gwA4VPfItcjx4A6ZrUX+uxtNtSj+EWKt9oY/bfetahLhiYJs0/OpZ4enfozSzmDU3VwNYcOXOYci5S3R1g1yE3oOIiLvRHMcsDg1hBJSFBUnX6XgbCYr3KWc6aeNkPdN4ldNIehrskFs6kicIF3MjgZFOgnvTqGaw6oq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JaDhKX5p; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JaDhKX5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727478478;
	bh=vZdofi7hPf6lEnQiTIeeDsfTwH6BQfwxwcUvBX4YTf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaDhKX5pM0In4h3su150xOzDBPpxzztbO9HMj1WTFaMEPMaSQEo64Zw3TGTcGOpd7
	 N1Fpz6PBXVflxj0OcasuQvF/8b0lhpwPxC7qwp5MdFRKKbC7+O7yKx/hMrgc5BlBuX
	 h+b5sFhF7GttU/hrbDe9gD6L7gcto0ezXD+523XZf45FTjj0EDxaH2FsUvG1LH0EfK
	 eq6bXxQmSM5SCwB75HDbciW6a2oLpETWgAWDjvDFfjYNabqald4gVJuH992zh4nXet
	 Gtdlz3ARXpqdq+fb5I/X8XM0R0OLDpUOL+G0AknFdRas+0bKrRSLV0tck9Bok9ei9z
	 /rBlmqnfp6Sww==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XFmMy4yh7z1SwZ;
	Fri, 27 Sep 2024 19:07:58 -0400 (EDT)
Message-ID: <23882bd6-c0e0-4f6c-9000-b79216194198@efficios.com>
Date: Fri, 27 Sep 2024 19:05:53 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] compiler.h: Introduce ptr_eq() to preserve address
 dependency
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
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
References: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-27 22:33, Mathieu Desnoyers wrote:
[...]

> ---
>   include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 

I'm wondering if this really belongs in compiler.h, or if it's so
RCU/HP specific that it should be implemented in rcupdate.h ?

[... ]
> +static __always_inline
> +int ptr_eq(const volatile void *a, const volatile void *b)

And perhaps rename this to rcu_ptr_eq() ?

Thanks,

Mathieu

> +{
> +	OPTIMIZER_HIDE_VAR(a);
> +	OPTIMIZER_HIDE_VAR(b);
> +	return a == b;
> +}
> +



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

