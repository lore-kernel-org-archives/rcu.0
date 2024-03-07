Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268B12DDB6
	for <rcu@vger.kernel.org>; Thu,  7 Mar 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841666; cv=none; b=g93RKUZwIAThifJdwCeVIlR1eA6Rs4Y8T8mAE1UC53v/4FOgFpory+RSmE5o8En9KD6NFRr12xVtkTy/d9WhEuHhZwLv93mWZS4zO3+69j3Hc0DPvVM0ZlOQgZmHfoAvIWgLl7mC598jU0AdSbvZbhrs2j+qe9wEB4zdoPXPXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841666; c=relaxed/simple;
	bh=20dZ8K6KYsjFLDRa9KVUU+GTtq9ea4tPvWyMafwWw8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKRBUChGIqUWrXeJYtvTTXiSO/qFVZ+mTlYdgcNDTysFM2xBG7y7N5ZkMahPKrBZD+RsJqocf3R0eA7COufkr2p/HUVYCxK2L1oxEMwLKNv4o75lbX+WBtsczml9cX1EIpkIJdXKr5H4O/yLJBkNu9aW5bsLHzddPR4YWr57/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MdfrHBLx; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MdfrHBLx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a446b5a08f0so242075866b.1
        for <rcu@vger.kernel.org>; Thu, 07 Mar 2024 12:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709841663; x=1710446463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6kBgbL9HAhEpnz7T+Yyi2IbRse7Tjb+btEkUQHTFGM=;
        b=MdfrHBLxH/RIH6gZIR42cr6QJSYvLHAGU6G4aJVYagTvGdSoH/pSP2qTk+N5mJ0DJS
         awNXTOxWNkGO5NF3IFe5651lbkVrIlr4JE0Fdgd6pc0Nc+LRuDUuvwe0G+Caxvxqi4hg
         680DwLN+jicX8rnjex442RRtmdy2znzRZuVzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709841663; x=1710446463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6kBgbL9HAhEpnz7T+Yyi2IbRse7Tjb+btEkUQHTFGM=;
        b=rlwg5eYveJq5lUZxD6p0bp15lzNNjspPhT3u1Cio+Ek5k5VJ80DwdwacKv1tG/3h5C
         AcGguMkr2RGPQz1jsG56Bqk1uZsG3la0wydHJ8FDXMvIdwFlIKG1tIqvk1l2IAKIYSIZ
         AXNC8yGlRaZY8Ys66GrZSe6i/peuFtMGaETafqMptdJ8W697l5yIKrZcVvM6gSpVgRdu
         LgOUsGsTjHaN1dKOFIeJo47NEhsW2s3ROWer8ZN+6/O2FTM7SuwDniPWiL1RKC5skw8z
         CnebKuINJwS3F4bEkZ3nlR/LxCiYfug152TZSPSFmEbGuvdZogd6JFShcTpVwEOudZgW
         FO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCZXnWDi/CFDW/tEkjBZ+Z3JbfgTGQpfeXSnEDxjBN/WOAAJ5I55NCBuR/GO36QE75MzeiKivX4jnbUI/C02chGqXR
X-Gm-Message-State: AOJu0Yy48aF8OlLoFkKAglLbIW5lCj9cCRAgINt7loJXxNK8b1ZwQPis
	4Ng8FSYSIvq6m51kuQL3cdoWdf322LVjiRHzNbd0KhKBMy96AC8g5g9sUT9NQQCu70O9Gc3oowa
	Oq9JmtQ==
X-Google-Smtp-Source: AGHT+IGy2Ip8WsgPT+h/zwjKz9WgINpxGxSdX50D9dFu8xDyd4G/HZK1il8mLh9YKL4lLbx6yJMOwQ==
X-Received: by 2002:a17:906:4a95:b0:a45:297d:52b9 with SMTP id x21-20020a1709064a9500b00a45297d52b9mr2370667eju.26.1709841662634;
        Thu, 07 Mar 2024 12:01:02 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id qb33-20020a1709077ea100b00a4410598eebsm8546132ejc.67.2024.03.07.12.01.02
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 12:01:02 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso447022766b.1
        for <rcu@vger.kernel.org>; Thu, 07 Mar 2024 12:01:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMScxF0kMJCy0//5aQqAB7hu8phTO/VzZfVA89fL37yAUu7VkAT/mMvJ1EupuSX4XRUtrkeIl/0nGMajSnRmwM0jRq
X-Received: by 2002:a17:906:a18a:b0:a3e:4d7c:9ce1 with SMTP id
 s10-20020a170906a18a00b00a3e4d7c9ce1mr1133545ejy.21.1709841661652; Thu, 07
 Mar 2024 12:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop> <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
 <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com> <72b14322-78c1-4479-9c4e-b0e11c1f0d53@paulmck-laptop>
 <bebbed4a-ced1-42c5-865c-dc9dc7857b6c@efficios.com> <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
In-Reply-To: <c1bb35c4-29af-4a84-8ba7-81ba30639a69@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Mar 2024 12:00:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
Message-ID: <CAHk-=wia769uoyVz3P7yZURhO8NNB7xeOLX07ZM2vWf1nTLYkQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: paulmck@kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linke li <lilinke99@qq.com>, joel@joelfernandes.org, boqun.feng@gmail.com, 
	dave@stgolabs.net, frederic@kernel.org, jiangshanlai@gmail.com, 
	josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	qiang.zhang1211@gmail.com, quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 11:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > - The per-thread counter (Thread-Local Storage) incremented by a single
> >   thread, read by various threads concurrently, is a good target
> >   for WRITE_ONCE()/READ_ONCE() pairing. This is actually what we do in
> >   various liburcu implementations which track read-side critical sections
> >   per-thread.
>
> Agreed, but do any of these use WRITE_ONCE(x, READ_ONCE(x) + 1) or
> similar?

Absolutely not.

The READ_ONCE->WRITE_ONCE pattern is almost certainly a bug.

The valid reason to have a WRITE_ONCE() is that there's a _later_
READ_ONCE() on another CPU.

So WRITE_ONCE->READ_ONCE (across threads) is very valid. But
READ_ONCE->WRITE_ONCE (inside a thread) simply is not a valid
operation.

We do have things like "local_t", which allows for non-smp-safe local
thread atomic accesses, but they explicitly are *NOT* about some kind
of READ_ONCE -> WRITE_ONCE sequence that by definition cannot be
atomic unless you disable interrupts and disable preemption (at which
point they become pointless and only generate worse code).

But the point of "local_t" is that you can do things that aresafe if
there is no SMP issues. They are kind of an extension of the
percpu_add() kind of operations.

In fact, I think it might be interesting to catch those
READ_ONCE->WRITE_ONCE chains (perhaps with coccinelle?) because they
are a sign of bugs.

Now, there's certainly some possibility of "I really don't care about
some stats, I'm willing to do non-smp-safe and non-thread safe
operations if they are faster". So I'm not saying a
READ_ONCE->WRITE_ONCE data dependency is _always_ a bug, but I do
think it's a pattern that is very very close to being one.

             Linus
