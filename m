Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9963C4363C
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62532223E
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600717024;
	bh=NgL5YAUFZqx/UlSr/zVuYuZ4T40KuqDKZFqs9400ZyU=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=XrxJcXpI28/dOtijcqgEJ6sSTvCbFbvx4zq3Tj0YdGE9q/BAV1JOURBWsUWwad/di
	 YGxb8HSsfsh8BWt2uu1XXduvw1b1Qh8h/OJn+9vJaz7hsbAtbsOIdlfyoNFB4dYU4o
	 Nmm81EvISz55W6wQy3wwLsgplHsnWlBVcE/C1JfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIUThE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgIUThE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 15:37:04 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B6C2193E;
        Mon, 21 Sep 2020 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600717023;
        bh=NgL5YAUFZqx/UlSr/zVuYuZ4T40KuqDKZFqs9400ZyU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=V0ly0WIsF1ge5taZVWuI9sNcnf98Wn6I6Vk2k6L/iW7VeZnMjLp5bQBTheaBrHi7Q
         Fqm66zUELGGc9QnIphBYnGUR35A1/A5q5A6c7kvtIy96ICHBotzRuOvZwx8LVHI7ID
         YESYhiUmtcm1uX61wAoWuEbzP+3WyX9vMmH0HSxc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF7F3352303A; Mon, 21 Sep 2020 12:37:03 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:37:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        laurent.pinchart@ideasonboard.com
Subject: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
Message-ID: <20200921193703.GA20208@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This pull request contains a single commit that fixes a bug that
was introduced in the last merge window.  This bug causes a compiler
warning complaining about show_rcu_tasks_classic_gp_kthread() being an
unused static function in !SMP kernels.  The fix is straightforward,
just adding an "inline" to make this a static inline function, thus
avoiding the warning.  This bug was reported by Laurent Pinchart (CCed),
who would like it fixed sooner rather than later.  So:

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/urgent

for you to fetch changes up to 78edc005f477a4987ee0a5d96bfe117295c231fd:

  rcu-tasks: Prevent complaints of unused show_rcu_tasks_classic_gp_kthread() (2020-09-16 16:32:36 -0700)

----------------------------------------------------------------
Paul E. McKenney (1):
      rcu-tasks: Prevent complaints of unused show_rcu_tasks_classic_gp_kthread()

 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
