Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7280DC433F5
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482E061B49
	for <rcu@archiver.kernel.org>; Tue, 16 Nov 2021 08:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbhKPI2O (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Nov 2021 03:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhKPI2N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Nov 2021 03:28:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB21DC061570
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id g18so17475657pfk.5
        for <rcu@vger.kernel.org>; Tue, 16 Nov 2021 00:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nY2dUOfwcuVKwH86QJzNlyUT0GQ8vz+924KfMba1VPc=;
        b=oSII1gGobUz74S1uShIbxvtB9PL+5gr0XRnOdKajgLmgjcr8SPMBvJ2YLAQsGydgxH
         Kfqu/L7Ny+8D4vzlghK2mW6TH6oTU960Za3Whpdo/NpbuDZsCgCdtepPdtPshTS0SRDP
         Sz0cVqMGVpKMMgykohMJ+kG24qfp1Lxs4kZywiaMcO+kihO7+aeyrRbEsXGZSh9Lyr+/
         EV9MW8w8+WjG065mEus3QQPDyEhOIhYKZFk6tWBF9Exe0LLyAi0ZiBD1Jy17/oRFwYzW
         fXX6Jih65H0wgrz39PK1QKXnS4Sd6mqkQZPPqxhv6Xyi6/8ndw/X244hwtOgFMW9gXqk
         3NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nY2dUOfwcuVKwH86QJzNlyUT0GQ8vz+924KfMba1VPc=;
        b=GYuP/+BZsrATuFGAil4bd/tUodoY0nRxPMDMKcak6A/Q9KYYfekV62lu0DZWpEIMLQ
         DODbcdAbCBRO7geOhtFI+HWrhgnszG6pORF1C2CCsDFX5eq+i0xoJRKXGOimhTCk6Hhz
         r/nxpbizem/AEYAszx+m2e1ItzkYx4Qs//aiCusjTrOxaHktDrHsvPks3KQkeVsQ8i5+
         /77hc+MuVLkYHTjS5a07o8DYWdfZ9pCmJs5B7dSgkFyeIMIidlr+y4EdA8JzjozJAGhV
         JHz9gwzJNHhr+3KFIQ7PEeaDZRxWDaVmDgr2axEpQ/eSF1Sn2A/6RoBZw0DgdF2R76wC
         zH3g==
X-Gm-Message-State: AOAM532DMGNXkdU1CwdwKqcljCM59O/j7IjrOi4pf9FQgOCC+hXlh6Zi
        M30qkkzg08S7dfFfiaJfzA==
X-Google-Smtp-Source: ABdhPJz03QLHrF+LuFmlRgA1TEZN2mJcp+0wT3SYhdpk62BirAg9JaxG04qeJdqCNjOMKMRv5kr7Wg==
X-Received: by 2002:aa7:8a56:0:b0:494:6b49:cbfa with SMTP id n22-20020aa78a56000000b004946b49cbfamr39292806pfa.72.1637051115911;
        Tue, 16 Nov 2021 00:25:15 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm17104011pfl.41.2021.11.16.00.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 00:25:15 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>, rcu@vger.kernel.org
Subject: [PATCHv3 0/4] arm64: Fixes RCU deadlock due to a mistaken
Date:   Tue, 16 Nov 2021 16:24:46 +0800
Message-Id: <20211116082450.10357-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

It was [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
[1], but as discussion, I found it hit a deadlock, so change subject in
v3.

Linux kernel places strict semantics between NMI and maskable interrupt.
So does the RCU component, else deadlock may happen.

The current arm64 entry code can partially breach this rule through
calling rcu_nmi_enter() in pNMI conext without calling __nmi_enter().
Finally, it calls __rcu_irq_enter_check_tick() trying to hold
raw_spin_lock_rcu_node(rdp->mynode), but this spinlock can already been
held by a task running note_gp_changes()->raw_spin_trylock_rcu_node(rnp).
Then deadlock happens.

The organization of this series:
  [1/4] aims to fix this bug
  [2-3/4] ease the implementation of [1/4]
  [4/4] is a cleanup

To do:
  Does arm need to handle pNMI as arm64?

v2 -> v3:
  drop handle_arch_nmi interface

[1]: https://lore.kernel.org/linux-arm-kernel/20210924132837.45994-2-kernelfans@gmail.com/

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Julien Thierry <julien.thierry@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
Cc: rcu@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org

Pingfan Liu (4):
  arm64: entry: judge nmi ealier to avoid deadlock in RCU
  arm64: entry: distinguish pNMI earlier in el0 interrupt
  irqchip: GICv3: expose pNMI discriminator
  arm64: entry: remove pNMI judgement in __el1_interrupt() path

 arch/arm64/kernel/entry-common.c | 55 +++++++++++++++++++++-----------
 arch/arm64/kernel/irq.c          | 15 +++++++++
 drivers/irqchip/irq-gic-v3.c     | 16 ++++++----
 3 files changed, 62 insertions(+), 24 deletions(-)

-- 
2.31.1

