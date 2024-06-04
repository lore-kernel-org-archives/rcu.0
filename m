Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB1ECC;
	Tue,  4 Jun 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471822; cv=none; b=cgCiw04IS3xHPx6ZjoohtWofFFOqm6Jpudt5fPpT90azN1/DKoIgoj/kACq95G5HWf7DDCT3ERQK0xCe/bhmO6HCrTeXqCbdartdi28pzFIW6hAVdyd841ktM8PAr+FfSKugKopzCloEl9/GffxZyBWqBKz0sPZ6XgIQjUUKvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471822; c=relaxed/simple;
	bh=2Ztio9qL8ZpBUVSvlweFkPrMPNc98vITPhHYI2PxnXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb56Nx9x72451LzVvOzYxAWvkY1Rwb6hlyXNWb2Z95/bTqGoiiUpASOxQ4nj3ZD93RlhCXj+1Ko1hwLeoA4aVYymONQW1qwhUPbCCzzuQoVUaMh/sxa7wS1+xrcKTUFhgOjVE57LrTeck5PTNFAZHnNSfzNIFzes7xnja7ubBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNZLElMb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNZLElMb"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4829d7136so496945a12.1;
        Mon, 03 Jun 2024 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717471820; x=1718076620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYrQk95y2prpjepkR4vgWKHcx6FJS0ARSzceKfmHqSU=;
        b=KNZLElMbbY2O6kxmpxGnWnvjQusK8bhlmrR8MqMMMSIEUXCODzP0T6qVlypxXo6ezm
         +4EhOOA3HBGJ+9PsQzHQMzm4ZRGj0VIiY2ac5M6yaAHvvvc0yGAm7/3P6FtrDEEebD6E
         RE1APTLUr3QgwwTp7vCRW3OKH+uTqY1NZzT1i2FLV/fDXcb+mkvlz+wpBaaYsYAuVC2Q
         29p3T1S/1ZsTBUeWHBrgB2f+s+IRoFLVMNpCc2c4tUcEpsWckGGUn7wGiX9Sz5PY8gZF
         KsSJxow8N9VCV3uQPKY0DJsP5WazGwODdSgPe915strvAua6Ja1Z8GtbLqp+6/9q5oaT
         8gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717471820; x=1718076620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYrQk95y2prpjepkR4vgWKHcx6FJS0ARSzceKfmHqSU=;
        b=T946az7rScp7O57fQyK5e7Ae6UefcZW+n+xY3l/Swzx6tD944pHY9w3WwrK4RFec+J
         MvtfJUDReyRKkvb15/C98fte8JecKHTv1/0g73HvPZVpGRz+T6NyYdqAcNp6ITHSu0wg
         t7m4YDX1qnXw2AFDat9VM4ZQHY1WeBN5HMn9+UoMS3XBBlYBjucHjZQbe6jwkoPV76k3
         bw8Cs7tPNFKw8Gy4Kn1i8uVA4C50mkLIjlWWdIv0M39oYn8zmcFHjydPjMOOQbqJF6r4
         0ld3QwJozdjQCvLJHAjevrpUg+ZSUy78B6wGZxJ8xQ1pejFUbR7yH5XI2pVEc+iUEvb4
         8t3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC3QMK32mt1QtDvr8kBQzQuCv8FBPc86YdgNlvU5RtBAQJKjfeYmjccjmaHaLqJw9v7R49V2EIN5z21NR2TuDg4HW5xVibzbC0a6vPf7OzSXNGaAUAU+pKfYPMzAvu6+lp
X-Gm-Message-State: AOJu0Yzi70SCEQyFhqcxupTzc4SyiYv6l9ONLBF+uPX7CBvx/mhNMYU6
	eW/SOPtDx5EqZ8YoFLRL2O8IYmNPm/viC/znGU7d7oRoRgcQc8DcqvuQudYNLJMb9iI4Trj7ZJQ
	VKCbf3W5aFLonotUtiS5Lb+KJch8=
X-Google-Smtp-Source: AGHT+IHdG9EnNjz/uQO4L2IHYIy1R9doqNoCM+9pIKcsIawyv2XEY1VZ+dbrbfNoapgMEwOsXdKNKzN1ZtPT5isGLtw=
X-Received: by 2002:a05:6a20:2590:b0:1af:8c2f:5f5e with SMTP id
 adf61e73a8af0-1b26f164267mr11793640637.28.1717471819902; Mon, 03 Jun 2024
 20:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
 <1195a9a3-db87-465d-a3b0-ee92d67da954@paulmck-laptop> <CALm+0cVZ7GQC+v4Xe7nArh0DHKeax+ok_tYsKaB=JtG-BVgUag@mail.gmail.com>
 <CALm+0cUQuZDb6nrng+CnOXNGyy6gUWNGq9VoreU98KNkyTw_CQ@mail.gmail.com>
 <4a6d1e70-ec91-4b6d-8f69-290c4ef57b7f@paulmck-laptop> <CALm+0cVjjL98+QRO7a=18JjUB2-1R0oFyksgkH9ZEAr2NsBniQ@mail.gmail.com>
 <aa5d29b4-3f3b-440c-a6a5-2f77691fac90@paulmck-laptop>
In-Reply-To: <aa5d29b4-3f3b-440c-a6a5-2f77691fac90@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 4 Jun 2024 11:30:08 +0800
Message-ID: <CALm+0cXdHU4qa175SAx3GaktdLWrchS_xcJcidmvmPtm0twjng@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Skip debug object testing for cur_ops without
 ->debug_objects set
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Tue, Jun 04, 2024 at 10:19:08AM +0800, Z qiang wrote:
> > >
> > > On Mon, Jun 03, 2024 at 12:55:30PM +0800, Z qiang wrote:
> > > > >
> > > > > >
> > > > > > On Tue, May 28, 2024 at 11:00:54AM +0800, Zqiang wrote:
> > > > > > > This commit make rcu_test_debug_objects() early return when the
> > > > > > > specified cur_ops not set the ->debug_objects.
> > > > > > >
> > > > > > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > > ---
> > > > > > >  kernel/rcu/rcutorture.c | 5 +++--
> > > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > > > > > index 08bf7c669dd3..9b8c277ab91a 100644
> > > > > > > --- a/kernel/rcu/rcutorture.c
> > > > > > > +++ b/kernel/rcu/rcutorture.c
> > > > > > > @@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
> > > > > > >               return;
> > > > > > >       }
> > > > > > >
> > > > > > > -     if (WARN_ON_ONCE(cur_ops->debug_objects &&
> > > > > > > -                     (!cur_ops->call || !cur_ops->cb_barrier)))
> > > > > > > +     if (!cur_ops->debug_objects ||
> > > > > > > +                     WARN_ON_ONCE(cur_ops->debug_objects &&
> > > > > >
> > > > > > You lost me here.  Given that we have "!cur_ops->debug_objects" before
> > > > > > that WARN_ON_ONCE(), why do we need "cur_ops->debug_objects" inside of it?
> > > > > >
> > > > > > Also, we don't get here unless the rcutorture.object_debug kernel boot
> > > > > > parameter is specified, don't we really want to WARN_ON_ONCE if the
> > > > > > current flavor does not support that?
> > > >
> > > > Maybe I didn't describe it clearly enough, this
> > > > modification is mainly to filter out test types that do not support
> > > > double call_rcu*() checking, for example tasks, tasks-rudes,
> > > >  task-tracing  ;) .
> > >
> > > Understood.
> > >
> > > It is just that in my experience, it is a good thing for rcutorture to
> > > splat when asked to do something that it cannot do.  Or do you have a
> > > use case where this is problematic?
> > >
> >
> > Hi, Paul
> >
> >
> > This is a scene I mentioned before:
> >
> > The rcutorture.object_debug is set true, but the tasks-tracing does not support
> > duplicate cur_ops->call check, but the debug_objects test was still done.
> >
> > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > n_barrier_cbs=4 object_debug=1
> >
> > [  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> > [  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
> > [  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
> > [  106.105552] rcutorture: duplicated callback was invoked.
> > [  106.105567] rcutorture: duplicated callback was invoked.
> >
> > for call_rcu*()  that does not support double call checking, if
> > continue to test,
> > "rcutorture: duplicated callback was invoked". will output,
> > I just want to avoid the output of this error message :)
>
> OK, but then why not just avoid setting rcutorture.object_debug for
> the torture_type values that do not support it?

OK, understand.

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > Thanks
> > Zqiang
> >
> >
> > > I don't count the fuzzers because they are supposed to avoid specifying
> > > things that are supposed to fail.  ;-)
> > >
> > >                                                         Thanx, Paul
> > >
> > > > Thanks
> > > > Zqiang
> > > >
> > > > >
> > > > > Hi, Paul
> > > > >
> > > > > The rcutorture.object_debug is set true, but the tasks-tracing does not support
> > > > > duplicate cur_ops->call check, but the debug_objects test was still done.
> > > > >
> > > > > insmod rcutorture.ko torture_type=tasks-tracing fwd_progress=4
> > > > > n_barrier_cbs=4 object_debug=1
> > > > >
> > > > > [  106.082416] rcutorture: WARN: Duplicate call_tasks-tracing() test starting.
> > > > > [  106.082533] tasks-tracing-torture: rcu_torture_read_exit: Start of test
> > > > > [  106.082543] tasks-tracing-torture: rcu_torture_read_exit: Start of episode
> > > > > [  106.105552] rcutorture: duplicated callback was invoked.
> > > > > [  106.105567] rcutorture: duplicated callback was invoked.
> > > > > [  106.111269] rcutorture: WARN: Duplicate call_tasks-tracing() test complete.
> > > > >
> > > > > Thanks
> > > > > Zqiang
> > > > >
> > > > > >
> > > > > > Or do you have a use case that needs to silence these warnings?
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > > +                             (!cur_ops->call || !cur_ops->cb_barrier)))
> > > > > > >               return;
> > > > > > >
> > > > > > >       struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
