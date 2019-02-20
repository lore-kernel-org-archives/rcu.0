Return-Path: <SRS0=hk7p=Q3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C954C43381
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA302147A
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pxGYaTK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfBTEJA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:09:00 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33051 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBTEJA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Feb 2019 23:09:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id x9so1154130qkf.0
        for <rcu@vger.kernel.org>; Tue, 19 Feb 2019 20:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HguPMmzXQ5VlR/oudafavQco3plilFgPNJadffOuwes=;
        b=pxGYaTK+n45dzjnRfhmqObmqm+T9nwQUNy8X+j9nrEdv6IEdvWnN/udgsHrtFIS4dW
         XZMYkn7ddSYsFIED5wl5lHuZxO704VINBhjwe3UTLuNX/gf7biyXSD4fDp/dxL736BeH
         V2SBj+BDtT/C3OiE8Bh13pi5kjC7qADrvHsa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HguPMmzXQ5VlR/oudafavQco3plilFgPNJadffOuwes=;
        b=EsNzZ8jq39Uv33mxvYv8z7DMB8GnqjrrfHLkAkHOnvuZnUui72FCZ2SwbUEpjzbkXl
         aOp1nlHTyPlzH0K08RwJb0ENucQmlmMq3TPEUYB9XytGB3/Nab/tRH7XH0CW/MZ4USG3
         8e6bsjAo9ZJ4sbSowpFsQlonx6yAphl0oz2muzmgkf5nYMshjRau1pLxnSyh+BzSLJR9
         DzzuZmOGxBfy7HiWh1ZgxcCuH9MTeA+cdSr3kJlfZK/fjQykBaSI3HeL66tZ+Vq6NZbm
         Bb4LSl+Qi1RmZEDmlME9UoqxJINBxA0NgTF9hWF4+TKWIyeoakQHWBi/PJj+RnfZK1RG
         2nBQ==
X-Gm-Message-State: AHQUAuZ62HeMkUoAwPxtB3ifTrGFIkwmKmNS+L8MSjd1T9ZU8VXHrwBO
        2ptDAKmJPN86X4gL1/CbVTYi8w==
X-Google-Smtp-Source: AHgI3IYG7MB2qKkvJQm4+Qfujh51SqDR8MfTg1BZmf54LmG9ibWntIfhP3xy1Y2xWtphZrYkmsYsRQ==
X-Received: by 2002:ac8:365a:: with SMTP id n26mr15031190qtb.18.1550635739422;
        Tue, 19 Feb 2019 20:08:59 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id s19sm2024593qth.80.2019.02.19.20.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 20:08:57 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@linux.ibm.com
Subject: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
Date:   Tue, 19 Feb 2019 23:08:22 -0500
Message-Id: <20190220040827.136184-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These patches fix various RCU API usage issues found due to sparse errors as a
result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().

This is very early RFC stage, and is only build tested. I am also only sending
to the RCU group for initial review before sending to LKML. Thanks for any feedback!

There are still more usages that cause errors such as rbtree which I am
looking into.

Joel Fernandes (5):
net: rtnetlink: Fix incorrect RCU API usage
ixgbe: Fix incorrect RCU API usage
sched/cpufreq: Fix incorrect RCU API usage
sched/toplogy: Use smp_store_release() instead of rcu_assign_pointer
rcuwait: Replace rcu_assign_pointer with smp_store_release

drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++++-----
include/linux/rcuwait.h                       |  2 +-
kernel/sched/cpufreq.c                        |  8 ++++++--
kernel/sched/sched.h                          |  2 +-
kernel/sched/topology.c                       | 16 ++++++++--------
net/core/rtnetlink.c                          |  4 ++--
7 files changed, 31 insertions(+), 21 deletions(-)

--
2.21.0.rc0.258.g878e2cd30e-goog

