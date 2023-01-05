Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17CFC53210
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbjAEAJu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAEAJt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:09:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA043A1C;
        Wed,  4 Jan 2023 16:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CE4DB8167B;
        Thu,  5 Jan 2023 00:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F468C433EF;
        Thu,  5 Jan 2023 00:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877386;
        bh=tPn2crWok3L9h4Dun1XVImkEdEdU+OpyUGdb6h6Vx9E=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=WcKPoU2pbHrjNxilmZOibmaHKkcRxLJ9ewwc+C16GvjfwTBSuJjHhPKL1RAjUtOFe
         gXg5VhNafN7HsHfR+JpPgQv7Wm95+/BTrjObARQn99ipEqWHDgCIH/mHkxb4TcqqpE
         IRcI9FT+SllkgkObg29lUs3n3D48uYYjGTSX4idcsRAjnODANxWIr0O7WX9N25VYX7
         wd3phZnuw6GT0YP5hL/eGv2Yzr7fLwdKCHkzKF/EWYmUTk1QT1+Ke/4NKGx5cDM03v
         PRhvJZiaBkkj4IvgJIj32W3NeaQeFjIP/SAiP9FgkjoIo5Ir61DcjWFudDTTUR+wC/
         9SvEOWLGyQ1MQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DED605C05CA; Wed,  4 Jan 2023 16:09:45 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:09:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/15] Documentation updates for v6.3
Message-ID: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains documentation updates:

1.	Further updates to RCU's lockdep.rst.

2.	Update NMI-RCU.rst.

3.	Update rcubarrier.rst.

4.	Update rcu_dereference.rst.

5.	Update and wordsmith rculist_nulls.rst.

6.	Update rcu.rst.

7.	Update stallwarn.rst.

8.	Update torture.rst.

9.	Update UP.rst.

10.	Update rcu.rst URL to RCU publications.

11.	Update whatisRCU.rst.

12.	Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information,
	courtesy of Zhen Lei.

13.	docs/RCU/rcubarrier: Adjust 'Answer' parts of QQs as
	definition-lists, courtesy of Akira Yokosawa.

14.	docs/RCU/rcubarrier: Right-adjust line numbers in code snippets,
	courtesy of Akira Yokosawa.

15.	Fix htmldocs build warnings of stallwarn.rst, courtesy of
	Zhen Lei.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/rcu.rst               |    3 
 Documentation/RCU/rcubarrier.rst        |  177 ++++++++++++++--------------
 Documentation/RCU/stallwarn.rst         |  144 +++++++++++++++++++----
 b/Documentation/RCU/NMI-RCU.rst         |    4 
 b/Documentation/RCU/UP.rst              |   13 +-
 b/Documentation/RCU/lockdep.rst         |   13 --
 b/Documentation/RCU/rcu.rst             |    3 
 b/Documentation/RCU/rcu_dereference.rst |   21 ++-
 b/Documentation/RCU/rcubarrier.rst      |  196 +++++++++++++++++---------------
 b/Documentation/RCU/rculist_nulls.rst   |  109 ++++++++---------
 b/Documentation/RCU/stallwarn.rst       |   43 ++++---
 b/Documentation/RCU/torture.rst         |   89 +++++++++++++-
 b/Documentation/RCU/whatisRCU.rst       |  193 ++++++++++++++++++++-----------
 13 files changed, 646 insertions(+), 362 deletions(-)
