Return-Path: <SRS0=ANd2=CD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0824C433E1
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 02:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75485204EC
	for <rcu@archiver.kernel.org>; Tue, 25 Aug 2020 02:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Y+quge4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHYCsv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgHYCsu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Aug 2020 22:48:50 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC3C061574
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o12so5082969qki.13
        for <rcu@vger.kernel.org>; Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDQbTxMp1C6CYIxUrZbkzWdwK+GUKbU9bbcwziJlLJM=;
        b=Y+quge4vKDkMBkG9K2uI17oyg6nOzsVtgH5Wj/BPuvqKsGNZI6V44MgZJOtabTfEoT
         ogB+Ub3YppTetYQm4v3e1Jf8cpg97taw40ZfkweT7BvtMmG21cfNN8KYAOQuO2jPnen8
         tQg94Peaiuzb0nBxC4tUqHVzV0FxdNnve5dF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDQbTxMp1C6CYIxUrZbkzWdwK+GUKbU9bbcwziJlLJM=;
        b=YBdLAlQolBU8Fap/ADhzZ1QqMQOV/x3smSvrCxuAc00ImBeCDHYgs4ZT4Uz7jzn0Cn
         jmzWYjChy50L33uX3LWalmsMlJwG22AkunuYtFwdYBr5oFw+Bo+kp8w4Z9JaEWzt/HQl
         bOrwIJu5vdnA+IpWWgS+R4bXnc+kZdNfj6ZXdXcgSJ/CcmHISVCpJlwHoJ8cu7Do78Dk
         /9jV+9BtjGQlut3we3dxn6pS5yiE0v5QH42LdBfj5x4nkj4Z+fnj+YtmlSi9plPucBKc
         srOtt9jkBMxcFzwvNVv/94m4aPeWpHeRFgHqsosbciY5bLE+vG+TbJ+ViodihUGF+itt
         qPZA==
X-Gm-Message-State: AOAM5308QaSO4dq0JFDHgnNxWSjCetdE1VIn4/DKDLoYEDwEsmViKTHe
        b6Laxsz740VHnuT0gl3+vWn6Cw==
X-Google-Smtp-Source: ABdhPJylkywYmbfoh8Km/IDLOzejn31ir/4h2j9L5LsuD9gSx2laJes3GgJLz2xbP7d5ycHUDQ7mAA==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr7549813qkk.293.1598323729632;
        Mon, 24 Aug 2020 19:48:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n14sm2159188qtk.50.2020.08.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:48:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        boqun.feng@gmail.com, dave@stgolabs.net,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: [PATCH v4 -rcu 0/4] Maintain the length of each segment in the segcblist
Date:   Mon, 24 Aug 2020 22:48:38 -0400
Message-Id: <20200825024842.3408659-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past. The trace patch is the last one in this series.

Passes 30 minutes of TREE01, TREE03, TREE07.  Testing of other TREE configs is
in progress.

Patches are based on -rcu commit:
4f43de2a419a ("Merge branch 'lkmm-dev.2020.08.24a' into HEAD")

Revision history:
v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Joel Fernandes (Google) (4):
rcu/segcblist: Do not depend on rcl->len to store the segcb len during
merge
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 +++++++
kernel/rcu/rcu_segcblist.c    | 119 ++++++++++++++++++++++++++++++++--
kernel/rcu/rcu_segcblist.h    |   8 +++
kernel/rcu/tree.c             |  32 +++++++--
5 files changed, 175 insertions(+), 11 deletions(-)

--
2.28.0.297.g1956fa8f8d-goog

