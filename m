Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A162C83F10
	for <rcu@archiver.kernel.org>; Sun, 27 Aug 2023 03:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjH0D1a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 26 Aug 2023 23:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjH0D10 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 26 Aug 2023 23:27:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96512B8
        for <rcu@vger.kernel.org>; Sat, 26 Aug 2023 20:27:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so31738721fa.2
        for <rcu@vger.kernel.org>; Sat, 26 Aug 2023 20:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693106840; x=1693711640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFuClnrxlnzijDXB/ZYm28FGDZrqZvXTpjgVHkF+lVY=;
        b=rYKLIPZcgUc658lttS46V4n3y17njI/5lQrGz7qprb+W1yQUiqD5n+PPyPpr9Fev0Q
         Ri7RkG4PlZE6BzwRZmyQwpEk59JGoHipVEL0vJ8pULjcmzHEtro5B1iVd3kHw7xctnmd
         RUYQpn0S8yemjEY5kVSh2dkbopS/iibwD89V8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106840; x=1693711640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFuClnrxlnzijDXB/ZYm28FGDZrqZvXTpjgVHkF+lVY=;
        b=h2NmCKHt7c986soErU74fOYC/Sl5WAOMzhATr3+muB1fFq50M7vv1lWKGf9rltxmHP
         0q4qUE8GtKJEMmgSE5F+vP0m3iGj1sSN7ZZ1VJFGgqtiYyOpgc9Rhxff59GsT5EfXVbC
         GX9tOVtgQKICFcxt5jWnsuuqbT1mgz/3kFvrfws4tlCw4BxH9a7hknQnUwQRg9+hMAfT
         YCM8NYKlnvy1O/Q5boj8KFJbpVwAOLsdz89UcteXV85NQWlkTF+yyKYJR8iYdfj5E2mM
         sUhsb9wHcW+y6N9nNjVmQd+zu53RILvcyZPjXv0kkA1Q0Yj7BW21KeR0Dqz5FAjZ735w
         zu0Q==
X-Gm-Message-State: AOJu0YypSYxsIjd8uxAxw3O+CKCJQZEmIpWw4OUhMBs1CFlbLltwXv+7
        65x73iLlUfNtY979+hQRjzj1Rj3anc5ptEwyCSEMdQ==
X-Google-Smtp-Source: AGHT+IGNSytWMbiYTZDM2JN3ucYZuC5kuk2wpKr7D2qJaMGC19/0Opdza7R/QYv6z9hecjJ8L2O7zZRDuVeGBpXU39A=
X-Received: by 2002:a2e:9646:0:b0:2bc:d7cb:8283 with SMTP id
 z6-20020a2e9646000000b002bcd7cb8283mr10072806ljh.40.1693106840121; Sat, 26
 Aug 2023 20:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx> <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop> <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop> <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com>
In-Reply-To: <20230825232807.GA97898@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 26 Aug 2023 23:27:08 -0400
Message-ID: <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 25, 2023 at 7:28=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Fri, Aug 25, 2023 at 07:15:44PM +0800, Huacai Chen wrote:
> > Hi, Paul,
> >
> > On Fri, Aug 25, 2023 at 2:28=E2=80=AFAM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
[..]
> > > > > > > > > > > On Thu, Aug 17, 2023 at 3:27=E2=80=AFAM Joel Fernande=
s <joel@joelfernandes.org> wrote:
> > > > > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI c=
ontext,
> > > > > > > > > > >>
> > > > > > > > > > >> Can you not make the jiffies update conditional on w=
hether it is
> > > > > > > > > > >> called within NMI context?
> > > > > > > > > >
> > > > > > > > > > Which solves what? If KGDB has a breakpoint in the jiff=
ies lock held
> > > > > > > > > > region then you still dead lock.
> > > > > > > > > >
> > > > > > > > > > >> I dislike that..
> > > > > > > > > > > Is this acceptable?
> > > > > > > > > > >
> > > > > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > > > > {
> > > > > > > > > > >         unsigned long delta;
> > > > > > > > > > >
> > > > > > > > > > >         delta =3D nsecs_to_jiffies(ktime_get_ns() - k=
time_get_coarse_ns());
> > > > > > > > > > >
> > > > > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > > > > >                    jiffies + delta + rcu_jiffies_till=
_stall_check());
> > > > > > > > > > > }
> > > > > > > > > > >
> > > > > > > > > > > This can update jiffies_stall without updating jiffie=
s (but has the
> > > > > > > > > > > same effect).
> > > > > > > > > >
> > > > > > > > > > Now you traded the potential dead lock on jiffies lock =
for a potential
> > > > > > > > > > live lock vs. tk_core.seq. Not really an improvement, r=
ight?
> > > > > > > > > >
> > > > > > > > > > The only way you can do the above is something like the=
 incomplete and
> > > > > > > > > > uncompiled below. NMI safe and therefore livelock proof=
 time interfaces
> > > > > > > > > > exist for a reason.
> > > > > > > > >
> > > > > > > > > Just for completeness, another approach, with its own adv=
antages
> > > > > > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > > > > > rcu_state.jiffies_stall, but also set a counter indicatin=
g that this
> > > > > > > > > has been done.  Then RCU's force-quiescent processing cou=
ld decrement
> > > > > > > > > that counter (if non-zero) and reset rcu_state.jiffies_st=
all when it
> > > > > > > > > does reach zero.
> > > > > > > > >
> > > > > > > > > Setting the counter to three should cover most cases, but=
 "live by the
> > > > > > > > > heuristic, die by the heuristic".  ;-)
> > > > > > > > >
> > > > > > > > > It would be good to have some indication when gdb exited,=
 but things
> > > > > > > > > like the gdb "next" command can make that "interesting" w=
hen applied to
> > > > > > > > > a long-running function.
> > > > > > > >
> > > > > > > > The original code is adding ULONG_MAX/2, so adding ULONG_MA=
X/4 may
> > > > > > > > make no much difference? The simplest way is adding 300*HZ,=
 but Joel
> > > > > > > > dislikes that.
> > > > > > >
> > > > > > > I am not seeing the ULONG_MAX/2, so could you please point me=
 to that
> > > > > > > original code?
> > > > > >
> > > > > > Maybe I misunderstand something, I say the original code means =
code
> > > > > > before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP=
 stall
> > > > > > detection in rcu_cpu_stall_reset()").
> > > > >
> > > > > Yes, my suggestion would essentially revert that patch.  It would
> > > > > compensate by resetting rcu_state.jiffies_stall after a few calls
> > > > > to rcu_gp_fqs().
> > > > >
> > > > > Alternatively, we could simply provide a way for gdb users to man=
ually
> > > > > disable RCU CPU stall warnings at the beginning of their debug se=
ssions
> > > > > and to manually re-enable them when they are done.
> > > >
> > > > This problem is not KGDB-specific (though it is firstly found in th=
e
> > > > KGDB case), so I want to fix it in the rcu code rather than in the
> > > > kgdb code.
> > >
> > > Sure, for example, there is also PowerPC XMON.
> > >
> > > But this problem also is not RCU-specific.  There are also hardlockup=
s,
> > > softlockups, workqueue lockups, networking timeouts, and who knows wh=
at
> > > all else.
> > >
> > > Plus, and again to Thomas's point, gdb breakpoints can happen anywher=
e.
> > > For example, immediately after RCU computes the RCU CPU stall time fo=
r
> > > a new grace period, and right before it stores it.  The gdb callout
> > > updates rcu_state.jiffies_stall, but that update is overwritten with =
a
> > > stale value as soon as the system starts back up.
> > >
> > > Low probabillity, to be sure, but there are quite a few places in
> > > the kernel right after a read from some timebase or another, and many
> > > (perhaps all) of these can see similar stale-time-use problems.
> > >
> > > The only way I know of to avoid these sorts of false positives is for
> > > the user to manually suppress all timeouts (perhaps using a kernel-bo=
ot
> > > parameter for your early-boot case), do the gdb work, and then unsupp=
ress
> > > all stalls.  Even that won't work for networking, because the other
> > > system's clock will be running throughout.
> > >
> > > In other words, from what I know now, there is no perfect solution.
> > > Therefore, there are sharp limits to the complexity of any solution t=
hat
> > > I will be willing to accept.
> > I think the simplest solution is (I hope Joel will not angry):
>
> Not angry at all, just want to help. ;-). The problem is the 300*HZ solut=
ion
> will also effect the VM workloads which also do a similar reset.  Allow m=
e few
> days to see if I can take a shot at fixing it slightly differently. I am
> trying Paul's idea of setting jiffies at a later time. I think it is doab=
le.
> I think the advantage of doing this is it will make stall detection more
> robust in this face of these gaps in jiffie update. And that solution doe=
s
> not even need us to rely on ktime (and all the issues that come with that=
).
>

I wrote a patch similar to Paul's idea and sent it out for review, the
advantage being it purely is based on jiffies. Could you try it out
and let me know?

thanks,

 - Joel
