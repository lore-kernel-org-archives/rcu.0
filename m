Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12508C433EF
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFCC96120D
	for <rcu@archiver.kernel.org>; Thu, 16 Sep 2021 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbhIPMMO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:12:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239255AbhIPMMO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2493A60F4A;
        Thu, 16 Sep 2021 12:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794253;
        bh=UgEA4kb2lcXFksBos8a4QPeHgOcznXv68lDgy/caka8=;
        h=From:To:Cc:Subject:Date:From;
        b=tqRkWUGdwHafR5Rpk8vhheAO1GkRUbKNR/w2xBboWF0oiLyelUT+Dj3TFZes5D7C1
         1+/OJpc128HrR4nZt+gQlAwwK2HqF2lL/d4KEI02sxpRSOM4UHC3eHkwBO1muZdJKB
         SeEhZb9AsWlZcm0X0LUkAMpi94wh40lubbjGCSeY8E5G+EqUxhV9GSUZxVLZL9ymWw
         OUeGM222wfdlyQ16F/l4EpQ936AywnS/HUrSt/pEQikYZqgu1bKwE6Y2ohLFHYTZTu
         gcuKixmVV7C1qwHKdwCkir9McEBMEU8TynMmkUHfe6QfxewjQf/hpdToG3EWfHGIfy
         u0CVXgOUrkT+Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 0/4] rcu: Unify a bit [non-]PREEMPT expedited quiescent state report
Date:   Thu, 16 Sep 2021 14:10:44 +0200
Message-Id: <20210916121048.36623-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This eventually removes rcu_data.exp_deferred_qs to use
rcu_data.cpu no_qs.b.exp instead.

For those like me who need a headlamp to walk there: https://ibb.co/3d06r0V

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/dev

HEAD: 7d9d8a0c6141f95cbac4367b12e755bfabb383ee

Thanks,
	Frederic
---

Frederic Weisbecker (4):
      rcu: Ignore rdp.cpu_no_qs.b.exp on premptible RCU's rcu_qs()
      rcu: Remove useless WRITE_ONCE() on rcu_data.exp_deferred_qs
      rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
      rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp


 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_exp.h    |  6 +++---
 kernel/rcu/tree_plugin.h | 24 +++++++++++++-----------
 3 files changed, 16 insertions(+), 15 deletions(-)
