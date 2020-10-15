Return-Path: <SRS0=9/AT=DW=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC7C433E7
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8461C22254
	for <rcu@archiver.kernel.org>; Thu, 15 Oct 2020 01:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QUu1tscR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbgJOBk0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389065AbgJOBji (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B81FC0F26D4
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so2078931ion.3
        for <rcu@vger.kernel.org>; Wed, 14 Oct 2020 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qqUc6oLuA3wydK6eova2ntHUOVFh7ZAPTYJ0QwAAxE=;
        b=QUu1tscRPul83dOHWS6L7NjV2mnKXCfx/hSWTelutMAHUCzpJCfPdYK6CzgyhcIJPb
         /lQLiUy+gGItyKusUyYmKb+TKlKsALw4GM+W8ZuNHwMqa+fzLQxTB53sxZNwIWbKMzxn
         EFvnP46Y1EBA/UpMSRQ9XLYLx1uWhLRQjbjOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qqUc6oLuA3wydK6eova2ntHUOVFh7ZAPTYJ0QwAAxE=;
        b=YDjT+z7b+JdsKj/guEekI7Fj+xhFOvY/ZKn77B+hj7tlTcja8uK6n108Q4kartAViL
         uB6J5+GbulqqgYORS5CEhSxgbnYWxW2DiyDR2m6ECu7luzMp6p55bXoRutnQFLyN8yxb
         ROGgtfk2ylPIY9MjB0JGGhB50aS8aVCKYFjbOBK1AJbU7rht1OPm8xQco9TEan82sZZv
         xetRhLtYRSXJbZhrC2MuJY5DZwRtgXTJSnUw14iuz3OHO5Ra1fpbTx31hiVRUV/oEjYh
         Rf+59AorrHW0k5qsq8rlSOUHWoSqJgII6MDhRXcfTuApfD7Nl4MpSkjLB9z7acxZbl4l
         42lg==
X-Gm-Message-State: AOAM531LR7f9Dyj1XyoB6J+bAblxll7d9LtO1ASDSh1ymFArTBbV1Y3k
        vn8A+OqDyMtCGlp0vG2NSh4jeg==
X-Google-Smtp-Source: ABdhPJxoO9v2xfAArjZyQUn7/gbeOAwuxwNck84l4IaTGIbUQXUgdmy4uu3EGTdxZCEkzU3VlvFf1Q==
X-Received: by 2002:a6b:b2c5:: with SMTP id b188mr1364466iof.90.1602721385747;
        Wed, 14 Oct 2020 17:23:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 0/6] Add support for length of each segment in the segcblist
Date:   Wed, 14 Oct 2020 20:22:55 -0400
Message-Id: <20201015002301.101830-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past.

>From Paul:
Another use case is of course more accurately determining whether a given CPU's
large pile of callbacks can be best served by making grace periods go faster,
invoking callbacks more vigorously, or both.  It should also be possible to
simplify some of the callback handling a bit, given that some of the unnatural
acts are due to there having been no per-batch counts.

Revision history:
v7: Cleaned up memory barriers (thanks fweisbec@ for reviewing), made minor
corrections per Neeraj (thanks).

v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.

v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@xxxxxxxxxxxxxxxxx/)

Joel Fernandes (Google) (6):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include
rcu/tree: Remove redundant smp_mb() in rcu_do_batch
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 205 ++++++++++++++++++++++++++--------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  21 ++--
5 files changed, 203 insertions(+), 58 deletions(-)

--
2.28.0.1011.ga647a8990f-goog

