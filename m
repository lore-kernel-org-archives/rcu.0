Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795505460;
	b=zbYHuPyYpomd1a7v1Qw7FN7JaLmYxsFRzkZK1fEa0B/Skiqi2Ogd4nz09OWxT6fRkiL/
	 Q9NqbQXN0DmR/msZgqWdw5odK0p/QADUXLRvv0qtN8AaYrZ16RBGcfhfrpC6q0q/oecxx
	 5SgkgjHvpLeEEyK4zGPECwWs6ma/U8OUGn9DzcaQsygZ7AWba2POaRyZ40IKZTxNhFAcF
	 P3REFFCWHmNlp18hwdN9h81hCpurQg3NYk9ZcLkm3sPnfaBq89pbU+fWCmIImErW5XNli
	 rYDr1vOTh2EgKr35j+PLjEWTDaNk0PKOciA191JPAxYPFYNIAeEQJUFoufPXefGz2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505460;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ICKsbXWih1ldCpzpgsQ/uVr8XB4yjrWqfudWCRA9yjQ=;
	b=aXYa4GOcU7/QAulusZaigHdvGdvEGSh6myrM4XTv/B6LmrvuG9r0V6fJPsBglGSSQnsT
	 v9+3WCgFy65BNpYvSZcxo8PHrvyWjK/23tomHgmiaE7wJv9DZ8ryB4rtiCjcx15joIO89
	 FbfpBjGKUKOHjtQaxEyLC/CUXM5w3VZFQFzJFjS4wESM4TVyeJleImqCQJ7ST70+fzWIb
	 ZOimSwAdjmZczK9NjIJ3jj4zy9Bh4yQtBccH7WGmGkBop2FVWGKGai0K+u9tDtsyhe+5v
	 JSmUjRX0ALX91/DoURT6ntvoKwsGcOjcZmKB35obqbbq+Z71jZNuJuE4LMQaqtjzHbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iSgSVTaN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fl4STBlE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AD606A322
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 07:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 908AD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iSgSVTaN;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fl4STBlE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795505458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ICKsbXWih1ldCpzpgsQ/uVr8XB4yjrWqfudWCRA9yjQ=;
	b=iSgSVTaNzPE05kdPCdtLfy9inr8+a/4utPK/lJ/ziFcNQ6Fj7AmTphzlPClfrEsAt/xp8G
	FhkX2SqaUooDYsUk0A7Q/u8LVgGCbZojSEyYAZJWW+zsNTIcbgWKJeZW9p1ikGXG9u7udJ
	R/a8ZSYy9A5rqYWgaiOUdX6jLkSfVFk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-BpjTL9EbN6qRtOpqG2NHkQ-1; Tue, 24 Nov 2026 07:30:56 +0000
X-MC-Unique: BpjTL9EbN6qRtOpqG2NHkQ-1
X-Mimecast-MFC-AGG-ID: BpjTL9EbN6qRtOpqG2NHkQ_1795505455
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4925ef75fc4so2587816f8f.1
        for <rcu@vger.kernel.org>; Mon, 23 Nov 2026 23:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795505455; x=1796110255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ICKsbXWih1ldCpzpgsQ/uVr8XB4yjrWqfudWCRA9yjQ=;
        b=fl4STBlE9F1zbALKvAgq9KByunB0yybbrYxsmospRkTMqV1a417MCXou9JDE2M9xEd
         bl/aBFHlfsuvG0pYnM6Xzz7qDWt4z0as4zGyq+sC6BUN5xNac79BmxBvaRqOpW1910ja
         rdXBmH0ELa3SHD8SJZS2QrRU8ZZJVbUTboFBEDWaW0gdvZLUG1N3mrs2ChdXrchmPO6x
         C3yTWAsgmxIIANk1+K6MCK8b/Rnl/LjGyYl27kVyGP3AW780DdCATtGAsSeaturDjF0P
         +jBn1SJQHZpjuGCxRcc0Ccmv1eLN/6+ULnb5xxF1JlTzP06kPfaEFvuiwMNAjRui/bhG
         UFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505455; x=1796110255;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ICKsbXWih1ldCpzpgsQ/uVr8XB4yjrWqfudWCRA9yjQ=;
        b=G+Px0hywz/az8yfeKJmBVwNudgugu0YEHbPulvmcbGes8mppNOQDwWRr8GTUCCjHce
         xwPsLfiFWfm5ifvC/QGVWeaqihKuhAvKQYzWkPFmOR3v83EyI3JvJaK6N4NeRGfv51Kb
         aCi22auJwCnqM8H8gVjAyJYuAP5XiOdLqWabH7ExAQP1BZxnDWKuueZRXmMO/H/iDbNi
         NKhllMW69hL8CHY/NwH/W64QSM3m3AwKizYdqW18nP8VBxp23CxVroU+yxbzb7MASLYu
         G49IyIJTon3yXmKNEmHn/lJV/V2FNbR6pBb55dtBA/lpKfjj9E4zIaVEVJkwsXU4j49k
         7mqg==
X-Forwarded-Encrypted: i=1; AL+hErFItxR/81gLmHFV0N8EinjY+oMciF/BEeVCHz5mR8lSTgdysdOvIPtvAfaqyeQspq5hJJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+X/ZUCLQ+MC3oUQUNyJ/dDLp23VAv9ShC1aQoaVRmf/AAFJFk+
	gfj2OFLIgCBq7f6rx+Pqebqb5vqBWuEGtTZvS/Qp9KYJso5PO8HYbml278ZzN/UCIMLIbADiO1B
	eqc8VIwuGEN9gBoMM5hzvoA0WCg37KC5D7WZt+ewWoftYuR21vEfNAA==
X-Gm-Gg: AZFdTZdlSqw4wpm2+UUswcgiw61h+rlFmOY4FKHv1Km1Rit7+2fro1WdPqFI04DWjaG
	JPZqJQtNUuDCMUHrgfSy49NNFaYc+vwzv4kgQlGZNbTVb/s7bqkYvlX2gUtMXLE2Gn+24cm55n1
	ANz5GN8ZT+xLI0pAaFhxQeM4Ok4/BUtKKp4I98tILq6ZzP61oCK97CtCp06Jb+yxax7iPs4zbBK
	TfKrsvh7X6zT+FQZIqIupRXz+4Go4LQDbcuUe4V99pfY9E92ikvFx8QjN7vGdA3NrjMQuGg3gPt
	+wLzwO87IjWWPG2+Xu6y8pJxaVvi/xir5eTPv1RcxX/tl5+N0DfwK0Nan5ZBmLORaBP/4V/nFkp
	b4YIPKR0t10Wti6D4BRiKWPUYiUPFqJxZ5UypEufHXULoJ3jOV1PRGu4zcaaMuG8cdqRpDv8hir
	fBZqA=
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr308304115e9.12.1795505455048;
        Mon, 23 Nov 2026 23:30:55 -0800 (PST)
X-Received: by 2002:a05:600c:1911:b0:4ba:38a9:85e3 with SMTP id 5b1f17b1804b1-4bb8880eecbmr308303335e9.12.1795505454675;
        Mon, 23 Nov 2026 23:30:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865b1sm407760395e9.5.2026.11.23.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 23:30:54 -0800 (PST)
Date: Tue, 24 Nov 2026 08:30:50 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 2/6] sched: Move DL's admission control to sysfs
Message-ID: <awU9KmFsbiyvbcOr@jlelli-thinkpadt14gen4.remote.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-2-d523e4d960d3@linutronix.de>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-sched_dl-v4-2-d523e4d960d3@linutronix.de>

Hello,

On 23/11/26 14:41, Sebastian Andrzej Siewior wrote:

...

> @@ -2882,26 +2881,18 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>  		if (ret)
>  			goto undo;
>  
> -		ret = sched_dl_global_validate();
> +		ret = sched_dl_try_boundary(sysctl_sched_rt_runtime,
> +					    sysctl_sched_rt_period);
>  		if (ret)
>  			goto undo;
> -
> -		sched_dl_do_global();

Nothing updates sysctl_sched_rt_{period,runtime} when the sysfs files
are written, but this always passes both, so a procfs write of one knob
resets the other to its stale sysctl value? E.g. write 2000000 to
dl_period_us, then -1 to sched_rt_runtime_us: admission control is
disabled as expected, but sysctl_sched_rt_period is still 1000000 and
the period is back to 1s.

Thanks,
Juri
