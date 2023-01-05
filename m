Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE98C46467
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjAEAcH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAEAcA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4F4A976;
        Wed,  4 Jan 2023 16:28:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1E96185C;
        Thu,  5 Jan 2023 00:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0454C433EF;
        Thu,  5 Jan 2023 00:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878526;
        bh=f8yR/DtHUbezKXgVkqs6Ex/em/iJfg177cWRXF1n5Xo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iayiSBaCfbxo7F+VSHW/rCkuW7+GGg5U/Uw+LiSlqMc3WO2Qc6ScNg2c4YFQ7slrJ
         DiSIPnIl3iGRLT38ycB9Ch9P67rS6nkH2kaeD70/eu+mr1ggI+SL7I4msyrmqMBffG
         v1mAeOXZpMN4NuBwodZscvFqfAlGTjCn/OztzmrvqddPWXJ1aGSgCAFB+DICPoSRee
         UoasHZXROmeRyzakeWRjnbqPHMH/ivVmpv/5WsNiaVv/nqdx+cqQL3mohmzczcwvT0
         FdHsUEkQvQbm+FIQ3/IsWxoXuuJo8pQTEwLok3URJYpC8DkO8jBsnDrTvEq0V0e5Qu
         HMeE80NK3wbQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9EDDD5C05CA; Wed,  4 Jan 2023 16:28:45 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:28:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/9] SRCU updates for v6.3
Message-ID: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides SRCU updates, perhaps most notably the addition
of a srcu_down_read() and srcu_up_read() that act like srcu_read_lock()
and srcu_read_unlock(), but which permit the srcu_up_read() to be invoked
from a different context than the srcu_down_read().

1.	Release early_srcu resources when no longer in use, courtesy
	of Zqiang.

2.	Delegate work to the boot cpu if using SRCU_SIZE_SMALL, courtesy
	of Pingfan Liu.

3.	Fix a misspelling in comment, courtesy of Pingfan Liu.

4.	Fix the comparision in srcu_invl_snp_seq(), courtesy of Pingfan
	Liu.

5.	Add srcu_down_read() and srcu_up_read().

6.	Add test code for semaphore-like SRCU readers.

7.	Remove needless rcu_seq_done() check while holding read lock,
	courtesy of Pingfan Liu.

8.	Yet more detail for srcu_readers_active_idx_check() comments.

9.	Update comment after the index flip.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h     |   45 ++++++++++++++++++++++
 b/include/linux/srcutree.h |    2 -
 b/kernel/rcu/srcutree.c    |    9 ++--
 b/kernel/rcu/update.c      |    1 
 kernel/rcu/srcutree.c      |   89 ++++++++++++++++++++++++++++++++-------------
 kernel/rcu/update.c        |    3 +
 6 files changed, 119 insertions(+), 30 deletions(-)
