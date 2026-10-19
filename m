Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431161;
	b=N9VjDenTd6wPFpdVuVXtt9MijJuOjp6ltPP0gu3+BOjgF4qrlGd3dnlri03PoWauGxsO
	 UD6C0U1cy8wfaEqAcBQnbhp48ogXJXr1KZr9OLOXlXD9aP2IBToOSqy0XVkQ6V7kcwF7Z
	 Ee6QqXlT7iGyOMXA+RH/LzJAa0C/ZVL1XP+MOKLtGK2Z6gvwj6qzTQ61ZhVT36svyPvkT
	 WD1qAagOxavWaQPIvCgTylbT8JAfhXQ94bLtjzkgmGpPiYiHwJ0EulAgHh4HSQ4uD0xPS
	 IcQWWWDp/HseciPR3JkcvK6eV1Cf6w52K/JY/6hRjGvkNnKQuBA1xWNsRM5LZLgxFAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=eLclega7SUgAlrP/YHd7B9RgRT5ZefPwtKid3vUTNJk=;
	b=20yHKxUVQg3CrEDa15CIz4DOba4CS2mxqyjBDFcjluJm8Y+QI6tv44v7/IrcTY8nWnLc
	 nNA5XQgGo10jcoMMpWrijgBN2AQwF7DigbNk1gOObMtUgiS/blCHOwKONLXWv3gm2Vyvd
	 RELbnddSTW/vdxPZsamjGUiz8FmY0nGTaLYoXJQMutlUUUrB/iPj2lPhYHZ2JVp/ZMUOy
	 G5SqhAlDR5U1y9T5qEaCoMpTcaqSwEmi0rLWYSCkbWRyuibof2upxNoTE4kIe+oZ9s71C
	 +2KXsQe36SLH8W8/MWp5gJoRV9BHI8YDDsfo6ZMEcw14NwuK3/QZy+OKprhwNabyjVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k915gHaf;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96983606A31A
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 17:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96983606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k915gHaf
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1783855f8f.0
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431160; x=1793035960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLclega7SUgAlrP/YHd7B9RgRT5ZefPwtKid3vUTNJk=;
        b=k915gHafF+/iVY/Q6ZAmfO8fDiMdadtiXExpN9lHP3BIJ5J9oBa9HMzI2CIExOdhIW
         oSSBVatxd/t4grE6McdzII8L6581JtFWOjIlzFMN/ZWwUWaZjKfepLWzMwm510DEJ/Gr
         +/ZWVpPVziRHvxrnVtZH9L8ybidr1t6e6SP67UgHaCKOG+AUWhzvad8CkKjA5LPJcKgD
         wYR0jjAEGt8neGKxTaKH713B5bGB+Cg4/HSLycS0yElemRXMKATPeE7wVHgj/S0XAIGs
         w8cHTr6VcgVKAC7i4Pqd6hHvNxjVF+/406KJd4h7OsTy/Djy8HpKUC/b4QDDsaVeSifh
         74Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431160; x=1793035960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLclega7SUgAlrP/YHd7B9RgRT5ZefPwtKid3vUTNJk=;
        b=WpWkEnEsQs7IKZzD/hS86ygUg9v/NP1wJtNsGbpCoJpd4DlTljkbfCL5XdIt6xFkPh
         9YJjxJfZgBoJ5WYUoOvVRvUGzkeT01QtNqt9e7jUmiQovuJusWyc75y869EBmiEW3v8l
         WjQMvqIC67ngRuNoIKRjlwsPEslvO9cTIc10ulp/ZfP76xyQAh5AmSNNLkNU7fu6WFLV
         mkyHFPpPDynCFyYhBe2WtXhTUlc0kw/n2NjGfvexx0ujdPZUlCH2CXECQ0yFmCIEbWhm
         3BFb21oSyNORtwNj6/wfCo5cX8KyvhFg1SCmlD5utwFJDM4/t0MVfarsajHtOraUjUsx
         gKxA==
X-Forwarded-Encrypted: i=1; AKwUvByDRb35mCFVKBpHA6NhmsswJXV3UJt6zsyjw5ShwqNxJn05Kpwtm2vJDBEDzzAvj3Pb5JQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDTWHzShF7sPbJotzDhZ3oC8iHtUQ7njJ6Z4zBzNkROa1oD10J
	b15FmloihRufIC14sOtwcqh1ZCWZclGO3Yexvgx7mOhXCh/v7TTxlxMG
X-Gm-Gg: AYBFou1n5HN6aDl7uq8LHScW+gIZPLk9et3ylRWj/hooBEjab59lENcIIifMAJXRcvp
	kiyHXR1PuSp4QpuN8X2mYoCwLtyt4HgH4scetsrQ7Bu7V4LSvH1lkfVr6KYlwUMuRWLsD45Rk3Y
	1rGCE1mOghhc4lkErnug7zsLUi+/lZkVtdDzNja9tfrSt+ypA9ajQF/vVbv1lp7NNtXQcR07Er9
	hJ8UOKUgcSbN6K4PcqlXu/KZYl6gHS8vEM+JcARxMxyd2QvW697Dga8vM0iQuoZ5SZFr3FW1zLz
	9bC9sPXNpNk6ihA7b2lnQDpno8N4T4WkLoavDcLM+PN0Fi1Am7dy1uOTR2QwseiEK9M4shLgQWC
	EaMN5zbgywEwASA5SfJ/fN4twl6Mnibe762yQTN7GMcWvyo1ELyziesF8ZMq0mFB4PnwfwD/vue
	EWuMtFgDGi0AXgXv/37xcTpE8ZTGebfPbTqSxc9AxFGcjiBydtK+gP+KfAIBEi4mxpcyhl3VVnR
	d5qn1GnyfY+Y4lzFENuGFYw/BytTRFqg65pGZwdjfQ=
X-Received: by 2002:a05:6000:46cd:b0:48c:69b3:6114 with SMTP id ffacd0b85a97d-48dfadf34cemr19629395f8f.3.1792431159687;
        Mon, 19 Oct 2026 10:32:39 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823b7esm253426f8f.40.2026.10.19.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:32:39 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Kunwu Chan <kunwu.chan@gmail.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptrtorture: Release all deferred hazard pointers before stopping
Date: Mon, 19 Oct 2026 19:32:28 +0200
Message-ID: <20261019173230.73558-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <AFA8DFD1-7D1C-49FD-BE53-95747FE4302C@mainlining.org>
References: <20261019162005.12888-1-parri.andrea@gmail.com> <AFA8DFD1-7D1C-49FD-BE53-95747FE4302C@mainlining.org>
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

On Mon, Oct 19, 2026 at 05:22:54PM +0100, Bradley Morgan wrote:
> On 19 October 2026 17:20:03 BST, Andrea Parri <parri.andrea@gmail.com>
> wrote:

[...]

> >Fixes: f23d7b47ced9 ("hazptrtorture: Add kthread to release deferred hazard pointers")
> >Assisted-by: LLM
>
> Why not put this into a series?

The two patches fix unrelated bugs, touch different files, and apply in
either order, so I posted them separately.  But both are for -rcu/dev,
and the test notes in the hazptr patch rely on this one.  I'll send the
next version as a two-patch series with this patch first, unless Paul
prefers separate submissions.

[...]

> >+	/*
> >+	 * Run until hazptr_torture_cleanup() stops this kthread, not just
> >+	 * until torture_must_stop(): the writer can be waiting in ->sync()
> >+	 * for a deferred hazard pointer while it is being stopped.
> >+	 */
>
> Could this be shorter?

Yes.  The comment in hazptr_torture_cleanup() already says why, so this
one can just point there:

	/* Keep going until hazptr_torture_cleanup() stops us, see there. */

[...]

> >+	/* The readers have stopped, so nothing new can be deferred. */
> >+	for_each_possible_cpu(cpu)
>
> Is the comment needed? I don't know if it's nessesary.

I'd keep it.  A reader can defer after the last pass in the loop, and
kthread_stop() can then end the loop without another pass, so this
pass is needed; the comment says why one pass is enough.

> >+	/*
> >+	 * Stop do_pending only after the writer and the readers: the writer
> >+	 * may be waiting on hazard pointers that readers deferred.
> >+	 */
>
> May we shorten this? Feel free to bikeshed that one.

Sure:

	/* The writer may wait on hazard pointers that readers deferred. */

Thanks for the review,
  Andrea
