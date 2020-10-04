Return-Path: <SRS0=q59W=DL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09687C4727D
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 00:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9A220717
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 00:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJDAS1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 3 Oct 2020 20:18:27 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:50136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgJDAS0 (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 3 Oct 2020 20:18:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8E98412D0;
        Sun,  4 Oct 2020 00:18:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: chain76_2508979271b1
X-Filterd-Recvd-Size: 1973
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Oct 2020 00:18:22 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] rcu/tree: Make struct kernel_param_ops definitions const
Date:   Sat,  3 Oct 2020 17:18:08 -0700
Message-Id: <c5e4bf0622e261f474b213c9eb0b646f7cca2a72.1601770305.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1601770305.git.joe@perches.com>
References: <cover.1601770305.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

These should be const, so make it so.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f78ee759af9c..c4732bb80818 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -552,12 +552,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
+static const struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-static struct kernel_param_ops next_fqs_jiffies_ops = {
+static const struct kernel_param_ops next_fqs_jiffies_ops = {
 	.set = param_set_next_fqs_jiffies,
 	.get = param_get_ulong,
 };
-- 
2.26.0

