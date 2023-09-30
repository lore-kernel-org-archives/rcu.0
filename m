Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C512E77356
	for <rcu@archiver.kernel.org>; Sat, 30 Sep 2023 10:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjI3KB5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 30 Sep 2023 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjI3KB4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 30 Sep 2023 06:01:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8A9DD
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 03:01:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533c8f8f91dso16213592a12.0
        for <rcu@vger.kernel.org>; Sat, 30 Sep 2023 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696068112; x=1696672912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRhQOCfQ96o+p7Uvban/CtT1oFLx80tk2CiKXKcRTCY=;
        b=bzd2Oo/gvlXFjBP4tEijzZuuVdIvWmcxyTDofq4U5AMVw+V5o/pmYk2kWOLGvmM3XK
         a3ytEzl7ixsVF8Xe8t65Jn788jVx/JW5XnFeCn04W157lp0PN9TCkWdwHfL7jTmdwDnK
         KnuEyC7ZDUKPIpE+Sz+G1pWrMn7bn+BoebAtEulXwHbzg1Bbyv1DZCpNwyEPg/uVKEC2
         tn3YIOSI67yKmkjoi1o/EJdjbLpdd5mhuWlFzssD384+6+XBNbyY+WzWBFTdl5Lo+u8t
         CQNzKCbh96+ybZMHi9On5H47vLphOp9q92Ce4eUpFV5Tfrl63m0NR1r9Ai6LEb1am32P
         GnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696068112; x=1696672912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRhQOCfQ96o+p7Uvban/CtT1oFLx80tk2CiKXKcRTCY=;
        b=K3BZFAn6bfFto5TVzpKETprxL19Lb9VOBw7KhamWY7U09fUXryf5BfL3xOsacPCBhf
         kQfkhKtl5ftlbRsvAGup1/1EEHsSYEnIuyY1V4ylylTLKxEB2BT9SO2FG8v3A//cZMjR
         EjhYn9iC106OsPNIxCpBApO7h5xD8X3NSOASynjxI5hBu8a0h4kjWMoqoOP6fvUx8AW7
         m5g6AbGLaOCbXvqCBdGp3AJt62/ZvEHd5HVtvUN7d1Fr3q43UN9rcxHk+aqOjMLsrScS
         rWm6SH4LnSFA1C7GuBD2Cu3FlHUZSGu8VXvYcGZOCFEJdSgPRNuhXOni4+JSYz9/4Lgt
         YOjQ==
X-Gm-Message-State: AOJu0YwfVLC7lP1PmxUDZ4OOQdHcXzuoEKsFiOsnht/kHSuNSgHujLdk
        eWpRNwwCyCgK3AYycl2afLKZJ5PEvRInHJAZshc=
X-Google-Smtp-Source: AGHT+IE8Hn3c0vQYAfxkleyg8NnJb+3T/WQt791gLfqQ30ypIDTG1h7nQ3zKUq0N08xVu9pty4XxiiDsca+1jarT9OE=
X-Received: by 2002:a50:fb07:0:b0:534:6668:605b with SMTP id
 d7-20020a50fb07000000b005346668605bmr5622222edq.22.1696068111655; Sat, 30 Sep
 2023 03:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
In-Reply-To: <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
From:   Neeraj upadhyay <neeraj.iitr10@gmail.com>
Date:   Sat, 30 Sep 2023 15:31:39 +0530
Message-ID: <CAFwiDX_db+WGuJvR-hvQCfGSoLw+E0nzzbn+nTvrhc4Pz2GbmA@mail.gmail.com>
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

On Fri, Sep 29, 2023 at 3:35=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> Hello,
> Firstly, kudos to the detailed report and analysis. Rare failures are
> hard and your usage crash/kdump is awesome to dig deeper into the
> issue..
>
> On Thu, Sep 28, 2023 at 3:59=E2=80=AFAM zhuangel570 <zhuangel570@gmail.co=
m> wrote:
> >
> > Hi,
> >
> > We encounter SRCU hung issue in stable tree 5.4.203, we are running VM =
create
> > and destroy concurrent test, the issue happens after several weeks. Now=
 we
> > didn't have a way to reproduce this issue, the issue happens randomly, =
this
> > is the second time we found it in this year.
> >
> >
> >
> > CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 292
> > - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
> > - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue =
entry
> >   to SDP.
> > - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, worklo=
ad run
> >   faster than CPU 136, start GP, set rcu_seq_start.
> > - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no =
need
> >   to start GP.
> > - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
> >   "accelerate" the seq of new added entry to 292 (it should be 288).
>
> But srcu_gp_seq is at 304 right now. How does it matter that the CB is
> marked for 292? It should be ready to execute anyway even at 292. Note
> the meaning of "acceleration", the idea is to start conservatively and
> move the callbacks forward as more accurate information is available.
> Considering this, 292 initially should be OK IMHO (that's just more
> conservative than 288)..
>

Maybe it matters, as for a CPU, the callbacks will only be scheduled
in srcu_gp_end() for the GPs, for which it has updated ->srcu_data_have_cbs=
[idx]
and ->srcu_have_cbs[idx]

> >
> > /*
> >  * CASE2
> >  * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296.
> >  * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
> >  */
> >
> > /* [GP0][CPU-136] */
> > process_srcu {
> >  srcu_gp_end
> > }
> >
> >                   /* [GP1][CPU-136] */
> >                   synchronize_srcu {
> >                    __call_srcu {
> >                     rcu_segcblist_enqueue
> >                                            /* [GP1][CPU-041] */
> >                                            synchronize_srcu {
> >                                             __call_srcu {
> >                                              srcu_funnel_gp_start
> >                                               srcu_gp_start
> >                                             }
> >                                            }
> >                                            process_srcu {
> >                                             srcu_gp_end
> >                                              rcu_seq_end
> >                                            }
> >                   /* [GP1][CPU-136] */
> >                     srcu_funnel_gp_start
> >                    }
> >                   }
> > /* [GP0][CPU-136] */
> > srcu_invoke_callbacks {
>
> If srcu_invoke_callbacks() was really called for the rdp, I would have
> expected rcu_segcblist_advance() to advance all those pending
> callbacks to 304.

If the callback is in NEXT_TAIL and not assigned GP num,
rcu_segcblist_advance() won't move it and next accelerate in
srcu_invoke_callbacks() will
assign it the next gp sequence num.


Thanks
Neeraj

>
> I posit that probably srcu_invoke_callbacks() is not even being called
> in the first place, otherwise why is the DONE segment count still 0?
> DONE should not be 0, otherwise callbacks will not run. The segcblist
> of the rdp seems out of date perhaps due to rcu_invoke_callbacks() not
> being called due to some other bug (or a workqueue/timer issue causing
> the srcu_invoke_callbacks() to not run?).
>
> I wonder if you would consider trying to reproduce it with the
> rcutorture module's SRCU testing in the chance that it occurs with it
> on your setup.
>
> thanks,
>
>  - Joel
>
>
> >                                                       /* [GP2][CPU-017]=
 */
> >                                                       synchronize_srcu =
{
> >                                                        __call_srcu {
> >                                                         srcu_funnel_gp_=
start
> >                                                          srcu_gp_start
> >                                                           rcu_seq_start
> >                                                        }
> >                                                       }
> > /* [GP0][CPU-136] */
> >  rcu_segcblist_accelerate
> > }
> >
> >
> > Potential fix:
> > We shouldn't accelerate the segcblist in srcu_invoke_callbacks base sna=
pshot
> > of current gp seq of SRCU struct, how about accelerate the sda base
> > sdp->srcu_gp_seq_needed, maybe like this:
> >
> >
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 21115ffb6c44..ff8579abc924 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1197,7 +1197,7 @@ static void srcu_invoke_callbacks(struct
> > work_struct *work)
> >         spin_lock_irq_rcu_node(sdp);
> >         rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
> >         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> > -                                      rcu_seq_snap(&ssp->srcu_gp_seq))=
;
> > +                                      rcu_seq_snap(&sdp->srcu_gp_seq_n=
eeded));
> >         sdp->srcu_cblist_invoking =3D false;
> >         more =3D rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
> >         spin_unlock_irq_rcu_node(sdp);
>
> I think "rcu_seq_snap(&ssp->srcu_gp_seq))" is correct IMHO,
> rcu_seq_snap() says which what's the gp_seq at which a full GP has
> passed from the moment rcu_seq_snap() is called. That's precisely when
> it is safe to call all those non-accelerated callbacks.
>
> Basically, if any of the bits are set in the state portion of the
> sequence of the gp_seq number, then it returns (COUNTER_PORTION + 2)
> << RCU_SEQ_CTR_SHIFT.
> Otherwise, it returns (COUNTER_PORTION + 1) << RCU_SEQ_CTR_SHIFT.
>
>
>
>
>
> >
> >
> > Thanks for reading!
> >
> >
> > Reference detail log of crash dump information:
> > https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/bt=
.f.252684.log
> > https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/ir=
q_srcu.partial.log
> > https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/ir=
q_srcu.raw.log
> > https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/ir=
q_srcu.sda.lock.log
> > https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/ir=
q_srcu.sda.raw.log
