Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666E2C433E0
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 07:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDEA239CF
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 07:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhANHWu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Jan 2021 02:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbhANHWu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Jan 2021 02:22:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45AAF239CF;
        Thu, 14 Jan 2021 07:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610608929;
        bh=x4ASfSl6fNvoaHZTcA9U5vpjYi6k+c+UnmfBcNVRlbg=;
        h=From:To:Cc:Subject:Date:From;
        b=mJzvUksr9f794ozs47blsW0nhEkZ2Dc1SY0CbduyKJ3hh+keDXRwJ+or3Io7dIyhl
         KWoIIrpavLASrvKbgVBM4ZUyZF+2nnwRYFVoTGBqLmnERfyHQYPagCpwgLS1E5FIZ/
         a7iiKmuCWa87WIPYwL7ExCC0W6bDHcan7fhLPJORrL0Qgkm73NGpXQy6gktnnkdlVn
         GOQpP07CA2Gw0PBUlCcXIRZFHntd66bQFUJRrWWrLFMoB9PkSHKKQyiJgU6zGSyew4
         wJmR+c8gey9LqNpgQCkX6m8tClIxXZ0nnh1SGU/TS50nz71RHhLDs8doPEZZsoGVXV
         nikQHRqBazKng==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzwxK-00EOaD-8U; Thu, 14 Jan 2021 08:22:06 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH] rcu: better document kfree_rcu()
Date:   Thu, 14 Jan 2021 08:22:02 +0100
Message-Id: <2ec9a8bc8b411b04e2f541b285cc0a133a6d94de.1610608910.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

After changeset 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro"),
kernel-doc now emits two warnings:

	./include/linux/rcupdate.h:884: warning: Excess function parameter 'ptr' description in 'kfree_rcu'
	./include/linux/rcupdate.h:884: warning: Excess function parameter 'rhf' description in 'kfree_rcu'

What's happening here is that some macro magic was added in order
to call two different versions of kfree_rcu(), being the first one
with just one argument and a second one with two arguments.

That makes harder to document the kfree_rcu() arguments, which
also reflects on the documentation text.

In order to make clearer that this macro accepts optional
arguments, by using macro concatenation, changing its
definition from:
	#define kfree_rcu kvfree_rcu

to:
	#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)

That not only helps kernel-doc to understand the macro arguemnts,
but also provides a better C definition that makes clearer that
the first argument is mandatory and the second one is optional.

Fixes: 5130b8fd0690 ("rcu: Introduce kfree_rcu() single-argument macro")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f722714f..5cc6deaa5df2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -881,7 +881,7 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu kvfree_rcu
+#define kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
 
 /**
  * kvfree_rcu() - kvfree an object after a grace period.
-- 
2.29.2

