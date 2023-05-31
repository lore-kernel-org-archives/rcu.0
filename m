Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60887C77B7A
	for <rcu@archiver.kernel.org>; Wed, 31 May 2023 10:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjEaKRz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 May 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbjEaKRt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 May 2023 06:17:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D41C133;
        Wed, 31 May 2023 03:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0471663082;
        Wed, 31 May 2023 10:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6E6C433EF;
        Wed, 31 May 2023 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528267;
        bh=yBShwf/AEIa+ihCN/zarM26dpN1QSrCJRHUQ1f0zrYU=;
        h=From:To:Cc:Subject:Date:From;
        b=DfNaJc8W80U58OjbozBk4AMlUzn2RvKVDIrscpCwEAxW5MexdUq35mZw6gwOlN/bG
         HVSMi8nvuTYt0pTi2oGUSGyX/4WibuR+83y8ewsIACOTDKSa94lZeTBhTaFr0LCbvR
         6RmTiqy2sfQlaQh2N7EThyFibRcaZN0zvR5gzxpLwhn5JXq6xEJsh9q8jY2ghYe/FF
         t9zk3rTAV0RbMlJZwKovvPVvn2Jqgi3DZTJSzXt0i+VqniH1RzaXs8CS2ftXz+kQzZ
         nSucFQXVGQ1e4RXx7yNO34EpctwLjY0dUb6rs/uCmGOMILQMpNwhhTYdBiCKfeQztE
         RdhLZCY5yJidA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 0/9] rcu: Support for lazy callbacks on !CONFIG_RCU_NOCB_CPU
Date:   Wed, 31 May 2023 12:17:27 +0200
Message-Id: <20230531101736.12981-1-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

Here is a first attempt at providing support for lazy callbacks on
non-offloaded CPUs. I have measured interesting results on my machine
when it is mostly idle (just an idle ssh connection kept alive) with
a gain of +10% idle time. This needs more serious testing though,
especially to make sure that no performance regression is introduced.

Also I have only mildly tested on NOCB (eg: no rcutorture yet), so I
might have broken something.

Finally it's also possible that the idle time improvement is due to me
introducing a bug :)

The patches 1-5 can be considered independently from the rest.

Frederic Weisbecker (9):
  rcu: Assume IRQS disabled from rcu_report_dead()
  rcu: Use rcu_segcblist_segempty() instead of open coding it
  rcu: Rename jiffies_till_flush to jiffies_lazy_flush
  rcu: Introduce lazy queue's own qhimark
  rcu: Add rcutree.lazy_enabled boot parameter
  rcu/nocb: Rename was_alldone to was_pending
  rcu: Implement lazyness on the main segcblist level
  rcu: Make segcblist flags test strict
  rcu: Support lazy callbacks with CONFIG_RCU_NOCB=n

 .../admin-guide/kernel-parameters.txt         |   5 +
 include/linux/rcu_segcblist.h                 |  13 +-
 kernel/rcu/Kconfig                            |   2 +-
 kernel/rcu/rcu.h                              |   8 +-
 kernel/rcu/rcu_segcblist.c                    |  44 ++-
 kernel/rcu/rcu_segcblist.h                    |  32 +-
 kernel/rcu/rcuscale.c                         |   6 +-
 kernel/rcu/tree.c                             | 272 +++++++++++++++--
 kernel/rcu/tree.h                             |   9 +-
 kernel/rcu/tree_nocb.h                        | 285 +++++-------------
 10 files changed, 425 insertions(+), 251 deletions(-)

-- 
2.40.1

