Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0E8C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C77422370
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m/MsTIVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgKCO0L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgKCO0I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:08 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C58C0613D1
        for <rcu@vger.kernel.org>; Tue,  3 Nov 2020 06:26:08 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so3195080qts.5
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2020 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFL7dVDfXNm5vtnmwHtQwhQMGcGnnQrFNvHpqb+k+Ro=;
        b=m/MsTIVOByd2e8T5GHX++XPIJ45s+RU9A99sAo57vatmJcea6Twgwv8Gorrypt3NK3
         0EjHvWZH8uRrdY1T+sz492AzusRY6tg3XMNwmufCs2oYZJaAZ7hDaT2AtCFIX1BkGWBS
         iZtOUtnscLcdHWNi+wJ/v+TwdDtatLMAnMZyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFL7dVDfXNm5vtnmwHtQwhQMGcGnnQrFNvHpqb+k+Ro=;
        b=YwpxpPJ2I3tixJi9VrgLPpR2TYeAqnUxoYbUiUq5+QdSRG5Uhm5g3E1y21V3Ngj8HB
         6pUYrR2gxvbV+KNbyNHMjU/kOheDLYAialNNV/GWTCQeZnmsSDlOCJMKn1uXx2veLFAr
         ZPh9LnQ0sk2Nrh9guejfIPHlOf+TpYW5agi6UNgSC5wWzY3mX7DOBaizTcliUZG/l+cZ
         Zpl4tlaCxUfRBOV6ecd5efYVayATQHRb+7II4rz5Kak3VtHpk6H0Dx06VkS6lu29xk6+
         yXNNMRDeIa5A2KDJ2h9c5PXx1LuZUG7IhdVpO6pt6d1J02wT3vRF58JgZPPs/L5/mDwS
         vF1g==
X-Gm-Message-State: AOAM530usGJDkDVJKrunYIQH/O/hP8wmJyeIU4R5SnzvUvH0L84snw0Y
        C1CLhrsxFD3xFYhbo6+iZYMGlA==
X-Google-Smtp-Source: ABdhPJyez4bk4O2JYt+Gbe7KqeyxQQ2Ozr9Yx/ldgen8/bBlvzWQH1jtwZD1v5Z1Oy4dARp6XvG3cA==
X-Received: by 2002:ac8:376b:: with SMTP id p40mr5915285qtb.231.1604413567648;
        Tue, 03 Nov 2020 06:26:07 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:06 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v9 0/7] Add support for length of each segment in the segcblist
Date:   Tue,  3 Nov 2020 09:25:56 -0500
Message-Id: <20201103142603.1302207-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
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
v9: Fix SRCU issues, other minor style changes (Frederic). Added Frederic's
Reviewed-by to all but the last patch..

v8: Small style changes, making the seglen as non-atomic since it is always
    under lock (Frederic).

v7: Cleaned up memory barriers (thanks fweisbec@ for reviewing), made minor
corrections per Neeraj (thanks).

v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.

v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@xxxxxxxxxxxxxxxxx/)

Joel Fernandes (Google) (7):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
srcu: Fix invoke_rcu_callbacks() segcb length adjustment
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include
rcu/tree: segcblist: Remove redundant smp_mb()s
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   1 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 198 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/srcutree.c         |   5 +-
kernel/rcu/tree.c             |  21 ++--
6 files changed, 199 insertions(+), 59 deletions(-)

--
2.29.1.341.ge80a0c044ae-goog

