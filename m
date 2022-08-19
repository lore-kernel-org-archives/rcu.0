Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4ECC32771
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350604AbiHSUtJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350392AbiHSUtH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6639E2F7
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c20so4212986qtw.8
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=luihRe+gsvUtCEJ5Y2NjEykt2CiKxLiHMuB5CkZuwHk=;
        b=xhdFQwkiQbFrCgAxvqW7TD0WD+MSILMz4rwjCreTkiMSs9phNWLFBSeTamnod2QSsi
         ekC5K+YE9aYk2ch0TA/n4eoPfnDfwpL4zef2Iwj06SCwABly482pexK0vu7n7iBuL+E4
         2oPDQYUb1htZU7KGAJd2lSHuPNpy7V8ES727g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=luihRe+gsvUtCEJ5Y2NjEykt2CiKxLiHMuB5CkZuwHk=;
        b=4bdqZsu7zvkAfFP94ndJstjMjkHQgWckG0sMZH2eMEgPXpkyotjmVBCA9K6uyZYcc3
         lJDaW9NhSL4DnbQ/a8T55j/UrAor+ANq6J21im7dN5f8SUqz5YKNOL4Uar+7ANzVDKYp
         6HdTB5J8Ot9ZCHb4XRsxhUfu4I0h6dd4h8aS77K+kmhl78FWqsrOhWU/VMSG+ElqXzV8
         eJgLN/2JGNK4l4lgxg/Ngv01dUkMZIq9+kZQEgPwZk4SKpM3r8OqfcpwbROdiYjqGeuJ
         6AYok791m9YqPbzwKecwAMd9wKkLvkVDKULAf72pqrPsANVoE+wIWsn15imwyl9+Ikc4
         vtqA==
X-Gm-Message-State: ACgBeo0Xq0/PRR2/mOLqVchQj2LCjVm06zdkXauD1ap+WX/S2SwQ+mmc
        pffpJdyFrFcAZde7sMcqOgbzEQ==
X-Google-Smtp-Source: AA6agR6l+rnEfgnLqgA2qIEDfeujjCjPgh/k3MpxqN39LFfjVE63d2QaD1or3nq+dVig1ppfD6ulAw==
X-Received: by 2002:a05:622a:15cf:b0:344:6a92:d8d6 with SMTP id d15-20020a05622a15cf00b003446a92d8d6mr7924817qty.104.1660942144512;
        Fri, 19 Aug 2022 13:49:04 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Fri, 19 Aug 2022 20:48:43 +0000
Message-Id: <20220819204857.3066329-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Refresh tested on real ChromeOS userspace and hardware, passes boot time tests
and rcuscale tests.

Fixes on top of v3:
- Fix boot issues due to a race in the lazy RCU logic which caused a missed
  wakeup of the RCU GP thread, causing synchronize_rcu() to stall.
- Fixed trace_rcu_callback tracepoint

I tested power previously [1], I am in the process of testing power again but I
wanted share my latest code as others who are testing power as well could use
the above fixes.

[1] https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/

Joel Fernandes (Google) (13):
rcu: Introduce call_rcu_lazy() API implementation
rcuscale: Add laziness and kfree tests
fs: Move call_rcu() to call_rcu_lazy() in some paths
rcutorture: Add test code for call_rcu_lazy()
debug: Toggle lazy at runtime and change flush jiffies
cred: Move call_rcu() to call_rcu_lazy()
security: Move call_rcu() to call_rcu_lazy()
net/core: Move call_rcu() to call_rcu_lazy()
kernel: Move various core kernel usages to call_rcu_lazy()
lib: Move call_rcu() to call_rcu_lazy()
i915: Move call_rcu() to call_rcu_lazy()
fork: Move thread_stack_free_rcu to call_rcu_lazy
rcu/tree: Move trace_rcu_callback() before bypassing

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

drivers/gpu/drm/i915/gem/i915_gem_object.c    |   2 +-
fs/dcache.c                                   |   4 +-
fs/eventpoll.c                                |   2 +-
fs/file_table.c                               |   2 +-
fs/inode.c                                    |   2 +-
include/linux/rcu_segcblist.h                 |   1 +
include/linux/rcupdate.h                      |   6 +
include/linux/sched/sysctl.h                  |   3 +
kernel/cred.c                                 |   2 +-
kernel/exit.c                                 |   2 +-
kernel/fork.c                                 |   6 +-
kernel/pid.c                                  |   2 +-
kernel/rcu/Kconfig                            |   8 +
kernel/rcu/rcu.h                              |  12 +
kernel/rcu/rcu_segcblist.c                    |  15 +-
kernel/rcu/rcu_segcblist.h                    |  20 +-
kernel/rcu/rcuscale.c                         |  74 ++++-
kernel/rcu/rcutorture.c                       |  60 +++-
kernel/rcu/tree.c                             | 139 ++++++----
kernel/rcu/tree.h                             |  10 +-
kernel/rcu/tree_nocb.h                        | 260 +++++++++++++++---
kernel/sysctl.c                               |  17 ++
kernel/time/posix-timers.c                    |   2 +-
lib/radix-tree.c                              |   2 +-
lib/xarray.c                                  |   2 +-
net/core/dst.c                                |   2 +-
security/security.c                           |   2 +-
security/selinux/avc.c                        |   4 +-
.../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
.../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
.../rcutorture/configs/rcu/TREE11.boot        |   8 +
31 files changed, 567 insertions(+), 123 deletions(-)
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

--
2.37.2.609.g9ff673ca1a-goog

