Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C821308F28
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255524; cv=none; b=ACrjfw580/g6+wTtwQHVgUTCn1Pw5c16SPySjZgg6GGa8/t/PDE0G0sYDYZh0mRsIeOQEmRvQEiS/ZIRDGm7rJ69XH6HNu9Yig+53vwUPWBXV1KwNsVgHBCq/d87g/W8gDZ9l+Zox+eHseDYnC9O5ADXjkqJBa98mrqmznldpVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255524; c=relaxed/simple;
	bh=AWbovU9yx+EpWoS2uH0YQS2sLaGQNcCturbavPTShxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixSQcfqn1+sl3wDvymnxPmheZbEhCB6CqFUaJK8EQL3kLqi+W/7ma2xzZv3zuQZ0qSXvbKGy14QUG/+HuvHuUGChiNAQUGaM2jVizdlXKIaunIMArDeXgw2VIBx7PQHqlRbqX1fQ9DdB4AmYcl5i9O683dxJ023VtyB8cpSWq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EjkUZ1Nd; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EjkUZ1Nd"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dqmdt6LgBzlfvpL
	for <rcu@vger.kernel.org>; Mon, 12 Jan 2026 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768255522; x=1770847523; bh=z9Y4BPiPU5vZeqyn1OIEPskt
	kMud/fciou6gPOxT/Gg=; b=EjkUZ1NdFd/F97FXYz9KdZpK3Od+wJcBrM7UemIn
	Me5qpjdizDTya8hE+51iNAgUPWbIkOYkKEsnR7PROZ1Bu1DZiRO0crdcS9RnrCEu
	opUtuBPC+VL0PE91/E6AWdR0W+5fj/1Dx32NoExgSqQXyXaV360nwT5+6xsVk3vR
	LiH05oMQh3BWc5uQ1RzNzJBLi02IHDzse9OMSKGLz7zgiLonpiS3+0yiG7+mOGN2
	/HnqEblB+WMyAasfe4tjsJLjDlxOG4dqNs2EbhlXINnCK2FXr7vNMb72UKrLNnaE
	ogh0Zsm5BYm+r4cF9PDn2lvz4BSNX0TvZLjCfbO26k+kLQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id izkcoWxq3rhs for <rcu@vger.kernel.org>;
 Mon, 12 Jan 2026 22:05:22 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dqmdS2QtzzllB6t;
	Mon, 12 Jan 2026 22:04:59 +0000 (UTC)
Message-ID: <3de714fc-7a18-4bcc-9ab5-c3831efbdb84@acm.org>
Date: Mon, 12 Jan 2026 14:04:59 -0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] sched: Enable context analysis for core.c and
 fair.c
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-37-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-37-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index a63f65aa5bdd..a22248aebcf9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -738,10 +738,12 @@ static inline int thread_group_empty(struct task_struct *p)
>   		(thread_group_leader(p) && !thread_group_empty(p))
>   
>   extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
> -						unsigned long *flags);
> +						unsigned long *flags)
> +	__acquires(&task->sighand->siglock);

I think the above annotation is wrong and should be changed into
__cond_acquires(nonnull, &task->sighand->siglock). My understanding of
the code in kernel/signal.c is that lock_task_sighand() only returns
with sighand->siglock acquired if it returns a non-NULL pointer.

Bart.
