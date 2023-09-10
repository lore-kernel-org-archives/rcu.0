Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C05C71153
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 23:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjIJXhb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjIJXhb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 19:37:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959CB184
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:37:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so65564091fa.2
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694389045; x=1694993845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSP1NDs3QipD9uIbW1N2zisvRfqt3t2DXhFPMioJlTw=;
        b=He9WpydxbKBHZMDUz0qeQCAYdyPfavypIpS02ygL7ECFKIyZhLSRL1X+39Fe99UOZK
         0e30v9d+uW5xskAosSvGDnJwPmWgS7aYbV8YuIC7zMkxKtIq725Mf+RPaBN3l6hrD8zS
         4nb2zLpEUQUchxUdYy01NsZLLQRsyF+I8d/MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694389045; x=1694993845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSP1NDs3QipD9uIbW1N2zisvRfqt3t2DXhFPMioJlTw=;
        b=J7Fc/xxeLKK5LNrwhQU3Tb1Es5vgsx10TbkiKNVoDC29l1wsdnRDzC9KjUfVwPlLdj
         pzQs5TGo8H0WjhJeFV2+KQWNKgnMtL4dwi7ERx10jL5LHPZnNGVd2Jxg6jj7ckTllap3
         ENPIRJmOg/wiWsVjBshUYG9cQFilaNOmdeXcHfA/fEFtBQl2yNSqU5kkTPy8g5X4GYap
         SBhtCDYDBt2eUT5PXB8bDyQLQTS7tLpsF+o1SnbddNB5nEmTiR1sR3bJbqI7yvnv+/j8
         dDH8IPBv7s+AEzhWIGkO5dSZPg9YxoTNElc9L+/WQQ5tJY8UIMWZeD3aKleuDN3uSeJ6
         GTQA==
X-Gm-Message-State: AOJu0YyepRkKM5/1lL1Til4NSPQtC3Jb98uOlUGfLxtnUOaA9w/IMeFF
        6reNWCerq/CjJ5ZhcBuyhUwCPcaXasNjZy0aDBi4YbRYfE0IYTJg
X-Google-Smtp-Source: AGHT+IFhhyxnzSWQYFPRUPcywyQOoYh7zGqB/wl79SK3UKdwQUE/yjMWziKbrpapsH3pqu1TxB1IFu7Hi8xXpxtYd2c=
X-Received: by 2002:a2e:9197:0:b0:2bc:c11c:4471 with SMTP id
 f23-20020a2e9197000000b002bcc11c4471mr6920047ljg.21.1694389044772; Sun, 10
 Sep 2023 16:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230910201445.GA1605059@google.com> <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
In-Reply-To: <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 10 Sep 2023 19:37:13 -0400
Message-ID: <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 10, 2023 at 5:16=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
[...]
> > >  I have been running into another intermittent one as well which
> > > is the boost failure and that happens once in 10-15 runs or so.
> > >
> > > I was thinking of running the following configuration on an automated
> > > regular basis to at least provide a better clue on the lucky run that
> > > catches an issue. But then the issue is it would change timing enough
> > > to maybe hide bugs. I could also make it submit logs automatically to
> > > the list on such occurrences, but one step at a time and all that.  I
> > > do need to add (hopefully less noisy) tick/timer related trace events=
.
> > >
> > > # Define the bootargs array
> > > bootargs=3D(
> > >     "ftrace_dump_on_oops"
> > >     "panic_on_warn=3D1"
> > >     "sysctl.kernel.panic_on_rcu_stall=3D1"
> > >     "sysctl.kernel.max_rcu_stall_to_panic=3D1"
> > >     "trace_buf_size=3D10K"
> > >     "traceoff_on_warning=3D1"
> > >     "panic_print=3D0x1f"      # To dump held locks, mem and other inf=
o.
> > > )
> > > # Define the trace events array passed to bootargs.
> > > trace_events=3D(
> > >     "sched:sched_switch"
> > >     "sched:sched_waking"
> > >     "rcu:rcu_callback"
> > >     "rcu:rcu_fqs"
> > >     "rcu:rcu_quiescent_state_report"
> > >     "rcu:rcu_grace_period"
> > > )
> >
> > So some insight on this boost failure. Just before the boost failures a=
re
> > reported, I see the migration thread interferring with the rcu_preempt =
thread
> > (aka GP kthread). See trace below. Of note is that the rcu_preempt thre=
ad is
> > runnable while context switching, which means its execution is interfer=
red.
> > The rcu_preempt thread is at RT prio 2 as can be seen.
> >
> > So some open-ended questions: what exactly does the migration thread wa=
nt,
> > this is something related to CPU hotplug? And if the migration thread h=
ad to
> > run, why did the rcu_preempt thread not get pushed to another CPU by th=
e
> > scheduler? We have 16 vCPUs for this test.
>
> Maybe we need a cpus_read_lock() before doing a given boost-test interval
> and a cpus_read_unlock() after finishing one?  But much depends on
> exactly what is starting those migration threads.

But in the field, a real RT task can preempt a reader without doing
cpus_read_lock() and may run into a similar boost issue?

> Then again, TREE03 is pretty aggressive about doing CPU hotplug.

Ok. I put a trace_printk() in the stopper thread to see what the
->fn() is. I'm doing another run to see what falls out.

thanks,

 - Joel
