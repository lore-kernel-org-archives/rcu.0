Return-Path: <SRS0=jKPx=DA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A959C4727F
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB5A2220D
	for <rcu@archiver.kernel.org>; Wed, 23 Sep 2020 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="we1UoORw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWPWP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgIWPWP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:15 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAAAC0613CE
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g72so11427qke.8
        for <rcu@vger.kernel.org>; Wed, 23 Sep 2020 08:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsf+EwlQ/vJ5nQq6iEXR0Qv2IGG/PhQoRKnRcKN3RJk=;
        b=we1UoORwPWcI+UtqtoiXWDV6ejQSy9EcodZBvq8bfGaMnmNw25cQOwZdN2irQ1kRpj
         gHNrBqeRsi0z0mIs7StBtCi/s9PKZEYEAFeNCI2LFLu/G5FJVXuLX91md5NtX07s+phw
         wwtt92H40fOuN04kDbYpMYDYJbuOEl6WjJfis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsf+EwlQ/vJ5nQq6iEXR0Qv2IGG/PhQoRKnRcKN3RJk=;
        b=uoek9YMqeMeWCNrMcor3XCA+tbysEgtwvVkYoT8iPi/UZOMYslbZ7RxMQUG+3VBwLV
         mmLms8KZRHoQDFoTIKsEztfCTa8Y8fVWBqVJsr62Tcrw0n/udIiYCl49GcMvjYTH6/ao
         T9DaFjG2bys2P+ZtOq4uzcpW4JHBNmJtI0lg+8EErhtAIKP/RkoiPcVdqrasQaobTSbH
         v2AAuGiCIJQ1GIYE5CnQzKtRyMmMF3yA2T5Hq3sCCgQJDkqRoknmRYlQxOWHPY1LmVUS
         7/0idxEnKvUGvXvsqgni8FBxMn9nEbCpUPbpEtRB+y+27xx87CLkqY/cbYbnLgYm8tYp
         KEbQ==
X-Gm-Message-State: AOAM530UpWXYrfocFBMKhCvl7daUn84VhQTjxvmV0k2UGRmxHfSwzam8
        CwgFcP4eHa3n3qGxjYpQzgevOw==
X-Google-Smtp-Source: ABdhPJyeuvIUk9cxpa08DtvNpej/wXfLpGEqMDDSx1FItXAPvuD88vu2da6n2UY6y3sbYS4vjr9BdQ==
X-Received: by 2002:a37:48c6:: with SMTP id v189mr403594qka.378.1600874534379;
        Wed, 23 Sep 2020 08:22:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 0/4] Add support for length of each segment in the segcblist
Date:   Wed, 23 Sep 2020 11:22:07 -0400
Message-Id: <20200923152211.2403352-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past.

From Paul:
Another use case is of course more accurately determining whether a given CPU's
large pile of callbacks can be best served by making grace periods go faster,
invoking callbacks more vigorously, or both.  It should also be possible to
simplify some of the callback handling a bit, given that some of the unnatural
acts are due to there having been no per-batch counts.

Revision history:
v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.

v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Joel Fernandes (Google) (4):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 ++++++
kernel/rcu/rcu_segcblist.c    | 161 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  18 ++--
5 files changed, 165 insertions(+), 49 deletions(-)

--
2.28.0.681.g6f77f65b4e-goog

