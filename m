Return-Path: <SRS0=neSi=6F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093DEC55184
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4240206F4
	for <rcu@archiver.kernel.org>; Tue, 21 Apr 2020 17:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587488700;
	bh=KOSXgY1unDOeRzswCJwrDcxcwNLE7Z9tDt1GWUVn2c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2uuaPTCD/dXyPNYWCvmgPmfWCcKt9HyVgMW3lMeozGxeBI3CvnqeoyuFgUaWwMd2W
	 XYP3SCROlzfnRkQGt2XYon3w+rcA3Vf0UZJnatgLrdtyPZstg53QXrQwtKzHy48Uh8
	 2EY0NcFGmcehpzTLF+BZiMLEIMYSyUq4lzeszVlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgDUREQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbgDUREP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:15 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F65E2074B;
        Tue, 21 Apr 2020 17:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=KOSXgY1unDOeRzswCJwrDcxcwNLE7Z9tDt1GWUVn2c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1S+VTU4DV4AtzQnb/fUz1DTMMZA1ZVDwebDLNTWnmSYC3l0r/EuY0jZXOB5ClXhV
         bvnHgm8yp6JfIZ1StUEfpZ67/ythA5EvYNeEciuDPp/bOvsKoLLvjTwAfPbUTvEOs5
         iiaVxsmqQQMUlCwVVdlisHD7IhWS9RNwyaYWWdqw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmMA-A9; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 10/10] docs: RCU: rculist_nulls.rst: don't duplicate chapter names
Date:   Tue, 21 Apr 2020 19:04:11 +0200
Message-Id: <6ec433635785b2f25f952c70fb7bcfbab858a6a4.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Since changeset 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst"),
auto-references for chapters are generated. This is a nice feature, but
has a drawback: no chapters can have the same sumber.

So, we need to add two higher hierarchy chapters on this document,
in order to avoid such duplication.

Fixes: 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/RCU/rculist_nulls.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
index d40374221d69..a9fc774bc400 100644
--- a/Documentation/RCU/rculist_nulls.rst
+++ b/Documentation/RCU/rculist_nulls.rst
@@ -10,6 +10,9 @@ objects using SLAB_TYPESAFE_BY_RCU allocations.
 
 Please read the basics in Documentation/RCU/listRCU.rst
 
+Using 'nulls'
+=============
+
 Using special makers (called 'nulls') is a convenient way
 to solve following problem :
 
@@ -126,6 +129,9 @@ very very fast (before the end of RCU grace period)
 
 --------------------------------------------------------------------------
 
+Avoiding extra smp_rmb()
+========================
+
 With hlist_nulls we can avoid extra smp_rmb() in lockless_lookup()
 and extra smp_wmb() in insert function.
 
-- 
2.25.2

