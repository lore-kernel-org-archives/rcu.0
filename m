Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A08D14037F
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754393; cv=none; b=a6SJNigPuUqdd9w9waZ/cpQrOfteO1210kHCnvhziyyCgosfVSM/wmbsKrUjCbMd7CGb7ljWj7MUtCg/BANJPK96wTb36b7iEiSVSBgSBEot5IWTvrDCtZv5DVsSHZFoLaXXbiv8/xuITC0C80H3IGiNJqTovYDgUBYSF1rixMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754393; c=relaxed/simple;
	bh=EsrOB7GWDfZEolkuh93kmRh+nny/GJZOQsiuqS+Npj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gP1zGJY5iGMjsssj3a9pI5RR2t8kk+0SP+XOkBj19yRtb2X6+59yFM2n/FQiou82s1RIEnK9hjdgTL33bSVaTzUhT4Fz26juEe1lQgxtaw6xw6hx8gXeGe+6DFOfcbeP04xlblyazykiGGoX7J9kvsseNpu1opVKsp0MXgtscNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TXdhyUP0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXdhyUP0"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56682b85220so120342a12.1
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709754390; x=1710359190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5tv/bveZOleZ+h93PkvUkJXX+8+GRGSuEkqnAwfMmY=;
        b=TXdhyUP0FB6RioX5Hy00f1H3cKYbNzZmcNmnQZgcS9ghEzIb6IVMpdfuHZOB+g4+Bf
         7c862vbqQ+CPpNST6YaaUbT2X+eyBrJUrn4uOnlRUOrwnsEx/tiaHzMqVCIJztkGjs64
         N3VokCsajNlNUQry+xjpBm/50Bta1dmkpcNyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754390; x=1710359190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5tv/bveZOleZ+h93PkvUkJXX+8+GRGSuEkqnAwfMmY=;
        b=Q9Urk+m5vcv7o5jQ+F3GuFBSS6ptlFbuawejbaIq2H7sIWkDW0eGIEaAbfJOHmVAgZ
         3VvH7LI+jxbFqA9bfUhGVcEkddqVIqNKD8LwFzCzWz3lOe/RjMwjLN1/d25OaBcK6vQK
         FyqTZPofA9aLZ6s65xkAJLNSiQ/3FOg12+fAG8wgL9ZuqiYTEAxqOUiRsPPlqWNOuW5j
         aCMotMHssOgwsFUYvW0eYdct71kvUqxSLnx9oo0YoFtWAtdRkm5v0qkECBE3aL3b2fsm
         bhsy8jfU7q43q643jtWxJw1YBkD//q3FoGI3qMXcOikV6uDTbgQKAsq7rFGTcIxEVZ+L
         OTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+lJnb53LzwMHjybkRAy0VmIULFlTyaqFMGeARCBMIki/YIp5XxjPki3sIx8CXpsD+XD3GxcqXiKnhZSZogS0QrzT9
X-Gm-Message-State: AOJu0Yx7g4KK9NqUaQLTN8w4VBhjAlxnIb4DRMRVfWUq2f5C0/bAVqFy
	meC8vomRzhchn1IeGU6eJlQszM0UEf2PXLR0ddNG6suTlO+BEU7X3H+IDew65sO6iQROiwPprN7
	kOIFB8A==
X-Google-Smtp-Source: AGHT+IGPLlzvI9hfCWBI6D9RJm3qvLB7nELXbFEtf3Z9+Zn35sarHe74+458Yhz9BteNTKF7Oa7Law==
X-Received: by 2002:a17:906:40d0:b0:a44:9e7e:64c3 with SMTP id a16-20020a17090640d000b00a449e7e64c3mr11636006ejk.10.1709754389722;
        Wed, 06 Mar 2024 11:46:29 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906c28200b00a412d3d509fsm7498999ejz.181.2024.03.06.11.46.27
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 11:46:28 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so115047a12.3
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 11:46:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5Bh+qJ8PzDpdt0OnDap0EVmvq/YIAbf58ba4PsJekXXtDLCmO1T4SmHQAmWhSt3VSgZ08ESmdyI13kXV2izO5N9xy
X-Received: by 2002:a17:906:fc16:b0:a44:3bec:20a8 with SMTP id
 ov22-20020a170906fc1600b00a443bec20a8mr10802569ejb.76.1709754387248; Wed, 06
 Mar 2024 11:46:27 -0800 (PST)
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
 <20240306142738.7b66a716@rorschach.local.home>
In-Reply-To: <20240306142738.7b66a716@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 11:46:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
Message-ID: <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix rcu_torture_pipe_update_one()/rcu_torture_writer()
 data race and concurrency bug
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linke li <lilinke99@qq.com>, joel@joelfernandes.org, 
	boqun.feng@gmail.com, dave@stgolabs.net, frederic@kernel.org, 
	jiangshanlai@gmail.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, qiang.zhang1211@gmail.com, 
	quic_neeraju@quicinc.com, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note this has nothing to do with tracing. This thread is in RCU. I just
> happen to receive the same patch "fix" for my code.

Ok, googling for rtort_pipe_count, I can only state that that code is
complete garbage.

And no amount of READ_ONCE/WRITE_ONCE will fix it.

For one thing, we have this code:

        WRITE_ONCE(rp->rtort_pipe_count, i + 1);
        if (rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {

which is broken by design. The compiler is allowed to (and probably
does) turn that into just

        WRITE_ONCE(rp->rtort_pipe_count, i + 1);
        if (i + 1 >= RCU_TORTURE_PIPE_LEN) {

which only results in the question "Why didn't the source code do that
obvious simplification itself?"

So that code is actively *STUPID*. It's randomly mixing READ_ONCE and
regular reads in ways that just makes me go: "there's no saving this
shit".

This needs fixing. Having tests that have random code in them only
makes me doubt that the *TEST* itself is correct, rather than the code
it is trying to actually test.

And dammit, none of that makes sense anyway. This is not some
performance-crticial code. Why is it not using proper atomics if there
is an actual data race?

The reason to use READ_ONCE() and WRITE_ONCE() is that they can be a
lot faster than atomics, or - more commonly - because you have some
fundamental algorithm that doesn't do arithmetic, but cares about some
"state at time X" (the RCU _pointer_ being one such obvious case, but
doing an *increment* sure as hell isn't).

So using those READ_ONCE/WRITE_ONCE macros for that thing is
fundamntally wrong to begin with.

The question should not be "should we add another READ_ONCE()". The
question should be "what drugs were people on when writing this code"?

People - please just stop writing garbage.

That 'rtort_pipe_count' should be an atomic_t, and the "add one and
return the old value" should be an "atomic_inc_return()-1" (the "-1"
is because "inc_return" returns the *new* value).

And feel free to add "_relaxed()" to that atomic op because this code
doesn't care about ordering of that counter. It will help on some
architectures, but as mentioned, this is not performance-crticial code
to begin with.

                Linus
