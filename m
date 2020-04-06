Return-Path: <SRS0=S3tF=5W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B902C2BA1E
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A91C20731
	for <rcu@archiver.kernel.org>; Mon,  6 Apr 2020 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586135438;
	bh=NapCtnOG7WBPhOJXPKNfQp/uL4cU/eeZHbTCOnYnNfM=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=BcersKxgdSOA0qpuRIqly8NTld6DM3+MbVhFKYCf4DYj0HBxOU57d1Zoqht/AAX+z
	 ByUQRD5QEpnAjljs/EzVME2M9E7fbsZjKGjdLEkBdCGrLtWDCOa3SrK7cqEhnyYcuC
	 CFg6jQCrHWdQTl4FKAlXa5bJgRObqO6KuGqVihCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDFBKh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 5 Apr 2020 21:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDFBKh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 5 Apr 2020 21:10:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A9F2068E;
        Mon,  6 Apr 2020 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586135436;
        bh=NapCtnOG7WBPhOJXPKNfQp/uL4cU/eeZHbTCOnYnNfM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=tPh0ZZ5IXSwmC3JWZ7d9qKNKQgjzkp9UT6hLMBIT1cjxLJjXAaxQ61hdIxhLWiuhD
         nbFK5NfzmcSb5gUZHHYBC3xxjAGP7FLlXphrn8wN2omSOqMczBn8JGI9eicSeruuiN
         iyWaWzbIOJTOWubYJVKcwxRx25b7+9sDQE0knUJ0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A88093522B2E; Sun,  5 Apr 2020 18:10:36 -0700 (PDT)
Date:   Sun, 5 Apr 2020 18:10:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        joel@joelfernandes.org
Subject: [GIT PULL rcu/urgent] Don't acquire lock in NMI handler (v5.7)
Message-ID: <20200406011036.GA1435@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This pull request contains a single commit that avoid acquiring
a lock when rcu_nmi_enter_common() is invoked from an NMI handler.
This issue can of course result in self-deadlock, and the fix is quite
straightforward.  I am therefore putting it forward for the current
release (v5.7) instead of following my normal process, which would
delay it until v5.8.

This fix has been subjected to rcutorture, kbuild test robot, and -next
testing and is available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent-for-mingo

for you to fetch changes up to bf37da98c51825c90432d340e135cced37a7460d:

  rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common() (2020-04-05 14:22:15 -0700)

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common()

 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
