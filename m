Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773DC433B4
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27DDD61074
	for <rcu@archiver.kernel.org>; Thu, 15 Apr 2021 17:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDORUg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhDORUg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Apr 2021 13:20:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F23C061574;
        Thu, 15 Apr 2021 10:20:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f41so17018281lfv.8;
        Thu, 15 Apr 2021 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCEEK+5pb6Occq/GE4wtkFZOWaHHn/Wj+jS63+GMFDk=;
        b=r2JmiSQcQgHYXwkUXVLdHcSPPFKOqPsL0pdeGwo1gwCY9chUDK4QXAXF+IFcbb3Hhg
         qeSVLLtjuFBCCSUHFoGAuzr0Qg2mM7uFTRviCfv6zPyq+8Qket1d8rrNOI5BtY0kEG7A
         WX+4YtuFsHZp2keUPmdofVFnrIt18InEvX+t9BvryZXRwyGrNOqhXIcYXAptbCRY4R7K
         7opU5lFSFntRj0yEhK1TfCXUwljtOD3GlfaOvIPpGYZB0UVq0Z/J26msOY4cyUbKyifs
         IFR/GksrnYHueubHNtVqShgRdf2jvssCbNiF/I02NfgTGF6X/R/rNDgfXhFTt/XwDOFc
         SxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCEEK+5pb6Occq/GE4wtkFZOWaHHn/Wj+jS63+GMFDk=;
        b=uJ2AswltSJQOdq2ZBMI4uOjuRljyqmaGuBtgnWHKWfDYRrIA/RgZTaBJAdOeFTfiBg
         Bw+LZXsQH7k+eYx644g2LxjXMiJp7Qs9etJ3+ILZTorGQOWOfvu6ln4xetDQBneNAp2p
         +FBgTqUXXJskwozoJtEWGUe+2B7h94bKYT2rHwj6mqMY9EyAqDJqfdqCjiOq9QGGbGJs
         WENpxPlBPKREWNkvQjmDixNA2vr5IYihTMe8lUErJRFghqLxBfY7/MqXsQrEMdEPrMtE
         9G/4or0F06UQPmwcjMy9dShzX3TitE4A0vRDkfKOIxYtui2B7N596PLYPP45TLeYV2xi
         Q6Tg==
X-Gm-Message-State: AOAM530KoRMlix+eM3f2NjoH/fgGg8gS0I8O84VKhi57XisfzRVNyXpi
        D6SHnVs6PpN/BCBOpfAl7c1PF58OtDHDZQ==
X-Google-Smtp-Source: ABdhPJz5+K5tKUfPHrRrCFWHCSzBWfSJInP+CrlJG14Tx1/pguScI5jiaZ7KWrq6rZ/yaKI3PRGBug==
X-Received: by 2002:a05:6512:902:: with SMTP id e2mr134411lft.275.1618507211292;
        Thu, 15 Apr 2021 10:20:11 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id t6sm84358lff.276.2021.04.15.10.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:20:10 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 0/5] kvfree_rcu() miscellaneous fixes
Date:   Thu, 15 Apr 2021 19:19:55 +0200
Message-Id: <20210415172000.15086-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is a v2 of a small series. See the changelog below:

V1 -> V2:
- document the rcu_delay_page_cache_fill_msec parameter;
- drop the "kvfree_rcu: introduce "flags" variable" patch;
- reword commit messages;
- in the patch [1], do not use READ_ONCE() instances in
  get_cached_bnode()/put_cached_bnode() it is protected
  by the lock.
- Capitalize the word following by ":" in commit messages.

Uladzislau Rezki (Sony) (4):
[1]  kvfree_rcu: Use [READ/WRITE]_ONCE() macros to access to nr_bkv_objs
[2]  kvfree_rcu: Add a bulk-list check when a scheduler is run
[3]  kvfree_rcu: Update "monitor_todo" once a batch is started
[4]  kvfree_rcu: Use kfree_rcu_monitor() instead of open-coded variant

Zhang Qiang (1):
[5]  kvfree_rcu: Release a page cache under memory pressure

 .../admin-guide/kernel-parameters.txt         |  5 +
 kernel/rcu/tree.c                             | 92 +++++++++++++++----
 2 files changed, 77 insertions(+), 20 deletions(-)

-- 
2.20.1

