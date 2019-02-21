Return-Path: <SRS0=rKhI=Q4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806DC43381
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184152086C
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HXwuk3Be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfBUFt6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:49:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39001 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUFt5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Feb 2019 00:49:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id x6so3599510qki.6
        for <rcu@vger.kernel.org>; Wed, 20 Feb 2019 21:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZndMi1vR8pP/uDQEpl/G+Gkh+/jfQAQYXNz5X7DRoYE=;
        b=HXwuk3BeRHfjIVcR9oRDVyFtMQbMdbB6iqlT1iCPSvuvHuf5PqOvGoEvA0RerSXNN3
         IxiBr0e6+Ue3fKS+p+HKNa67QGQJghaa5r1dgb1YfCSEdfSQihc04wk7MY8QLCPpzTON
         5OD9oO16wKd/LGd2VXFdromAXymHHAXky4Jjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZndMi1vR8pP/uDQEpl/G+Gkh+/jfQAQYXNz5X7DRoYE=;
        b=mtQLNxA/EnLudnAAm//ZBj9KTS2meqVo+9XpDb47q/31FaQWd1cI9+3cIpEmXIUDG6
         s6wYXwFLYWrF3pUQqfLBgYAkpLIFw4EwfF2pKeN8pr4uSuxAtBP9Ht9p3rNfU2UAiXis
         vqL056/usuD3cmONKThF68Pm6W2u8lQiFpsn4chRD8fPNZ9Zt0abEtvLXUG0uif8Z8nZ
         AqyxzRZVRfRgPoca2J+w4ft5zop5VOqUN248ZtdHzmAeWa55CYsmH7qudxs81KJxUM+c
         Xxl6NrTKMgFAadejnAZaj293pVOQBIAj5zUmOgziQCfODP51pBze1HsPKO1kftPPOK5b
         3Iow==
X-Gm-Message-State: AHQUAubDak0xBsd/v8df2ydKf4Cu4hW0Jry2InBQb9IZQBau1sJAz4mU
        l1pBb/R5oF3heqYeTnzCHZNbxQ==
X-Google-Smtp-Source: AHgI3IYTOygGX7goz+5D+gWeyTs6X2J1fpXjlzgml9y1fS3y2srDtA2WXSzBoZfOpUxLKtPVleq63A==
X-Received: by 2002:a37:4d57:: with SMTP id a84mr12453328qkb.35.1550728196248;
        Wed, 20 Feb 2019 21:49:56 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:49:55 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 0/5] RCU fixes for rcu_assign_pointer() usage
Date:   Thu, 21 Feb 2019 00:49:37 -0500
Message-Id: <20190221054942.132388-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These patches fix various RCU API usage issues found due to sparse errors as a
result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
The errors in many cases seem to indicate either an incorrect API usage, or
missing annotations. The annotations added can also help avoid future incorrect
usages and bugs so it is a good idea to do in any case.

These are only build/boot tested and I request for feedback from maintainers
and developers in the various areas the patches touch. Thanks for any feedback!

(There are still errors in rbtree.h but I have kept those for a later time
since fixing them is a bit more involved).

Joel Fernandes (Google) (5):
net: rtnetlink: Fix incorrect RCU API usage
ixgbe: Fix incorrect RCU API usage
sched/cpufreq: Fix incorrect RCU API usage
sched/topology: Annonate RCU pointers properly
rcuwait: Replace rcu_assign_pointer() with WRITE_ONCE

drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 ++--
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 17 ++++++++++++-----
include/linux/rcuwait.h                       |  2 +-
kernel/sched/cpufreq.c                        |  8 ++++++--
kernel/sched/sched.h                          | 14 +++++++-------
kernel/sched/topology.c                       | 12 ++++++------
net/core/rtnetlink.c                          |  4 ++--
7 files changed, 36 insertions(+), 25 deletions(-)

--
2.21.0.rc0.258.g878e2cd30e-goog

