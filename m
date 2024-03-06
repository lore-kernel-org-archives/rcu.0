Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2447142906
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755583; cv=none; b=flurSfut84aEwGkxwWf3qkr2b7Y8n4LkIknmffAToFiSRBP7iVDJ9jZBRjz/L2J+c0YPNwcJ+eojanVmlc2kgbSDY5VFP0//s7Y4R576qGHNxVISMM4fAWQLwDs2hPS23P93cUBzpQsyOWNudtdHVHbM5NkT78/uExhGGYMrBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755583; c=relaxed/simple;
	bh=SyrHb40N341DxXn2vMM7iLdQWShX0cFfOW4dnLdSUZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq1Vsw/IRMvvncEd8Gl1WigMFHB4e4u7Pun8SjIRaohJD4G2By31Mv08qCH++ukmvZMt7NWhOAMgF0MByxvclgs25tJ/076oCBwFdATPUoJ8D6HWgCDpWJ6xmIsuk7vUZ0hcpGCejj5YZ4JlYe+G+a34jgVlysbOHJDq5AK7cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K0VFvWKr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K0VFvWKr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so162501a12.1
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709755580; x=1710360380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFv5gaMBFA/PPhuhGbhdZFZpUSVHV/ywVciaghdbwWE=;
        b=K0VFvWKrFalgsCR0hpdajtKHZgoxbBH2VC+Hi9l6tIO4zk21bPLaoXLBveVr0Vlmfv
         ouJP8Ko/t4KgMOcBasIP7JgELIfQA3jTCK/J28ETMO6zoNPfHXFVW3/US/7Qrk7EkUK+
         3lg2TAA2B/gSKfsHpQUpZON5kiIy7dXPttBzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755580; x=1710360380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFv5gaMBFA/PPhuhGbhdZFZpUSVHV/ywVciaghdbwWE=;
        b=tb6e6CrdyFE0NDw44JPvGnWqmsWsWIOveV4jhOblGWzIVveNkazNHwqMVIJTwjhMmz
         9fjqBNT+ifTqMZDOvoOJ0MoKjTFipgJ8fBj0FyCsu7X5reM1HwzDiXDC+UN4OpOpIJID
         YVj67AgR8Lf1YW8Lj+BUUbCjdyUi+juJ3za3eo7zjZhRHGmLb+CHlYdTa2IOdgaczB2M
         bPbxOR/4H72A7Yz++nGsAFCL3jAvy/RoS6zq+XMremD2mZsWE4U3XU0IUZtBeyzq2FSg
         zRD0hRwM1dwgJvdatDb+qUKxreKl7X2o96awbOip2TQxUPtL+L4D8b+C5kz+SaC2T+s6
         UUrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMjbJoFi2o0c7C4mx51Csef9/lDio8o9PyX7sYA4ImlDWasAJ7wSNTiTEuZcLSkKUOtx2NExsLu3fpV16L0MKsJUmn
X-Gm-Message-State: AOJu0YzG7UtvH4+uZQs1WoSKeiUJq9qf1rqx8rpPRYRAxlLnUcO5Ftwi
	Tp6UcQD5Ey1OR39WQ1lYfRGizwL7EmA6vd71BDBKGcQTirG/WoXlIbnxTJ61sCbvoAzMkNlNCaM
	Pjes5Uw==
X-Google-Smtp-Source: AGHT+IFvVbOONdi8c3WlkJKFAL+Fmoe93twpcFP959bji1hDyPfSJqDXkQzgP0jR8IQ00JVWBLUC5g==
X-Received: by 2002:a50:8e45:0:b0:566:7250:9ea2 with SMTP id 5-20020a508e45000000b0056672509ea2mr11704096edx.34.1709755579994;
        Wed, 06 Mar 2024 12:06:19 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c686000000b0056711540692sm5046188edq.79.2024.03.06.12.06.18
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:06:19 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a45b6fcd5e8so19884066b.1
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 12:06:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWecK1PNmSr7Fg89pEtZ0xPBKbagqdM0HIaNCJKOs0+17IArEvByY/pSDBevCq3bMvEpU4DSixzYsLLn/0ZbE19FZnC
X-Received: by 2002:a17:906:364d:b0:a43:811b:71de with SMTP id
 r13-20020a170906364d00b00a43811b71demr10393124ejb.38.1709755577715; Wed, 06
 Mar 2024 12:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com> <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop> <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home> <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <CAHk-=whvyzsbqLkw4kwEC-KzAMKFuy5VuMtJFn-mCerSYoRnqw@mail.gmail.com> <20240306144713.2e1709ad@gandalf.local.home>
In-Reply-To: <20240306144713.2e1709ad@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 12:06:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
Message-ID: <CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Here's the back story. I received the following patch:
>
>   https://lore.kernel.org/all/tencent_BA1473492BC618B473864561EA3AB1418908@qq.com/
>
> I didn't like it. My reply was:
>
>         > -     rbwork->wait_index++;
>         > +     WRITE_ONCE(rbwork->wait_index, READ_ONCE(rbwork->wait_index) + 1);
>
>         I mean the above is really ugly. If this is the new thing to do, we need
>         better macros.
>
>         If anything, just convert it to an atomic_t.

The right thing is definitely to convert it to an atomic_t.

The memory barriers can probably also be turned into atomic ordering,
although we don't always have all the variates.

But for example, that

                /* Make sure to see the new wait index */
                smp_rmb();
                if (wait_index != work->wait_index)
                        break;

looks odd, and should probably do an "atomic_read_acquire()" instead
of a rmb and a (non-atomic and non-READ_ONCE thing).

The first READ_ONCE() should probably also be that atomic_read_acquire() op.

On the writing side, my gut feel is that the

        rbwork->wait_index++;
        /* make sure the waiters see the new index */
        smp_wmb();

should be an "atomic_inc_release(&rbwork->wait_index);" but we don't
actually have that operation. We only have the "release" versions for
things that return a value.

So it would probably need to be either

        atomic_inc(&rbwork->wait_index);
        /* make sure the waiters see the new index */
        smp_wmb();

or

        atomic_inc_return_release(&rbwork->wait_index);

or we'd need to add the "basic atomics with ordering semantics" (which
we aren't going to do unless we end up with a lot more people who want
them).

I dunno. I didn't look all *that* closely at the code. The above might
be garbage too. Somebody who actually knows the code should think
about what ordering they actually were looking for.

(And I note that 'wait_index' is of type 'long' in 'struct
rb_irq_work', so I guess it should be "atomic_long_t" instead -  just
shows how little attention I paid on the first read-through, which
should make everybody go "I need to double-check Linus here")

               Linus
