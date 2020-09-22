Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2FC4727F
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 21:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F1323787
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/zRgyqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIVVno (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIVVnn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 17:43:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB6FC061755;
        Tue, 22 Sep 2020 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E8yPXrmAmXC425PS/UGZAI8Xr/ohRxvzglQPHDRJMN4=; b=2/zRgyqxZ0fXPI21L8+RD4pVUU
        c3vX5CgmMAPSgO1yLQqD7NV9XT4519pQjveIRwGMg3ArPZb7d6rhu/sk4UDhDdqnljoyi7wiucH0j
        kRLb4+CvhPwsr73snZzcSpMclvzAJDwucleaBsQlbvMj1CrNwyJZAiiay+uUlDcwZWMEPphRcy+pz
        9TaHlu6QvForEd/VdB9vly6emwFhBRXrIRMaSdZGGv8OIBdfkxLrdRrUWV8Z8phKcaivJOch6f6Kt
        co7ht1dNL/xwlULwM5UX7qpF0xXhsCyioHX39bGL2CutAPakwEitdi8KAZ2VHyCs77x70cd/an2yS
        J2e6muHg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKq4X-0004fa-PC; Tue, 22 Sep 2020 21:43:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH] RCU: export rcu_idle_enter/_exit for loadable modules
Date:   Tue, 22 Sep 2020 14:43:30 -0700
Message-Id: <20200922214331.26608-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

drivers/acpi/processor.ko uses rcu_idle_enter()/_exit() but
they are not exported. This causes build errors on IA64,
so export those 2 functions.

ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-ia64@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: rcu@vger.kernel.org
---
Is there a problem with exporting these functions for use by
loadable modules?  If so, this driver should be modified not
to use rcu_idle_enter/exit.

 kernel/rcu/tree.c |    2 ++
 1 file changed, 2 insertions(+)

--- lnx-59-rc6.orig/kernel/rcu/tree.c
+++ lnx-59-rc6/kernel/rcu/tree.c
@@ -673,6 +673,7 @@ void rcu_idle_enter(void)
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(false);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_enter);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
@@ -886,6 +887,7 @@ void rcu_idle_exit(void)
 	rcu_eqs_exit(false);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
