Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FEDC001DF
	for <rcu@archiver.kernel.org>; Thu,  3 Aug 2023 03:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbjHCDYY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 2 Aug 2023 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjHCDYR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 2 Aug 2023 23:24:17 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355A2733
        for <rcu@vger.kernel.org>; Wed,  2 Aug 2023 20:24:13 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7835c92c373so41698539f.0
        for <rcu@vger.kernel.org>; Wed, 02 Aug 2023 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691033053; x=1691637853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri+AV8Kf+G5whax+bk9HTGfLE0fpaHCunlBX3LcI+MY=;
        b=SSROfGyqV9e3u74mTKmoa9swo8SFey1Lh0VpFbL1JE70n1rclCj8tC30xw4OMGN2vB
         +IlNzwUN30w4Nw4O0wOw4zYh/3Z5xy5EI6IPgTWrmkRvfYDNsjzL6uSm3a0h4mlH2GOM
         10aW6NWacR4dbgGPHJmVb5bJhYKUm3LEhZML0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033053; x=1691637853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri+AV8Kf+G5whax+bk9HTGfLE0fpaHCunlBX3LcI+MY=;
        b=jpyFJTfzPnSN1+CnYDFFvTvwMlCX4Gn5nMLr+P99pf+gAALXmP+HWif0xPdrPQB4RC
         dO1NBh78M5Fh8mcW9rk+ISF0gNJnESSRIVmye63vtG7VLSbxXsgIR/t3w2IVvV7To/Q8
         3JpaowgVYjb5zd1UXOgUXxKWd5iOi0udIrWsZqYyeC7FrXcRzIZadKJze6yEA9O8FVaY
         KRH7UdTDu0uxd6R+moBi538HW4KYuTnZl2i3FMgsabS5H7zRUQM/HryRRqrVg3op2UfI
         LBWOkktC648qy6NlN1uje4ItSA7qm7y5HsHbB0kZKznIx1y5jsDF9PAaRQjyHzAp5QeF
         hbSg==
X-Gm-Message-State: ABy/qLYYP0IcxDDp+cVNWv+BdUdqV/icQiYx8B3TNs64EaP3amZbieKi
        y7At5BT9o6bfsurmW/Ha27+7xw==
X-Google-Smtp-Source: APBJJlHbI5KfWmA5QewNsyrWaZR6V3ElyXs1v2enBL4DptJM5Dt3K9W5sbejVgaJWYiVHbEr+1qIJQ==
X-Received: by 2002:a05:6602:2559:b0:785:cac9:2d49 with SMTP id cg25-20020a056602255900b00785cac92d49mr14841576iob.1.1691033053197;
        Wed, 02 Aug 2023 20:24:13 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id a14-20020a02ac0e000000b0042b67b12363sm4535176jao.37.2023.08.02.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 20:24:12 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: rcu: Add cautionary note on plain-accesses to requirements
Date:   Thu,  3 Aug 2023 03:24:06 +0000
Message-ID: <20230803032408.2514989-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Add a detailed note to explain the potential side effects of
plain-accessing the gp pointer using a plain load, without using the
rcu_dereference() macros; which might trip neighboring code that does
use rcu_dereference().

I haven't verified this with a compiler, but this is what I gather from
the below link using Will's experience with READ_ONCE().

Link: https://lore.kernel.org/all/20230728124412.GA21303@willie-the-truck/
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index f3b605285a87..e0b896d3fb9b 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -376,6 +376,38 @@ mechanism, most commonly locking or reference counting
 .. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
 .. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
 
+Note that, there can be strange side effects (due to compiler optimizations) if
+``gp`` is ever accessed using a plain load (i.e. without ``READ_ONCE()`` or
+``rcu_dereference()``) potentially hurting any succeeding
+``rcu_dereference()``. For example, consider the code:
+
+   ::
+
+       1 bool do_something_gp(void)
+       2 {
+       3   void *tmp;
+       4   rcu_read_lock();
+       5   tmp = gp; // Plain-load of GP.
+       6   printk("Point gp = %p\n", tmp);
+       7
+       8   p = rcu_dereference(gp);
+       9   if (p) {
+      10     do_something(p->a, p->b);
+      11     rcu_read_unlock();
+      12     return true;
+      13   }
+      14   rcu_read_unlock();
+      15   return false;
+      16 }
+
+The behavior of plain accesses involved in a data race is non-deterministic in
+the face of compiler optimizations. Since accesses to the ``gp`` pointer is
+by-design a data race, the compiler could trip this code by caching the value
+of ``gp`` into a register in line 5, and then using the value of the register
+to satisfy the load in line 10. Thus it is important to never mix
+plain accesses of a memory location with rcu_dereference() of the same memory
+location, in code involved in a data race.
+
 In short, updaters use rcu_assign_pointer() and readers use
 rcu_dereference(), and these two RCU API elements work together to
 ensure that readers have a consistent view of newly added data elements.
-- 
2.41.0.585.gd2178a4bd4-goog

