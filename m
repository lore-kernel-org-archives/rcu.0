Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FAE748F1
	for <rcu@archiver.kernel.org>; Sun,  1 Oct 2023 02:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjJAC1c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 22:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjJAC1b (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 22:27:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F125DBC
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 19:27:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so4380080a12.0
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 19:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696127247; x=1696732047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1PmEzfVhh1QIpmXa2KqhTryun/2Vj42dNRodayRu0U=;
        b=Dov1ctNdDhRN7Oj/CVLlFV3x9whH87J9frXBJ9L5c3WVluzaPmlZSNS1pchB6RDo9r
         XPrVtAOWklBjJIjhKxFQqJLcr68h+/aZfRFohe3Y1e92/68BPv+gIw94c2iXUbW3yO7R
         WJImQso9TnjLovP0Nha5p115G1zKzCiOlIOMU20ZgmySsbhJsfDwyaXJ5LVoFOrQw1Ku
         iTp8IULYlmV9JqUoLoqI8L+FdU5weSPWTHzbkjGfE4nsVWjTT5unIeiUtK5ULtm68Sab
         Wkdo97VEswHJcdb9LOIX7oiN/jGr4UO1f1ELmEgWAwe0y0l+o8V45ZdFr6/Nn8/73uCz
         f+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696127247; x=1696732047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1PmEzfVhh1QIpmXa2KqhTryun/2Vj42dNRodayRu0U=;
        b=ENpEECIwzIfwYsnLvwnwzkmyYAJOO2dZRErj5LxH0bBekiiIOYXMD7THtOWWJ6KeTa
         21gCic9ZLcWe6GygjFCxrXlBBoFE2G/hxeTqD+yN5RShXByFVUB/HOiDd5jJUQ+mQCgq
         H7gICmZQpj+drZ2hjeJyEOaL+xLW8528IXO/iWJhhsrAfMXTIhEoMCruFqt3AmizvIJ1
         CJc2jHwsKv3z9PKJPpytlsosbZB2hN7bVO+NW07rapgeBbbM8YWgDs1VOz0H2fLukcCs
         xhshwSxtktCCXCOHp8febTsaWEC1j+iY7nVj4jRhKhmKTiOMyu1aRg4bbbhOLpKJ1u9l
         4ofg==
X-Gm-Message-State: AOJu0YyW4leS9YvsC7nbnjtBiwQALVQk+AGg0eTA+5nSydBU9wOzKTAL
        PDF+l8VH3LdJFb6HpfOjOfOApbN9DN6/aI5FU9niZtmf3hkj1CTF
X-Google-Smtp-Source: AGHT+IFrFlRs5dsE2waoMjylKx41oNS2eeRe4uMNRwpNqzRcbo3899i8yzwpU1CgZNa2USOv07upr5FaxL/ITUOZP48=
X-Received: by 2002:aa7:c301:0:b0:533:dd4d:2941 with SMTP id
 l1-20020aa7c301000000b00533dd4d2941mr8036524edq.16.1696127247180; Sat, 30 Sep
 2023 19:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
 <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com> <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
In-Reply-To: <CAEXW_YSTbtk9MtQ0mhCn+yYduyNu1CHzDgvyOKwrOY19xUwqag@mail.gmail.com>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Sun, 1 Oct 2023 07:57:14 +0530
Message-ID: <CAFwiDX8FVzo3M9LORPbMK2XST8LqyoGO_YAo+kJekBO80m3PJg@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     zhuangel570 <zhuangel570@gmail.com>, paulmck@kernel.org,
        rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 1, 2023 at 5:49=E2=80=AFAM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
> On Sat, Sep 30, 2023 at 6:01=E2=80=AFAM Neeraj upadhyay <neeraj.iitr10@gm=
ail.com> wrote:
> >
> > On Fri, Sep 29, 2023 at 3:35=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Hello,
> > > Firstly, kudos to the detailed report and analysis. Rare failures are
> > > hard and your usage crash/kdump is awesome to dig deeper into the
> > > issue..
> > >
> > > On Thu, Sep 28, 2023 at 3:59=E2=80=AFAM zhuangel570 <zhuangel570@gmai=
l.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > We encounter SRCU hung issue in stable tree 5.4.203, we are running=
 VM create
> > > > and destroy concurrent test, the issue happens after several weeks.=
 Now we
> > > > didn't have a way to reproduce this issue, the issue happens random=
ly, this
> > > > is the second time we found it in this year.
> > > >
> > > >
> > > >
> > > > CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 292
> > > > - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callba=
cks.
> > > > - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, qu=
eue entry
> > > >   to SDP.
> > > > - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, wo=
rkload run
> > > >   faster than CPU 136, start GP, set rcu_seq_start.
> > > > - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found=
 no need
> > > >   to start GP.
> > > > - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbac=
ks,
> > > >   "accelerate" the seq of new added entry to 292 (it should be 288)=
.
> > >
> > > But srcu_gp_seq is at 304 right now. How does it matter that the CB i=
s
> > > marked for 292? It should be ready to execute anyway even at 292. Not=
e
> > > the meaning of "acceleration", the idea is to start conservatively an=
d
> > > move the callbacks forward as more accurate information is available.
> > > Considering this, 292 initially should be OK IMHO (that's just more
> > > conservative than 288)..
> > >
> >
> > Maybe it matters, as for a CPU, the callbacks will only be scheduled
> > in srcu_gp_end() for the GPs, for which it has updated ->srcu_data_have=
_cbs[idx]
> > and ->srcu_have_cbs[idx]
>
> Right but if I am looking at the code correctly, nothing guarantees
> that srcu_invoke_callbacks is called before srcu_gp_seq can advance.
> So all callbacks that were previously queued for older grace periods
> should be run whenever srcu_invoke_callbacks() eventually runs. That's
> why I was thinking that part looked normal to me (segments having
> older GP numbers).
>
> > > >
> > > > /*
> > > >  * CASE2
> > > >  * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296.
> > > >  * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
> > > >  */
> > > >
> > > > /* [GP0][CPU-136] */
> > > > process_srcu {
> > > >  srcu_gp_end
> > > > }
> > > >
> > > >                   /* [GP1][CPU-136] */
> > > >                   synchronize_srcu {
> > > >                    __call_srcu {
> > > >                     rcu_segcblist_enqueue
> > > >                                            /* [GP1][CPU-041] */
> > > >                                            synchronize_srcu {
> > > >                                             __call_srcu {
> > > >                                              srcu_funnel_gp_start
> > > >                                               srcu_gp_start
> > > >                                             }
> > > >                                            }
> > > >                                            process_srcu {
> > > >                                             srcu_gp_end
> > > >                                              rcu_seq_end
> > > >                                            }
> > > >                   /* [GP1][CPU-136] */
> > > >                     srcu_funnel_gp_start
> > > >                    }
> > > >                   }
> > > > /* [GP0][CPU-136] */
> > > > srcu_invoke_callbacks {
> > >
> > > If srcu_invoke_callbacks() was really called for the rdp, I would hav=
e
> > > expected rcu_segcblist_advance() to advance all those pending
> > > callbacks to 304.
> >
> > If the callback is in NEXT_TAIL and not assigned GP num,
> > rcu_segcblist_advance() won't move it and next accelerate in
> > srcu_invoke_callbacks() will
> > assign it the next gp sequence num.
>
> Sure, and after that again it will call srcu_schedule_cbs_sdp() so
> that should be fine and the next workqueue invocation
> srcu_invoke_callbacks() can advance at that time. Right?
>

But "more" only checks for CBs in DONE tail. The callbacks which have been =
just
accelerated are not advanced to DONE tail.

Having said above, I am still trying to figure out, which callbacks
are actually being pointed
by NEXT tail. Given that __call_srcu() already does a advance and
accelerate, all enqueued
callbacks would be in either WAIT tail (the callbacks for current
active GP) or NEXT_READY
tail (the callbacks for next GP after current one completes). So, they
should already have
GP num assigned and srcu_invoke_callbacks() won't accelerate them.
Only case I can
think of is, if current GP completes after we sample
rcu_seq_current(&ssp->srcu_gp_seq) for
rcu_segcblist_advance() (so, WAIT tail cbs are not moved to DONE tail)
and a new GP is started
before we take snapshot ('s') of next GP  for
rcu_segcblist_accelerate(), then the gp num 's'
> gp num of NEXT_READY_TAIL and will be put in NEXT tail. Not sure
if my understanding is correct here. Thoughts?

__call_srcu()
        rcu_segcblist_advance(&sdp->srcu_cblist,
                              rcu_seq_current(&ssp->srcu_gp_seq));
        s =3D rcu_seq_snap(&ssp->srcu_gp_seq);
        (void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);

Thanks
Neeraj


> if (more) {
>   srcu_schedule_cbs_sdp(sdp, 0);
> }
>
> thanks,
>
>  - Joel
