Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E84C04AA9
	for <rcu@archiver.kernel.org>; Wed, 20 Sep 2023 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjITPof (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjITPoe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Sep 2023 11:44:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F16A3
        for <rcu@vger.kernel.org>; Wed, 20 Sep 2023 08:44:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B507DC433C8;
        Wed, 20 Sep 2023 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695224668;
        bh=p2GetbceuCrtDTO5zidlJCWFsNrfcfSHkymVwJ6Sq5I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=icFGXE8ztEt9lHo3k5p7y+CyRkE4lK/lf3y2BwmARDx+WsnYaK4xdZzKux7jrNnyq
         vTbnAS7Q8wudzX5jwemm/4YtXUwkEU+MDZto4C1C5PUzoqujzsnPoiO/qPHexuWgrC
         7cKbYK3WyueWWU+oDIYSvsjJrglPua0hnMq0hX1xaBluqZqdTJ8XqaUay8XPk7dwh4
         q6hhD3B3OtGnRwklMW5NA+PYoFyrbkCdTDoxXEPEUVUXZwi4qvYCLNISRebEyVqzTP
         QQABzKixSfI0SIDltTxqb5cMqrvzRuJgFZ82qM0MTHMVX3wd0Mquqa3DBiHNqCwUfx
         YlKD4LDzSmdvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B7DD0CE0CF9; Wed, 20 Sep 2023 08:44:26 -0700 (PDT)
Date:   Wed, 20 Sep 2023 08:44:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     rcu@vger.kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        urezki@gmail.com, joel@joelfernandes.org, boqun.feng@gmail.com
Subject: Frederic will be doing RCU PR for v6.7 merge window
Message-ID: <6a6d4007-e783-4dee-9f0d-6a1d2525a766@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Linus,

This time, Frederic Weisbecker will be handling the RCU commits for the
upcoming v6.7 merge window.  This is once again a practice exercise,
and I will likely be returning for the v6.8 merge window.

This again covers only RCU, so I will be sending pull requests as needed
for the other topics.

Again, please let me know of any concerns or issues with this.

							Thanx, Paul
