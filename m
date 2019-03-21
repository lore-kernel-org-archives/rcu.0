Return-Path: <SRS0=muXe=RY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14950C43381
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88EE2083D
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LofPvRi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCUAeu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45081 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUAeu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id v20so4801537qtv.12
        for <rcu@vger.kernel.org>; Wed, 20 Mar 2019 17:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNxH5hn+1vJ5BZfNhhP2qaREL1mT+cXvzry7emknzXo=;
        b=LofPvRi1FKvhO8MdnUpMoXtwNj2VpxJhzmLikJCTAC96n8I9zjrUK+YA9mxxKIhPMR
         BrbNAAdLfHklU02+Odvf4TMRIqyt/4xQKRibsgsXeAp3ZVZl50OY2taDuf5Qb6Rebl4V
         RXav2V7cSth/x3rk6TAFQq/yKzIdUdjDth9JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNxH5hn+1vJ5BZfNhhP2qaREL1mT+cXvzry7emknzXo=;
        b=Yviu5Yn+pN9hZ4y4J15WKjQEVLQ73wIodyjq2Q4DkhDedfnF/RSQQgScVFdIY4jNmQ
         nqXgqH7Iyxc6pn1/Z1sudwGRSlxHeb4/+ujS0Wn3LEsx1ImQX5zhs3P7BJCSYBGW+SyU
         j/0qAWGjt/BLtyOTjcfBMSMM8efJOe4U9YFk/CmQLloucAcjhKvq+tqv1PTGsKV0pTMs
         U/Ae8D1v9bC6f01iXcnIp/SfWhBe9d1niE0fShb87CsXgWhtaCg+XFahIxmd2UyNDjO0
         ejz72gRZEQisdAYKfTuTY1CRbV49SfkzJdMdk+SGJTQ94JL0DCXYgU97Ft1wCWswg6c0
         3fpQ==
X-Gm-Message-State: APjAAAX/qyzfudcM/shJRkzH9WY8lPv4vVjJlcFslCSFHKS1ZIqTpZFW
        28++esBOicdl19T/sWUUKex4aQ==
X-Google-Smtp-Source: APXvYqw2IZEg0AtQ4SwPf0ZCsNZpyPpyXX7g4iPc87HH3TUictMPSPsYXXOMZzDmuY1YyqR053Z1SQ==
X-Received: by 2002:a0c:e58f:: with SMTP id t15mr810027qvm.170.1553128489530;
        Wed, 20 Mar 2019 17:34:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/4] RCU fixes for rcu_assign_pointer() usage
Date:   Wed, 20 Mar 2019 20:34:22 -0400
Message-Id: <20190321003426.160260-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is just a resend with scheduler patches split from the driver fixes and
Paul's Reviewed-by(s) added.

These patches fix various sparse errors ccaused as a result of the recent check
to add rcu_check_sparse() to rcu_assign_pointer().  The errors are due to
missing annotations. The annotations added in the series can also help avoid
future incorrect usages and bugs so it is a good idea to do in any case.

RFC v1 -> Patch v2:
Made changes based on Peter Zijlstra review.

Joel Fernandes (Google) (4):
sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
sched_domain: Annotate RCU pointers properly
rcuwait: Annotate task_struct with __rcu
sched: Annotate perf_domain pointer with __rcu

include/linux/rcuwait.h        |  2 +-
include/linux/sched/topology.h |  4 ++--
kernel/sched/cpufreq.c         |  2 +-
kernel/sched/sched.h           | 18 +++++++++---------
kernel/sched/topology.c        | 10 +++++-----
5 files changed, 18 insertions(+), 18 deletions(-)

--
2.21.0.225.g810b269d1ac-goog

