Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176DDC433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbiELDFC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiELDE7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:04:59 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15381FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:04:58 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kk28so3481208qvb.3
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0qQTLcLpjX9FQM3fnQL6R3n5QbSlZYQSJdL5JR87Lc=;
        b=rbPuvRnRtAVZUYX1id7DqAeSS0QbwaUtWkmJHYoe2GFkklOLj3xJr5tAgbmcTDwZcS
         qxRWtGSjguiJq8t4OFu/1OFeKPcQ/T228UJtJVRUaUrNhOtxO3dikv3xoAP5KLkj4spt
         bCRp1t5/HHsP3iRsL54ww9KSgZktWBWQkdZIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S0qQTLcLpjX9FQM3fnQL6R3n5QbSlZYQSJdL5JR87Lc=;
        b=6toexFtVhPlsnGxLUfeGdJAXwK3+i6jDxbrOgdAbIqzSCx43H10DnHSJsZ3ctO64x8
         E40cHOYPjXYTQvCCkv9SQwvozo7e0P/iNLMETw9mydae7zwl/9zrEnofKzKg7K77fpUu
         sFcuH2ldiMXwbOcgReuxiibf9m6NRBTalPhmLV9vpIdId6fNSacP1AFODlTC9GbnY4l4
         avLl2iKuIANARWVToPHq1+o/g6yfeZ/zYfA0TW8nZKMuzSLTcuHYK9zfdqeIXk+Yxmzx
         UwPmmy5uiMZE3kEvsEmrHIJSF93nEe1ll6n3i0rGzWbEgZ0ehRCzRxveRlSYdIgVBSmo
         eK6Q==
X-Gm-Message-State: AOAM530/BqMO0GK+rDrOA6GW5lXPtDLmiAg5W7TUiBsbeV+6LphconKK
        k20PNO1Iae04RulC+e6hGQ12kZcoPU5ipg==
X-Google-Smtp-Source: ABdhPJz2cYwnKe5tBuWO2Dr8+hzcnHyXycgh6ChHpDdvN1StPi8i+ZjuDDtJEQpDUWaWkA0rxktY/A==
X-Received: by 2002:ad4:576c:0:b0:45a:91a4:c109 with SMTP id r12-20020ad4576c000000b0045a91a4c109mr24930924qvx.115.1652324697661;
        Wed, 11 May 2022 20:04:57 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:04:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Thu, 12 May 2022 03:04:28 +0000
Message-Id: <20220512030442.2530552-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!
Please find the proof of concept version of call_rcu_lazy() attached. This
gives a lot of savings when the CPUs are relatively idle. Huge thanks to
Rushikesh Kadam from Intel for investigating it with me.

Some numbers below:

Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
The observation is that due to a 'trickle down' effect of RCU callbacks, the
system is very lightly loaded but constantly running few RCU callbacks very
often. This confuses the power management hardware that the system is active,
when it is in fact idle.

For example, when ChromeOS screen is off and user is not doing anything on the
system, we can see big power savings.
Before:
Pk%pc10 = 72.13
PkgWatt = 0.58
CorWatt = 0.04

After:
Pk%pc10 = 81.28
PkgWatt = 0.41
CorWatt = 0.03

Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
can see that the display pipeline is constantly doing RCU callback queuing due
to open/close of file descriptors associated with graphics buffers. This is
attributed to the file_free_rcu() path which this patch series also touches.

This patch series adds a simple but effective, and lockless implementation of
RCU callback batching. On memory pressure, timeout or queue growing too big, we
initiate a flush of one or more per-CPU lists.

Similar results can be achieved by increasing jiffies_till_first_fqs, however
that also has the effect of slowing down RCU. Especially I saw huge slow down
of function graph tracer when increasing that.

One drawback of this series is, if another frequent RCU callback creeps up in
the future, that's not lazy, then that will again hurt the power. However, I
believe identifying and fixing those is a more reasonable approach than slowing
RCU down for the whole system.

NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
at runtime to turn it on or off globally. It is default to on. Further, please
use the sysctls in lazy.c for further tuning of parameters that effect the
flushing.

Disclaimer 1: Don't boot your personal system on it yet anticipating power
savings, as TREE07 still causes RCU stalls and I am looking more into that, but
I believe this series should be good for general testing.

Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
of review and agreements.

Joel Fernandes (Google) (14):
  rcu: Add a lock-less lazy RCU implementation
  workqueue: Add a lazy version of queue_rcu_work()
  block/blk-ioc: Move call_rcu() to call_rcu_lazy()
  cred: Move call_rcu() to call_rcu_lazy()
  fs: Move call_rcu() to call_rcu_lazy() in some paths
  kernel: Move various core kernel usages to call_rcu_lazy()
  security: Move call_rcu() to call_rcu_lazy()
  net/core: Move call_rcu() to call_rcu_lazy()
  lib: Move call_rcu() to call_rcu_lazy()
  kfree/rcu: Queue RCU work via queue_rcu_work_lazy()
  i915: Move call_rcu() to call_rcu_lazy()
  rcu/kfree: remove useless monitor_todo flag
  rcu/kfree: Fix kfree_rcu_shrink_count() return value
  DEBUG: Toggle rcu_lazy and tune at runtime

 block/blk-ioc.c                            |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c |   2 +-
 fs/dcache.c                                |   4 +-
 fs/eventpoll.c                             |   2 +-
 fs/file_table.c                            |   3 +-
 fs/inode.c                                 |   2 +-
 include/linux/rcupdate.h                   |   6 +
 include/linux/sched/sysctl.h               |   4 +
 include/linux/workqueue.h                  |   1 +
 kernel/cred.c                              |   2 +-
 kernel/exit.c                              |   2 +-
 kernel/pid.c                               |   2 +-
 kernel/rcu/Kconfig                         |   8 ++
 kernel/rcu/Makefile                        |   1 +
 kernel/rcu/lazy.c                          | 153 +++++++++++++++++++++
 kernel/rcu/rcu.h                           |   5 +
 kernel/rcu/tree.c                          |  28 ++--
 kernel/sysctl.c                            |  23 ++++
 kernel/time/posix-timers.c                 |   2 +-
 kernel/workqueue.c                         |  25 ++++
 lib/radix-tree.c                           |   2 +-
 lib/xarray.c                               |   2 +-
 net/core/dst.c                             |   2 +-
 security/security.c                        |   2 +-
 security/selinux/avc.c                     |   4 +-
 25 files changed, 255 insertions(+), 34 deletions(-)
 create mode 100644 kernel/rcu/lazy.c

-- 
2.36.0.550.gb090851708-goog

