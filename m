Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E0C19F2D
	for <rcu@archiver.kernel.org>; Tue,  9 Aug 2022 03:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHIDp2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 8 Aug 2022 23:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDp0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 8 Aug 2022 23:45:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6ED74
        for <rcu@vger.kernel.org>; Mon,  8 Aug 2022 20:45:23 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id u8so7759896qvv.1
        for <rcu@vger.kernel.org>; Mon, 08 Aug 2022 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMFSm9fzlCqsL9Wl8knZNV1YuIRXh8vZL0+Qm4vwsdw=;
        b=gaoDGtT7P0PU1txGGwS6nqQwoWr78izFFV6nTSD+0uArCjjTELeFzv4pJTMgIi4CUg
         dJF1ysNQ6QnohyA+3U3h/jN1J71OFQYnx7/71j67phYLsv/ZLJHN67fkMPWHMJH0gjRP
         rc/i/d6KbRdYsO25gle/h6TDQQ7XrXuwf/z+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KMFSm9fzlCqsL9Wl8knZNV1YuIRXh8vZL0+Qm4vwsdw=;
        b=HjbCKCkHPnPRsSx7iDszM+DollcBrh0GfA83fLcB0WqSlCtrzbB39kRG2iagS7QYle
         s2vbyfuJA87l4wP3olT/pmkzZglGLd2YuKMAzGsfgb7oHqD8GE8l84Io/dES7cVMm1P0
         f9wqRQNkdW+EM8OXDzEnb44S3Yjvr5wZ1rICkjkXoPSxRPwGJw1zzqXozQi+kEFJEr3t
         BQd3Xg30excAjv3cznVZndjPdyBhLF43Pk28XwEsfPffo4uZ31wFxnO+tXFo3vD5Nnaz
         ARdMuBq7zMSOgKijQy+XOhNXBAH8AaOibzhwho0lntjVPc+b0e/NYWh3YT68zjsqgRtW
         HI1Q==
X-Gm-Message-State: ACgBeo0SbOe5exb+/YLUkeYbmOoU07C0IV/JILigsmHMQ1n+6Cdoz4Tx
        SVGnTtO4UQ2YDU9TKomBjWQgbAZH1DEPvA==
X-Google-Smtp-Source: AA6agR42ATZ3/Jp8DA3RUD+VOOvGOfBuGXIMPL7I8s6nqNQ/UchL90HMU28gDJB8NvjnTAuNxW2KPw==
X-Received: by 2002:a05:6214:19e8:b0:478:89de:9d4f with SMTP id q8-20020a05621419e800b0047889de9d4fmr17590523qvc.126.1660016722922;
        Mon, 08 Aug 2022 20:45:22 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id ca8-20020a05622a1f0800b0031f0b43629dsm9170979qtb.23.2022.08.08.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 20:45:22 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org
Subject: [PATCH v3 resend 0/6] Implement call_rcu_lazy() and miscellaneous fixes
Date:   Tue,  9 Aug 2022 03:45:11 +0000
Message-Id: <20220809034517.3867176-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Just a refresh of v3 with one additional debug patch. v3's cover letter is here:
 https://lore.kernel.org/all/20220713213237.1596225-1-joel@joelfernandes.org/

I just started working on this again while I have some time during paternity
leave ;-) So I thought I'll just send it out again. No other changes other
than that 1 debug patch I added on the top.

Next I am going to go refine the power results as mentioned in Paul's comments
on the last cover letter.

Joel Fernandes (Google) (5):
rcu: Introduce call_rcu_lazy() API implementation
rcuscale: Add laziness and kfree tests
fs: Move call_rcu() to call_rcu_lazy() in some paths
rcutorture: Add test code for call_rcu_lazy()
debug: Toggle lazy at runtime and change flush jiffies

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

fs/dcache.c                                   |   4 +-
fs/eventpoll.c                                |   2 +-
fs/file_table.c                               |   2 +-
fs/inode.c                                    |   2 +-
include/linux/rcu_segcblist.h                 |   1 +
include/linux/rcupdate.h                      |   6 +
include/linux/sched/sysctl.h                  |   3 +
kernel/rcu/Kconfig                            |   8 +
kernel/rcu/rcu.h                              |  12 +
kernel/rcu/rcu_segcblist.c                    |  15 +-
kernel/rcu/rcu_segcblist.h                    |  20 +-
kernel/rcu/rcuscale.c                         |  74 +++++-
kernel/rcu/rcutorture.c                       |  60 ++++-
kernel/rcu/tree.c                             | 131 ++++++----
kernel/rcu/tree.h                             |  10 +-
kernel/rcu/tree_nocb.h                        | 246 +++++++++++++++---
kernel/sysctl.c                               |  17 ++
.../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
.../selftests/rcutorture/configs/rcu/TREE11   |  18 ++
.../rcutorture/configs/rcu/TREE11.boot        |   8 +
20 files changed, 536 insertions(+), 104 deletions(-)
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11
create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot

--
2.37.1.559.g78731f0fdb-goog

