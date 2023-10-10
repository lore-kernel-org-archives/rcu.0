Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C46BCD80B9
	for <rcu@archiver.kernel.org>; Tue, 10 Oct 2023 12:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjJJMAI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjJJMAA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Oct 2023 08:00:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3152106;
        Tue, 10 Oct 2023 04:59:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE5EC433CA;
        Tue, 10 Oct 2023 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696939193;
        bh=hexvkn2hnhCEIZ6bn521V53iUzGk9vn3IPw1DjKvLpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWS30IabNEX9fceGBtSuMMzfGb0CHykp2v+Lh/h5xN43CD5mcsAauKz6J+mTvDRSo
         L6NEQnuLY27VNJJxyFmHQx9xj/wwnKVIgq0Q+iW4IZbrBaNq0Xzm2hvTECaOH7WzvO
         +moqMQp2kCOLKQFm0FYwqGrGkMYtjZCDzqtQxWmXaL92vNNHvubyXTawzG6Pv6jbmj
         T+yLU+FmKRU6u3UJJBcFx6bzRxnLujVSKZ9YQoXoUhS16mdQGD/qCoFFmw7Ugwepmk
         Co0Ei3Cq8EauRdkA/dRnRcDv/fEDWkkTvdxB/PePqHBIyPmwCk2yHtPn2RmOhQqvsK
         XKQWUFdwO5r+w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 07/23] rcutorture: Add CONFIG_DEBUG_OBJECTS to RCU Tasks testing
Date:   Tue, 10 Oct 2023 13:59:05 +0200
Message-Id: <20231010115921.988766-8-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010115921.988766-1-frederic@kernel.org>
References: <20231010115921.988766-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds CONFIG_DEBUG_OBJECTS=y to the TRACE02 rcutorture scenario
to catch any further RCU Tasks bugs involving this Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TRACE02 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index 093ea6e8e65c..9003c56cd764 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -11,3 +11,4 @@ CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
+CONFIG_DEBUG_OBJECTS=y
-- 
2.34.1

