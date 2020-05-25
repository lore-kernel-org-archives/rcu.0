Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4826AC433DF
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2529620825
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5doM9LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgEYVsM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 17:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYVsM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 17:48:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A9C061A0E;
        Mon, 25 May 2020 14:48:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so22188270ljj.1;
        Mon, 25 May 2020 14:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQInU0916PNBneM+14O7BbOheS8JSAcYzX9gJpm38/0=;
        b=s5doM9LODG25aDd2E7u/5vjcryloRBJtNYWudVya935NtAdZKrp0I1wCzyNdEdLaFS
         v801EJtFd5hFmgAoASGPtLDUzh7jGmxV0JzlOwAQyuPFJoCvJKro6lSiBo2o6Z6m6cWF
         826PjgQmXHESMXIqmNgUiwEwOT9XDSzdX+gd1X6OGyJ8n9p22SREG/FKLJ/Ae1aqQO1X
         ABwhPEFS+w0NtNIt0SuJevVUJOw+G43tegm7vyUS+X+Ke427d403NINDi/Lgm7hJ8mRb
         8eUL8NUEuI+AqDp9rrpM7G61XmgYTFJ0mv3u2NyRCtgi03TP8Kx947lRgnx2TORljniv
         gfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SQInU0916PNBneM+14O7BbOheS8JSAcYzX9gJpm38/0=;
        b=TDpnBE0o86RkWRFnWZGRmz5JBQm3r/EJnl+3gRyhXY3tXOEKL80hkVoxU+1ti4jIei
         wxc0UCvhpH/G8fPDZd5vjTVlGdMroIwEdZWK6PsfW9Kx5Q29ivGj2qD8H0ErxW+TtzXc
         kvxpXWoPIr6IEUPxo1CpuiK9tmYBr9RzxWGldtJlALFfXUsKE/uPjvA+j7iSSXvp2d5s
         I4lgX06Qm64r4jdWR6FGfFt/VqVTCgiV/A8SET4T2pPr1LFXhxho5HTznZeYAAfIps4W
         9iqswwdCT47tHyjYvPZ5bDg1qjoZYT8DaDkornNitXE9oa2R4MGKUkQmRmCu1AObLbOl
         ATVQ==
X-Gm-Message-State: AOAM532Gbah7nSR3eZFBVf/+6qsYLh9R58oS+D6Bu6IATMtx8nQoCMCb
        tuRdRO8pKzejZMsgSNb+2fxxipEA56E1Rw==
X-Google-Smtp-Source: ABdhPJwcnuFHWd0AlFd25w3mPH8hnUWSjWPFIkEbWtMsd55xIv2VvAGEVKWegIcMc6d/B/3mksTjEg==
X-Received: by 2002:a2e:7001:: with SMTP id l1mr12185404ljc.388.1590443289777;
        Mon, 25 May 2020 14:48:09 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a6sm2280044lji.29.2020.05.25.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:48:09 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH v2 00/16] Introduce kvfree_rcu(1 or 2 arguments)
Date:   Mon, 25 May 2020 23:47:44 +0200
Message-Id: <20200525214800.93072-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is a v2 of the https://lkml.org/lkml/2020/4/28/1626 series.
Please have look at v1 to find out more about motivation and details.
It is based on the latest dev.2020.05.17a Paul's branch.

Short changelog (v1 -> v2):
    - Combine some patches, thus reduce the overall number;
    - Switch one line comment type from "/* */" to "//";
    - Improve commit messages of some patches;
    - For tiny-RCU we just do synchronize_rcu() followed by kvfree()
      for single-argument of kvfree_rcu();
    - Drop the dynamic rcu_head attaching techniques + related patches;
    - Reduce duplication of code in some functions;
    - Added more comments for better understanding of code.

There is one patch related to "mm": "Rename kvfree_rcu() to local variant"
please note, it does not change any functionality, only renaming is done.

Joel Fernandes (Google) (3):
  rcu/tree: Keep kfree_rcu() awake during lock contention
  rcu/tree: Skip entry into the page allocator for PREEMPT_RT
  rcu/tree: Make debug_objects logic independent of rcu_head

Sebastian Andrzej Siewior (1):
  rcu/tree: Use static initializer for krc.lock

Uladzislau Rezki (Sony) (12):
  rcu/tree: Repeat the monitor if any free channel is busy
  rcu/tree: Simplify KFREE_BULK_MAX_ENTR macro
  rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate functions
  rcu/tree: cache specified number of objects
  rcu/tree: Maintain separate array for vmalloc ptrs
  rcu/tiny: support vmalloc in tiny-RCU
  rcu: Rename *_kfree_callback/*_kfree_rcu_offset/kfree_call_*
  mm/list_lru.c: Rename kvfree_rcu() to local variant
  rcu: Introduce 2 arg kvfree_rcu() interface
  rcu: Support reclaim for head-less object
  rcu: Introduce single argument kvfree_rcu() interface
  lib/test_vmalloc.c: Add test cases for kvfree_rcu()

 .../admin-guide/kernel-parameters.txt         |   8 +
 include/linux/rcupdate.h                      |  53 ++-
 include/linux/rcutiny.h                       |  20 +-
 include/linux/rcutree.h                       |   2 +-
 include/trace/events/rcu.h                    |   8 +-
 kernel/rcu/tiny.c                             |   7 +-
 kernel/rcu/tree.c                             | 381 ++++++++++++------
 lib/test_vmalloc.c                            | 103 ++++-
 mm/list_lru.c                                 |   6 +-
 9 files changed, 446 insertions(+), 142 deletions(-)

-- 
2.20.1

