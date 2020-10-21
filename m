Return-Path: <SRS0=Ug6t=D4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A8C4363A
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF33D22447
	for <rcu@archiver.kernel.org>; Wed, 21 Oct 2020 19:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="enybzjH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441227AbgJUTIS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Oct 2020 15:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441200AbgJUTIS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE85C0613CE
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:18 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i22so3607464qkn.9
        for <rcu@vger.kernel.org>; Wed, 21 Oct 2020 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9Kg/TgEEAwz+IelTGb09lowYE0dFmOxL25uAWCOofo=;
        b=enybzjH3Yn2KZzVK3i9SK/mk2ALvQ4YHPbKyiNX+OsMXhTX/N/yLcUI8lDkw+RC6aR
         K7h7HVIZ2TPVX/I7OZI2OT+NqQDrB03Q0UyFwxtDr79sM9Z3Qcb8PReVmqrSN6AspHqF
         dYCo4ielmbhI0CNXG5R7Dt0+F1J5UmFFimNxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9Kg/TgEEAwz+IelTGb09lowYE0dFmOxL25uAWCOofo=;
        b=TLAfQFiXblucY/xyW1IhOk53KDU+GYstxmaf01povz/K2o5RIubTlrGyHioQCLe3E7
         arMTZk/BA77V/PaZC9wtK+Czj3UW1rXovUesEjPk7GO31Hne0vauNU1tKmknan8rqh5x
         xd+tVLwJ6pczI8AnewRxB9TM6hGXHGzWYKmcAfS81DL9eKhXAPoGqwFQH7xhvGOKfQnN
         fRAbRv/zFPnWVCX2SKWZ4WS5U6pu3zmnLcQwMR1JPStZ8nU3uVeyOF/ejnZGzVLmSJkW
         H5+1PcpDxmsJl15JrTaA9iCYwCfEdJYg3lD1xkJJC/9LttW47lBO25lpxFh/3UALSxTH
         HSCQ==
X-Gm-Message-State: AOAM530zcUs+fPy4DQXn7oTOL6VdzAmtWaL0cLAJZgmveQObMrGaWfdQ
        VcKm5iHFb79QMxDmkb+UI5YjYA==
X-Google-Smtp-Source: ABdhPJwFCVEmNPuw4HT/WxGRYQjLBlcDOMGyWmMepgBxukxg8Ec6dcBTVwWvjaKijM0CFFHgMwIPBg==
X-Received: by 2002:ae9:de82:: with SMTP id s124mr4662627qkf.379.1603307297364;
        Wed, 21 Oct 2020 12:08:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 0/6] Add support for length of each segment in the segcblist
Date:   Wed, 21 Oct 2020 15:08:07 -0400
Message-Id: <20201021190813.3005054-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Joel Fernandes <joelaf@google.com>

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

Joel Fernandes (Google) (6):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include
rcu/tree: segcblist: Remove redundant smp_mb()s
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   1 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 195 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  21 ++--
5 files changed, 192 insertions(+), 58 deletions(-)

--
2.29.0.rc1.297.gfa9743e501-goog

