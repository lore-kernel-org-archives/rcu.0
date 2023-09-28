Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6471FCE7B09
	for <rcu@archiver.kernel.org>; Thu, 28 Sep 2023 07:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI1H7w (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 28 Sep 2023 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1H7v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 28 Sep 2023 03:59:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BBC92
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 00:59:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-693375d2028so2524109b3a.2
        for <rcu@vger.kernel.org>; Thu, 28 Sep 2023 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695887989; x=1696492789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DWI5gY4r+2fwiWtIRnzFyDM+ulljYxFv0jdv+qzdJms=;
        b=DyhsE+IotiK2wyRTrHFAhzub9OQCip3EatuT717HvqEh/y5cFvptMYrYncaOiIURj5
         KiAWA6MVcmgVuLyRQTodPSQHnSAKQ9dZwLLp7o+RWYEGoUujP/pWoJfgCFfs7HnRDCkt
         8vzKeRJQR8LvG/BQBPfZ53nL1i94pBM+fJsO/2CPsQWJF/cf43j5H8GvxTrtGWtlFSjp
         DIrj1TQ/0sTmY16YRk6Dve5APqKYWvF3MJbR/m+Ghmz1P2dTLmfRGgQd/Zk805fju/gd
         Y893leAgmJ9j5agZ0Xef0tvxBHIYyRYUj0HIYZzVUQALIFVEQ1p9PzjZ0S2huxyd8hGD
         dLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695887989; x=1696492789;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWI5gY4r+2fwiWtIRnzFyDM+ulljYxFv0jdv+qzdJms=;
        b=bum9LiSJcvJbN1BlOfH+tomvi05iZncOIjnpP5RvFZ8N+m+eEn8kGWqOr6KZGK4L33
         NmNFC7hElEFDWT/QsApJfpSupmCQKKGa57hTGxUGO6Jf0Ffzb3x05IgSPQ0IG33Rzx0e
         M6kBY8sAFV2IGdUkWsi4gKUBzbEvKPoOkH06vP7ROz1NtE2iPE/2cUO5SnEx5PoHNKeV
         LkpNfkPA9TJBBzn8Myz4EoVvQzh/Xt+x8ggAY31IJ1scPBwTkQYFVK+fwSeieJH8LH4C
         ZtarVy5fAQOfve4JwKANoh+ub1cq/DNQIhVzv+RnWTZ2vxuRqeHUwZ2TLgsxEr4gR5NK
         7nSQ==
X-Gm-Message-State: AOJu0YyDHUWxhxT8S4llG26G6AqbDRiRbSUC+nXbLupdzGBxYqP2bYCi
        Uuw1+fnZ187y8uOaAJswJc1Lm7svpl8fCfBOl0M=
X-Google-Smtp-Source: AGHT+IFs4/Ck1W61hZzD2wwpV1GWV/i8Z8XkfVgl6vbuKbRUfWleTIYeON5UrSvJxrvcZG8rxjgrF7UFuWwjgKSfwIs=
X-Received: by 2002:a05:6a20:a109:b0:155:2359:2194 with SMTP id
 q9-20020a056a20a10900b0015523592194mr497950pzk.46.1695887989222; Thu, 28 Sep
 2023 00:59:49 -0700 (PDT)
MIME-Version: 1.0
From:   zhuangel570 <zhuangel570@gmail.com>
Date:   Thu, 28 Sep 2023 15:59:37 +0800
Message-ID: <CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com>
Subject: SRCU: kworker hung in synchronize_srcu
To:     paulmck@kernel.org, rcu@vger.kernel.org, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Cc:     like.xu.linux@gmail.com, linussli@tencent.com, foxywang@tencent.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

We encounter SRCU hung issue in stable tree 5.4.203, we are running VM create
and destroy concurrent test, the issue happens after several weeks. Now we
didn't have a way to reproduce this issue, the issue happens randomly, this
is the second time we found it in this year.

We did some investigation with crash tools, hope to get some useful clues
about the issue, try to find root cause of the issue (further find a way to
fix or workaround it), here is some of our investigation, hope to get
feedback from SRCU experts.

[3144162.608392] INFO: task kworker/136:12:252684 blocked for more
than 122 seconds.
[3144162.615986]       Tainted: G           O  K   5.4.203-1-tlinux4-0011.1 #1
[3144162.623053] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[3144162.631162] kworker/136:12  D    0 252684      2 0x90004000
[3144162.631189] Workqueue: kvm-irqfd-cleanup irqfd_shutdown [kvm]
[3144162.631192] Call Trace:
[3144162.631202]  __schedule+0x2ee/0x660
[3144162.631206]  schedule+0x33/0xa0
[3144162.631209]  schedule_timeout+0x1c4/0x340
[3144162.631214]  ? update_load_avg+0x82/0x660
[3144162.631217]  ? raw_spin_rq_lock_nested+0x1f/0x30
[3144162.631218]  wait_for_completion+0x119/0x180
[3144162.631220]  ? wake_up_q+0x80/0x80
[3144162.631224]  __synchronize_srcu.part.19+0x81/0xb0
[3144162.631226]  ? __bpf_trace_rcu_utilization+0x10/0x10
[3144162.631227]  synchronize_srcu+0x5f/0xc0
[3144162.631236]  irqfd_shutdown+0x3c/0xb0 [kvm]
[3144162.631239]  ? __schedule+0x2f6/0x660
[3144162.631243]  process_one_work+0x19a/0x3a0
[3144162.631244]  worker_thread+0x37/0x3a0
[3144162.631247]  kthread+0x117/0x140
[3144162.631247]  ? process_one_work+0x3a0/0x3a0
[3144162.631248]  ? __kthread_cancel_work+0x40/0x40
[3144162.631250]  ret_from_fork+0x1f/0x30

Test workload:
- Repeated concurrency testing, include Create VM, service probe, destroy VM.
- VM using virito device, so kvm->irq_srcu is using frequently.
- x86_64 Machine with 191 core.

Crash analysis clues:
- The hung task is run on CPU 136, waiting synchronize_srcu to be completed.
- The current GP of SRCU struct is 304 (srcu_gp_seq and srcu_gp_seq_needed).
- The SNP (node) of SRCU struct has 2 levels.
- The SNP (node) of SRCU struct show all SNP now in GP 304 (srcu_have_cbs).
- The SNP (node) of SRCU struct show CPU 136 belongs to group [128,143].
- The SDP (per-cpu) of SRCU struct show lock and unlock matches.
- The SDP (per-cpu) of CPU 136 segcblist has one entry in pending list.
- The pending entry is just the calling entry of hung kwoker task.
- The SDP (per-cpu) of CPU 136 is waiting GP 288, gp_seq of segcblist is 296.
- The SDP (per-cpu) of CPU 136 segcblist has no entry in DONE list.
- The work-queue of SRCU and SDP of CPU 136 is idle.
- More details could be found via reference at the end of this mail.

crash> struct srcu_struct.srcu_idx,srcu_gp_seq,srcu_gp_seq_needed,srcu_gp_seq_needed_exp,sda
0xffffc900f100e878
        srcu_idx = 76
        srcu_gp_seq = 304
        srcu_gp_seq_needed = 304
        srcu_gp_seq_needed_exp = 304
        sda = 0x5fff9ac17800

crash> struct srcu_data 0x5fff9ac17800:136
[136]: ffffe8bee9817800
...
  srcu_cblist = {
    head = 0xffffc900e8413dd0,
    tails = {0xffffe8bee9817848, 0xffffc900e8413dd0,
0xffffc900e8413dd0, 0xffffc900e8413dd0},
    gp_seq = {0, 296, 296, 0},
    len = 1,
    len_lazy = 0,
    enabled = 1 '\001',
    offloaded = 0 '\000'
  },
  srcu_gp_seq_needed = 288,
  srcu_gp_seq_needed_exp = 0,
  srcu_cblist_invoking = false,
...

Root cause (we can't reproduce the issue, so the result is base on crash
analysis and code analysis):
- The leaked entry on segcblist has incorrect gp_seq (SDP is waiting 288).
- The leaked entry on segcblist seems has been "accelerated".
- The incorrect accelerate maybe caused by srcu_invoke_callbacks, because
  srcu_invoke_callbacks may be using incorrect GP seq doing accelerate.
- Here are two emulated case may cause the "accelerate issue":


CASE1: entry of CPU 136 belongs to GP 288 was accelerated to GP 292
- [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
- [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue entry
  to SDP.
- [CPU 041] [GP 284-288] starting, new synchronize_srcu request, workload run
  faster than CPU 136, start GP, set rcu_seq_start.
- [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no need
  to start GP.
- [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
  "accelerate" the seq of new added entry to 292 (it should be 288).


CASE2: entry of CPU 136 belongs to GP 288 was accelerated to GP 296
- [CPU 136] [GP 280-284] finished, yet not enter srcu_invoke_callbacks.
- [CPU 136] [GP 284-288] starting, new synchronize_srcu request, queue entry
  to SDP.
- [CPU 041] [GP 284-288] starting, new synchronize_srcu request, workload run
  faster than CPU 136, start GP.
- [CPU 041] [GP 284-288] finished, workload run faster, finish GP.
- [CPU 136] [GP 284-288] starting, call srcu_funnel_gp_start, found no need
  to start GP.
- [CPU 017] [GP 288-292] starting, new synchronize_srcu request, start GP,
  set rcu_seq_start.
- [CPU 136] [GP 280-284] finished, start to run srcu_invoke_callbacks,
  "accelerate" new added entry to 296 (it should be 288).


/*
 * CASE1
 * - entry of CPU 136 expecting GP 288 was accelerated to GP 292
 * - GP0: 280-284, GP1: 284-288.
 */

/* [GP0][CPU-136] */
process_srcu {
 srcu_gp_end
}
                /* [GP1][CPU-136] */
                synchronize_srcu {
                 __call_srcu {
                  rcu_segcblist_enqueue
                                         /* [GP1][CPU-041] */
                                         synchronize_srcu {
                                          __call_srcu {
                                           srcu_funnel_gp_start
                                            srcu_gp_start
                                             rcu_seq_start
                                          }
                                         }
                /* [GP1][CPU-136] */
                  srcu_funnel_gp_start
                 }
                }
/* [GP0][CPU-136] */
srcu_invoke_callbacks {
 rcu_segcblist_accelerate
}


/*
 * CASE2
 * - entry of CPU 136 belongs to GP 288 was accelerated to GP 296.
 * - GP0: 280-284, GP1: 284-288, GP2: 288-292.
 */

/* [GP0][CPU-136] */
process_srcu {
 srcu_gp_end
}

                  /* [GP1][CPU-136] */
                  synchronize_srcu {
                   __call_srcu {
                    rcu_segcblist_enqueue
                                           /* [GP1][CPU-041] */
                                           synchronize_srcu {
                                            __call_srcu {
                                             srcu_funnel_gp_start
                                              srcu_gp_start
                                            }
                                           }
                                           process_srcu {
                                            srcu_gp_end
                                             rcu_seq_end
                                           }
                  /* [GP1][CPU-136] */
                    srcu_funnel_gp_start
                   }
                  }
/* [GP0][CPU-136] */
srcu_invoke_callbacks {
                                                      /* [GP2][CPU-017] */
                                                      synchronize_srcu {
                                                       __call_srcu {
                                                        srcu_funnel_gp_start
                                                         srcu_gp_start
                                                          rcu_seq_start
                                                       }
                                                      }
/* [GP0][CPU-136] */
 rcu_segcblist_accelerate
}


Potential fix:
We shouldn't accelerate the segcblist in srcu_invoke_callbacks base snapshot
of current gp seq of SRCU struct, how about accelerate the sda base
sdp->srcu_gp_seq_needed, maybe like this:


diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 21115ffb6c44..ff8579abc924 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1197,7 +1197,7 @@ static void srcu_invoke_callbacks(struct
work_struct *work)
        spin_lock_irq_rcu_node(sdp);
        rcu_segcblist_insert_count(&sdp->srcu_cblist, &ready_cbs);
        (void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-                                      rcu_seq_snap(&ssp->srcu_gp_seq));
+                                      rcu_seq_snap(&sdp->srcu_gp_seq_needed));
        sdp->srcu_cblist_invoking = false;
        more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
        spin_unlock_irq_rcu_node(sdp);


Thanks for reading!


Reference detail log of crash dump information:
https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/bt.f.252684.log
https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_srcu.partial.log
https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_srcu.raw.log
https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_srcu.sda.lock.log
https://raw.githubusercontent.com/zhuangel/misc/main/debug/srcu_hung/irq_srcu.sda.raw.log
