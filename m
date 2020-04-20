Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3673C3815B
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 12:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E758206D4
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 12:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YmwirKmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDTMbE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgDTMbE (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 20 Apr 2020 08:31:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDBEC061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 05:31:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so10285130qkg.1
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eaG2gLL03LkT8pT2zeSAn0ohevupyY8MdxmF2b4hXsg=;
        b=YmwirKmDiLcbNtebseCDTO9pWBlcKWZYJxl3iYGTcjTLxfysGA/vHljqY6tnfjVVQF
         IU1jJkxOKjk3mFkmpFxWT2nD0wAJb5sYEhG6wt2jOUxddWA+JgcEp1gyAzezExVWDtZO
         qVc8rOxkYJtCwPYfDipBZh6/6d1fLrmYig3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eaG2gLL03LkT8pT2zeSAn0ohevupyY8MdxmF2b4hXsg=;
        b=kss9E9B0vrpKiD0jHq0U8mpgh4q7fjxn/bA9SnwIL4tqQLgQXR5mYHssZlFcAyzM/X
         AZafhJ6bscxa47hrgiZ6jYCT9D1V5OJFQqO14S3JjIKWcKaHsYBInAA+7uOfAEpX7Tjv
         kJtVDLGDNGkQgokbFG03DvwRE+Gc8tTTQ2CqsaIDPlO6sebQrZznoIsSf4OyFWaInMy2
         LsqKWv8N4iWw1Maxaz8RPexDBuSWobSKpWSV0BoqgkBNtTnK6T5Pgx1ip8wGOxjO+zap
         GEY5HrI4SiY+N4t/i2zwa+YumoxxNVjV3lzxVWQ5wj3uucNjJkEKX3+EG+VBlGoNqYTv
         Jrkg==
X-Gm-Message-State: AGi0PubW9bClmhhMDjmHcbpGd0bDhROrNS0f0Ii+ycY0OeRmvC4eHM+G
        hqAm8cKq8nf27UJ2Iqb6JriGuA==
X-Google-Smtp-Source: APiQypJc/JQ743Rcu0N/JMKbck/b34YLthMwsU461CgwgaIgq4MVgVnnqQOBfKz+hRbYwl7v4onV2g==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr15270562qka.496.1587385862813;
        Mon, 20 Apr 2020 05:31:02 -0700 (PDT)
Received: from [192.168.1.17] (c-71-62-121-229.hsd1.va.comcast.net. [71.62.121.229])
        by smtp.gmail.com with ESMTPSA id v16sm452808qkf.80.2020.04.20.05.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 05:31:02 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:30:58 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <1587351761.9608.4.camel@gmx.de>
References: <20200416203637.GA176663@google.com> <20200416210057.GY17661@paulmck-ThinkPad-P72> <20200416213444.4cc6kzxmwl32s2eh@linutronix.de> <20200417030515.GE176663@google.com> <20200417150442.gyrxhjymvfwsvum5@linutronix.de> <20200417182641.GB168907@google.com> <20200417185449.GM17661@paulmck-ThinkPad-P72> <20200418123748.GA3306@pc636> <20200419145836.GS17661@paulmck-ThinkPad-P72> <20200420002713.GA160606@google.com> <20200420011749.GF176663@google.com> <1587351761.9608.4.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
To:     Mike Galbraith <efault@gmx.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   joel@joelfernandes.org
Message-ID: <7E5B2485-547F-48F3-B2E1-2B99110ADE7E@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On April 19, 2020 11:02:41 PM EDT, Mike Galbraith <efault@gmx=2Ede> wrote:
>On Sun, 2020-04-19 at 21:17 -0400, Joel Fernandes wrote:
>>
>> > > Can we do even better by moving the work-scheduling out from
>under the
>> > > spinlock?  This of course means that it is necessary to handle
>the
>> > > occasional spurious call to the work handler, but that should be
>rare
>> > > and should be in the noise compared to the reduction in
>contention=2E
>> >
>> > Yes I think that will be required since -rt will sleep on workqueue
>locks as
>> > well :-(=2E I'm looking into it right now=2E
>> >
>> >         /*
>> >          * If @work was previously on a different pool, it might
>still be
>> >          * running there, in which case the work needs to be queued
>on that
>> >          * pool to guarantee non-reentrancy=2E
>> >          */
>> >         last_pool =3D get_work_pool(work);
>> >         if (last_pool && last_pool !=3D pwq->pool) {
>> >                 struct worker *worker;
>> >
>> >                 spin_lock(&last_pool->lock);
>>
>> Hmm, I think moving schedule_delayed_work() outside lock will work=2E
>Just took
>> a good look and that's not an issue=2E However calling
>schedule_delayed_work()
>> itself is an issue if the caller of kfree_rcu() is !preemptible() on
>> PREEMPT_RT=2E Because the schedule_delayed_work() calls spin_lock on
>pool->lock
>> which can sleep on PREEMPT_RT :-(=2E
>
>As of 4=2E19-rt, workqueue locks are converted to raw_spinlock_t=2E
>

Thanks for the clarification on that!!

- Joel


>	-Mike

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
