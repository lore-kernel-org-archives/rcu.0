Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0195C433B4
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5BFD6135B
	for <rcu@archiver.kernel.org>; Wed, 19 May 2021 00:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhESAKy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 May 2021 20:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233435AbhESAKy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 May 2021 20:10:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 012C060FF1;
        Wed, 19 May 2021 00:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621382976;
        bh=AvEnFdTLVCRak+TylWOHZmptX9FZMRNSRxRg4LzQx0g=;
        h=From:To:Cc:Subject:Date:From;
        b=GNvR+iSt+7Q4RdNuzt7viTDzTpqwXBuoZrAuAPLNY7c/M1S4WJf/UBtnc9geGUuwl
         VU8vA+dnnhW7Q5hlZXBMRCYH2jgXtdfmZORE3DxUFf2btDVn5BXhXY8RKPF352ulmI
         9XSFe14XCuKO5A62dP9utnR6pmad8sO662Gx7gLcx31zida/9bZbcIIAEXF7zTrlyu
         BtgGUhRTEFraLtG4FFuuzeQGdDVeg+tpvEkEeVlHh9qVathP1KaYJJLbQc/3PU5JAV
         9cnJ4Rld0vOj6wC1zEympUEgqERfdHRGgUBTuqArme5JOOqRrUmkU+B54P2ORce34C
         jbE2O8qkfoUIg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH 0/3] rcu/nocb cleanups
Date:   Wed, 19 May 2021 02:09:27 +0200
Message-Id: <20210519000930.15702-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Just a few cleanups for rcu/nocb.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 296a71cc074b187cdb35388d4d50b86429032a24

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      rcu/nocb: Start moving nocb code to its own plugin file
      rcu: Remove NOCB deferred wakeup from rcutree_dead_cpu()
      rcu: Assume rcu_report_dead() always deals with local CPU


 .../Expedited-Grace-Periods.rst                    |    2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg  |    2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg      |    2 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg |    2 +-
 .../RCU/Design/Requirements/Requirements.rst       |    2 +-
 arch/arm64/kernel/smp.c                            |    2 +-
 include/linux/rcupdate.h                           |    2 +-
 kernel/cpu.c                                       |    4 +-
 kernel/rcu/nocb.h                                  | 1494 ++++++++++++++++++++
 kernel/rcu/tree.c                                  |    9 +-
 kernel/rcu/tree_plugin.h                           | 1488 +------------------
 11 files changed, 1507 insertions(+), 1502 deletions(-)
