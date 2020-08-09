Return-Path: <SRS0=RTr5=BT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0FC433DF
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FA2206A2
	for <rcu@archiver.kernel.org>; Sun,  9 Aug 2020 20:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmxdgDnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHIUoG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIUoG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 9 Aug 2020 16:44:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5EC061756;
        Sun,  9 Aug 2020 13:44:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so7454926ljc.3;
        Sun, 09 Aug 2020 13:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvDAYJLcZBgTsyI3IaDujHuoZCk3THaG/ArcfhJ0GWI=;
        b=GmxdgDnJfiMvbGkhskAMmhvwWFIywN7TCDp+2/6/kRsL1IzbleBtKRWN34/wAYC5g/
         nBEq0kPXP2SBmJz7F2p1yYi5aggjrvqqmk3mFP9MXiH56Ot2W8ZSYdniknQpRnvErsf5
         hHJ76yI/SpvjAhkSak0Ak6pFjyD+cUpzGywpzo7KcrYvZgxA+U7aZkdG48d9SihPQSF4
         OdENNtxsWQH2Xl+ju0SQVJED7D/NFkt3CgcfdGlYY876QVs0gFEk10je3pgDZajUlY0I
         q2HB/joDS9dZR/N5MX3KF/egEJh/LRm2U1CfEp8iB9nB75K43PUibwk5wDjTmftP4SVD
         ODZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SvDAYJLcZBgTsyI3IaDujHuoZCk3THaG/ArcfhJ0GWI=;
        b=dRPfHwSX0OygST223EB3381MV/WE+vUNGMvercjQOXhfrcyKC05jfmI1NfDY5FCs/q
         SeyAklgyFSBEGUE6tjjFhbQYJjfaHeQyUSrqPU5lp3Q9/qNqKHkQYxYER0VdfDEu7icr
         cYmkVbYwenar/vDwWMixW1PFJy8c5wcD705AL9cQhr/HEX76bg+odVnfvDSBSF/OywLy
         IBWVQQ4/l5ai4jbxvRfu4T4eY/dFE9w3Z/qRiDCX4F6sfj+plja6tVYEgffBzemfkSpH
         DWw2ljG7zZdWvoUNDnHMH9YdGDmDQZ4Fne5aJGznJQC09JmS6F/H/w/zthFdnJbz4h6H
         N0sA==
X-Gm-Message-State: AOAM532OoLWugqw2PaN4a2E+67N+LMRiEJENGL05IlJoF1nu4jvPaNCb
        iRWyIJxV8p4PHzjoNH21AiHIKeSFxyc=
X-Google-Smtp-Source: ABdhPJxe/b92Z2GqoBPeYDyLCZJRAhOMt12bGw+W+K9D7jJB9I8hfv0+hQN6Bltk3MwPUO8Z6nqKHg==
X-Received: by 2002:a2e:7615:: with SMTP id r21mr10287452ljc.371.1597005843876;
        Sun, 09 Aug 2020 13:44:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id c17sm9529603lfr.23.2020.08.09.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:44:03 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [RFC-PATCH 0/2] __GFP_NO_LOCKS
Date:   Sun,  9 Aug 2020 22:43:52 +0200
Message-Id: <20200809204354.20137-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, folk!

This small series introduces __GFP_NO_LOCKS flag. Detailed description
is here https://lkml.org/lkml/2020/8/3/961. I would like to get some
input at least about [1] patch. 

Please RFC. Appreciate for valubale comments, review and proposals :)

Thanks!

Uladzislau Rezki (Sony) (2):
  mm: Add __GFP_NO_LOCKS flag [1]
  rcu/tree: use __GFP_NO_LOCKS flag [2]

 include/linux/gfp.h            | 11 +++++++++--
 include/trace/events/mmflags.h |  1 +
 kernel/rcu/tree.c              |  2 +-
 mm/page_alloc.c                | 31 +++++++++++++++++++++++++------
 tools/perf/builtin-kmem.c      |  1 +
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.20.1

