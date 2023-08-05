Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42DC001DB
	for <rcu@archiver.kernel.org>; Sat,  5 Aug 2023 01:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjHEBws (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Aug 2023 21:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHEBws (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Aug 2023 21:52:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21ED10C1
        for <rcu@vger.kernel.org>; Fri,  4 Aug 2023 18:52:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so41647571fa.2
        for <rcu@vger.kernel.org>; Fri, 04 Aug 2023 18:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691200365; x=1691805165;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mIyYD4oABiUjOGIcDeLQ4mVFt41Zr9Cqz9RWqqG1cq8=;
        b=LQeumAFVUHYAAM4IraNMF11aKVkmfa9MTMNa1jjsf3OvKqg/HLmVISBvB++cTYgxBb
         vSHPcrfxCWir5cDlLzgJMHc+cpzjm2iufB7d2grVInLL3s0VFpVLWVsOdgkM+MxGuLQf
         ApMKFv/0iZkMjSkSUMt1NDazAHrzaehgvYomw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691200365; x=1691805165;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mIyYD4oABiUjOGIcDeLQ4mVFt41Zr9Cqz9RWqqG1cq8=;
        b=PVhI7P7tJVcPC2SRmXLo2U12pz4TE2QHrxObBGKvAFczJogqMj/yjP5Fm4yuMjbMfd
         VXDCiQb8XO3+lt8rxsL5kNQTIJgIgwpEX5AAT5mTf61eQHUnEY+s0BlLSDtqVMC/I+zs
         ybr89n7eR1FIolaKupCMYe2+eKS0RuRaNmC/dozuUSNNxuo2/K2zvREtRuy9rXC6x1SQ
         i3/jqm5JH7tGDcnzlM5/sP94mYzaU5kInsPCHjYrDFRJ8ebekZ+9JyLivrPdanAisXCy
         cGvvzmup0eQ1ercboFZJ0fRYlhP0APhPN4U0K5xl2ViodvREMYfPfroigRA67X/X6giN
         Y4Rg==
X-Gm-Message-State: AOJu0YwoaWXQ0Khwx9m3TksVgUmMBqGYWz40Kn4X46pmw8I19JkTWZc/
        fHtnaNCSOvrRdIpTFamhS+kExr9J0FoZoMS77Q84JOqSZKwjmpvuE/w=
X-Google-Smtp-Source: AGHT+IH9OuAWjlgbjooQ8e+ezvmEhpcFzAMM1ZbIYBLL5iO8dnBSbM7Cwu04UQWsEFyw6vsWniovhT3taLOTACUMdWc=
X-Received: by 2002:a2e:7e0b:0:b0:2b6:ed80:15d1 with SMTP id
 z11-20020a2e7e0b000000b002b6ed8015d1mr2342980ljc.24.1691200364567; Fri, 04
 Aug 2023 18:52:44 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 4 Aug 2023 21:52:33 -0400
Message-ID: <CAEXW_YSXZ=j=2CAjTOLy1FQdqixohSBPX=HPviqxep3MRv0=hw@mail.gmail.com>
Subject: [BUG] 5.15 stable: TASKS03 rcutorture writer thread hung in D state
 at synchronize_rcu_mult_test()
To:     rcu <rcu@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
I hit this TASKS03 hung in D-state at synchronize_rcu_mult_test() but
only once and cannot reproduce it. I am sharing it here just for
tracking. Let me know any feedback. I'll continue to monitor/debug it.

This is excerpt from dmesg with full logs at the link:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-5.15.y/49/artifact/tools/testing/selftests/rcutorture/res/2023.08.03-11.12.30/TASKS03/console.log

[  592.563051] kvm-clock: cpu 2, msr 61a3081, secondary cpu clock
[ 2791.512132] kvm-guest: stealtime: cpu 2, msr 1f51b140
[ 2791.689159] tasks-torture: rtc: 0000000079608068 ver: 1879 tfle: 0
rta: 1880 rtaf: 0 rtf: 1870 rtmbe: 0 rtmbkf: 0/1648 rtbe: 0 rtbke: 0
rtbre: 0 rtbf: 0 rtb: 0 nt: 208618 onoff: 187/188:188/188
60,424:14,382 29372:19593 (HZ=1000) barrier: 1556/1557:0 read-exits:
662 nocb-toggles: 0:0
[ 2791.753481] tasks-torture: Reader Pipe:  1294864132 635 0 0 0 0 0 0 0 0 0
[ 2791.765096] tasks-torture: Reader Batch:  1294864767 0 0 0 0 0 0 0 0 0 0
[ 2791.774413] tasks-torture: Free-Block Circulation:  1879 1878 1877
1876 1875 1874 1873 1872 1871 1870 0
[ 2791.789398] ??? Writer stall state RTWS_EXP_SYNC(4) g0 f0x0 ->state 0x2 cpu 3
[ 2791.800678] task:rcu_torture_wri state:D stack:14752 pid:   75
ppid:     2 flags:0x00004000
[ 2791.814827] Call Trace:
[ 2791.819597]  <TASK>
[ 2791.823774]  __schedule+0x299/0x720
[ 2791.830734]  schedule+0x57/0xe0
[ 2791.836622]  schedule_timeout+0x113/0x150
[ 2791.844009]  wait_for_completion+0x87/0xe0
[ 2791.851416]  __wait_rcu_gp+0x126/0x130
[ 2791.858109]  synchronize_rcu_mult_test+0x47/0x70
[ 2791.865706]  ? rcu_tasks_trace_postgp+0x320/0x320
[ 2791.873743]  ? rcu_nocb_gp_kthread+0xab0/0xab0
[ 2791.881410]  ? perf_trace_rcu_torture_read+0x140/0x140
[ 2791.890288]  rcu_torture_writer+0x237/0x6e0
[ 2791.897484]  ? rcu_torture_pipe_update+0x130/0x130
[ 2791.905824]  kthread+0x12d/0x160
[ 2791.911068]  ? set_kthread_struct+0x40/0x40
[ 2791.923480]  ret_from_fork+0x22/0x30
[ 2791.929779]  </TASK>
[ 2791.933912] rcu_tasks: RTGS_WAIT_SCAN_HOLDOUTS(6) since 78 g:3027 i:0/0 kC
[ 2791.946351] Dumping ftrace buffer:
[ 2791.956592]    (ftrace buffer empty)
