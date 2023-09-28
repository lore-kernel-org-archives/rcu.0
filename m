Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2575E743C4
	for <rcu@archiver.kernel.org>; Thu, 28 Sep 2023 21:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjI1Vje (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Sep 2023 17:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1Vjd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Sep 2023 17:39:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F119D
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 14:39:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso223220111fa.0
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1695937169; x=1696541969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSDaU79irOYOx9DQ1w1FgtBcj0jRCBMN1JpXZdEcrQg=;
        b=AKXaP56uq4fsUQ/9sFrBXRT9hhK8kNeB60seyqrjNXZdxFZz7TYFoZ5Exefr6WZDxz
         JuRN1+lBjc0Lzuow3CW++Zae8zguBccz3YKQoRahe+pdd8Pdx3dEM9ANLFtu97EwQ2Yz
         19FpRUk14lOT26oBzSsKcJMBwQ3torxQSE/xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695937169; x=1696541969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSDaU79irOYOx9DQ1w1FgtBcj0jRCBMN1JpXZdEcrQg=;
        b=PmJMCIiPaT2aa4GE/IPG5k5C5IfEbMjYW964rWjwx/y2U2ajKEpY/pn6uvYd/wf1AK
         yA3Cf8fbeeY28Edr7Q+fFONM224bEsSgcuRTU4XhcQdgObeKQEkD7xGkeddoFfUO7NJG
         xWfSma7UD0//bepUtg707Zk36woZlKI/ybzlYJ1ZeUAFhfnuCvj9ebBbVjhkPggejIpG
         ru/6EgMeYMdIhXXx3My+pG/kitpmOOIYl2HU78dl+bFdM5MoZM7Bv0S8GtEUvRChjSsq
         fqRIokK3ly8Gg1g+wtiwtuI4cbb2zn3v/VEww9SUXt+3CMCQe5i1ibKwrEdZ8C7k8fUd
         37lQ==
X-Gm-Message-State: AOJu0YyVxUzvb5jG/VFlRaMnN4jv5Qurft4w3RR1Xum4M/BiAF1v4qSS
        OBWkwYEiJwVMUdJoONxOSdFkX2msxKkaQvQ2sStWeA==
X-Google-Smtp-Source: AGHT+IFq5HU5ktlRwtzKmXG1h8L09LZsaPoLJFFHSR5XZ1pSEu1PF011KUhGtbgsyYRkf4xzfnSXv47qs1SeBNhCKZA=
X-Received: by 2002:a2e:a175:0:b0:2bf:e855:8cbf with SMTP id
 u21-20020a2ea175000000b002bfe8558cbfmr2389450ljl.35.1695937168647; Thu, 28
 Sep 2023 14:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
In-Reply-To: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 28 Sep 2023 17:39:17 -0400
Message-ID: <CAEXW_YSLTaagos86FnPjcfMOUjZA6zadTCaizQwsh6E38zN3eA@mail.gmail.com>
Subject: Re: SRCU: kworker hung in synchronize_srcu
To:     zhuangel570 <zhuangel570@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, like.xu.linux@gmail.com,
        linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
Firstly, kudos to the detailed report and analysis. Rare failures are
hard and your usage crash/kdump is awesome to dig deeper into the
issue..

On Thu, Sep 28, 2023 at 3:59=E2=80=AFAM zhuangel570 <zhuangel570@gmail.com>=
 wrote:
>
> Hi,
>
> We encounter SRCU hung issue in stable tree 5.4.203, we are running VM cr=
eate
> and destroy concurrent test, the issue happens after several weeks. Now w=
e
> didn't have a way to reproduce this issue, the issue happens randomly, th=
is
> is the second time we found it in this year.
>
> We did some investigation with crash tools, hope to get some useful clues
> about the issue, try to find root cause of the issue (further find a way =
to
> fix or workaround it), here is some of our investigation, hope to get
> feedback from SRCU experts.
>
> [3144162.608392] INFO: task kworker/136:12:252684 blocked for more
> than 122 seconds.
> [3144162.615986]       Tainted: G           O  K   5.4.203-1-tlinux4-0011=
.1 #1
> [3144162.623053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [3144162.631162] kworker/136:12  D    0 252684      2 0x90004000
> [3144162.631189] Workqueue: kvm-irqfd-cleanup irqfd_shutdown [kvm]
> [3144162.631192] Call Trace:
> [3144162.631202]  __schedule+0x2ee/0x660
> [3144162.631206]  schedule+0x33/0xa0
> [3144162.631209]  schedule_timeout+0x1c4/0x340
> [3144162.631214]  ? update_load_avg+0x82/0x660
> [3144162.631217]  ? raw_spin_rq_lock_nested+0x1f/0x30
> [3144162.631218]  wait_for_completion+0x119/0x180
> [3144162.631220]  ? wake_up_q+0x80/0x80
> [3144162.631224]  __synchronize_srcu.part.19+0x81/0xb0
> [3144162.631226]  ? __bpf_trace_rcu_utilization+0x10/0x10
> [3144162.631227]  synchronize_srcu+0x5f/0xc0
> [3144162.631236]  irqfd_shutdown+0x3c/0xb0 [kvm]
> [3144162.631239]  ? __schedule+0x2f6/0x660
> [3144162.631243]  process_one_work+0x19a/0x3a0
> [3144162.631244]  worker_thread+0x37/0x3a0
> [3144162.631247]  kthread+0x117/0x140
> [3144162.631247]  ? process_one_work+0x3a0/0x3a0
> [3144162.631248]  ? __kthread_cancel_work+0x40/0x40
> [3144162.631250]  ret_from_fork+0x1f/0x30
>
> Test workload:
> - Repeated concurrency testing, include Create VM, service probe, destroy=
 VM.
> - VM using virito device, so kvm->irq_srcu is using frequently.
> - x86_64 Machine with 191 core.
>
> Crash analysis clues:
> - The hung task is run on CPU 136, waiting synchronize_srcu to be complet=
ed.
> - The current GP of SRCU struct is 304 (srcu_gp_seq and srcu_gp_seq_neede=
d).
> - The SNP (node) of SRCU struct has 2 levels.
> - The SNP (node) of SRCU struct show all SNP now in GP 304 (srcu_have_cbs=
).
> - The SNP (node) of SRCU struct show CPU 136 belongs to group [128,143].
> - The SDP (per-cpu) of SRCU struct show lock and unlock matches.
> - The SDP (per-cpu) of CPU 136 segcblist has one entry in pending list.
> - The pending entry is just the calling entry of hung kwoker task.
> - The SDP (per-cpu) of CPU 136 is waiting GP 288, gp_seq of segcblist is =
296.
> - The SDP (per-cpu) of CPU 136 segcblist has no entry in DONE list.
> - The work-queue of SRCU and SDP of CPU 136 is idle.
> - More details could be found via reference at the end of this mail.
>
> crash> struct srcu_struct.srcu_idx,srcu_gp_seq,srcu_gp_seq_needed,srcu_gp=
_seq_needed_exp,sda
> 0xffffc900f100e878
>         srcu_idx =3D 76
>         srcu_gp_seq =3D 304
>         srcu_gp_seq_needed =3D 304
>         srcu_gp_seq_needed_exp =3D 304
>         sda =3D 0x5fff9ac17800
>
> crash> struct srcu_data 0x5fff9ac17800:136
> [136]: ffffe8bee9817800
> ...
>   srcu_cblist =3D {
>     head =3D 0xffffc900e8413dd0,
>     tails =3D {0xffffe8bee9817848, 0xffffc900e8413dd0,
> 0xffffc900e8413dd0, 0xffffc900e8413dd0},
>     gp_seq =3D {0, 296, 296, 0},

I am actually a bit puzzled why the DONE segment count is 0. I would
have expected it to be >=3D 296 in this situation.

>     len =3D 1,
>     len_lazy =3D 0,
>     enabled =3D 1 '\001',
>     offloaded =3D 0 '\000'
>   },
>   srcu_gp_seq_needed =3D 288,
>   srcu_gp_seq_needed_exp =3D 0,
>   srcu_cblist_invoking =3D false,
> ...
>
> Root cause (we can't reproduce the issue, so the result is base on crash
> analysis and code analysis):
> - The leaked entry on segcblist has incorrect gp_seq (SDP is waiting 288)=
.
> - The leaked entry on segcblist seems has been "accelerated".
> - The incorrect accelerate maybe caused by srcu_invoke_callbacks, because
>   srcu_invoke_callbacks may be using incorrect GP seq doing accelerate.
> - Here are two emulated case may cause the "accelerate issue":
>
>
> CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 292
> - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
> - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue en=
try
>   to SDP.
> - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, workload=
 run
>   faster than CPU 136, start GP, set rcu_seq_start.
> - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no ne=
ed
>   to start GP.
> - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
>   "accelerate" the seq of new added entry to 292 (it should be 288).

But srcu_gp_seq is at 304 right now. How does it matter that the CB is
marked for 292? It should be ready to execute anyway even at 292. Note
the meaning of "acceleration", the idea is to start conservatively and
move the callbacks forward as more accurate information is available.
Considering this, 292 initially should be OK IMHO (that's just more
conservative than 288)..

> CASE2: entry of CPU 136 belongs to GP 288 was accelerated to GP 296
> - [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
> - [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue en=
try
>   to SDP.
> - [CPU 041] [GP 284-288] starting, new synchronize_srcu request, workload=
 run
>   faster than CPU 136, start GP.
> - [CPU 041] [GP 284-288] finished, workload run faster, finish GP.
> - [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no ne=
ed
>   to start GP.
> - [CPU 017] [GP 288-292] starting, new synchronize_srcu request, start GP=
,
>   set rcu_seq_start.
> - [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
>   "accelerate" new added entry to 296 (it should be 288).

I had the same analysis here.

> /*
>  * CASE1
>  * - entry of CPU 136 expecting GP 288 was accelerated to GP 292
>  * - GP0: 280-284, GP1: 284-288.
>  */
>
> /* [GP0][CPU-136] */
> process_srcu {
>  srcu_gp_end
> }
>                 /* [GP1][CPU-136] */
>                 synchronize_srcu {
>                  __call_srcu {
>                   rcu_segcblist_enqueue
>                                          /* [GP1][CPU-041] */
>                                          synchronize_srcu {
>                                           __call_srcu {
>                                            srcu_funnel_gp_start
>                                             srcu_gp_start
>                                              rcu_seq_start
>                                           }
>                                          }
>                 /* [GP1][CPU-136] */
>                   srcu_funnel_gp_start
>                  }
>                 }
> /* [GP0][CPU-136] */
> srcu_invoke_callbacks {
>  rcu_segcblist_accelerate
> }
>
>
> /*
>  * CASE2
>  * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296.
>  * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
>  */
>
> /* [GP0][CPU-136] */
> process_srcu {
>  srcu_gp_end
> }
>
>                   /* [GP1][CPU-136] */
>                   synchronize_srcu {
>                    __call_srcu {
>                     rcu_segcblist_enqueue
>                                            /* [GP1][CPU-041] */
>                                            synchronize_srcu {
>                                             __call_srcu {
>                                              srcu_funnel_gp_start
>                                               srcu_gp_start
>                                             }
>                                            }
>                                            process_srcu {
>                                             srcu_gp_end
>                                              rcu_seq_end
>                                            }
>                   /* [GP1][CPU-136] */
>                     srcu_funnel_gp_start
>                    }
>                   }
> /* [GP0][CPU-136] */
> srcu_invoke_callbacks {

If srcu_invoke_callbacks() was really called for the rdp, I would have
expected rcu_segcblist_advance() to advance all those pending
callbacks to 304.

I posit that probably srcu_invoke_callbacks() is not even being called
in the first place, otherwise why is the DONE segment count still 0?
DONE should not be 0, otherwise callbacks will not run. The segcblist
of the rdp seems out of date perhaps due to rcu_invoke_callbacks() not
being called due to some other bug (or a workqueue/timer issue causing
the srcu_invoke_callbacks() to not run?).

I wonder if you would consider trying to reproduce it with the
rcutorture module's SRCU testing in the chance that it occurs with it
on your setup.

thanks,

 - Joel


>                                                       /* [GP2][CPU-017] *=
/
>                                                       synchronize_srcu {
>                                                        __call_srcu {
>                                                         srcu_funnel_gp_st=
art
>                                                          srcu_gp_start
>                                                           rcu_seq_start
>                                                        }
>                                                       }
> /* [GP0][CPU-136] */
>  rcu_segcblist_accelerate
> }
>
>
> Potential fix:
> We shouldn't accelerate the segcblist in srcu_invoke_callbacks base snaps=
hot
> of current gp seq of SRCU struct, how about accelerate the sda base
> sdp->srcu_gp_seq_needed, maybe like this:
>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 21115ffb6c44..ff8579abc924 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1197,7 +1197,7 @@ static void srcu_invoke_callbacks(struct
> work_struct *work)
>         spin_lock_irq_rcu_node(sdp);
>         rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
>         (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
> -                                      rcu_seq_snap(&ssp->srcu_gp_seq));
> +                                      rcu_seq_snap(&sdp->srcu_gp_seq_nee=
ded));
>         sdp->srcu_cblist_invoking =3D false;
>         more =3D rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
>         spin_unlock_irq_rcu_node(sdp);

I think "rcu_seq_snap(&ssp->srcu_gp_seq))" is correct IMHO,
rcu_seq_snap() says which what's the gp_seq at which a full GP has
passed from the moment rcu_seq_snap() is called. That's precisely when
it is safe to call all those non-accelerated callbacks.

Basically, if any of the bits are set in the state portion of the
sequence of the gp_seq number, then it returns (COUNTER_PORTION + 2)
<< RCU_SEQ_CTR_SHIFT.
Otherwise, it returns (COUNTER_PORTION + 1) << RCU_SEQ_CTR_SHIFT.





>
>
> Thanks for reading!
>
>
> Reference detail log of crash dump information:
> https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/bt.f=
.252684.log
> https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_=
srcu.partial.log
> https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_=
srcu.raw.log
> https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_=
srcu.sda.lock.log
> https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_=
srcu.sda.raw.log
