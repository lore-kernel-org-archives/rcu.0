Return-Path: <SRS0=Nt6M=DN=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BD6C4363D
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B232087E
	for <rcu@archiver.kernel.org>; Tue,  6 Oct 2020 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601990526;
	bh=LHGrdkmby5BA4t4N23HL7SkHHxZy7yqooZ3dMT3aY2s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=cIx/EJC9k4jwHY+tRIYbdLlEZq0XZ0itWFMbqZE0VR/RRTcq93UcBwGPRiCJGWSnD
	 qNOJHJTLRb6BcoDhCFtD2TfAufejE6K+Ic1ZzI6hR4feZBSfmyOj/9J6B+05afyy0d
	 DEZDgWF6Kw+xMaq9bW85DJ+2VZ/ez6pg8djuhQB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJFNWG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Oct 2020 09:22:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgJFNWF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Oct 2020 09:22:05 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25142078E;
        Tue,  6 Oct 2020 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601990525;
        bh=LHGrdkmby5BA4t4N23HL7SkHHxZy7yqooZ3dMT3aY2s=;
        h=From:To:Cc:Subject:Date:From;
        b=UfPGt9w4ExaWlstmmTjNUtHH93y5mElanmrggfILcMKUt4abJ+zea61rxv3QlNqS8
         i/x4J8NZcOijylogzbLZIa9aYcy1hSw0kZxVfDwfQjAktPxCxt7f0jZjH3ypf2jdQy
         1vwZVDXuv8tOjyEFsAEFi204UxM1TCTTA6JRNdZQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPmuM-0018Kh-4g; Tue, 06 Oct 2020 15:21:34 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bailu Lin <bailu.lin@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>, rcu@vger.kernel.org
Subject: [PATCH 0/4] linu-next next-20201006 document build fixes
Date:   Tue,  6 Oct 2020 15:21:29 +0200
Message-Id: <cover.1601990386.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This small series fix new warnings introduced on today's linux-next.

Feel free to add the patches on this series at the same tree
as the warning was introduced at the first place.

Thanks!
Mauro


Mauro Carvalho Chehab (4):
  docs: infrastructure.rst: exclude device_link_state from device.h
  docs: zh_CN: amu.rst: fix document title markup
  docs: RCU: Requirements.rst: fix a list block
  firmware_loader: fix a kernel-doc markup

 Documentation/RCU/Design/Requirements/Requirements.rst | 1 +
 Documentation/driver-api/infrastructure.rst            | 1 +
 Documentation/translations/zh_CN/arm64/amu.rst         | 4 ++--
 drivers/base/firmware_loader/fallback.c                | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.26.2


