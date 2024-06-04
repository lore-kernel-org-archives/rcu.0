Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7F13D50F;
	Tue,  4 Jun 2024 02:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717467562; cv=none; b=M1PTKAPYQZdWJpz9Y7UYWKHHJd8CyxNaoTxaFfQures1FIJ44cLvNy6zsM+rv6r6XlhhKLMbTUVhE6SzvkhfKubQX7IaD+vad4/81XasAbLkpiNpfFb6gbTbWwSi0BwThuSyfPY8cnCr0EGnzd91b0dlJATX+trvUZHEKeHJDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717467562; c=relaxed/simple;
	bh=ae09Bok+7c40U7+a/HBGd5hON5Y5Ex8pTOtiKczukCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAEncXl6hecLJTbEheWs1q5PjHimncd7joeKJQ3Yhqaj+GNvMRBTl1kGPdN3uTsL17zzkgxejA5zpwnU82h7znvOM/zT4AnYNwrP9Qq42g1xh8muo3+ehX+2oa/DRgsqyA4tu04ePMP0nHAGhJA54jhGRCrOZ7o0WAekAqwfzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJIjaV31; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJIjaV31"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-702621d8725so2281939b3a.0;
        Mon, 03 Jun 2024 19:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717467560; x=1718072360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bfeY666rk1f2+TdD4mCmpU8biTw6zhseS8B25qhfvhY=;
        b=EJIjaV31fYvrkiDt3cn1uIPWepfmItnSmBz/QhDvCeKu6/JJ8M9wgI4EL4rpYhQgib
         aNhwUGIRnaLuLdJtbfuafpVMq2YJMXc+vtoaczjimlCQsHNeORSsvLM+RIHU7Swu/Rjt
         AW4QFfpSCR2oDAjnJo7KIdaRIiIV1kqZF4p17NkJUlYXUokXtqgJil3g6sphR4vqHEJr
         /8G2POLo1YKgc8Z2KdTjv0NVIOQlToS8eVdJDbhXISdDSKQaLqpserCjyGBqGxpG1uwO
         TcO7vMJseMB+WZcZOEG+gYQOFMipj5LY6KkOauj6QkGEOqMOBS5rnZmQ7OGPgPd39bLC
         Cnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717467560; x=1718072360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfeY666rk1f2+TdD4mCmpU8biTw6zhseS8B25qhfvhY=;
        b=Fh0XysT1MPSl0VBBt9BshFFDkRxkMayLxiOtagTmr5GZ6Y7AnYzUKWT1GZNatSqrFN
         NA66b503tPJTJVlZf6KWYGxA7lFfLELQSNqPyah5AOjLotSR/JjIkPd2xkAMsa4ij3if
         GoIm8Epg+2DhxJvFyJkt3xZhnUDd+onQK8tcs5kxF9sSSx6GJFDh08Cs+bj/KHO4k7mp
         6PWk7+8YG5YDPVrxa/Xv2hWQaC2U4/d+xhr3C76UhRN3Waip+a6i9H7CorEpBF//RIu1
         Ft753CQZMxkPuJh4IkCtRsoegXnHbdjmIUkA3CIxPqvDftYEmpqzz55BY4CYI+E6uPRZ
         TGnw==
X-Forwarded-Encrypted: i=1; AJvYcCXFRu21vhgHjJkg0dntHUjQ/tcApHj4bJwSFpKYBYsVA/TpDC27tqcznV05EBRGHSJiSubtd6eIWHotRkOylqiOf/8f9swgXV+yz+ONjlwWjukJQnWVN3f0MPMI9FbTZ3O6
X-Gm-Message-State: AOJu0YzAb49sQ/iu0O5+aniZPXCnBgva/athLdGKJ9BAJW7jOszVdJ/L
	Aay/q84u/+90ml0vpnzYaZFwp6qzmjE4SUzTA5xJCVf4GeexbQ+vnEl3sf/eFR2usOLNN3jqZel
	VSCX88XYeUeg64Mlr5HpcFeICr69DvnYO
X-Google-Smtp-Source: AGHT+IGzmPU+zRpnVlFuldWTKzqZo5wJODzcCnXHR+S7Pn1YefmWqQ0EErc9Oh5J3te1IPu4S8l3xP0EiZy6JXcQeFE=
X-Received: by 2002:a05:6a20:2444:b0:1af:d9df:d8de with SMTP id
 adf61e73a8af0-1b26f146b92mr11991213637.21.1717467560114; Mon, 03 Jun 2024
 19:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
 <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop> <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
 <CALm+0cUQuZDb6nrng+CnOXNGyy6gUWNGq9VoreU98KNkyTw_CQ@mail.gmail.com> <4a6d1e70-ec91-4b6d-8f69-290c4ef57b7f@paulmck-laptop>
In-Reply-To: <4a6d1e70-ec91-4b6d-8f69-290c4ef57b7f@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 4 Jun 2024 10:19:08 +0800
Message-ID: <CALm+0cVjjL98+QRO7a=18JjUB2-1R0oFyksgkH9ZEAr2NsBniQ@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops without
 ->debug_objects set
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Jun 03, 2024 at 12:55:30PM +0800, Z qiang wrote:
> > >
> > > >
> > > > On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> > > > > This commit make rcu_test_debug_objects() early return when the
> > > > > specified cur_ops not set the ->debug_objects.
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > ---
> > > > >  kernel/rcu/rcutorture.c | 5 +++--
> > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > index 08bf7c669dd3..9b8c277ab91a 100644
> > > > > --- a/kernel/rcu/rcutorture.c
> > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
> > > > >               return;
> > > > >       }
> > > > >
> > > > > -     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > > > > -                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > > > > +     if (!cur_ops->debug_objects ||
> > > > > +                     WARN_ON_ONCE(cur_ops->debug_objects &&
> > > >
> > > > You lost me here.  Given that we have "!cur_ops->debug_objects" before
> > > > that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?
> > > >
> > > > Also, we don't get here unless the rcutorture.object_debug kernel boot
> > > > parameter is specified, don't we really want to WARN_ON_ONCE if the
> > > > current flavor does not support that?
> >
> > Maybe I didn't describe it clearly enough, this
> > modification is mainly to filter out test types that do not support
> > double call_rcu*() checking, for example tasks, tasks-rudes,
> >  task-tracing  ;) .
>
> Understood.
>
> It is just that in my experience, it is a good thing for rcutorture to
> splat when asked to do something that it cannot do.  Or do you have a
> use case where this is problematic?
>

Hi, Paul


This is a scene I mentioned before:

The rcutorture.object_debug is set true, but the tasks-tracing does not support
duplicate cur_ops->call check, but the debug_objects test was still done.

insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
n_barrier_cbs=4 object_debug=1

[  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
[  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
[  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
[  106.105552] rcutorture: duplicated callback was invoked.
[  106.105567] rcutorture: duplicated callback was invoked.

for call_rcu*()  that does not support double call checking, if
continue to test,
"rcutorture: duplicated callback was invoked". will output,
I just want to avoid the output of this error message :)

Thanks
Zqiang


> I don't count the fuzzers because they are supposed to avoid specifying
> things that are supposed to fail.  ;-)
>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> > >
> > > Hi, Paul
> > >
> > > The rcutorture.object_debug is set true, but the tasks-tracing does not support
> > > duplicate cur_ops->call check, but the debug_objects test was still done.
> > >
> > > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > > n_barrier_cbs=4 object_debug=1
> > >
> > > [  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> > > [  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
> > > [  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
> > > [  106.105552] rcutorture: duplicated callback was invoked.
> > > [  106.105567] rcutorture: duplicated callback was invoked.
> > > [  106.111269] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
> > >
> > > Thanks
> > > Zqiang
> > >
> > > >
> > > > Or do you have a use case that needs to silence these warnings?
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > +                             (!cur_ops->call || !cur_ops->cb_barrier)))
> > > > >               return;
> > > > >
> > > > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > > > > --
> > > > > 2.17.1
> > > > >
