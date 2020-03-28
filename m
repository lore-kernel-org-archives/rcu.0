Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE7C43331
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2BE520714
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 22:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vQejaGRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgC1WRL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:17:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43529 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1WRL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 18:17:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id o10so14977828qki.10
        for <rcu@vger.kernel.org>; Sat, 28 Mar 2020 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xweZZ/PuKU5Urwn8I1bvMApWVXFcICm6DizzqOoCjjA=;
        b=vQejaGRuzZaYEdUfpeVw5viLB+lXkY1ZmIG1vaVtWbvquj0mZ+fuxuLtgAfauu6p5O
         bCnpf2KXc20JxOIUfcd9GP0lywaG3C69TCW3MKyYmix0FlL6nA0Aos3oU6Uxfk/1b92O
         rHsJirApnyffucCa5R5FDSFtI7ahBD2GhPR2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xweZZ/PuKU5Urwn8I1bvMApWVXFcICm6DizzqOoCjjA=;
        b=o3XLke8BbrDFXowB/EbtOcOJ2vFwI00HvEnvThTzZTeUBKpwB3vnCYAZT6GPmO9zlS
         lVOcVg/xXbBJ9waIgCrIrURUWpqNxJ4i/Xi4k3KfLuv0HtX8PUHUYekymp+ypSInLNGY
         7e90wvjtyyt6Mvkf4GSySKIe0aLCHjRKkxh1aT/3flHQl0Wk2y7U8rVepxUt0sEjTXb4
         Dt7sa1AWB9LQ3Xj6J5unjHz9L0a+r5zfDvKenLM5c9CySrtf6dgkamokBv55fY9hbgln
         aGHCdaKAEkDhx7iFQEOzG/iqpSFOU4BXildhC6Uq8oOeSFZYRBPw9eR/whHoBc3G51Al
         zhXw==
X-Gm-Message-State: ANhLgQ38BqVFJCHIg0jhwv5//jn++6+nSl52ESsfSPRpvREkH5xPhpPz
        BC6qaIIAZqeFxR+o+HrZgn1CSg==
X-Google-Smtp-Source: ADFU+vtchfIp7MmRr0BM5PqLR1+Vw2vhF6c1g65ZAGsKGxM2eB+Hd0x3Kd62RhbRwuOKLHSL8x65+Q==
X-Received: by 2002:a05:620a:12bc:: with SMTP id x28mr5493168qki.175.1585433830370;
        Sat, 28 Mar 2020 15:17:10 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id k66sm6742950qke.10.2020.03.28.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 15:17:09 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v2 0/4] RCU dyntick nesting counter cleanups
Date:   Sat, 28 Mar 2020 18:16:59 -0400
Message-Id: <20200328221703.48171-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These patches clean up the usage of dynticks nesting counters simplifying the
code, while preserving the usecases.

It is a much needed simplification, makes the code less confusing, and prevents
future bugs such as those that arise from forgetting that the
dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
common situations.

rcutorture testing with all TREE RCU configurations succeed with
CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.

v1->v2:
- Rebase on v5.6-rc6

Joel Fernandes (Google) (4):
Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
->dynticks counter")
rcu/tree: Add better tracing for dyntick-idle
rcu/tree: Clean up dynticks counter usage
rcu/tree: Remove dynticks_nmi_nesting counter

.../Data-Structures/Data-Structures.rst       |  31 +--
Documentation/RCU/stallwarn.txt               |   6 +-
include/linux/rcutiny.h                       |   3 -
include/trace/events/rcu.h                    |  29 +--
kernel/rcu/rcu.h                              |   4 -
kernel/rcu/tree.c                             | 188 +++++++-----------
kernel/rcu/tree.h                             |   4 +-
kernel/rcu/tree_stall.h                       |   4 +-
8 files changed, 105 insertions(+), 164 deletions(-)

--
2.26.0.rc2.310.g2932bb562d-goog

