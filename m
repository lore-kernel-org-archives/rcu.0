Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757283;
	b=HQfU8hpXqpDccrKgautf69cxWOaS99/6xv//sxPbYlTHLJCS4WNrJuRXGWnZLm2avtDC
	 hiSQMyM/180609knBYlRuNGoj5zIRm54gn5Bj5B0Ca/JaSwuAs9yYdllGofkm/OwKbEGV
	 tg99MmRRoZF/TTgKN+nzzwveXPcl5Kln5GZjGw2odbtk0WfkCeh1eYk8Ew7fFWrBXIEUz
	 uvWVGhE8b3c7PDVmUpvlwVLHBMmINGjkPFl1e0GV1376loBdDE3m5/5Fw5V+Lixza3kP1
	 6W+p0HQV16cMvXEnyED/2TwG2/yrgwCKSxysLbnk7aVipl/WWz7xPOEXAkdT2K1r7gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RdXJI0x7HsNY2cGNP3WXBwk0wIy56kzCps1jgvgyMwQ=;
	b=gkxIRIIOVDOOlPJUAfQ4sXA7Avxpy9RTVT6kL3ZU/rkQkkV9/o54rGk8TKnyo/ZzziAm
	 xGExRKS6SkUmNnYIiKhz8iYkAwePeYhJbIl+akFHSjKWeiu3M8ncAY+wSBJDh8W215pko
	 t3pjs/LExfwFSC4rU4dQdRoXwxtbgFTRqrmjiBdI1GAPoFA8PAVTm4aVfu9FR775UgWbm
	 jd+S/p8QO+vE2ee5jVbSy4FJKo2+ElzoLGWg1qVlBau3jZCktMW8o7LfgqeobNp3rLpRt
	 +IHpVXony/Hev/t40z+2qDtsj0varQcji0Nrw42Tl/I3SVvSeoUg8peIHSW9wEHvjDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fq9jNBy7;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D60606A31E
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D60606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fq9jNBy7
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49d05d51553so5646535e9.2
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 05:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757282; x=1793362082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RdXJI0x7HsNY2cGNP3WXBwk0wIy56kzCps1jgvgyMwQ=;
        b=fq9jNBy7VQCVOPP1Lmy75+Xjjtus69mYqfyB2DOr4z0dQhPOWCJhqx3VGXG5EcWKRd
         BUlUuCRfr85TT5U9pG9X54OQB+XXAQ8eutJxzi8H4MY5r8NG5KR4Oj+iUFIMNQB2Vk8T
         lM8MXSEd80Hsh+XbhJkwteVw4cLT5U/N9iKA/KOVbTVIhic4jvpJqR5ue6bU9bGsJVtH
         XdC91w/IQGECN+ush3zJFzgS9j8Vq2BUuyXQ7NWIt0sGQHHA7CHyzu1WPwCK5ibQqiBw
         TDAvgEqKa696/FwUfBGgSW86i1Xc+10d08dwrxjbL3gOeGuC91dE/wGDqVjbMcUlsXLI
         dOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757282; x=1793362082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RdXJI0x7HsNY2cGNP3WXBwk0wIy56kzCps1jgvgyMwQ=;
        b=l8690vUmrCS1YkyNqbijcZEF5oyCsHkvApow+XVQmBCulP4/67LszKUpt2y9y3ou6z
         PMBQxrNwpXAZ6/A0veAtfypro6lYofd1KqDZhrdkU8+I0Xe05q8Ha5vE7UFSIayt28tt
         GaKYKuMxQnmOSHCjuvmc7ybXtYCDtRnXVOyDb354FE0JKR9crEOTUBnpMBK7WySRhHxh
         PV2kBIOv5pzjVVxQH8hjRBW9mvpkd2o+SoPFFtGY2eFNfI5fhEUtMKgDFNvHAJPb3usy
         nOre8HPjR67oRaqJqQBkyeVKpTvWKtJcQUJU+lOZq1Mnb/BJFNg0N1ExV0JGKZahjuyT
         JwAw==
X-Forwarded-Encrypted: i=1; AKwUvBxTH4ve52N7jn7TU2FqUhlBhL/cTCIWqGSmkyOe8JWk507jpN/JwV1HCQyhBp40mnh/88Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxRF+05XWYTEbi/0MzwOZCY/c38pTxJUVBsvzXxkjsYrKbYklB
	k3ESpY49drc7lkhpnjyOhVNlng5STuzVTXiiVuK13a6jOY9E5szOEJej
X-Gm-Gg: AYBFou1hhcijqi/SBJB2I9nS7UPE/ltqpQ0DvmUIis8IdSaVAbTCsu2XcxvZWwBUbDN
	GWc7cs6I354XjZSR10OWqCCaUUeQV4pC4ZlUU3LfqWXGB8u2/0YR8fnjtkaaG51nxNnXiou9wh3
	Vr+RL3O/am4055Lyek5OUxFsTkkTjAsasd/+MOJR7V/Y5sIIktm3/ONyva6yPK2RLqkkjzHZdcd
	pmBe+pO2MVzNDYhR0+K5m30vMDxKqMCfD3fpNnmefTnCv+ywgq8DFT/hVWM2W2VnfspybZPNTdz
	XAH6ZpzkKzSoNn7W+XsTF54/AUvCVU+5mjnqc3sRoeFfqdADDIUBgD0XK0NNDbAd0mic0SFBzIU
	lYCLzS6LwrWj2nmORqVc8exaqmzioBISKy6Y2XO4kkkMZKcGPk24PsGzDxDbiHCnxqrNkLmpJZ+
	406nwBGRGtMFjlZkVyiLWUBe8c87ZnUFa2w+rBWz6x/LA1ZoS16tsLvtBkTQu9o35ODa3aafYKn
	lO78uGw0skmV5vP4cgcLZRznqBDI5G3FvOvxBlwpdQ5/9/78MyXfFRw22bOREocMZZvDB9A95HL
	TaQc2u69XhOCVaJsuTG9hVOp
X-Received: by 2002:a05:600c:64c7:b0:4a1:93fd:8f8 with SMTP id 5b1f17b1804b1-4a211bf21f9mr31104145e9.4.1792757281607;
        Fri, 23 Oct 2026 05:08:01 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a29cdc74b7sm686225e9.14.2026.10.23.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:08:00 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Fri, 23 Oct 2026 14:07:54 +0200
Message-ID: <20261023120755.2463384-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <579683e2-ee2a-46e8-8bf3-f7ecc5547581@paulmck-laptop>
References: <20261019162005.12888-1-parri.andrea@gmail.com> <3e7abe29-df1f-4cb6-884f-dd0a70c5311f@paulmck-laptop> <20261021090652.20333-1-parri.andrea@gmail.com> <45a6159e-1bcd-45d4-af25-baddf729ac54@paulmck-laptop> <20261022125556.3559773-1-parri.andrea@gmail.com> <579683e2-ee2a-46e8-8bf3-f7ecc5547581@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 03:55:44PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 22, 2026 at 02:55:55PM +0200, Andrea Parri wrote:

[...]

> Then let's please keep the torture_must_stop() check.  Yes, there is
> still a window between the return from torture_must_stop() and the
> call to torture_hrtimeout_ms(), but maybe that is something to take
> care of later on.

Will do.

[...]

> Yes, agreed, almost:
>
> o	Keep the hazptr_torture_do_pending() do-while loop as it
> 	is, but add the for_each_possible_cpu() after loop exit.
>
> o	Stop the readers first, stop hazptr_torture_do_pending()
> 	to flush out anything left from the readers, then stop
> 	the writer.
>
> However, for the "almost", note that the "while (!torture_must_stop())"
> needs to become "while (!kthread_should_stop())".  If this change is
> not made, then hazptr_torture_do_pending() will exit its do-while loop
> as soon as hazptr_torture_cleanup() calls torture_cleanup_begin().
> This will of course defeat the reordering.
>
> Does that work, or am I still missing something?

do_pending does leave the loop then, but the final pass goes after
torture_kthread_stopping(), not right after the loop:

	} while (!torture_must_stop());
	torture_kthread_stopping("hazptr_torture_do_pending");
	/* The readers have stopped, so nothing new can be deferred. */
	for_each_possible_cpu(cpu)
		hazptr_torture_do_one_pending(cpu, &rand);
	return 0;

torture_kthread_stopping() sleeps HZ/20 at a time until
kthread_should_stop(), so the pass runs only once
hazptr_torture_cleanup() stops do_pending, after the readers.

With "while (!kthread_should_stop())" and the torture_must_stop()
check before the sleep, do_pending would instead spin without sleeping
from torture_cleanup_begin() until it is stopped.

> Alternatively, you could keep the current do-while condition and place
> a loop around your post-do-while code like this:
>
> 	while (!kthread_should_stop())
> 		for_each_possible_cpu(cpu)
> 			hazptr_torture_do_one_pending(cpu, &rand);
>
> But changing the do-while condition looks cleaner to me.

That loop would spin too.

> This code will also need adjustment when something like a call_hazptr()
> is added, presumably along with a hazptr_barrier(), but we can worry
> about that when it happens.

Agreed.

I have been running this version locally, with the rest of v1: a
30-minute PREEMPT run, and a 30-minute NOPREEMPT run with
torture_type=hazptr, pass.  With kthread_do_pending_ms=10000, the
shutdown still takes less than 150ms.  If it works for you, v1 will
have it.

Thanks,
  Andrea
