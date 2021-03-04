Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AF4C4332B
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CC464F14
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbhCDBAz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:00:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237573AbhCDARE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:17:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC17764F02;
        Thu,  4 Mar 2021 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816984;
        bh=L6bj1/ig39rWvhNfvNwbauz4pem9SmnVEE1Bq9BuDcM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=cFmKjrwRSEoFdjEzLfoTJ51c7TyrBVGAzU15DPbHMhILD3Whp6Z2U9iJDc2HhYaQW
         PrInoWKNyiGQMk0kZAWMJs9Q055PzfQMu8Q3XpeKJJiAnmZjkaQzajTeVE0ONzrgLG
         JTU+m5ctm/ufr0MyGgaaODIHqx6jgXi/u0gNaY7HefWfzEn17R44l4nSmr3x+9IUvv
         aGZvvm9iaYQI2gcPesewCuT+9BGMqUo1WZNcqK+k8lJ6ue9ehP1pspCXDtH4GJNsMH
         L5PA0UUTyCGXOK1P0KXinMRIaqxYtHCPwCQtnpRHH40guxYj9z9n16Ll31x0pqiVgE
         KeWC0NoYi42Jg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6DB43522591; Wed,  3 Mar 2021 16:16:23 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:16:23 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        kernel-team@fb.com, mingo@kernel.org, rcu@vger.kernel.org
Subject: [PATCH tip/core/rcu 0/2] mm_dump_obj() updates for v5.13
Message-ID: <20210304001623.GA23196@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains the following:

1.	Don't build mm_dump_obj() on CONFIG_PRINTK=n kernels.

2.	Add crude tests for mem_dump_obj().

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/mm.h      |    4 ++++
 include/linux/slab.h    |    2 ++
 include/linux/vmalloc.h |    2 +-
 kernel/rcu/rcutorture.c |   39 +++++++++++++++++++++++++++++++++++++++
 mm/slab.c               |    2 ++
 mm/slab.h               |    2 ++
 mm/slab_common.c        |    4 ++++
 mm/slob.c               |    2 ++
 mm/slub.c               |    2 ++
 mm/util.c               |    3 +++
 mm/vmalloc.c            |    2 ++
 11 files changed, 63 insertions(+), 1 deletion(-)
