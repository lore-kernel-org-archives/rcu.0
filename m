Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F045C3A5A9
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3EC8206A4
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rtVHEmP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEDMFN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEDMFN (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:05:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D12BC061A0E
        for <rcu@vger.kernel.org>; Mon,  4 May 2020 05:05:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so8121603qke.8
        for <rcu@vger.kernel.org>; Mon, 04 May 2020 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS++A28Sh4YuaqyBwWRbxbmVEu733+KrFFtrnA7xbs8=;
        b=rtVHEmP14tFavtrMl2kCsfA31NxuymsQu8umBMB3Dl7s+NzUCfNvdF4FiC+FL/QMGO
         HwyZKmyN3i3brVIudSE3r0cHWSKpv4hv90ZKfGANxC/gUc++i0uowHvDbr7n6JcmJV3d
         yTTtaf4Gardm8NucaNktiNDDpNSRFUW++FCJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS++A28Sh4YuaqyBwWRbxbmVEu733+KrFFtrnA7xbs8=;
        b=Qwd/vY7TIRDyFTZYP7zizddUxIav8z5bJjMZwgGHqlSwqMOxxQdZA8f4ECb0vOV3fK
         SDOCRPX/68joV0pRfkNnB6RgU7gTxeWvqcXUowjuindTlH2mbB9Ko1nicNm0EGplGYa+
         rtlNicvChZy8DIZi0n8zcBOupHyo3NoQxxlOgiIEIPiei2sMbuAOZxTHPdhsRaBhV+ZB
         o72dj7EsSVmqvvSG9iFlDRyo/XibvfultXrbfkAPBgrCJms7FNxIb548GzGx5CUcR/pJ
         +348LxYTuThkJPhvgUVivIJSeBQnKL0ReNt8PzD2ikepv5PPBPk10SsBUn5ThWKhyVOl
         b/Eg==
X-Gm-Message-State: AGi0Pubrd5n1wwwL7ZGlkOnESYAoVcTDeoJaNz8YExjnsnVGSHKOwvrS
        hxEWHAOwcrW7s5/n/pucy6dPmQ==
X-Google-Smtp-Source: APiQypLPAvbk14sQlHrVZi67scGx/9pMjn2HmrrOBspEAdaiBo+4EXf9zml7kfDGC+ee+0MlTeIxCA==
X-Received: by 2002:a37:48a:: with SMTP id 132mr16527293qke.390.1588593912487;
        Mon, 04 May 2020 05:05:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:11 -0700 (PDT)
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
Subject: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Date:   Mon,  4 May 2020 08:05:00 -0400
Message-Id: <20200504120505.89351-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
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

v2->v3:
- Rebase on rcu/dev with adjustments for tasks-RCU.

Joel Fernandes (Google) (4):
Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
->dynticks counter")
rcu/tree: Add better tracing for dyntick-idle
rcu/tree: Clean up dynticks counter usage
rcu/tree: Remove dynticks_nmi_nesting counter

Madhuparna Bhowmik (1):
trace: events: rcu: Change description of rcu_dyntick trace event

.../Data-Structures/Data-Structures.rst       |  31 +--
Documentation/RCU/stallwarn.rst               |   6 +-
include/linux/rcutiny.h                       |   3 -
include/trace/events/rcu.h                    |  29 +--
kernel/rcu/rcu.h                              |   4 -
kernel/rcu/tree.c                             | 199 +++++++-----------
kernel/rcu/tree.h                             |   4 +-
kernel/rcu/tree_stall.h                       |   4 +-
8 files changed, 110 insertions(+), 170 deletions(-)

--
2.26.2.526.g744177e7f7-goog

