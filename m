Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3009C4332F
	for <rcu@archiver.kernel.org>; Sat, 31 Dec 2022 17:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLaROw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 31 Dec 2022 12:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiLaROu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 31 Dec 2022 12:14:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3660D8
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 09:14:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id jr11so19316443qtb.7
        for <rcu@vger.kernel.org>; Sat, 31 Dec 2022 09:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fum9yMjcVMS7KMVDYbdCfxK7plNoPjOvttlxUrKefAs=;
        b=wIBI8E1zEMOMk+WKH6/au+OZo4Tkl3XC9O4m7QE8KnnFtAiiE1dG4WMyDeXAyLSHYM
         HZQcxuvY6qzKiJSaSzlMOApfj+ypq3nKEBaZqSwggbYyxXuEszS3SKBNg02Fw0XmREhy
         RP20MA6UI5yAYVkuu27F6dWgsCMdAZS7gHwac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fum9yMjcVMS7KMVDYbdCfxK7plNoPjOvttlxUrKefAs=;
        b=yYpzOi6+0JsIxBFp1+6hw0k52PEvTIp8v4E70uhRlAP06D2o/W7x2rE266bFxxR/di
         YieeXmcITZSbdEGAK/U4UZVUlvYT3BHPADMYYllIZpW3cOPwNJGru/moufnEzoxZuZHs
         bTnQndCWqLKo9VId0nASLIN0RXFWKbpnmLUvtD+r9xOIwN+aA7aMCzqPN/PGZlQelS/g
         f3H05HfKEASY1kALXtCyjuIif+R+atGgsDB6Q9mYyGwgWVT4XZX739/v5t2fUUAuSNOp
         y/RmukdFyGPfDCt7b2FQI/jMkHvYJdF5Y3KwB4GyYa+0TECL4scTA1PwO7ycdkqjU7M5
         ymCg==
X-Gm-Message-State: AFqh2kqvUp8dcGO0QexxWw1XOXBWrMzFrmRpJAycHFvWR6B9Ebw/cxuy
        r8zvPP9mbDE0DhCvAqc4Wr70NeXJBkgQZUoW
X-Google-Smtp-Source: AMrXdXuQY5nLLk9DihEfn02RDQuZsW2d3Z5zbIKFacoCOsXLnQKh75xySfXPJgHvxu4kkX0RwpGYNQ==
X-Received: by 2002:a05:622a:59c8:b0:3a8:16a7:696f with SMTP id gc8-20020a05622a59c800b003a816a7696fmr56939897qtb.0.1672506888642;
        Sat, 31 Dec 2022 09:14:48 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id dt45-20020a05620a47ad00b006ec771d8f89sm17239115qkb.112.2022.12.31.09.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 09:14:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: RCU stalls with TREE07 on v6.0 kernel
Date:   Sat, 31 Dec 2022 12:14:37 -0500
Message-Id: <1090A1E0-B316-4115-8A90-5C23A6405E26@joelfernandes.org>
References: <20221231165220.GV4001@paulmck-ThinkPad-P17-Gen-1>
Cc:     rcu <rcu@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <20221231165220.GV4001@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Dec 31, 2022, at 11:52 AM, Paul E. McKenney <paulmck@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Sat, Dec 31, 2022 at 04:18:40PM +0000, Joel Fernandes wrote:
>>> On Sat, Dec 31, 2022 at 4:16 PM Joel Fernandes <joel@joelfernandes.org> w=
rote:
>>>=20
>>> On Sat, Dec 31, 2022 at 4:07 PM Paul E. McKenney <paulmck@kernel.org> wr=
ote:
>>>>=20
>>>> On Sat, Dec 31, 2022 at 12:28:10AM -0500, Joel Fernandes wrote:
>>>>> On Fri, Dec 30, 2022 at 9:14 PM Paul E. McKenney <paulmck@kernel.org> w=
rote:
>>>>>>=20
>>>>>> On Fri, Dec 30, 2022 at 08:42:24PM -0500, Joel Fernandes wrote:
>>>>>>> Hello,
>>>>>>>=20
>>>>>>> I have been firefighting a hang on 6.0.y stable kernels with
>>>>>>> rcutorture. It happens mostly consistently when TREE07 is shutting
>>>>>>> down.
>>>>>>>=20
>>>>>>> It appears that the RCU torture threads are attempted to stop but th=
e
>>>>>>> shutdown thread, but are constantly awakened by a timer softirq
>>>>>>> handler in ksoftirqd context. When they wake up, they immediately go=
to
>>>>>>> sleep in uninterruptible state until the next time a timer handler
>>>>>>> wakes them up. It appears the timer softirq is long enough to cause
>>>>>>> RCU stalls and I see it calling 100s of timer function handlers
>>>>>>> (call_timer_fn).
>>>>>>>=20
>>>>>>> I am doing some more investigation with trace_printk(s):
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/comm=
it/?h=3Dstable/trace-hang-6.0.y&id=3Db779b1e92c97f29333a282ee8f548da02f64de2=
b
>>>>>>>=20
>>>>>>> Regarding the timer handlers, I was wondering if it is possible that=
 a
>>>>>>> large number of timer handlers constantly queued can cause RCU stall=
s
>>>>>>> due to the timer softirq taking a very long time. That certainly
>>>>>>> appears to be the case here. Shouldn't the timer softirq also do
>>>>>>> rcu_softirq_qs() similar to the ksoftirq loop, in case there are too=

>>>>>>> many of them?
>>>>>>=20
>>>>>> That is certainly a good thing to try!
>>>>>=20
>>>>> I am trying something like this just for testing, let's see what happe=
ns ;-)
>>>>>=20
>>>>> @@ -1788,9 +1796,14 @@ static inline void __run_timers(struct timer_ba=
se *base)
>>>>>=20
>>>>>                while (levels--)
>>>>>                        expire_timers(base, heads + levels);
>>>>=20
>>>> Might you need to put it inside the body of this "while" loop?
>>>=20
>>> I could but even doing the below did not help. Do you see any reason
>>> putting inside the loop helps? Let me know.
>>>=20
>>>>> +               rcu_softirq_qs();
>>>>>        }
>>>>>=20
>>>>> I guess I am also wondering why the rcu reader does not stop queuing
>>>>> timers. It is doing schedule_timeout_interruptible() constantly even
>>>>> though the test is being stopped.
>>>>=20
>>>> As in it is doing schedule_timeout_interruptible() in a loop that does
>>>> not check torture_must_stop()?  That would be bad unless there is some
>>>> reason the loop cannot just stop.  But if the loop cannot just stop,
>>>> that leads me to believe that there is a bug elsewhere.  After all, giv=
en
>>>> that the test is ending, why shouldn't all the loops be able to just st=
op?
>>>=20
>>> Sorry I meant uninterruptible sleep. So
>>> schedule_timeout_uninterruptible(). But I still cannot nail where in
>>> the torture test it is coming from. Now I put a trace_dump_stack()
>>> directly in the schedule loop() and I am hoping it will show:
>>>=20
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index c2bb0cd4225d5..d79bc3b91818a 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -6390,6 +6390,8 @@ pick_next_task(struct rq *rq, struct task_struct
>>> *prev, struct rq_flags *rf)
>>> *
>>> * WARNING: must be called with preemption disabled!
>>> */
>>> +static int rcu_tort_ds;
>>> +
>>> static void __sched notrace __schedule(unsigned int sched_mode)
>>> {
>>> struct task_struct *prev, *next;
>>> @@ -6452,6 +6454,11 @@ static void __sched notrace __schedule(unsigned
>>> int sched_mode)
>>> if (prev->sched_contributes_to_load)
>>> rq->nr_uninterruptible++;
>>> + // Dump stack for uninterruptible every 10 stacks.
>>> +   if (prev_state & TASK_UNINTERRUPTIBLE && ((rcu_tort_ds++ % 10) =3D=3D=
 0)) {
>>> +       trace_dump_stack(0);
>>> + }
>>> +
>>> /*
>>=20
>> Ok found the uninterruptible sleep, it is coming from here:
>>=20
>> [ 1359.592979] rcu_tort-160      15d.... 346177086us : <stack trace>
>> [ 1359.592979]  =3D> __ftrace_trace_stack
>> [ 1359.592979]  =3D> __schedule
>> [ 1359.592979]  =3D> schedule
>> [ 1359.592979]  =3D> schedule_timeout
>> [ 1359.592979]  =3D> torture_kthread_stopping
>> [ 1359.592979]  =3D> rcu_torture_reader
>> [ 1359.592979]  =3D> kthread
>> [ 1359.592979]  =3D> ret_from_fork
>>=20
>> Thoughts?
>=20
> That is door #3, or a variation on it.  That rcu_torture_reader() task
> is waiting to be stopped in torture_kthread_stopping().  The next question=

> is "why isn't rcu_torture_cleanup() making it to the 'if (reader_tasks)'
> code that stops the readers?"
>=20
> Getting a stack trace of the task executing rcu_torture_cleanup() would
> likely be helpful.  Or just check for the console-log messages that it
> already emits.  These look like "Stopping rcu_torture_writer task".

Thanks for the suggestions, will look into them. I will focus the debug on t=
he kthread stopping part. I think we might have to check for signal flags if=
 we are not already, I found another patch that solved similar issues doing s=
o. And in that patch also it was tight loop around the schedule timeout call=
s.

Happy new year, over here probably going to take it easy rest of the day.. b=
ut this issue is making me curious ;-)

Thanks,

 - Joel=20


>=20
>                            Thanx, Paul
