Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B65AE743D5
	for <rcu@archiver.kernel.org>; Fri, 29 Sep 2023 01:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2Bui (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Sep 2023 21:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Buh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Sep 2023 21:50:37 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AB19C
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 18:50:35 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c49f781855so7809551a34.3
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695952235; x=1696557035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEm0VdVK9zPc5NSAgw5SYND4pjPpWBb334+9HMpWgA4=;
        b=Y50677C36uvVFPKJIe7MPjOq+S6h/IwLccNAE34bnLdGyNuexfLSK1pZ3X9lmhZl9U
         qMo8CdDQ8rAmNZmMFFD5xnip3V2Pp9eTiCfsal8kpG9y27xnxdkztuRUhr5A11w+hKBL
         8J737pgIIiLSrG3IpTCeSGkIsd8KPZnUVWa+h2oV3+PO+HEkGv2BRpOF+5+a431NV1o+
         c2S28dE198TjEIzeM3gwdZXB7fTJBonBenBO7emGIyXcEep2niMMczFKTfmjim0q6OV5
         XJwEueUnR+dN4t8x3DCvRypvL2SZVYFt46nMwPOTCWqTu92pkKpJKnxE5ZgPNLialjLS
         NC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695952235; x=1696557035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEm0VdVK9zPc5NSAgw5SYND4pjPpWBb334+9HMpWgA4=;
        b=GR5EelFg10hCehMik2MmnLjEyPujVHXUAareeIaLkzmPaqXGFQjV3OIzxqLBCHorD2
         f7masLmquEm/5+tuOcGRrLBMT+VxmKhz4e0vU1jGpVZONhygBjbIgsywB5KeH/it5Q7b
         hTdXs73QKgTLYWNxxCTuH8PbuuV/cE8f6Sb2zNfpC7H2INfHaY8+lNNTb2hXweTzEaLu
         +ZRsdeOOsXISYLJ+hnYKaGmPhgkmYTIEMdVk4Cvn1nqsenMPj9Ac4X+BwUoNlRX2ue7q
         dk6PgXnsFi0P15/7DAU3awHGFoYsu2FlSQGQGzLCoSTpucLXu6ZrzhIQ8+oAvbIbyfHd
         CcwA==
X-Gm-Message-State: AOJu0Yxovrb1THZhi+3yV6E6zsDUMAYBnLVbkAMfpsTnfT5145m6Krda
        +3SzycJSVJwSGyUKxUuv79Wee+DWYRCCn/zV7f0=
X-Google-Smtp-Source: AGHT+IHVMbCIaAsI/0MEMfbDOsHUNq+BQiyKtEjn9rz3X7Il/BSAqO7FHfC5AjS3kX6tY1uLp+yXKP+Azi6kcjhE9WU=
X-Received: by 2002:a05:6830:139a:b0:6b9:6481:8e33 with SMTP id
 d26-20020a056830139a00b006b964818e33mr2975728otq.13.1695952234676; Thu, 28
 Sep 2023 18:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
 <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
In-Reply-To: <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 29 Sep 2023 09:50:23 +0800
Message-ID: <CAABZP2y07HaayoDo_o-DgbTTRR8NZrcpCvQi9-omq-catu3RLQ@mail.gmail.com>
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

On Fri, Sep 29, 2023 at 6:05=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
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
> > We did some investigation with crash tools, hope to get some useful clu=
es
> > about the issue, try to find root cause of the issue (further find a wa=
y to
> > fix or workaround it), here is some of our investigation, hope to get
> > feedback from SRCU experts.
> >
> > [3144162.608392] INFO: task kworker/136:12:252684 blocked for more
> > than 122 seconds.
> > [3144162.615986]       Tainted: G           O  K   5.4.203-1-tlinux4-00=
11.1 #1
> > [3144162.623053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > disables this message.
> > [3144162.631162] kworker/136:12  D    0 252684      2 0x90004000
> > [3144162.631189] Workqueue: kvm-irqfd-cleanup irqfd_shutdown [kvm]
> > [3144162.631192] Call Trace:
> > [3144162.631202]  __schedule+0x2ee/0x660
> > [3144162.631206]  schedule+0x33/0xa0
> > [3144162.631209]  schedule_timeout+0x1c4/0x340
> > [3144162.631214]  ? update_load_avg+0x82/0x660
> > [3144162.631217]  ? raw_spin_rq_lock_nested+0x1f/0x30
> > [3144162.631218]  wait_for_completion+0x119/0x180
> > [3144162.631220]  ? wake_up_q+0x80/0x80
> > [3144162.631224]  __synchronize_srcu.part.19+0x81/0xb0
> > [3144162.631226]  ? __bpf_trace_rcu_utilization+0x10/0x10
> > [3144162.631227]  synchronize_srcu+0x5f/0xc0
> > [3144162.631236]  irqfd_shutdown+0x3c/0xb0 [kvm]
> > [3144162.631239]  ? __schedule+0x2f6/0x660
> > [3144162.631243]  process_one_work+0x19a/0x3a0
> > [3144162.631244]  worker_thread+0x37/0x3a0
> > [3144162.631247]  kthread+0x117/0x140
> > [3144162.631247]  ? process_one_work+0x3a0/0x3a0
> > [3144162.631248]  ? __kthread_cancel_work+0x40/0x40
> > [3144162.631250]  ret_from_fork+0x1f/0x30
> >
> > Test workload:
> > - Repeated concurrency testing, include Create VM, service probe, destr=
oy VM.
> > - VM using virito device, so kvm->irq_srcu is using frequently.
> > - x86_64 Machine with 191 core.
> >
> > Crash analysis clues:
> > - The hung task is run on CPU 136, waiting synchronize_srcu to be compl=
eted.
> > - The current GP of SRCU struct is 304 (srcu_gp_seq and srcu_gp_seq_nee=
ded).
> > - The SNP (node) of SRCU struct has 2 levels.
> > - The SNP (node) of SRCU struct show all SNP now in GP 304 (srcu_have_c=
bs).
> > - The SNP (node) of SRCU struct show CPU 136 belongs to group [128,143]=
.
> > - The SDP (per-cpu) of SRCU struct show lock and unlock matches.
> > - The SDP (per-cpu) of CPU 136 segcblist has one entry in pending list.
> > - The pending entry is just the calling entry of hung kwoker task.
> > - The SDP (per-cpu) of CPU 136 is waiting GP 288, gp_seq of segcblist i=
s 296.
> > - The SDP (per-cpu) of CPU 136 segcblist has no entry in DONE list.
> > - The work-queue of SRCU and SDP of CPU 136 is idle.
> > - More details could be found via reference at the end of this mail.
> >
> > crash> struct srcu_struct.srcu_idx,srcu_gp_seq,srcu_gp_seq_needed,srcu_=
gp_seq_needed_exp,sda
> > 0xffffc900f100e878
> >         srcu_idx =3D 76
> >         srcu_gp_seq =3D 304
> >         srcu_gp_seq_needed =3D 304
> >         srcu_gp_seq_needed_exp =3D 304
> >         sda =3D 0x5fff9ac17800
> >
> > crash> struct srcu_data 0x5fff9ac17800:136
> > [136]: ffffe8bee9817800
> > ...
> >   srcu_cblist =3D {
> >     head =3D 0xffffc900e8413dd0,
> >     tails =3D {0xffffe8bee9817848, 0xffffc900e8413dd0,
> > 0xffffc900e8413dd0, 0xffffc900e8413dd0},
> >     gp_seq =3D {0, 296, 296, 0},
>
> I am actually a bit puzzled why the DONE segment count is 0. I would
> have expected it to be >=3D 296 in this situation.
>
> >     len =3D 1,
> >     len_lazy =3D 0,
> >     enabled =3D 1 '\001',
> >     offloaded =3D 0 '\000'
> >   },
> >   srcu_gp_seq_needed =3D 288,
> >   srcu_gp_seq_needed_exp =3D 0,
> >   srcu_cblist_invoking =3D false,
> > ...
> >
> > Root cause (we can't reproduce the issue, so the result is base on cras=
h
> > analysis and code analysis):
> > - The leaked entry on segcblist has incorrect gp_seq (SDP is waiting 28=
8).
> > - The leaked entry on segcblist seems has been "accelerated".
> > - The incorrect accelerate maybe caused by srcu_invoke_callbacks, becau=
se
> >   srcu_invoke_callbacks may be using incorrect GP seq doing accelerate.
> > - Here are two emulated case may cause the "accelerate issue":
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
> > CASE2: entry of CPU 136 belongs to GP 288 was accelerated to GP 296
> > - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
> > - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue =
entry
> >   to SDP.
> > - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, worklo=
ad run
> >   faster than CPU 136, start GP.
> > - [CPU 041] [GP 284-288] finished, workload run faster, finish GP.
> > - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no =
need
> >   to start GP.
> > - [CPU 017] [GP 288-292] starting, new synchronize_srcu request, start =
GP,
> >   set rcu_seq_start.
> > - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
> >   "accelerate" new added entry to 296 (it should be 288).
>
> I had the same analysis here.
>
> > /*
> >  * CASE1
> >  * - entry of CPU 136 expecting GP 288 was accelerated to GP 292
> >  * - GP0: 280-284, GP1: 284-288.
> >  */
> >
> > /* [GP0][CPU-136] */
> > process_srcu {
> >  srcu_gp_end
> > }
> >                 /* [GP1][CPU-136] */
> >                 synchronize_srcu {
> >                  __call_srcu {
> >                   rcu_segcblist_enqueue
> >                                          /* [GP1][CPU-041] */
> >                                          synchronize_srcu {
> >                                           __call_srcu {
> >                                            srcu_funnel_gp_start
> >                                             srcu_gp_start
> >                                              rcu_seq_start
> >                                           }
> >                                          }
> >                 /* [GP1][CPU-136] */
> >                   srcu_funnel_gp_start
> >                  }
> >                 }
> > /* [GP0][CPU-136] */
> > srcu_invoke_callbacks {
> >  rcu_segcblist_accelerate
> > }
> >
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
As an enthusiast, I have an idea, could we use the ftrace mechanism to
log ftrace just before the stall for more detailed analysis.
Recently I used the cyclictest --tracemark option to analyze the
ftrace of the system just before the cyclictest's -b latency is
exceeded. [1]

Thanks
Zhouyi
[1] https://man.archlinux.org/man/cyclictest.8.en
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
