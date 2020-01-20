Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0033C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BE522464
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 14:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLYKKfHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgATOmg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:42:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40203 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOmg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 09:42:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id u1so34098122ljk.7;
        Mon, 20 Jan 2020 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tPUAJ9X04qViQXYSSdVkGqjbgm7Y7KnnSkCCZDyhAk=;
        b=LLYKKfHYIYNwz0arLEPRcusRLhCiyMBA0LAel8j7wOdAZOFsrnd48VliNmvCtw7WlU
         atkHNF39hK07Y/v6UE9Gh5tSgzhXbb1vQcy2YHl2xXScs58DLi/HIAED/R9TZQ9nYBhU
         15pLDuP1O2BI2rmYbE0KGr5+NOzzDZzfUgnf+2Z2iVOOxKE5le4aPtH+ql3k9YvkxjaJ
         CVLm1BOyCbLNWMaOjm8WRFlt+xJsq/Y0uYzcTJz5Z5hODjqDunkQlPe68Kwt/uVuN289
         0YWnxFTJX4TdewN4bQzyFq+KAbLQGlf5JTsjr5YpyR+VNQIX+Gel3/0t5S+e4dXn+F8v
         xp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1tPUAJ9X04qViQXYSSdVkGqjbgm7Y7KnnSkCCZDyhAk=;
        b=HE6QXXGuGQ1gcinh3aFaxR7P3zwELuMsumuo8NYCfYCX8JRsHxeUxl3X0wyGHvYsrD
         FVpcpDDJzZWEJccuei5Vl6r3vK8QfuneiOxf+zu5Xts/78DuKCtiwqyDKJiWo+KefLmG
         ImjFoWndCFi/eR9GeqRscE/AC63Ms1RcrUhoFv5uSPWuPtrq70lM4U22xlk0luqE+cJ8
         Wt+wbZfMzcxK8SsvNSaxWVpNKvIpo1Bxx+iIRs3RL6UKRFtnWpZVdWIJdDJgMHE+0JO+
         sDtlRcFNNgZY8lDVu0PXkz9NNEvceTX8/boG6wTr8Y3E+iwiubv0iB6o4aZuEiW7BtsR
         MxnA==
X-Gm-Message-State: APjAAAWLTy8UdEZ1Mu55eR7tGraIZJqxSIMf+TXxyk+P50F2tE7BVarQ
        7qAuMI2Cbw5nNKjl8dfzkKKEOICYIuC0Gg==
X-Google-Smtp-Source: APXvYqyEWUpTBZNMoOP7os3kv8i+DpGs8tMbgk+mLoNe95AMC+xzJecFZ3Bc7zBgdVkgSl1I/dyKEQ==
X-Received: by 2002:a2e:809a:: with SMTP id i26mr13967684ljg.108.1579531353559;
        Mon, 20 Jan 2020 06:42:33 -0800 (PST)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id 21sm16945432ljv.19.2020.01.20.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:42:33 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [v2 PATCH 0/2] enhance kfree_rcu() throughput
Date:   Mon, 20 Jan 2020 15:42:24 +0100
Message-Id: <20200120144226.27538-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Here we go with V2 version of the "support kfree_bulk() interface in
kfree_rcu()" patchest. Apart of that there is one more, it just adds
a trace event for kfree_bulk() call.

Boths patches are based on "dev.2020.01.10a" branch of the linux-rcu.git

V1 -> V2:
   - fix and support debugobjects;
   - updated the commit message of [1]. Added test results
     of CONFIG_SLAB / CONFIG_SLUB configurations together
     with recent new parameter kfree_vary_obj_size=1;
   - add more comments.

Rezki (Sony) (2):
[1]  rcu/tree: support kfree_bulk() interface in kfree_rcu()
[2]  rcu/tree: add a trace invoke event of the kfree_bulk()

 include/trace/events/rcu.h |  28 +++++
 kernel/rcu/tree.c          | 207 ++++++++++++++++++++++++++++++-------
 2 files changed, 200 insertions(+), 35 deletions(-)

-- 
2.20.1

