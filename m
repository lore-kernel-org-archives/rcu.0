Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6528E0
	for <rcu@vger.kernel.org>; Thu, 12 Feb 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770923767; cv=pass; b=AihwS8+UymlsCUWkbXBaIqR6QmOptQyxDth16DFTwyrsNn02aRB4TTmpxFQleH4G1nyJOIN6A5lnb+uzo/88KfsxNMeGjGFomo4PHlQr357XKBo8n5BRuF1mCva6A9Wc4GhgWJ1mNEdn4MRe2ejhHY3BxaQ9BS4GP76jXQrZ34c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770923767; c=relaxed/simple;
	bh=qlrNwdBTPBiHmIII6NewTsfdeTe+gakww2NBTJP2Qwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeE4nXE4w6OUXJt+ZjI4MUDDWzW0LQJJfi3KJUkGBIIvrQJBDd33iymqnHH7oFsOsw+rD80nS/WTdKYlIogTTocNQjnLMbYfXV0L44p8dOWyQMfvcwspgAgx1m9gg4ZP59rI+Ja5tZhFSBAP/NCMn8ejfi5cdhA+m92Z02mfdTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/2skPy3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/2skPy3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-482f2599980so2188365e9.0
        for <rcu@vger.kernel.org>; Thu, 12 Feb 2026 11:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770923764; cv=none;
        d=google.com; s=arc-20240605;
        b=LKh37gomsj1F8CpZTlVn/112tmQo2u1DqT3L3OozoiE5GlmRKL/R0h1ItQJ7aAR2cj
         sHmU6bKvu8vJhLv6n0sbtg126LS5BSx6ckmv3NXmcytg5Txae7a8W7UJmYqP2iWUZULu
         pLfUmdy81GDyHrsNTeQhwHqDbKs85gmIl54HbHxjEADGAvJri7jryjm4ILEB/VgtaWDZ
         yyYebzRU6YqUCJnGFepHBUuszKdmjknWGWTFL5CUcP1wznyQHeCECb2stt8MoEnEquuW
         xYuzTlW5jRquYcPsQilamzaHRyfcDOozWhXB2pVvJn6D9FttxDNZr8/D0qq/KQt3L2qR
         tMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        fh=UMvtJyjHWHktC3STAuFXaBSq+h9FeShglc9y592K/V0=;
        b=B8Z8GWWzADfNg5N/J1TXWxqJxRhBYemqJbiKo4wfiNp2J3zzkXlD3iRnvcuctIfgL7
         t2Tfrr548y3t1MNybPmUSgaUlBQg4+2q2bToccSnbAzBAmYy9XWCvTlf+WHJ2vlcRE5f
         g5gXABJWvlOsJ2clugyA+fadqIK3JGOMWg1AZokQxpoja1aGeOI0f0D5o8bG6NpJfPuw
         T8xXiEC/aw8sFxAQoytvMVV9UxS8BRcy8Y/AHg72SEGKUvbhc9ju0tqVHgCeTobzoXjC
         chJm3o2IEDt+v8AfjbrWWUlZC/uRJIkg0+BGj8ToIMvI89OvDoGISew1pAMCrFZKqEqu
         PhnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770923764; x=1771528564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        b=R/2skPy3uXvqYVtqfCJRs6dpYyqOTrYjF6iG3TokMqiZ0D1222ppXLe9FZGSAgRxkD
         mJbKwUeEqT0hUidskUQd9/v9WMd9gE5NtVmYG5lGPfoZi/i8j64ZD6FZ52G1yI0EiGIx
         xliOUyqu0TzKqbnMShW+w3ntGzTiBConyWsBwCzUym7R31d8lIW2d4s1BYP94Nay6G5T
         LqMEkgAw4E+tyIA7263bMGz/IJGBBH/ec61iZGW04j5hL/3CsXO8Wd90ybhvpNI9kX5c
         /8ul67iY23lVii5EeL6r5tY++rKRmSqpHVwlTkFaJNzk52a2Zs5EW0wIo41Nfz8N8kif
         LpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770923764; x=1771528564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34GBq/w9QEN1MAXl5GyaptaVmrZQSD6tth2MQtzvH/8=;
        b=f7V662vex+12372+3t08+bTMuMZ1zeKeUJqkx2OLY9JZXzk+Dp8HYZ/PxVxbyan5JM
         /MJQ0j+BxV+e4by164eHIlffF26+DzR2ad8gCVDVCbEPqz2CbhuZlOehXqsvxsTGFcF7
         Aa9b3Z/zhreiNawFTZcAzoQBempxuf20bUlh4E2lLvjm7JQ+zrCeG2O0svXqsZ3Abm2y
         wLXwkoH6aKEArvSsSB+d4zcWraSmrIna8I3uHnkBO5d8Q3X5cs8zx9qqC6M45HhYHFQG
         9uZ5CXY4Ua/YDcA3lEL4HTDS38BOcX2pJvTbMsoDVdKpZZ3bTN9bnnytkVYirsOfnAjb
         Znyw==
X-Forwarded-Encrypted: i=1; AJvYcCWukG2huJCwfisX6QQYQ4/w1RJ6m8guJUCTN2+jYcdp1dUqDBNHZeCZRcvm4lJZxCpXx1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgrC/2nfORjdJudVtD27Zl9MywztdhRpWTdynVsK6QRnj9U+5
	lNAii90/KKUa8MWTBSB8+JaqtgW/tHmZnozcUAU05wGvqPcqghwWx9dAkGtKtKS2KA0RBpw3U7P
	GmmbBN3xTrjyi3X7zJW/ApuL1elfHDpQ=
X-Gm-Gg: AZuq6aKKCtrR+D1509CNqhuqaGs3Ak7CKjflZzYrGZiZW0G869CzF2YJdLaCUXQVVBP
	1kZfM7sy3MfOEH8Ez/4UDXEx0pUck/6rFZG6TA8o4FjghVkcSVF4vJJEvZlbG66DNFWNO1q8ok1
	1AIPjleXHte9WFcMcag2yOre4EK/2oIDe6Okmh6C2uHyqsijpboGkvS4+nyNEbLQyZtBVjQidn/
	QLJ57S2lV7GI5GsUKBCk9SkD437nWM5kaZzoqxKZmweUQ6wbqqNXLYCxBQzIgw//lDJcLp4jD0h
	TojGAkUQJTNEpSd1tga1mUWIzj3MFx6+JZVMxNsYv7U686tn1RC8UfWWfE4gJEVvXGauhczKiDR
	wv6EEIZmS
X-Received: by 2002:a05:600c:4f0b:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-48370cc979bmr3868275e9.0.1770923764039; Thu, 12 Feb 2026
 11:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-8-harry.yoo@oracle.com>
In-Reply-To: <20260206093410.160622-8-harry.yoo@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Feb 2026 11:15:52 -0800
X-Gm-Features: AZwV_QheBogDYj3hjqCT8mZg95VywPTWK4lWyWbkX01r20D5GbhYKN4gZGkX0C8
Message-ID: <CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] mm/slab: make kfree_rcu_nolock() work with sheaves
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:35=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wro=
te:
>
>         } else {
> +               if (unlikely(!allow_spin)) {
> +                       /* call_rcu() does not support NMI context */
> +                       rcu_sheaf->size--;
> +                       local_unlock(&s->cpu_sheaves->lock);
> +                       goto fail;

As a first step it's ok, but we need to make call_rcu() work too.
Shouldn't be too hard. It protects itself with local_irq_save,
so if (irqs_disabled()) defer to irq_work and call_rcu there
or guard reentrance into __call_rcu_common() with per-cpu busy counter.
rcu_head can be reused to form list of objects to be processed in irq work.
