Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC7C43334
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbiFTWRg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFTWRf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE821A3AC;
        Mon, 20 Jun 2022 15:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21580611FA;
        Mon, 20 Jun 2022 22:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810AEC3411B;
        Mon, 20 Jun 2022 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655763453;
        bh=ic9VILZnmW7oJbQF1duKHcHgpncSY6t6Lh5W2GkGEHA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=JSk4960JOw0kasFf86k5U26evc9fo/MPQmhhoeA1eDojv4JQplkXXzeSd1rCTYD2o
         F0Fdw0lJAjvPTNIKYSAe4Qhk2GmMJ6odaTJ06Ld3FKMd0LfxIiL0yis7DNoqNTtEpf
         uo02SwIqJWhfx4tq6s2AbvaBztbzJB/Drxmngv7BlomPb9MsPMyRXMfn1g9zq9Ysg9
         aTvm6aoykTVEFYRR1CU1KymDc4OUV7KW4mkB87LoeUR2RfcIq068RH/FYwccgpT6Qf
         T9GVzApcbNoteuY/Xi/6wUa+8DxyZVykbAOYlxTLtDOgoEXGbxEOk45KUsyF6Ws9EW
         1ot1EccqbqRTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2C0EA5C05B9; Mon, 20 Jun 2022 15:17:33 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:17:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/3] Documentation updates for v5.20
Message-ID: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains a few documentation updates:

1.	Update rcutorture.fwd_progress help text.

2.	Document the rcutree.rcu_divisor kernel boot parameter.

3.	Document rcutree.nocb_nobypass_lim_per_jiffy kernel parameter.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |   13 +++++
 b/Documentation/admin-guide/kernel-parameters.txt |   15 ++++++
 b/kernel/rcu/rcutorture.c                         |   53 +++++++---------------
 3 files changed, 46 insertions(+), 35 deletions(-)
