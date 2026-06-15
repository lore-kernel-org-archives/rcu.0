Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134D33B5E15
	for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555340; cv=none; b=MFcblUtgF/N6ivJuNHeoqH6MBDpfJ0Ir9JF2CtfYQLE0pfqEtIkIzGXrbxJGEf6VTbw1e4S/1ik2SRpIRF54p3xMZnloBt3PJFfJpgK1x+liASf8x8PL/4lpTuG3JmeZxMm8PrmlB2LtDZHkK9ksMZVs+6QkncgbATUzaadwSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555340; c=relaxed/simple;
	bh=3W+exRfVeOk+9d4eMCZYeHa57RR+U+1NmggjR9Z7Tho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g9ddWuG+cf3wXPBMcSYsxO65id6tyhw0RiEn909OR2fn09tqWqL6q4c3AabV14O6MPo6QJxD/d1JORvHUq9OxEAEmojYo+VV5aNH5SRuU5qHZMxtECTDffg007ERp9G0Hvmoo6ObrXY/Jz6h/Ji/5gwgwqwzDZknLGdlMmIyn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6ivGIk/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6ivGIk/"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6d37b7098so4006763a34.0
        for <rcu@vger.kernel.org>; Mon, 15 Jun 2026 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781555338; x=1782160138; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=K6ivGIk/dUzCp6FY447cJc48etvgQxTXHMv7Zu9hF6fT4SFzxcWDFO6iFA6UmCGRT/
         tsU9Zpep6J29yDEYJqnn39+hNxEkiKG8s+/Lqo9Oik7Epeu1eVb/VI6PflvZFN1ZVFwy
         DA714N5KKMQ0VuwrHU86WdZrXQ5yc3DyrVWV8ctzDianCldBzb232hXI4GHVxp+uO4tQ
         12rmd/YUMyhUY7K2zVwdvr1vhRVB7W8qFWurbGE4FlhUx4TswBZlVvQZky/bbZp8n/h2
         ITZxh2RruvR1Kc/HjDujSMJHtl5igFwsARw8Ujstz45BMQ1MN814a7k9I95U9mzyVdGC
         pgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555338; x=1782160138;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=kk942Pl7xrxwETXmUy+ls6LShqROdglo061N/Rx5VaRctBbSdFR1vmqUp6FZuHDjeS
         AcRvS9zx+Cf/RUd8pe/kgcPHyEOnhEg9SiPiuZcUjLeHPoHFZQ7yt2EPJJ9c1T0CIHsh
         vbmtzOAWzs7AVtU0uch1lA+sJzqQoyFXNzxqTJ5PrWMqfb/uSWED/d4vGik0mvfWjDyh
         QmuwxP8LVeozQ3IvvRok78ZGmHuUEzWV5UNZ6pNxlX0ST9IaCitgvBajbKezQtl5QfSr
         SkT7CAVuRNhE7ZP7i5H3gJMDZohyesNWN5RTUZyVqd4B5Z1/PxOqH8iuald0ks3/L4lh
         vgKA==
X-Forwarded-Encrypted: i=1; AFNElJ9cn8oCO8i27ZkLb2HLMfL2tc5JwfRfWJlDQKC6+DzYpwc/7crjsYpFcEnJ3AEYTk5MdEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePUezb0N8bO/kxJSoLZkOKjYA8su34b3HbDt38cpKr7e5h0Un
	azQeRSpCqbypb2rw2va9VOrQ2B3J0pPByeojigInL4jcGRX14+wpK/hQ
X-Gm-Gg: Acq92OFAqaszpkz1iJgEjQln1SwIPL38+0ovxNzHB83EmyUrgK4nkw+BQkwKKvljh95
	whkbSMYc8XB2Zgpkjfi4vF6dM8uw7YTiX/XIF7QmXphZ2w0pmNu+nAI38JOwQMlCONbbVz7hgyu
	wTMRox/ctM/8ay2/eKUDr+ngprsvpZg37iKe7/Ad2sy6xvmlYKs2DhyNhWRtRD+NNW7mr9JvrOT
	yTnJw27ybacnSOxQPn+HZbequesbd/9rjSmjtwJSgWl1Eq+Zm1GrvDpRt7/62QagYKmIWYAixG0
	xoBygMRHiueHhZ2C3Hd4pyOWTiHj9saQj8niu+QP2/qvqC5WdBE3RkYGt215evV3MN7whEpABb3
	cCc/iJwI9UFlhmm45MYBVLQKL1h0W8A3PDK1pLEid8v9NlN/uXGWAFzYKc6sxIlvdmSht+SwEuB
	ignmXbt/e0AhTM4Z09Jn2xAOCzNi9uvJXUzNCaRMG22LR5otHyaXtL7q87I+64D2jKliuo+oRqb
	wUIawfN8WQSyVax/A==
X-Received: by 2002:a05:6808:690a:b0:47c:b38c:a19a with SMTP id 5614622812f47-4884c10168bmr462076b6e.14.1781555337911;
        Mon, 15 Jun 2026 13:28:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm3252791b6e.7.2026.06.15.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:28:55 -0700
Message-Id: <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock()
 and improve slub_kunit coverage
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> Not the best time to post a series, but didn't want to delay posting
> the series for too long. no pressures ;)  This is aimed to be queued
> for review and testing after the merge window closes.
>
> This series is based on next-20260612, and is also available on
> git.kernel.org [3].
>
> To RCU folks: It would be great if you could kindly take a quick look at
> patch 4 and either ack or nack the patch ;)
>
> To BPF folks: Ulad asked to share workloads to measure performance
> of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
> and have not spent much effort on that. It would be nice if BPF folks
> could help evaluate it on their relevant workloads.

kfree_rcu_nolock() needs to replace bpf_mem_alloc which is backbone
of bpf maps and bpf local storage.
So all of the selftests/bpf/benchs/run_bench_*.sh
will exercise it one way or the other the replacement is complete.
In other words performance is absolutely critical.

>
> To PREEMPT_RT folks: The most relevant part is allowing
> kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleeping
> by acquiring the locks via local_trylock() or spin_trylock_irqsave()
> to avoid sleeping within a raw spinlock. When trylock or unlock is
> unsafe, kmalloc_nolock() always fails.
>
> Changes since RFC v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reduced complexity and intrusiveness (Uladzislau Rezki)
> -------------------------------------------------------
>
> While discussing concerns about the complexity of adding allow_spin
> handling with Ulad (Thanks!), I realized that adding complexity to the
> kvfree_rcu batching is not strictly necessary: only slab objects need to
> be batched, they are already batched by rcu sheaves, and slab already
> supports unknown context. So it is enough to implement only a minimal
> fallback for the sheaves path.
>
> I tried to avoid making intrusive changes to the existing kvfree_rcu
> path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
> following Vlastimil's suggestion, and it is used only in the
> kfree_rcu_nolock() path for now.
>
> As a result, the complexity is significantly reduced and the series
> became much less intrusive. This is also reflected well in the diffstat
> below.

Overall looks good to me.
btw sashiko was confused in few cases.
Not everything that it flags needs a fix. Sometimes it's not an issue at al=
l.
It only sounds like one.

