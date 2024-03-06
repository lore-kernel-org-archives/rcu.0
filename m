Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB913BAC8
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756434; cv=none; b=lHqAy5MQ845ZYkl+aYKrhiFkNGsUibalXboe1vr5fgPTse4/fSYv5zOoS0506hzQB4rS7lXrLH3swTX0M6rh3nJTaPAeIyrj/mgI/KtD+Jr5EHrdM6sAdmQeKoVhbivKtVUmZ+bV7G8apG4bTBt0nxG0STr4q/eJIEsWg7KUo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756434; c=relaxed/simple;
	bh=1fMRZLipMrytyIL2P/bemn1/S7ehcHXKbZQM+j1zbmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FECUYGW9PvP/Wj/2FoEPMIiKS33/rgFwXhki+Rt2ZUo1lq//s4ypFygnSEHyIafNOXdr1xnmY4oiT1ShDm6Zl2a33A92XioiAlNK1pk1HQ3+ApffhM9pRVA3TP0j0di9BPJ1rbxqpgO4G7cFv+hSchzejfC2+y2n76gkqw9ohr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O9ahK6Rr; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O9ahK6Rr"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512e39226efso142423e87.0
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 12:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709756431; x=1710361231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eBM56IgKWK3xhe9y5Rbhoc/hv2ZNbpBXfMCabxfGGA=;
        b=O9ahK6RrMAIhZ2N5wgmD/QXizmks9/fuI0hz5LNa/8PXh840Z7Vc0u22ld0JuRy6QY
         hoH/+7eRnhB6qXxu3JITOjBZZECVWpMxJDfyFHH9Ve4tfPgrJuk1a3vrQtQBdPSrkMlI
         upzR/v6cSEcEItSAGlVWUk9PbelvR/sJaFi1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709756431; x=1710361231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eBM56IgKWK3xhe9y5Rbhoc/hv2ZNbpBXfMCabxfGGA=;
        b=QwfBhVFMPdT4OPLWPiu3qP341A8GqEkEmSYcKf2Xm9x2p0NkBkLMHLxZceRln+IhIq
         YMxCiDa+EzezEVrUPL2FdFPxnpP0jbjUfd5vlvxBaq6xDleH83v/XyFlUQRFkxu49aie
         vhtofFRfwvw3mI/25NspAu+WLOOI/6/r3GJ8kOe0RuNdH2t24ooSvd3RipRsHwkVRur/
         qRZLr7PBLWVj7n8gliiR89nW5ZXgYDGfn//pB0cQwDtrRILGTj31BMQmvsPxRSUEz6sF
         5fakvn8hoTgFo52FBH32vRMtu3Vo7fx/EIMYogsEoq9fmFLBKB0Oq4kxY4r9ayppe2FN
         KMnw==
X-Forwarded-Encrypted: i=1; AJvYcCXut7TWfEuT1VGeOc1rcC/r8XuEPK1M0yp3lpg7LzJztItsGT1vZ0CoJKgzUtN20WhL607yNviEf6Bx3TUa1l3C4j1/
X-Gm-Message-State: AOJu0YwkcFArcliL4IsvDIk03n2srjQeno8tcgnHY3IgCFvo/UsEl10E
	9GClIeNech6ZxKcPnV8kG5cZ0mFqHM111g6cGwCXGyKvXmKo7exgOVpEC/3wObrQVmDmdOlPyrD
	xGdNqDA==
X-Google-Smtp-Source: AGHT+IFoXpovn1Id3KPEZqbu2I2hbCTXOzeRPNo8IhqrY1dnS6h6L7jBlLF7/8GmCTIqfx1IVjhzjQ==
X-Received: by 2002:a05:651c:1411:b0:2d3:1c52:7b3d with SMTP id u17-20020a05651c141100b002d31c527b3dmr68133lje.11.1709756430823;
        Wed, 06 Mar 2024 12:20:30 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id q22-20020a50aa96000000b00564e489ce9asm7623665edc.12.2024.03.06.12.20.29
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 12:20:29 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so26247766b.2
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 12:20:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpSPEo8P2ZvuunqdY0r/fCweJjVMlL8bO2Du0EAPIQCDIazdWdwqBOpEA0xglEBSw1lTrGjpfI5WODOTQfI6NOFLSm
X-Received: by 2002:a17:906:5fd3:b0:a45:ac0f:38e4 with SMTP id
 k19-20020a1709065fd300b00a45ac0f38e4mr3620090ejv.38.1709756429144; Wed, 06
 Mar 2024 12:20:29 -0800 (PST)
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
 <20240306142738.7b66a716@rorschach.local.home> <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 12:20:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiswkKOzA7279LOzMMMBwYhquu9yQsujJDZnS_Zi9PzbA@mail.gmail.com>
Message-ID: <CAHk-=wiswkKOzA7279LOzMMMBwYhquu9yQsujJDZnS_Zi9PzbA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That 'rtort_pipe_count' should be an atomic_t, and the "add one and
> return the old value" should be an "atomic_inc_return()-1" (the "-1"
> is because "inc_return" returns the *new* value).

Bah. I am lost in a twisty maze of operations, all the same.

One final correction to myself: if you want the old value, the nicer
thing to use is probably just "atomic_fetch_inc()".

It generates the same result as "atomic_inc_return()-1", but since we
do have that native "return old value" variant of this, let's just use
it.

So the rules are "atomic_op_return()" returns the new value after the
op, and "atomic_fetch_op()" returns the old value.

For some ops, this matters more than for others. For 'add' like
operations, it's you can deduce the old from the new (and vice versa).

But for bitwise ops, only the 'fetch" version makes much sense,
because you can see the end result from that, but you can't figure out
the original value from the final one.

And to *really* confuse things, as with the memory ordering variants,
we don't always have the full complement of operations.

So we have atomic_fetch_and() (returns old version) and atomic_and()
(doesn't return any version), but we don't have "atomic_and_return()"
because it's less useful.

But for 'inc' we have all three.

                        Linus
