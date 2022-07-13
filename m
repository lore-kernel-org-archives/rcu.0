Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA802C43334
	for <rcu@archiver.kernel.org>; Wed, 13 Jul 2022 21:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiGMVdD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbiGMVdB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 13 Jul 2022 17:33:01 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8D33A0B
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:32:59 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id d17so147444qvs.0
        for <rcu@vger.kernel.org>; Wed, 13 Jul 2022 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvqepsLMsuS6DoLYx67U9RDfmCI01IK2NC8IO5NzD3A=;
        b=W21G0lZm0YqU2BhzBwK6+oNHLtfUiOLByiCp4hmU2HfUxs8732h+5XFg148Rw+N95I
         j71GwAHH0GJ+0z5aSmrrOtoejmgSEC4bxvYIDvkwq7rpAwDj7Jjb5r+v1TP2y4uoA7dd
         hp995v1ZDTTay/dgRm/nFc57Le7E//TozRpyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BvqepsLMsuS6DoLYx67U9RDfmCI01IK2NC8IO5NzD3A=;
        b=hqeEXmHXERhIkVye5sH3dt4T5nu0nFgIrdrrgo3/zEk/K+lMn6Ar1ZirPvuT6PWvT9
         hlbZLDYcH3id51xFlQqqdyQJ0rQexAth7jGBCftDK5sdChobawdI0asBa01WCFYM0UEA
         /d3iyMD9jMSADRLlnU9alZblm51nKASHh9XU6z2Q4nC1MGnm8TXWnkaf8EdX8ZMbgFb1
         WDDzaD8wacYWRe/S6w0GJWfnDDB+Ii27ykSpPiR8Mt0gL4sx88U41gWDwznB9qWcobYS
         uwwkTTZQVEV9+FNbeTOfirst14ApZrmVxX0g/IVvyQCnGp0NgMPHL4B4PjJbhZsYwU41
         2/hA==
X-Gm-Message-State: AJIora9JTTE8gcGlZBhJO20DK/g6atJ/d3iOXAcYhcRP+46/p5RO6p4L
        4Gsdp6RCyN65NdRUqnbEdbZYsF2k/1qh+w==
X-Google-Smtp-Source: AGRyM1sPujnYwtKBJT+7FOgKH6If0HyX+opeRVzC2OBfdBxKJoaow5bVqJqV/z04iBI5sqSS98dkyA==
X-Received: by 2002:a05:6214:29e3:b0:473:7170:dafd with SMTP id jv3-20020a05621429e300b004737170dafdmr4857430qvb.38.1657747977944;
        Wed, 13 Jul 2022 14:32:57 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a241300b006b5988b2ca8sm6791163qkn.40.2022.07.13.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:32:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Wed, 13 Jul 2022 21:32:32 +0000
Message-Id: <20220713213237.1596225-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

Please find the next improved version of call_rcu_lazy() attached.  The main
difference between the previous versions is that:
- In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
  GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
  requested by Paul.
- Fixed checkpatch and build robot issues.
- Some more changes to 'lazy' parameter passing and consolidation of segcblist
  functions.
- more testing via rcutorture and rcuscale.

Note that these tests were run on v2 patches, I am expecting similar power
improvements however I've not yet tested power.

Following are power savings we saw on top of RCU_NOCB_CPU on an Intel platform
in v2.  The observation is that due to a 'trickle down' effect of RCU
callbacks, the system is very lightly loaded but constantly running few RCU
callbacks very often. This confuses the power management hardware that the
system is active, when it is in fact idle.

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

On memory pressure, timeout or queue growing too big, we initiate a flush of of
the bypass lists holding the lazy CBs.

Similar results can be achieved by increasing jiffies_till_first_fqs, however
that also has the effect of slowing down RCU. Especially I saw huge slow down
of function graph tracer when increasing that. That may be possible to fix via
rcu_expedited=1 boot parameter, however call_rcu_lazy() provides another option
over slowing down ALL call_rcu() globally. Further using jiffies_till_first_fqs
approach will still cause a wake up of the main RCU GP kthread, with this work
we delay even those wakeups.

One drawback of this series is, if another frequent RCU callback creeps up in
the future, that's not lazy, then that will again hurt the power. However, I
believe identifying and fixing those is a more reasonable approach than slowing
RCU down for the whole system.

Disclaimer: I have intentionally not CC'd other subsystem maintainers (like
net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
of review and agreements.

Joel Fernandes (Google) (4):
  rcu: Introduce call_rcu_lazy() API implementation
  rcuscale: Add laziness and kfree tests
  fs: Move call_rcu() to call_rcu_lazy() in some paths
  rcutorture: Add test code for call_rcu_lazy()

Vineeth Pillai (1):
  rcu: shrinker for lazy rcu

 fs/dcache.c                                   |   4 +-
 fs/eventpoll.c                                |   2 +-
 fs/file_table.c                               |   2 +-
 fs/inode.c                                    |   2 +-
 include/linux/rcu_segcblist.h                 |   1 +
 include/linux/rcupdate.h                      |   6 +
 kernel/rcu/Kconfig                            |   8 +
 kernel/rcu/rcu.h                              |  12 +
 kernel/rcu/rcu_segcblist.c                    |  15 +-
 kernel/rcu/rcu_segcblist.h                    |  20 +-
 kernel/rcu/rcuscale.c                         |  74 +++++-
 kernel/rcu/rcutorture.c                       |  60 ++++-
 kernel/rcu/tree.c                             | 132 ++++++----
 kernel/rcu/tree.h                             |  10 +-
 kernel/rcu/tree_nocb.h                        | 239 ++++++++++++++----
 .../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
 .../rcutorture/configs/rcu/TREE11.boot        |   8 +
 17 files changed, 508 insertions(+), 105 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

-- 
2.37.0.144.g8ac04bfd2-goog

