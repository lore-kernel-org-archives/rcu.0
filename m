Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D90BC77B61
	for <rcu@archiver.kernel.org>; Wed, 26 Apr 2023 00:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjDZAdT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Apr 2023 20:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbjDZAdS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Apr 2023 20:33:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2D18B95
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 17:33:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b8f599b9277so9727470276.2
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 17:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682469190; x=1685061190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m31fXmCYkRykjr64yLyl9No/N7/LO0PyiOq0SfOTcI=;
        b=mCC2U7P4bVDltEipaZ1XO58WvXI4foGsHyOajzLAv1XL51cy2mClqEWTfeNCdz0BjB
         FDaoePmyG2l8LR5TIE3yaMDKpElpT5DtYWTyv3aeA2jFJrey8VP4Tdt6aQGdIXfhs3tY
         +8it1lkZbl8pOt81pRKN37p4nZb779z/7zK/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682469190; x=1685061190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m31fXmCYkRykjr64yLyl9No/N7/LO0PyiOq0SfOTcI=;
        b=bqQtiM1iajsQgCbrSsN6VWqbP2GGX0TTv1NlESPjhwoK7TIKnmFi2UVxzpMZOoeW0+
         zSbmKSMUEH9hOmBATGMVIZS0UEIJnv8cdQRYWh4YkMNireCQvH7YH0K5k7VffdEu3MDb
         DQrijkGfTeAGKE+yoxdnf8h+aJAXYjF+5aztCnopm2QRBeBxCT38iZaRObrZ9hc7qulB
         TChzsjMELeMqdrNc88wInTXw2E4ebv4wcdSyKDGrLC7T/f9qXs3d0Iobst6oDaoEc2Ke
         v+SblcD7iRUrbtQFHTQ9pu/+Ogf+Hs8HTQR/fNA9R4QBTDUVMW6IFN+8jJwcCDQhivUH
         Z2Jw==
X-Gm-Message-State: AAQBX9frtAlI3iAkhOUTJNCkC06Jg4Nujq0fp0EYBoldvhOJWmh1+1W+
        CCaPi8n4iN3v6lOXJlY4+Sc9CR6loNLHdI+sEn/XEA==
X-Google-Smtp-Source: AKy350Z8Tn/PgyoxEoAPve79RTGvXC15zR/anbf7Twr9gfnfZWc5FlCqSIaNWE0szg0jkK8Nqg1HXvZBZGmykHGG8gQ=
X-Received: by 2002:a0d:d796:0:b0:54f:aa28:c908 with SMTP id
 z144-20020a0dd796000000b0054faa28c908mr12274895ywd.49.1682469189628; Tue, 25
 Apr 2023 17:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
 <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
 <ZEXOMC2casTlobE1@boqun-archlinux> <87fs8pzalj.fsf@mail.concordia>
 <20230424151351.GP19790@gate.crashing.org> <ZEagN1jJwg+rUzX4@boqun-archlinux>
 <CAEXW_YRfetnhgCw5OgnwhgZF_U+UkHN=uy=L8ovGLqn1UCtfTg@mail.gmail.com>
 <20230425101324.GD1331236@hirez.programming.kicks-ass.net>
 <CAABZP2ypJ98T3XAqPnLrxxzrYckSQ6sn3woEmpigQ+cRRaw=Zw@mail.gmail.com>
 <CAEXW_YQEarLt7YGQZdwmcSyZcGRCGKf89ovxjQdXBO-TgXAk-w@mail.gmail.com>
 <528b2adc-9955-5545-9e9d-affd1f935838@csgroup.eu> <CAABZP2zW7aTPChjvZMA1bECdOdFUdTd-q+vEJXJnH2zPU+uR8A@mail.gmail.com>
In-Reply-To: <CAABZP2zW7aTPChjvZMA1bECdOdFUdTd-q+vEJXJnH2zPU+uR8A@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 25 Apr 2023 20:32:57 -0400
Message-ID: <CAEXW_YQJowYrF2A=f2NOKNNjL6qZH6LzghBxt7VnJFgg-i1zgg@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lance@osuosl.org" <lance@osuosl.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 25, 2023 at 9:50=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Hi
>
> On Tue, Apr 25, 2023 at 9:40=E2=80=AFPM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 25/04/2023 =C3=A0 13:06, Joel Fernandes a =C3=A9crit :
> > > On Tue, Apr 25, 2023 at 6:58=E2=80=AFAM Zhouyi Zhou <zhouzhouyi@gmail=
.com> wrote:
> > >>
> > >> hi
> > >>
> > >> On Tue, Apr 25, 2023 at 6:13=E2=80=AFPM Peter Zijlstra <peterz@infra=
dead.org> wrote:
> > >>>
> > >>> On Mon, Apr 24, 2023 at 02:55:11PM -0400, Joel Fernandes wrote:
> > >>>> This is amazing debugging Boqun, like a boss! One comment below:
> > >>>>
> > >>>>>>> Or something simple I haven't thought of? :)
> > >>>>>>
> > >>>>>> At what points can r13 change?  Only when some particular functi=
ons are
> > >>>>>> called?
> > >>>>>>
> > >>>>>
> > >>>>> r13 is the local paca:
> > >>>>>
> > >>>>>          register struct paca_struct *local_paca asm("r13");
> > >>>>>
> > >>>>> , which is a pointer to percpu data.
> > >>>>>
> > >>>>> So if a task schedule from one CPU to anotehr CPU, the value gets
> > >>>>> changed.
> > >>>>
> > >>>> It appears the whole issue, per your analysis, is that the stack
> > >>>> checking code in gcc should not cache or alias r13, and must read =
its
> > >>>> most up-to-date value during stack checking, as its value may have
> > >>>> changed during a migration to a new CPU.
> > >>>>
> > >>>> Did I get that right?
> > >>>>
> > >>>> IMO, even without a reproducer, gcc on PPC should just not do that=
,
> > >>>> that feels terribly broken for the kernel. I wonder what clang doe=
s,
> > >>>> I'll go poke around with compilerexplorer after lunch.
> > >>>>
> > >>>> Adding +Peter Zijlstra as well to join the party as I have a feeli=
ng
> > >>>> he'll be interested. ;-)
> > >>>
> > >>> I'm a little confused; the way I understand the whole stack protect=
or
> > >>> thing to work is that we push a canary on the stack at call and on
> > >>> return check it is still valid. Since in general tasks randomly mig=
rate,
> > >>> the per-cpu validation canary should be the same on all CPUs.
> > >>>
> > >>> Additionally, the 'new' __srcu_read_{,un}lock_nmisafe() functions u=
se
> > >>> raw_cpu_ptr() to get 'a' percpu sdp, preferably that of the local c=
pu,
> > >>> but no guarantees.
> > >>>
> > >>> Both cases use r13 (paca) in a racy manner, and in both cases it sh=
ould
> > >>> be safe.
> > >> New test results today: both gcc build from git (git clone
> > >> git://gcc.gnu.org/git/gcc.git) and Ubuntu 22.04 gcc-12.1.0
> > >> are immune from the above issue. We can see the assembly code on
> > >> http://140.211.169.189/0425/srcu_gp_start_if_needed-gcc-12.txt
> > >>
> > >> while
> > >> Both native gcc on PPC vm (gcc version 9.4.0), and gcc cross compile=
r
> > >> on my x86 laptop (gcc version 10.4.0) will reproduce the bug.
> > >
> > > Do you know what fixes the issue? I would not declare victory yet. My
> > > feeling is something changes in timing, or compiler codegen which
> > > hides the issue. So the issue is still there but it is just a matter
> > > of time before someone else reports it.
> > >
> > > Out of curiosity for PPC folks, why cannot 64-bit PPC use per-task
> > > canary? Michael, is this an optimization? Adding Christophe as well
> > > since it came in a few years ago via the following commit:
> >
> > It uses per-task canary. But unlike PPC32, PPC64 doesn't have a fixed
> > register pointing to 'current' at all time so the canary is copied into
> > a per-cpu struct during _switch().
> >
> > If GCC keeps an old value of the per-cpu struct pointer, it then gets
> > the canary from the wrong CPU struct so from a different task.
> This is a fruitful learning process for me!

Nice work Zhouyi..

> Christophe:
> Do you think there is still a need to bisect GCC ? If so, I am very
> glad to continue

my 2 cents: It would be good to write a reproducer that Segher
suggested (but that might be hard since you depend on the compiler to
cache the r13 -- maybe some trial/error with CompilerExplorer will
give you the magic recipe?).

If I understand Christophe correctly, the issue requires the following
ingredients:
1. Task A is running on CPU 1, and the task's canary is copied into
the CPU1's per-cpu area pointed to by r13.
2. r13 is now cached into r10 in the offending function due to the compiler=
.
3. Task A running on CPU 1 now gets preempted right in the middle of
the offending SRCU function and gets migrated to CPU 2.
4.  CPU 2's per-cpu canary is updated to that of task A since task A
is the current task now.
5. Task B now runs on CPU 1 and the per-cpu canary on CPU 1 is now that of =
B.
6. Task A exits the function, but stack checking code reads r10 which
contains CPU 1's canary which is that of task B!
7. Boom.

So the issue is precisely in #2.  The issue is in the compiler that it
does not treat r13 as volatile as Boqun had initially mentioned.

 - Joel



>
> Cheers
> Zhouyi
> >
> > Christophe
> >
> > >
> > > commit 06ec27aea9fc84d9c6d879eb64b5bcf28a8a1eb7
> > > Author: Christophe Leroy <christophe.leroy@c-s.fr>
> > > Date:   Thu Sep 27 07:05:55 2018 +0000
> > >
> > >      powerpc/64: add stack protector support
> > >
> > >      On PPC64, as register r13 points to the paca_struct at all time,
> > >      this patch adds a copy of the canary there, which is copied at
> > >      task_switch.
> > >      That new canary is then used by using the following GCC options:
> > >      -mstack-protector-guard=3Dtls
> > >      -mstack-protector-guard-reg=3Dr13
> > >      -mstack-protector-guard-offset=3Doffsetof(struct paca_struct, ca=
nary))
> > >
> > >      Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > >      Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > >
> > >   - Joel
