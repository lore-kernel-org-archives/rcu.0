Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07943C433FE
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKWOCO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiKWOBr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 09:01:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62D485178
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:00 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 140so17381890pfz.6
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ev0iIRJeirT1XBKCA40pvSZnMx+/ZBLwwphaesYT2PM=;
        b=OhtKUV8Slhj2Agtj8GAx2zylkt08KQUJu/8MfLtV3gHvXpHtoVS6AuK6WPn6oDUx66
         68mHQYYOu531fnCPfOg95dMPXXEfSPfr6Ag9jLGa4coZ71FADPyHEgC721RIb1Ep2bzm
         ndLtnJJ8bGg7/B4NVN6MZ/WzVr8f2YIO3585d/yxbF6EfHxZVL0OEHM92sTThPDXnLNW
         zDsQBZYkn34WfHS3iIofsjXWQ6SzFXzYbe/NVCU/9RlgpkIamCNqjlLT5pP7TMpOs6Zz
         1oIRvXmqSME3jeutG4eV3PIPfcI89PkLYuag6HNBeEFwwZycSDCmlv4W8/KOt5Fz1on8
         HucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev0iIRJeirT1XBKCA40pvSZnMx+/ZBLwwphaesYT2PM=;
        b=MX+C7aE5oaHXgAcryjOL81zkCQXrSI4CZY9rcMIKbpERb4FVfatPhzVEhJBYAJ3L+q
         dRSGYJnEsgkQuEiOTAbPUseKQkZ3ntnKen7C2umh8LTUuPrMb8hq4u9IQn6dz3vnbqJD
         kmBh5hnhkEkUck74mflFDCWLrLN3PYfSuckpsNK8baMyKcLDnmlrPMgCponuRYJPC1ol
         Zrwl17if/zgJNcYZ/cFTsOXVdgy+5dOqTo5RqX2HH6StQ+Ba1oPx6PB13ZZDwauffScK
         HefQnAyXTlOLfp1J7M70yl8/Yxjy8gWSsZNCWlu4ZyEvRn2XATEtiEFORKGPExUSecTp
         AsAA==
X-Gm-Message-State: ANoB5pkkzYNEIUjCGbKBSa69Xe4SsvuMfUgv1+1M8UHbAeN6Mnvfv5ey
        dfvXt+uBzRBu2fukfZ0L7RgGaVv8mQ==
X-Google-Smtp-Source: AA0mqf6AOc63vBbTtHUGf3RkWvGvAVrBOn/5bwPHIcU5tbiNtwfn0x17TXkxhDGi5f55MPNoq6t78w==
X-Received: by 2002:a63:1464:0:b0:46a:f665:ed96 with SMTP id 36-20020a631464000000b0046af665ed96mr8477285pgu.486.1669211819843;
        Wed, 23 Nov 2022 05:56:59 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11-20020a63d34b000000b0047048c201e3sm10895996pgi.33.2022.11.23.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:56:59 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCHv2 0/2] srcu: Optimize when srcu_gp_start_if_needed() holds read lock
Date:   Wed, 23 Nov 2022 21:56:36 +0800
Message-Id: <20221123135638.79021-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This series optimizes and remove some code under the condition that
srcu_gp_start_if_needed() holds the srcu read lock.

v1 -> v2:
  add debug check in [1/2]
  drop original "[PATCH 2/2] srcu: Remove needless updating of
srcu_have_cbs in srcu_gp_end()"

Pingfan Liu (2):
  srcu: Remove needless rcu_seq_done() check while holding read lock
  srcu: Eliminate the case that snp_seq bigger than snap in
    srcu_funnel_gp_start()

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org

 include/linux/rcupdate.h |  1 +
 kernel/rcu/srcutree.c    | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

-- 
2.31.1

